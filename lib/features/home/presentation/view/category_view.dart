import 'package:flutter/material.dart';
import 'package:petfinder_app_demo/core/widgets/custom_text_widgets.dart';

class CategoryFilterCustom extends StatefulWidget {
  final Function(String) onCategorySelected;

  const CategoryFilterCustom({super.key, required this.onCategorySelected});

  @override
  State<CategoryFilterCustom> createState() => _CategoryFilterCustomState();
}

class _CategoryFilterCustomState extends State<CategoryFilterCustom> {
  String selectedCategory = 'All';

  final List<String> categories = [
    'All',
    'Cats',
    'Dogs',
    'Birds',
    'Fish',
    'Reptiles',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       Row(
        
         children: [
          SizedBox(width: 16,),
           CustomTextWidget(text: "Categories", fontSize: 18, fontWeight: FontWeight.w600,),
         ],
       ),

        Container(
          height: 40,
          margin: const EdgeInsets.symmetric(vertical: 16),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              final isSelected = selectedCategory == category;
        
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedCategory = category;
                  });
                  widget.onCategorySelected(category);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.teal[400]
                        : const Color(0xFFE8F5F3),
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: Colors.teal.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ]
                        : null,
                  ),
                  child: Center(
                    child: Text(
                      category,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.w500,
                        color: isSelected ? Colors.white : Colors.grey[700],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
