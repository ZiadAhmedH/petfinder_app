import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petfinder_app_demo/core/utils/app_colors.dart';
import 'package:petfinder_app_demo/core/widgets/custom_text_widgets.dart';
import 'package:petfinder_app_demo/features/fav/presentation/cubit/favorites_cubit.dart';
import 'package:petfinder_app_demo/features/fav/presentation/view/favorites_view.dart';
import 'package:petfinder_app_demo/features/home/presentation/sections/home_body_view.dart';

import '../../../../core/di.dart' as di;
import '../../../../core/utils/constants/assets.dart';
import '../cubit/pet/pet_cubit.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<PetCubit>()..loadPets()),
        BlocProvider(create: (_) => di.sl<FavoritesCubit>()..loadFavorites()),
      ],
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: CustomTextWidget.title24("Find Your Forever Pet"),
          actions: [
            IconButton(
              icon: SvgPicture.asset(
                Assets.assetsIconsNotification,
                width: 24,
                height: 24,
              ),
              onPressed: () {
                
              },
            ),
          ],
        ),
        body: const PetsListBodyView(),
      ),
    );
  }
}
