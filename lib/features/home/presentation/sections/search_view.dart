import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/search/search_cubit.dart';
import '../cubit/search/search_state.dart';
import '../widgets/pet_item.dart';
import '../widgets/pet_shimmer.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SearchView();
  }
}

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_isBottom && mounted) {
      final state = context.read<SearchCubit>().state;
      if (state is SearchLoaded && !state.hasReachedMax) {
        context.read<SearchCubit>().searchPets(
          query: state.query,
          loadMore: true,
        );
      }
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            // Hero Search Bar
            Hero(
              tag: 'search_bar',
              child: Material(
                color: Colors.transparent,
                child: Container(
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    focusNode: _focusNode,
                    style: const TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                      hintText: 'Search for pets...',
                      hintStyle: TextStyle(color: Colors.grey[500]),
                      prefixIcon: IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.teal[400]),
                        onPressed: () => Navigator.pop(context),
                      ),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: Icon(Icons.clear, color: Colors.grey[400]),
                              onPressed: () {
                                _searchController.clear();
                                context.read<SearchCubit>().clearSearch();
                                setState(() {});
                              },
                            )
                          : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {});
                      if (value.trim().length >= 2) {
                        context.read<SearchCubit>().searchPets(
                          query: value.trim(),
                        );
                      } else if (value.isEmpty) {
                        context.read<SearchCubit>().clearSearch();
                      }
                    },
                  ),
                ),
              ),
            ),

            // Search Results
            Expanded(
              child: BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  // Initial State
                  if (state is SearchInitial) {
                    return _buildEmptyState(
                      icon: Icons.search,
                      title: 'Search for Pets',
                      subtitle: 'Start typing to find your perfect companion',
                      color: Colors.teal,
                    );
                  }

                  // Loading State
                  if (state is SearchLoading) {
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      itemCount: 5,
                      itemBuilder: (context, index) => const PetItemShimmer(),
                    );
                  }

                  // Empty Results
                  if (state is SearchEmpty) {
                    return _buildEmptyState(
                      icon: Icons.search_off,
                      title: 'No Results Found',
                      subtitle:
                          'Try searching with different keywords\nLike: Persian, Bengal, Siamese',
                      color: Colors.orange,
                    );
                  }

                  // Error State
                  if (state is SearchError) {
                    return _buildErrorState(state.message.message);
                  }

                  // Results Found
                  if (state is SearchLoaded || state is SearchLoadingMore) {
                    final pets = state is SearchLoaded
                        ? state.pets
                        : (state as SearchLoadingMore).currentPets;

                    final isLoadingMore = state is SearchLoadingMore;
                    final hasReachedMax = state is SearchLoaded
                        ? state.hasReachedMax
                        : false;

                    return Column(
                      children: [
                        // Results Count Header
                        if (state is SearchLoaded)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                bottom: BorderSide(color: Colors.grey[200]!),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.pets,
                                  size: 18,
                                  color: Colors.teal[400],
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '${pets.length} ${pets.length == 1 ? 'pet' : 'pets'} found',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                const Spacer(),
                                if (!hasReachedMax)
                                  Text(
                                    'Scroll for more',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                              ],
                            ),
                          ),

                        // Results List
                        Expanded(
                          child: RefreshIndicator(
                            onRefresh: () async {
                              if (state is SearchLoaded) {
                                context.read<SearchCubit>().searchPets(
                                  query: state.query,
                                );
                              }
                            },
                            color: Colors.teal,
                            child: ListView.builder(
                              controller: _scrollController,
                              physics: const BouncingScrollPhysics(),
                              padding: const EdgeInsets.only(bottom: 16),
                              itemCount: pets.length + (isLoadingMore ? 1 : 0),
                              itemBuilder: (context, index) {
                                if (index >= pets.length) {
                                  return const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: PetItemShimmer(),
                                  );
                                }
                                return PetListItem(pet: pets[index]);
                              },
                            ),
                          ),
                        ),

                        // End of Results Indicator
                        if (hasReachedMax && pets.isNotEmpty)
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 1,
                                  width: 40,
                                  color: Colors.grey[300],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                  ),
                                  child: Text(
                                    'End of results',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 1,
                                  width: 40,
                                  color: Colors.grey[300],
                                ),
                              ],
                            ),
                          ),
                      ],
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 64, color: color.withOpacity(0.6)),
            ),
            const SizedBox(height: 24),
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red[300],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Oops!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              message,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                context.read<SearchCubit>().clearSearch();
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Try Again'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
