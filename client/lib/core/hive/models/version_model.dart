import 'package:hive_flutter/adapters.dart';
part 'version_model.g.dart';

@HiveType(typeId: 1)
class Version{
  @HiveField(0)
  late int version;

  Version({required this.version});
}