import 'package:hive_flutter/adapters.dart';
part 'paper_model.g.dart';

@HiveType(typeId: 2)
class Paper{
  @HiveField(0)
  late String filePath;

  Paper({required this.filePath});
}