import 'package:client/features/home/models/stat_model.dart';
import 'package:client/features/home/data/paper_data.dart';
import 'package:client/features/questions/repositories/questions_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'stat_viewmodel.g.dart';

@riverpod
class StatViewmodel extends _$StatViewmodel {
  @override
  FutureOr<StatModel>build() async{
    return _getStats();
  }


  FutureOr<StatModel>_getStats() async{
    final totalQuestions = await ref.watch(questionRepositoryProvider).getTotalQuestions();
    final paperCreated = ref.watch(paperLocalDataSourceProvider).getPapers().length;
    return StatModel(
      paperCreated: paperCreated,
      totalQuestions: totalQuestions
    );
  }

  Future<void>refresh() async{
    state = const AsyncValue.loading();
    state = AsyncValue.data(await _getStats());
  }
}
