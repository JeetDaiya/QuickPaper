import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:client/core/hive/models/question_model.dart';
import 'package:dio/dio.dart';


part 'remote_data.g.dart';

@riverpod
QuestionRemoteDataSource questionRemoteDataSource(QuestionRemoteDataSourceRef ref){
  return QuestionRemoteDataSource(Dio());
}

class QuestionRemoteDataSource{
  final Dio _dio;
  QuestionRemoteDataSource(this._dio);

  final String _baseUrl = 'assets/mockData.json';

  Future<List<Question>>getQuestions() async {
    final jsonString = await rootBundle.loadString(_baseUrl);
    final Map<String, dynamic> jsonList = json.decode(jsonString);
    final List<dynamic> questionList = jsonList['data'];
    final questions = questionList.map((e) {
      return Question.fromMap(e as Map<String, dynamic>);
    }).toList();
    return questions;
  }

  Future<int>getVersion() async{
    final jsonString = await rootBundle.loadString(_baseUrl);
    final Map<String, dynamic> jsonList = json.decode(jsonString);
    final int version = jsonList['version'];
    return version;
  }



}