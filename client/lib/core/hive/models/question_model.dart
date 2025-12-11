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
  String? subject;

  @HiveField(5)
  late bool hasImage;

  @HiveField(6)
  String? chapter;

  @HiveField(7)
  String? imageUrl;

  @HiveField(8)
  String? standard;

  @HiveField(9)
  late int marks;


  Question({
    required this.id,
    required this.text,
    required this.questionType,
    this.additionalData,
    this.hasImage = false,
    required this.imageUrl,
    this.chapter,
    this.standard,
    required this.marks
  });


  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      id: map['id'].toString(),
      text: map['text'] as String,
      questionType: map['type'] as String,
      additionalData: map['data'] != null ? Map<String, dynamic>.from(map['data']) : null,
      hasImage: map['has_image'] as bool,
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : null,
      marks: map['marks'] as int,
    );
  }
}