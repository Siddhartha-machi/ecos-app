import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:ecos_main/common/animations/beat.dart';
import 'package:ecos_main/common/utils.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

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

  BoxDecoration _decoration(BuildContext context) {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Theme.of(context).primaryColor.withAlpha(150),
          Theme.of(context).primaryColor.withAlpha(200),
          Theme.of(context).primaryColor.withAlpha(255)
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.onPrimary;
    return Scaffold(
      body: Container(
        decoration: _decoration(context),
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
      ),
    );
  }
}
