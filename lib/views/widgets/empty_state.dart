import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class EmptyState extends StatefulWidget {
  const EmptyState({super.key});

  @override
  State<EmptyState> createState() => _EmptyStateState();
}

class _EmptyStateState extends State<EmptyState> {
  final List<String> messages = [
    "What are you working on?",
    "What can I help you with?",
    "What can I do for you?",
    "What can I help you with?",
  ];
  int index = 0;
  @override
  void initState() {
    super.initState();
    index = Random().nextInt(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedTextKit(
        pause: Duration(seconds: 1),

        totalRepeatCount: 1,
        repeatForever: false,
        animatedTexts: [
          TypewriterAnimatedText(
            messages[index],
            textStyle: Theme.of(context).textTheme.headlineMedium,
          ),
        ],
      ),
    );
  }
}
