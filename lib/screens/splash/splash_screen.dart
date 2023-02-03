import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:superhero_rendezvous/constants/constants.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/splash';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const SplashScreen(),
    );
  }

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 2),
      () {
        context.pushNamed(RoutePaths.authWrapper);

        // if (SharedPrefs().skipRegistration) {
        //   Navigator.of(context).pushReplacementNamed(AuthWrapper.routeName);
        // } else {
        //   Navigator.of(context).pushReplacementNamed(RegistrationPrompt.routeName);
        // }
      },
    );

    // _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
    //   if (_timer.tick == 4) {
    //     if (SharedPrefs().skipRegistration) {
    //       Navigator.of(context).pushReplacementNamed(AuthWrapper.routeName);
    //     } else {
    //       Navigator.of(context)
    //           .pushReplacementNamed(RegistrationPrompt.routeName);
    //     }
    //     //
    //   }
    // });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomCenter,
          // stops: [0.1, 0.5, 0.7, 0.9],
          stops: [0.6, 0.9],
          colors: [
            Color(0xffED462F),
            Color(0xffF28931),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/svgs/twins.svg',
                height: 80.0,
                width: 80.0,
              ),
              const SizedBox(height: 20.0),
              const Text(
                'AstroTwins',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                ),
              ),
              const SizedBox(height: 6.0),
              const Text(
                'Astrology by A.I',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
