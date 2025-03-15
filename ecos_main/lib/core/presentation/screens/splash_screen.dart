import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import 'package:ecos_main/core/data/models/route_models.dart';
import 'package:ecos_main/shared/lib/presentation/widgets/animations/beat.dart';
import 'package:ecos_main/shared/lib/utils/global.dart';
import 'package:ecos_main/shared/lib/presentation/widgets/background/gradiant_background.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToLogin();
  }

  void _navigateToLogin() async {
    // TODO API addition
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      context.go(Paths.auth.root.absolutePath);
    }
  }

  Widget _appLogo(Color color) {
    return SvgPicture.asset(
      'assets/icons/logo.svg',
      height: 90,
      width: 90,
      fit: BoxFit.contain,
      colorFilter: ColorFilter.mode(
        color,
        BlendMode.srcIn,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.onPrimary;
    return GradientBackground(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BeatAnimation(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _appLogo(color),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppConfig.APP_NAME,
                        style: TextStyle(
                          color: color,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        AppConfig.APP_CAPTION,
                        style: TextStyle(
                          color: color,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
