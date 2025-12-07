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
  Future<String?> sentMessage(String message) async {
    final messageContent = Content.text(message);
    final response = await chatSession.sendMessage(messageContent);
    return response.text;
  }

  @override
  void startSession() {
    chatSession = model.startChat();
  }
}
