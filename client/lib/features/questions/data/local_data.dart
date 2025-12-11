import 'package:client/core/hive/hive_boxes.dart';
import 'package:client/core/hive/models/version_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:client/core/hive/models/question_model.dart';

part 'local_data.g.dart';

@riverpod
QuestionLocalDataSource questionLocalDataSource(QuestionLocalDataSourceRef ref){
  return QuestionLocalDataSource();
}

class QuestionLocalDataSource{
  final Box<Question> _questionBox = Hive.box<Question>(HiveBoxes.questionBox);
  final Box<Version> _versionBox = Hive.box<Version>(HiveBoxes.versionBox);

  List<Question>getQuestion(){
    return _questionBox.values.toList();
  }

  Future<void>cacheQuestion(List<Question> questions)async {
    await _questionBox.clear();
    await _questionBox.addAll(questions);
  }

  int getDataVersion(){
    return _versionBox.get('version', defaultValue: Version(version: 0))!.version;
  }

  Future<void>setDataVersion(int version)async {
    await _versionBox.put('version', Version(version: version));
  }

}