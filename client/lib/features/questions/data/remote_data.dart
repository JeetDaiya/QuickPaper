import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:client/core/hive/models/question_model.dart';
import 'package:dio/dio.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


part 'remote_data.g.dart';

@riverpod
QuestionRemoteDataSource questionRemoteDataSource(QuestionRemoteDataSourceRef ref){
  return QuestionRemoteDataSource();
}

class QuestionRemoteDataSource{
  final SupabaseClient _supabase = Supabase.instance.client;
  QuestionRemoteDataSource();


  Future<List<Question>>getQuestions() async {
    try {
      // 1. Call the Postgres Function (RPC)
      // We pass empty strings because our SQL function currently ignores params to return ALL data
      final response = await _supabase.rpc('get_chapter_data', params: {
        'req_subject': '',
        'req_chapter': '',
      });
      print(response);
      // 2. Parse the 'data' field from the response: { "version": 1, "data": [...] }
      final List<dynamic> data = response['data'] as List<dynamic>;

      // 3. Convert to List<Question>
      final questions = data.map((e) {
        return Question.fromMap(e as Map<String, dynamic>);
      }).toList();

      return questions;
    } catch (e) {
      // It's often good to throw the error so the Provider knows something failed
      print(e);
      throw Exception('Failed to fetch questions from Supabase: $e');
    }
  }

  Future<int>getVersion() async{
    try {
      final response = await _supabase
          .from('app_config')
          .select('value')
          .eq('key', 'version')
          .single();
      // Parse string "1" to int 1
      print('nigggaaaaa $response');
      return response['value'] as int;
    } catch (e) {
      // Default to 0 or throw error if version check fails
      print(e);
      return 0;
    }
  }



}