import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petfinder_app_demo/core/di.dart';
import '../../../../core/widgets/custom_text_widgets.dart';
import '../cubit/favorites_cubit.dart';
import '../cubit/favorites_state.dart';
import '../sections/favortes_body_view.dart';
import '../widgets/fav_state_empty.dart';

import '../widgets/favorites_item.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: CustomTextWidget.title24("Find Your Forever Pet"),
      ),
      body: BlocProvider(
        create: (context) => sl<FavoritesCubit>()..loadFavorites(),
        child: const FavortesBodyView(),
      ),
    );
  }
}
