import 'package:firebase_ai/firebase_ai.dart';
import 'package:flutter/widgets.dart';

abstract class ChatServices {
  Future<void> sentPrompt(String prompt);
}

class ChatServicesImple implements ChatServices {
  final model = FirebaseAI.googleAI().generativeModel(
    model: 'gemini-2.5-flash',
  );

  @override
  Future<void> sentPrompt(String prompt) async {
    final promptContent = [Content.text(prompt)];

    // To generate text output, call generateContent with the text input
    final response = await model.generateContent(promptContent);
    debugPrint(response.text);
  }
}
