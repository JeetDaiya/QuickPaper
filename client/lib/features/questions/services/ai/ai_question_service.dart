   import 'package:dio/dio.dart';

  import '../../../../core/hive/models/question_model.dart';

  final urlPath = 'http://10.0.2.2:4000/api/generate-questions';

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
      final List list = response.data['data'];
      return list.map<Question>((e) => Question.fromMap(e)).toList();
    }
  }
