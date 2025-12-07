import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgima_chat/view_model/chat/chat_cubit.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late TextEditingController textController;
  @override
  void initState() {
    textController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final chatCubit = BlocProvider.of<ChatCubit>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Chat Page")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: BlocConsumer<ChatCubit, ChatState>(
                  bloc: chatCubit,
                  listenWhen: (previous, current) =>
                      current is MessageSentFailed,

                  listener: (context, state) {
                    if (state is MessageSentFailed) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(state.message)));
                    }
                  },
                  buildWhen: (previous, current) =>
                      current is ChatSucess ||
                      current is SendingMessage ||
                      current is MessageSentFailed,
                  builder: (context, state) {
                    if (state is ChatSucess) {
                      final messages = state.messages;

                      return ListView.builder(
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final message = messages[index];
                          return ListTile(
                            title: Text(message.text),
                            subtitle: Text(message.time.toString()),
                            leading: Icon(
                              message.isUser ? Icons.person : Icons.chat,
                            ),
                          );
                        },
                      );
                    }
                    return SizedBox.shrink();
                  },
                ),
              ),
              TextField(
                controller: textController,
                onSubmitted: (value) async {
                     if (textController.text.isEmpty) return;
                  await chatCubit.sendMessage(value);
                  textController.clear();
                },
                decoration: InputDecoration(
                  hintText: "Enter your message",
                  suffixIcon: BlocBuilder<ChatCubit, ChatState>(
                    bloc: chatCubit,
                    buildWhen: (previous, current) =>
                        current is SendingMessage ||
                        current is MessageSentFailed ||
                        current is MessageSent,

                    builder: (context, state) {
                      if (state is SendingMessage) {
                        return Transform.scale(
                            scale: 0.5,
                          child: CircularProgressIndicator.adaptive());
                      }
                      return InkWell(
                        onTap: () async {
                          if (textController.text.isEmpty) return;
                          await chatCubit.sendMessage(textController.text);
                          textController.clear();
                        },
                        child: Icon(Icons.send),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
