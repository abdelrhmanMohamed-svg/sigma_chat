import 'package:hive/hive.dart';
part 'message_model.g.dart';

@HiveType(typeId: 0)
class MessageModel {
  @HiveField(0)
  final String text;
  @HiveField(1)
  final bool isUser;
  @HiveField(2)
  final DateTime time;
  MessageModel({required this.text, required this.isUser, required this.time});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
      'isUser': isUser,
      'time': time.millisecondsSinceEpoch,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      text: map['text'] as String,
      isUser: map['isUser'] as bool,
      time: DateTime.fromMillisecondsSinceEpoch(map['time'] as int),
    );
  }
}
