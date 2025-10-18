import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petfinder_app_demo/features/fav/presentation/widgets/favorites_item.dart';

import '../cubit/favorites_cubit.dart';
import '../cubit/favorites_state.dart';
import '../widgets/fav_state_empty.dart';

class FavortesBodyView extends StatelessWidget {
  const FavortesBodyView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, state) {
        if (state is FavoritesLoading) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.teal),
          );
        }

        if (state is FavoritesEmpty) {
          return const FavoritesEmptyState();
        }

        if (state is FavoritesError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
                const SizedBox(height: 16),
                Text(
                  'Error: ${state.message}',
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }

        if (state is FavoritesLoaded) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<FavoritesCubit>().loadFavorites();
            },
            color: Colors.teal,
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.favorites.length,
              itemBuilder: (context, index) {
                final favorite = state.favorites[index];
                return FavoriteItem(favorite: favorite);
              },
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}
