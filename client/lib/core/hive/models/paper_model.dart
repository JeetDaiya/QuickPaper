import 'package:client/core/hive/models/question_model.dart';
import 'package:client/features/subject/domain/subject.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
part 'paper_model.g.dart';

@HiveType(typeId: 2)
class Paper{
  @HiveField(0)
  String? filePath;

  @HiveField(1)
  late List<String>questionIds;

  @HiveField(2)
  String dateOfCreation;

  @HiveField(3)
  late String subject;

  Paper({this.filePath, required this.questionIds, required this.dateOfCreation, required this.subject});
}

