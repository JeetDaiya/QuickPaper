import 'package:client/features/questions/data/local_data.dart';
import 'package:client/features/questions/data/remote_data.dart';
import 'package:client/core/hive/models/question_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'questions_repository.g.dart';

@riverpod
QuestionRepository questionRepository(QuestionRepositoryRef ref){
  final local = ref.watch(questionLocalDataSourceProvider);
  final remote = ref.watch(questionRemoteDataSourceProvider);
  return QuestionRepository(local, remote);
}

class QuestionRepository {
  final QuestionLocalDataSource _local;
  final QuestionRemoteDataSource _remote;

  QuestionRepository(this._local, this._remote,);

  Future<List<Question>>getQuestions() async {
    try{
      final localVersion = _local.getDataVersion();
      final remoteVersion = await _remote.getVersion();

      if(localVersion < remoteVersion){
        Future.delayed(const Duration(seconds: 5));
        final freshData = await _remote.getQuestions();
        await _local.cacheQuestion(freshData);
        await _local.setDataVersion(remoteVersion);
        return freshData;
      }else{
        return _local.getQuestion();
      }
    }catch(error){
      try{
        final cached = _local.getQuestion();
        return cached;
      }catch(_){
       throw Exception('Error loading question, check you internet and try again.');
      }
    }
  }

  Future<int>getTotalQuestions() async {
    try {
      final localVersion = _local.getDataVersion();
      final remoteVersion = await _remote.getVersion();
      if (localVersion < remoteVersion) {
        Future.delayed(const Duration(seconds: 5));
        final freshData = await _remote.getQuestions();
        await _local.cacheQuestion(freshData);
        await _local.setDataVersion(remoteVersion);
        return freshData.length;
      } else {
        return _local
            .getQuestion()
            .length;
      }
    }catch(error){
      try{
        final cached = _local.getQuestion();
        return cached.length;
    }
      catch(_){
        throw Exception('Error loading question, check you internet and try again.');
      }
    }
  }
}