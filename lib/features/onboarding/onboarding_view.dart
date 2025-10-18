import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../core/route/app_routes.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/constants/assets.dart';
import '../../core/widgets/custom_text_widgets.dart';


class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
         crossAxisAlignment: CrossAxisAlignment.center,
        children:  [
             
             Image.asset(Assets.assetsLogoOnboard,),

           SizedBox(height: 55,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                CustomTextWidget(
                 text:  "Find Your Best Companion With Us",
                  color: Colors.black,
                  fontSize: 32,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.bold,
                
                  ),
                       
                SizedBox(height: 16,),
                
                CustomTextWidget(
                  text: "Join & discover the best suitable pets as per your preferences in your location",
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  textAlign: TextAlign.center,
                  ),
                
                SizedBox(height: 55,),
                
          SizedBox(
            width: 250,
            height: 60,
            child: ElevatedButton(
              onPressed: () {
                GoRouter.of(context).go(AppRoutes.home);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(Assets.assetsLogoPetFeet),
                  SizedBox(width: 10),
                  CustomTextWidget(
                    text: "Get Started",
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),


              ],
              
            ),
          ),

        ],
      )
    );
  }
}