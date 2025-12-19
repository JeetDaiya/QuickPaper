import 'package:hive_flutter/hive_flutter.dart';
import 'package:client/core/hive/models/paper_model.dart';
import 'package:client/core/hive/hive_boxes.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'saved_papers_repository.g.dart';

@riverpod
SavedPapersRepository savedPapersRepository(SavedPapersRepositoryRef ref){
  return SavedPapersRepository();
}

class SavedPapersRepository{
  final Box<Paper> _papersBox = Hive.box<Paper>(HiveBoxes.madePapersBox);
  Future<void>addPaper(Paper paper)async{
    await _papersBox.add(paper);
  }

  List<Paper>getPapers(){
    final formatter = DateFormat.yMMMMd();
    final paperList = _papersBox.values.toList();
    paperList.sort(
            (a, b) {
          DateTime dateA = formatter.parse(a.dateOfCreation);
          DateTime dateB = formatter.parse(b.dateOfCreation);
          return dateB.compareTo(dateA);}
    );

    return paperList;
  }

  Future<void>deletePaper(int index)async{
    await _papersBox.deleteAt(index);
  }


}