
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petfinder_app_demo/core/widgets/custom_text_widgets.dart';
import 'package:petfinder_app_demo/features/home/presentation/sections/home_body_view.dart';

import '../../../../core/di.dart' as di;
import '../../../../core/utils/constants/assets.dart';
import '../cubit/pet/pet_cubit.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomTextWidget.title24("Find Your Forever Pet"),
        actions: [
          IconButton(
            icon: SvgPicture.asset(Assets.assetsIconsNotification,
                width: 24, height: 24,),
            onPressed: () {
              // Navigator.pushNamed(context, '/fav');
            },
          ),
        ],
      ),
      body:BlocProvider(
        create: (_) => di.sl<PetCubit>()..loadPets(),
        child:  PetsListBodyView(),
      ), 
    );
  }
}