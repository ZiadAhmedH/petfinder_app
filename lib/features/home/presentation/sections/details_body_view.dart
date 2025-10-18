import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:petfinder_app_demo/core/extentaions/image_extention.dart';
import '../../domain/entities/pet.dart';
import '../widgets/pet_card_info.dart';

class DetailsBodyView extends StatelessWidget {
  final Pet pet;

  const DetailsBodyView({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: pet.id,
                child: SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.30,
                  child: CachedNetworkImage(
                    imageUrl: pet.referenceImageId.getImageUrl(
                      pet.referenceImageId,
                    ),
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.error,
                      size: 40,
                      color: Colors.redAccent,
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        pet.name,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Text(
                      'Free',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal[400],
                      ),
                    ),
                  ],
                ),
              ),

              // Distance (using origin as location)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Icon(Icons.location_on, size: 18, color: Colors.red[400]),
                    const SizedBox(width: 4),
                    Text(
                      pet.origin,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Info Cards (Gender, Age, Weight)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    // Gender Card
                    Expanded(
                      child: PetInfoCard(
                        title: 'temperament',
                        value: pet.temperament.split(',').first.trim(),
                        color: Colors.teal[50]!,
                      ),
                    ),

                    const SizedBox(width: 12),

                    // Life Span Card (as Age)
                    Expanded(
                      child: PetInfoCard(
                        title: 'Life Span',
                        value: pet.lifeSpan,
                        color: Colors.teal[50]!,
                      ),
                    ),

                    const SizedBox(width: 12),

                    // Weight Card
                    Expanded(
                      child: PetInfoCard(
                        title: 'Weight',
                        value: '${pet.weight.metric} kg',
                        color: Colors.teal[50]!,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // About Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'About:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      pet.description,
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.6,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 80),
            ],
          ),
        ),
        // Adopt Me Button
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,

          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  _showAdoptDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal[400],
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'Adopt me',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showAdoptDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.pets, color: Colors.teal[400]),
            const SizedBox(width: 8),
            const Text('Adopt Pet'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Would you like to start the adoption process for ${pet.name}?',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.teal[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Adoption Fee:',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Text(
                        'free',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.teal[700],
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(color: Colors.grey[600])),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Adoption request sent for ${pet.name}!'),
                  backgroundColor: Colors.teal[400],
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal[400],
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }
}
