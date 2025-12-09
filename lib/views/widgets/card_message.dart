import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:sgima_chat/models/message_model.dart';
import 'package:sgima_chat/utils/theme/app_color.dart';

class CardMessage extends StatefulWidget {
  const CardMessage({
    super.key,
    required this.message,
    this.isInitial = false,
    this.lastMessageId,
    this.isPlayed = false,
    this.onPlayed,
  });

  final MessageModel message;
  final bool isInitial;
  final String? lastMessageId;
  final bool isPlayed;
  final Function(String)? onPlayed;

  @override
  State<CardMessage> createState() => _CardMessageState();
}

class _CardMessageState extends State<CardMessage> {
  bool _played = false;

  @override
  void initState() {
    super.initState();

    // لو الرسالة دي هي آخر رسالة جديدة، يبقى مسموح نلعب الأنيميشن مرة واحدة فقط
    if (widget.lastMessageId == widget.message.id) {
      _played = false;
    } else {
      _played = true; // قديمة → خالص الأنيميشن خلاص
    }
  }

  @override
  void didUpdateWidget(CardMessage oldWidget) {
    super.didUpdateWidget(oldWidget);

    // لو الرسالة تغيرت (رسالة جديدة)
    if (oldWidget.message.id != widget.message.id) {
      if (widget.lastMessageId == widget.message.id) {
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
                child: _buildContent(textStyle!),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(TextStyle textStyle) {
    if (widget.message.isUser) {
      return Text(
        widget.message.text,
        style: textStyle.copyWith(color: AppColor.primary),
      );
    }

    if (widget.isInitial) {
      return Text(widget.message.text, style: textStyle);
    }

    // ❤️ هنا السحر — لو الأنيميشن اتلعب مرة → مش هيتلعب تاني أبدًا مهما حصل rebuild
    if (_played) {
      return Text(widget.message.text, style: textStyle);
    }

    return AnimatedTextKit(
      totalRepeatCount: 1,
      isRepeatingAnimation: false,
      onFinished: () {
        setState(() {
          _played = true; // خلص → من هنا ورايح Text ثابت
        });
      },
      animatedTexts: [
        TyperAnimatedText(widget.message.text, textStyle: textStyle),
      ],
    );
  }
}
