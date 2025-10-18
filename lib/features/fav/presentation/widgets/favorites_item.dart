import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:petfinder_app_demo/core/extentaions/image_extention.dart';
import '../../data/model/favorite_pet_model.dart';
import '../cubit/favorites_cubit.dart';

class FavoriteItem extends StatelessWidget {
  final FavoritePetModel favorite;

  const FavoriteItem({super.key, required this.favorite});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
        children: [
          // Pet Image
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              bottomLeft: Radius.circular(16),
            ),
            child: favorite.imageUrl != null
                ? CachedNetworkImage(
                    imageUrl: favorite.imageUrl!.getImageUrl(
                      favorite.imageUrl!,
                    ),
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: Colors.teal[50],
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.teal[50],
                      child: Icon(
                        Icons.pets,
                        size: 40,
                        color: Colors.teal[200],
                      ),
                    ),
                  )
                : Container(
                    width: 120,
                    height: 120,
                    color: Colors.teal[50],
                    child: Icon(Icons.pets, size: 40, color: Colors.teal[200]),
                  ),
          ),

          // Pet Info
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    favorite.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (favorite.origin != null) ...[
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 16,
                          color: Colors.red[400],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          favorite.origin!,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                  if (favorite.temperament != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      favorite.temperament!.split(',').first.trim(),
                      style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                    ),
                  ],
                ],
              ),
            ),
          ),

          // Remove Button
          IconButton(
            icon: const Icon(Icons.favorite, color: Colors.red),
            onPressed: () {
              _showRemoveDialog(context);
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }

  void _showRemoveDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Remove from Favorites'),
        content: Text('Remove ${favorite.name} from your favorites?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text('Cancel', style: TextStyle(color: Colors.grey[600])),
          ),
          ElevatedButton(
            onPressed: () {
              // Create a minimal pet object for removal
              final petForRemoval = _PetForRemoval(favorite.id);
              context.read<FavoritesCubit>().toggleFavorite(petForRemoval);
              Navigator.pop(dialogContext);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${favorite.name} removed from favorites'),
                  backgroundColor: Colors.red[400],
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[400],
              foregroundColor: Colors.white,
            ),
            child: const Text('Remove'),
          ),
        ],
      ),
    );
  }
}

// Helper class for removal
class _PetForRemoval {
  final String id;
  _PetForRemoval(this.id);
}
