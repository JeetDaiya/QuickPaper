   import 'dart:convert';

import 'package:dio/dio.dart';

  import '../../../../core/hive/models/question_model.dart';

  final urlPath = 'https://quickpaper-s8n2.onrender.com/api/generate-questions';

  class AiQuestionService {
    final Dio _dio = Dio();

    Future<List<Question>>generateAiQuestion({required String topic, required String chapter}) async {
      final response = await _dio.post(
        urlPath,
        data: {
          'topic': topic,
          'chapter': chapter
        },
        options: Options(
          receiveTimeout: Duration(seconds: 120),
          responseType: ResponseType.json,
          headers: {
            'Content-Type': 'application/json'
          }
        )
      );
      final dynamic rawData = response.data['data'];
      List<dynamic>parsedList;
      if (rawData is String) {
        parsedList = jsonDecode(rawData);
      } else {
        // If the server was fixed to return a List, use it directly
        parsedList = rawData;
      }

      // 3. Convert to Question objects
      return parsedList.map<Question>((e) => Question.fromMap(e)).toList();


    }
  }
