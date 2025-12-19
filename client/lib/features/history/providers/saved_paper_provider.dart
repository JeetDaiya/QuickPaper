import 'package:client/core/hive/models/paper_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../repository/saved_papers_repository.dart';

part 'saved_paper_provider.g.dart';

@riverpod
List<Paper>getPapers(GetPapersRef ref){
    final repository = ref.watch(savedPapersRepositoryProvider);
    return repository.getPapers();

}
