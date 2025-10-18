import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petfinder_app_demo/core/utils/app_colors.dart';
import 'package:petfinder_app_demo/features/fav/presentation/cubit/favorites_cubit.dart';
import 'package:petfinder_app_demo/features/fav/presentation/cubit/favorites_state.dart';
import '../../../../core/extentaions/image_extention.dart';
import '../../domain/entities/pet.dart';

class PetListItem extends StatelessWidget {
  final Pet pet;

  const PetListItem({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, state) {
        // Check if this pet is in favorites
        final isFav = context.read<FavoritesCubit>().isFavorite(pet.id);

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: isFav
                ? Border.all(color: AppColors.primaryColor.withOpacity(0.3), width: 2)
                : null,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Pet Image with Favorite Badge
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      pet.referenceImageId.getImageUrl(pet.referenceImageId),
                      height: 120,
                      width: 120,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 120,
                          width: 120,
                          color: Colors.grey[200],
                          child: const Icon(
                            Icons.pets,
                            size: 50,
                            color: Colors.grey,
                          ),
                        );
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          height: 120,
                          width: 120,
                          color: Colors.grey[200],
                          child: const Center(
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        );
                      },
                    ),
                  ),
                  // Favorite Badge on Image
                      ],
              ),
              const SizedBox(width: 16),

              // Pet Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name with Favorite Label
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            pet.name,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        
                          
                      ],
                    ),
                    const SizedBox(height: 4),

                    // Origin
                    Text(
                      pet.origin,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Life Span
                    Text(
                      '${pet.lifeSpan} Years Old',
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    ),
                    const SizedBox(height: 12),

                    // Temperament with icon
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 18,
                          color: Colors.red[400],
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            pet.temperament.split(',').first.trim(),
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[600],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Favorite Toggle Button
              IconButton(
                onPressed: () {
                  // Toggle the favorite status
                  context.read<FavoritesCubit>().toggleFavorite(pet);

                  // Get the NEW status after toggle
                  final newIsFav = !isFav;

                  // Show snackbar with updated status
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        newIsFav
                            ? 'Added to favorites'
                            : 'Removed from favorites',
                      ),
                      backgroundColor: newIsFav
                          ? Colors.teal[400]
                          : Colors.grey[700],
                      behavior: SnackBarBehavior.floating,
                      duration: const Duration(seconds: 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  );
                },
                icon: Icon(
                  isFav ? Icons.favorite : Icons.favorite_border,
                  color: isFav ? AppColors.primaryColor : Colors.grey[400],
                  size: 28,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
