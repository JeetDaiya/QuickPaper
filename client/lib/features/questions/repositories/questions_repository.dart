import 'package:client/features/questions/data/local_data.dart';
import 'package:client/features/questions/data/remote_data.dart';
import 'package:client/core/hive/models/question_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'questions_repository.g.dart';

@riverpod
QuestionRepository questionRepository(QuestionRepositoryRef ref) {
  final local = ref.watch(questionLocalDataSourceProvider);
  final remote = ref.watch(questionRemoteDataSourceProvider);
  return QuestionRepository(local, remote);
}

class QuestionRepository {
  final QuestionLocalDataSource _local;
  final QuestionRemoteDataSource _remote;

  QuestionRepository(this._local, this._remote);

  Future<List<Question>> getQuestions() async {
    try {
      final localVersion = _local.getDataVersion();
      int remoteVersion = localVersion;
      try {
        remoteVersion = await _remote.getVersion();
      } catch (_) {
        throw Exception('Could not fetch remote version. Using offline questions');
      }

      final localData = _local.getQuestion();

      print(remoteVersion);

      if (localVersion < remoteVersion || localData.isEmpty) {

        print("🔄 Syncing... (Local: $localVersion, Remote: $remoteVersion)");

        final freshData = await _remote.getQuestions();

        if (freshData.isNotEmpty) {
          await _local.cacheQuestion(freshData);
          await _local.setDataVersion(remoteVersion);
          return freshData;
        }
      }

      // Local is up to date OR we are offline
      if (localData.isNotEmpty) {
        return localData;
      }

      // No internet and No local data
      throw Exception('No data available');

    } catch (error) {
      // Try to return whatever is in cache
      final cached = _local.getQuestion();
      if (cached.isNotEmpty) return cached;

      throw Exception('Error loading questions. Check your internet connection.');
    }
  }

  Future<int> getTotalQuestions() async {
    final questions = await getQuestions();
    return questions.length;
  }
}