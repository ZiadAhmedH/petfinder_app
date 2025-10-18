import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petfinder_app_demo/features/home/presentation/cubit/pet_cubit.dart';
import 'package:petfinder_app_demo/features/home/presentation/cubit/pet_state.dart';
import 'package:petfinder_app_demo/features/home/presentation/widgets/pet_item.dart';
import '../widgets/pet_shimmer.dart';

class PetsListBodyView extends StatefulWidget {
  const PetsListBodyView({super.key});

  @override
  State<PetsListBodyView> createState() => _PetsListPageState();
}

class _PetsListPageState extends State<PetsListBodyView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<PetCubit>().loadPets();
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
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PetCubit, PetState>(
      builder: (context, state) {
        if (state is PetLoading) {
          return ListView.builder(
            itemCount: 5, // Show 5 shimmer items
            itemBuilder: (context, index) => const PetItemShimmer(),
          );
        }

        if (state is PetsError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
                const SizedBox(height: 16),
                Text(
                  state.message.message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () => context.read<PetCubit>().refresh(),
                  icon: const Icon(Icons.refresh),
                  label: const Text('Retry'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        if (state is PetsLoaded || state is PetsLoadingMore) {
          final pets = state is PetsLoaded
              ? state.pets
              : (state as PetsLoadingMore).currentPets;

          final isLoadingMore = state is PetsLoadingMore;
          final hasReachedMax = state is PetsLoaded && state.hasReachedMax;

          if (pets.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.pets, size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    'No pets found',
                    style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async => context.read<PetCubit>().refresh(),
            color: Colors.teal,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              controller: _scrollController,
              itemCount:
                  pets.length + (isLoadingMore || !hasReachedMax ? 1 : 0),
              itemBuilder: (context, index) {
                if (index >= pets.length) {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: PetItemShimmer(),
                  );
                }
                return PetListItem(pet: pets[index]);
              },
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}
