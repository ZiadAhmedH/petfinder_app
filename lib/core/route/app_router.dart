import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:petfinder_app_demo/core/utils/app_colors.dart';
import 'package:petfinder_app_demo/core/utils/constants/assets.dart';
import 'package:petfinder_app_demo/features/onboarding/onboarding_view.dart';

import '../../features/home/presentation/view/home_view.dart';
import '../../features/splash/splash_view.dart';
import 'app_routes.dart';



final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  debugLogDiagnostics: kDebugMode,
  routes: [
     
    GoRoute(path: AppRoutes.splash,
      name: 'splash',
      pageBuilder: (context, state) =>
          MaterialPage(child: const SplashView()),
    ),
    
    GoRoute(path:AppRoutes.onboarding,
      name: 'onboarding',
      pageBuilder: (context, state) =>
          MaterialPage(child: const OnboardingView()),
    ),
    
    ShellRoute(
      pageBuilder: (context, state, child) => MaterialPage<void>(
        key: state.pageKey,
        child: MainAppShell(child: child),
      ),
      routes: [
        GoRoute(
          path: AppRoutes.home,
          name: 'home',
          pageBuilder: (context, state) =>
              MaterialPage(child: const HomeView()),
        ),
        GoRoute(
          path: AppRoutes.fav,
          name: 'fav',
          pageBuilder: (context, state) => MaterialPage(child: const FavView()),
        ),
      ],
    ),
  ],
  errorBuilder: (context, state) =>
      Scaffold(body: Center(child: Text('Route error: ${state.error}'))),
);


class FavView extends StatelessWidget {
  const FavView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: const Center(child: Text('Favorites Page')),
    );
  }
}

class MainAppShell extends StatefulWidget {
  final Widget child;
  const MainAppShell({super.key, required this.child});

  @override
  State<MainAppShell> createState() => _MainAppShellState();
}

class _MainAppShellState extends State<MainAppShell> {
  late PageController _pageController;
  int _currentIndex = 0;
  final List<String> _routes = [AppRoutes.home, AppRoutes.fav];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final location = Uri.base.path;
    final newIndex = location.startsWith(AppRoutes.fav) ? 1 : 0;
    if (newIndex != _currentIndex) {
      _currentIndex = newIndex;
      _pageController.jumpToPage(newIndex);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTap(int index) {
    if (index == _currentIndex) return;
    setState(() => _currentIndex = index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    context.go(_routes[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [const HomeView(), const FavView()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTap,
        items:  [
          BottomNavigationBarItem(icon: SvgPicture.asset(Assets.assetsIconsHome, width: 30, height: 30,
            colorFilter: ColorFilter.mode(
              _currentIndex == 0 ? AppColors.primaryColor : Colors.grey,
              BlendMode.srcIn,
            ),
          ), label: ''),
          BottomNavigationBarItem(icon: SvgPicture.asset(Assets.assetsIconsHeart,
            width: 30,
            height: 30,
            colorFilter: ColorFilter.mode(
              _currentIndex == 1 ? AppColors.primaryColor : Colors.grey,
              BlendMode.srcIn,
            ), 
          ), label: ''),
        ],
      ),
    );
  }
}
