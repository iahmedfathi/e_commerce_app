import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/core/utils/app_images.dart';
import 'package:shop_app/core/utils/app_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 2), () {
      if (!mounted) return;
      context.go(token != null && token != ""
          ? AppRouter.kLayoutScreen
          : AppRouter.kSignInScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SvgPicture.asset(
          Assets.imagesLogo,
          height: 120,
          width: 120,
        ),
      ),
    );
  }
}
