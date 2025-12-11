import 'package:hive_flutter/adapters.dart';
part 'question_model.g.dart';

@HiveType(typeId: 0)
class Question{
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String text;

  @HiveField(2)
  late String questionType;

  @HiveField(3)
  Map<String, dynamic>? additionalData;

  @HiveField(4)
  late String subject;

  @HiveField(5)
  late bool hasImage;

  @HiveField(6)
  String? chapter;

  @HiveField(6)
  late String imageUrl;

  Question({
    required this.id,
    required this.text,
    required this.questionType,
    this.additionalData,
    required this.subject,
    this.hasImage = false,
    required this.imageUrl,
    this.chapter,
  });
}