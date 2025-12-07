import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgima_chat/view_model/chat/chat_cubit.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final chatCubit = BlocProvider.of<ChatCubit>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Chat Page")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text("Chat Page")),
          ElevatedButton(
            onPressed: () async => await chatCubit.sentPrompt(
              "'Write a story about a magic backpack.'",
            ),
            child: Text("send prompt"),
          ),
        ],
      ),
    );
  }
}
