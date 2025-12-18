import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_ai/firebase_ai.dart';
import 'package:sgima_chat/utils/app_helper.dart';

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
  Future<String?> sentMessage(
    String message, [
    File? image,
    PlatformFile? file,
  ]) async {
    late Content messageContent;
    if (image != null) {
      final bytes = await image.readAsBytes();

      messageContent = Content.multi([
        TextPart(message),
        InlineDataPart('image/jpeg', bytes),
      ]);
    }
    if (file != null) {
      String pdfText = AppHelper.extractTextFromPdf(file.path!);

      messageContent = Content.multi([TextPart(message), TextPart(pdfText)]);
    }
    if (image == null && file == null) {
      messageContent = Content.text(message);
    }
  

    final response = await chatSession.sendMessage(messageContent);
    return response.text;
  }

  @override
  void startSession() {
  
    chatSession = model.startChat(
      
    );
  }
}
