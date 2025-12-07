import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgima_chat/models/message_model.dart';
import 'package:sgima_chat/services/chat_services.dart';
import 'package:sgima_chat/services/hive_local_database.dart';
import 'package:sgima_chat/utils/app_constants.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  final _chatServices = ChatServicesImple();
  final _hiveServices = HiveLocalDatabase.getinstance;
  final List<MessageModel> _messages = [];

  Future<void> sendMessage(String message) async {
    emit(SendingMessage());
    try {
      final userMessage = MessageModel(
        text: message,
        isUser: true,
        time: DateTime.now(),
      );
      _messages.add(userMessage);
      await _hiveServices.saveData<List<MessageModel>>(
        AppConstants.messageKey,
        _messages,
      );

      emit(ChatSucess(_getMessages()));
      final response = await _chatServices.sentMessage(message);
      final chatMessage = MessageModel(
        text: response ?? "there is no response",
        isUser: false,
        time: DateTime.now(),
      );
      _messages.add(chatMessage);
      await _hiveServices.saveData<List<MessageModel>>(
        AppConstants.messageKey,
        _messages,
      );
      emit(MessageSent());
      emit(ChatSucess(_getMessages()));
    } catch (e) {
      emit(MessageSentFailed(e.toString()));
    }
  }

  Future<void> getMessages() async {
    emit(ChatSucess(_getMessages()));
  }

  void startSession() {
    _chatServices.startSession();
  }

  List<MessageModel> _getMessages() {
    final messages = _hiveServices.getData(AppConstants.messageKey);
    return messages.map((e) => e as MessageModel).toList();
  }
}
