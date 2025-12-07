part of 'chat_cubit.dart';

sealed class ChatState {
  const ChatState();
}

final class ChatInitial extends ChatState {}

final class SendingMessage extends ChatState {}

final class MessageSent extends ChatState {}

final class MessageSentFailed extends ChatState {
  final String message;
  const MessageSentFailed(this.message);
}

final class ChatSucess extends ChatState {
  final List<MessageModel> messages;

  const ChatSucess(this.messages);
}
