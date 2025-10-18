import 'package:flutter/material.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    // add an list of categories here (e.g., Dogs, Cats, Birds, etc.  )
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return ListTile(title: Text('Category $index'));
      }, 
    );
  }
}

