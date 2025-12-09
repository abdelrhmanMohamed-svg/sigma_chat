import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgima_chat/utils/theme/app_color.dart';
import 'package:sgima_chat/view_model/chat/chat_cubit.dart';
import 'package:sgima_chat/views/widgets/card_message.dart';
import 'package:sgima_chat/views/widgets/custom_bottom_sheet_item.dart';
import 'package:sgima_chat/views/widgets/empty_state.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late TextEditingController textController;
  late ScrollController scrollController;

  @override
  void initState() {
    textController = TextEditingController();
    scrollController = ScrollController();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    textController.dispose();
    scrollController.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final chatCubit = BlocProvider.of<ChatCubit>(context);
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(title: Text("Sigma Chat")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: BlocConsumer<ChatCubit, ChatState>(
                  listenWhen: (previous, current) =>
                      current is MessageSentFailed || current is ChatSucess,
                  listener: (context, state) {
                    if (state is MessageSentFailed) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(state.message)));
                    }
                    if (state is ChatSucess) {
                      _scrollToBottom();
                    }
                  },
                  bloc: chatCubit,
                  buildWhen: (previous, current) =>
                      current is ChatInitial ||
                      (current is ChatSucess) ||
                      current is MessageSentFailed,
                  builder: (context, state) {
                    final messages = chatCubit.messages;

                    if (messages.isEmpty) {
                      return EmptyState();
                    }
                    if (state is ChatInitial) {
                      return ListView.separated(
                        controller: scrollController,
                        itemCount: messages.length,
                        separatorBuilder: (_, __) => SizedBox(height: 15),
                        itemBuilder: (context, index) {
                          final message = messages[index];
                          return CardMessage(message: message, isInitial: true);
                        },
                      );
                    }
                    if (state is ChatSucess) {
                      final message = state.messages.last;

                      return ListView.separated(
                        controller: scrollController,
                        itemCount: messages.length,
                        separatorBuilder: (_, __) => SizedBox(height: 15),
                        itemBuilder: (context, index) {
                          return CardMessage(
                            message: messages[index],
                            lastMessageId: message.id,
                          );
                        },
                      );
                    }
                    return ListView.separated(
                      controller: scrollController,
                      itemCount: messages.length,
                      separatorBuilder: (_, __) => SizedBox(height: 15),
                      itemBuilder: (context, index) {
                        return CardMessage(message: messages[index]);
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: size.height * 0.04),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 5.0,
                ),
                decoration: BoxDecoration(
                  color: AppColor.primary,
                  borderRadius: BorderRadius.circular(14.0),
                  border: Border.all(color: AppColor.gray400),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    BlocBuilder<ChatCubit, ChatState>(
                      bloc: chatCubit,
                      buildWhen: (previous, current) => current is ImagePicked,
                      builder: (context, state) {
                        if (state is ImagePicked) {
                          final image = state.image;
                          if (image == null) return SizedBox.shrink();
                          return Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.file(
                                  image,
                                  height: size.height * 0.13,
                                  width: size.width * 0.3,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 3,
                                right: 3,
                                child: InkWell(
                                  onTap: () => chatCubit.removeImage(),
                                  child: CircleAvatar(
                                    backgroundColor: AppColor.gray300,
                                    radius: 15,
                                    child: Icon(Icons.close),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                        return SizedBox.shrink();
                      },
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: AppColor.gray300,
                          radius: 22,
                          child: IconButton(
                            onPressed: () => _showBottomSheet(context),
                            icon: Icon(Icons.add, size: 28),
                          ),
                        ),

                        Expanded(
                          child: TextField(
                            controller: textController,
                            onSubmitted: (value) async {
                              if (textController.text.isEmpty) return;
                              await chatCubit.sendMessage(value);
                              textController.clear();
                              //  _scrollToBottom();
                            },
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            minLines: 1,

                            decoration: InputDecoration(
                              hintText: "Type a message",
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
                                      child:
                                          CircularProgressIndicator.adaptive(),
                                    );
                                  }
                                  return InkWell(
                                    onTap: () async {
                                      if (textController.text.isEmpty) return;
                                      await chatCubit.sendMessage(
                                        textController.text,
                                      );
                                      textController.clear();
                                      //_scrollToBottom();
                                    },
                                    child: Icon(Icons.send),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final chatCubit = BlocProvider.of<ChatCubit>(context);

    showModalBottomSheet(
      clipBehavior: Clip.hardEdge,
      context: context,
      builder: (_) {
        return SizedBox(
          height: size.height * 0.4,
          width: size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 25.0,
              vertical: 30.0,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    CustomBottomSheetItem(
                      onTap: () async {
                        await chatCubit.pickImageFormCamera();
                        Navigator.pop(context);
                      },
                      icon: Icons.camera_alt_outlined,
                      label: "Camera",
                    ),
                    SizedBox(width: size.width * 0.05),
                    CustomBottomSheetItem(
                      onTap: () async {
                        await chatCubit.pickImageFormGallery();
                        Navigator.pop(context);
                      },
                      icon: Icons.image_outlined,
                      label: "Gallery",
                    ),
                    SizedBox(width: size.width * 0.05),
                    CustomBottomSheetItem(
                      onTap: () {},
                      icon: Icons.file_open_outlined,
                      label: "Files",
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
