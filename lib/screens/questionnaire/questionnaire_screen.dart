import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';

class QuestionnaireScreen extends StatefulWidget {
  const QuestionnaireScreen({super.key});

  @override
  State<QuestionnaireScreen> createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen> {
  final GlobalKey<ExpansionTileCardState> cardA = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ExpansionTileCard(
            key: cardA,
            title: const Text('If you had a superpower, what would it be?'),
            children: [
              const Divider(
                thickness: 1.0,
                height: 1.0,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter your answer here',
                  contentPadding: EdgeInsets.all(20.0),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
