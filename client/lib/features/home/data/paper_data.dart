import 'package:client/core/hive/hive_boxes.dart';
import 'package:client/core/hive/models/paper_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'paper_data.g.dart';

@riverpod
PaperLocalDataSource paperLocalDataSource(PaperLocalDataSourceRef ref){
  return PaperLocalDataSource();
}

class PaperLocalDataSource{
  final Box<Paper> _paperBox = Hive.box<Paper>(HiveBoxes.madePapersBox);

  List<Paper>getPapers(){
    return _paperBox.values.toList();
  }



}