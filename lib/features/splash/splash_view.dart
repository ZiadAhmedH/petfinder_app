import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:petfinder_app_demo/core/route/app_routes.dart';

import 'package:petfinder_app_demo/features/onboarding/onboarding_view.dart';

import '../../core/utils/app_colors.dart';
import '../../core/utils/constants/assets.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), () {
      _initialize();
    });
  }

  Future<void> _initialize() async {
    await Future.delayed(const Duration(seconds: 2));
    print('Initialization complete');
    if (mounted) {
      GoRouter.of(context).go(AppRoutes.onboarding);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Center(
        child: SvgPicture.asset(Assets.assetsLogoLogo, width: 150, height: 150),
      ),
    );
  }
}
