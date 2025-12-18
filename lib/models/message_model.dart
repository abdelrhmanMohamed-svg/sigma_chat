import 'package:hive/hive.dart';
part 'message_model.g.dart';

@HiveType(typeId: 0)
class MessageModel extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String text;
  @HiveField(2)
  final bool isUser;
  @HiveField(3)
  final DateTime time;
  @HiveField(4)
  final String? imagePath;
  @HiveField(5)
  final String? filePath;
  @HiveField(6)
  final String? fileName;

  MessageModel({
    required this.id,
    required this.text,
    required this.isUser,
    required this.time,
    this.imagePath,
    this.filePath,
    this.fileName,
  });
}
