import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/constants/route_paths.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.pushNamed(RoutePaths.details),
        child: const Icon(Icons.add),
      ),
      body: const Center(
        child: Text('Home'),
      ),
    );
  }
}

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.pushNamed(RoutePaths.newPage),
        child: const Icon(Icons.add),
      ),
      body: const Center(
        child: Text('Details'),
      ),
    );
  }
}

class NewPage extends StatelessWidget {
  const NewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.network(
          'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/800px-Image_created_with_a_mobile_phone.png',
          height: 250.0,
          width: 250.0,
        ),
      ),
    );
  }
}
