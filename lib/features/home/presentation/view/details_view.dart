import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petfinder_app_demo/core/di.dart';
import 'package:petfinder_app_demo/features/fav/presentation/cubit/favorites_cubit.dart';
import 'package:petfinder_app_demo/features/home/presentation/sections/details_body_view.dart';

import '../../../../core/widgets/custom_text_widgets.dart';
import '../../domain/entities/pet.dart';

class DetailsView extends StatelessWidget {
  final Pet petDetails;

  const DetailsView({super.key, required this.petDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: CustomTextWidget.title24("Find Your Forever Pet")),
      body: BlocProvider(
        create: (context) => sl<FavoritesCubit>()..loadFavorites(),
        child: DetailsBodyView(pet: petDetails),
      ),
    );
  }
}
