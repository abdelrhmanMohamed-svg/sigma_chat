import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bubble/bubble.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:sgima_chat/models/message_model.dart';
import 'package:sgima_chat/utils/theme/app_color.dart';
import 'package:sgima_chat/views/widgets/selected_file_item.dart';

class CardMessage extends StatefulWidget {
  const CardMessage({
    super.key,
    required this.message,
    this.isInitial = false,
    this.lastMessageId,
    required this.file,
  });

  final MessageModel message;
  final bool isInitial;
  final String? lastMessageId;
  final PlatformFile? file;

  @override
  State<CardMessage> createState() => _CardMessageState();
}

class _CardMessageState extends State<CardMessage> {
  bool _played = false;

  @override
  void initState() {
    super.initState();

    if (widget.lastMessageId == widget.message.id) {
      _played = false;
    } else {
      _played = true;
    }
  }

  @override
  void didUpdateWidget(CardMessage oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.message.id != widget.message.id) {
      if (widget.lastMessageId == widget.lastMessageId) {
        _played = false;
      } else {
        _played = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyLarge;
    final size = MediaQuery.sizeOf(context);

    return Align(
      alignment: widget.message.isUser
          ? Alignment.centerLeft
          : Alignment.centerRight,
      child: SizedBox(
        width: size.width - 100,
        child: Row(
          children: [
            if (widget.message.isUser) ...[
              const CircleAvatar(child: Icon(Icons.person)),
              SizedBox(width: size.width * 0.02),
            ],
            Expanded(
              child: Bubble(
                elevation: 2.0,
                nip: widget.message.isUser
                    ? BubbleNip.leftBottom
                    : BubbleNip.rightBottom,
                style: BubbleStyle(
                  padding: const BubbleEdges.symmetric(
                    horizontal: 12,
                    vertical: 10.0,
                  ),
                  color: widget.message.isUser ? AppColor.blue : null,
                ),
                child: _buildContent(textStyle!, size),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(TextStyle textStyle, Size size) {
    if (widget.message.isUser) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.message.imagePath != null) ...[
            Image.file(
              File(widget.message.imagePath!),
              height: size.height * 0.3,
              width: double.infinity,
              fit: BoxFit.contain,
            ),
            SizedBox(height: size.height * 0.01),
          ],

          if (widget.file != null) ...[
            SelectedFileItem(file: widget.file!, isSend: true),
          ],

          Text(
            widget.message.text,
            style: textStyle.copyWith(color: AppColor.primary),
          ),
        ],
      );
    }

    if (widget.isInitial) {
      return Text(widget.message.text, style: textStyle);
    }

    if (_played) {
      return Text(widget.message.text, style: textStyle);
    }

    return AnimatedTextKit(
      totalRepeatCount: 1,
      isRepeatingAnimation: false,
      onFinished: () {
        setState(() {
          _played = true;
        });
      },
      animatedTexts: [
        TyperAnimatedText(widget.message.text, textStyle: textStyle),
      ],
    );
  }
}
