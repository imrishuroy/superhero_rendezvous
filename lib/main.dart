import 'package:flutter/material.dart';

import '/configs/route_config.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: RouteConfig.appRouter,
      //routeInformationParser: RouteConfig.appRouter.routeInformationParser,
      // routeInformationProvider: RouteConfig.appRouter.routeInformationProvider,
      //routerDelegate: RouteConfig.appRouter.routerDelegate,
    );
  }
}
