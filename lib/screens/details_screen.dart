import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final String? id;

  const DetailsScreen({super.key, this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SelectableText('Details Screen: $id'),
      ),
    );
  }
}
