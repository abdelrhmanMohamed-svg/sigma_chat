import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sgima_chat/services/chat_services.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  final chatServices = ChatServicesImple();

  Future<void> sentPrompt(String prompt) async {
    await chatServices.sentPrompt(prompt);
  }
}
