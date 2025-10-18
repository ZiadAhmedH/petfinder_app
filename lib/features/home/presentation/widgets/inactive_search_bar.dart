import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petfinder_app_demo/features/home/presentation/cubit/search/search_cubit.dart';

class SearchBarActive extends StatefulWidget {
  final VoidCallback onBack;

  const SearchBarActive({
    super.key,
    required this.onBack,
  });

  @override
  State<SearchBarActive> createState() => _SearchBarActiveState();
}

class _SearchBarActiveState extends State<SearchBarActive> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Auto focus when the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
        decoration: InputDecoration(
          hintText: 'Search pets by name...',
          prefixIcon: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.teal),
            onPressed: widget.onBack,
          ),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, color: Colors.grey),
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
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
        onChanged: (value) {
          setState(() {});
          if (value.length >= 2) {
            context.read<SearchCubit>().searchPets(query: value);
          } else if (value.isEmpty) {
            context.read<SearchCubit>().clearSearch();
          }
        },
      ),
    );
  }
}