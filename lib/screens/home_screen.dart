import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/constants/route_constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final canvas = MediaQuery.of(context).size;
    print('Widgth: ${canvas.width}');
    print('Height: ${canvas.height}');
    return LayoutBuilder(builder: (context, constrants) {
      print('Widgth 2: ${constrants.maxWidth}');
      print('Height 2: ${constrants.maxHeight}');
      return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => context.goNamed(
            RouteConstants.detailsScreen,
            params: {'id': '123'},
          ),
        ),
        body: const Center(
          child: SelectableText('Home Screen'),
        ),
      );
    });
  }
}
