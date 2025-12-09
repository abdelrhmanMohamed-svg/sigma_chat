import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgima_chat/models/message_model.dart';
import 'package:sgima_chat/services/chat_services.dart';
import 'package:sgima_chat/services/hive_local_database.dart';
import 'package:sgima_chat/services/native_services.dart';
import 'package:sgima_chat/utils/app_constants.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial([]));
  Map<String, bool> playedMessages = {};

  final _chatServices = ChatServicesImple();
  final _hiveServices = HiveLocalDatabase.getinstance;
  final _nativeServices = NativeServicesImpl();
  late List<MessageModel> messages;
  late File? selectedImage;

  Future<void> sendMessage(String message) async {
    emit(SendingMessage());
    try {
      final userMessage = MessageModel(
        id: DateTime.now().toIso8601String(),
        text: message,
        isUser: true,
        time: DateTime.now(),
        image: selectedImage,
      );
      messages.add(userMessage);
      await _hiveServices.saveData<List<MessageModel>>(
        AppConstants.messageKey,
        messages,
      );

      emit(ChatSucess(List.from(messages), userMessage.id));
      final response = await _chatServices.sentMessage(message);
      final chatMessage = MessageModel(
        id: DateTime.now().toIso8601String(),
        text: response ?? "there is no response",
        isUser: false,
        time: DateTime.now(),
      );
      messages.add(chatMessage);
      await _hiveServices.saveData<List<MessageModel>>(
        AppConstants.messageKey,
        messages,
      );
      emit(ChatSucess(List.from(messages), chatMessage.id));

      emit(MessageSent());
    } catch (e) {
      emit(MessageSentFailed(e.toString()));
    }
  }

  Future<void> getMessages() async {
    messages = _getMessages();
    emit(ChatInitial(messages));
  }

  void startSession() {
    _chatServices.startSession();
  }

  List<MessageModel> _getMessages() {
    final messages = _hiveServices.getData(AppConstants.messageKey);

    if (messages == null) {
      return [];
    }
    return List<MessageModel>.from(messages);
  }

  Future<void> pickImageFormCamera() async {
    final image = await _nativeServices.pickImageFromCamera();
    if (image == null) return;
    selectedImage = image;
    emit(ImagePicked(selectedImage));
  }

  Future<void> pickImageFormGallery() async {
    final image = await _nativeServices.pickImageFromGallery();
    if (image == null) return;
    selectedImage = image;
    emit(ImagePicked(selectedImage));
  }

  void removeImage() {
    selectedImage = null;
    emit(ImagePicked(selectedImage));
  }
}
