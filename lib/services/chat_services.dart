import 'dart:io';

import 'package:firebase_ai/firebase_ai.dart';

abstract class ChatServices {
  Future<String?> sentMessage(String message);
  void startSession();
}

class ChatServicesImple implements ChatServices {
  final model = FirebaseAI.googleAI().generativeModel(
    model: 'gemini-2.5-flash',
  );
  late ChatSession chatSession;

  @override
  Future<String?> sentMessage(String message, [File? image]) async {
    late Content messageContent;
    if (image != null) {
      final bytes = await image.readAsBytes();
      messageContent = Content.multi([
        TextPart(message),
        InlineDataPart('image/jpeg', bytes),
      ]);
    } else {
      messageContent = Content.text(message);
    }

    final response = await chatSession.sendMessage(messageContent);
    return response.text;
  }

  @override
  void startSession() {
    chatSession = model.startChat();
  }
}
