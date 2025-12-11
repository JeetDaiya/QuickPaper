import 'package:hive_flutter/hive_flutter.dart';
import 'package:client/core/hive/models/question_model.dart';
import 'hive_boxes.dart';
import 'package:client/core/hive/models/version_model.dart';
import 'package:client/core/hive/models/paper_model.dart';



class HiveInit {
  static Future<void>init() async{
      await Hive.initFlutter();
      Hive.registerAdapter(QuestionAdapter());
      Hive.registerAdapter(VersionAdapter());
      Hive.registerAdapter(PaperAdapter());
      await Hive.openBox<Question>(HiveBoxes.questionBox);
      await Hive.openBox<Version>(HiveBoxes.versionBox);
      await Hive.openBox<Paper>(HiveBoxes.madePapersBox);

  }
}