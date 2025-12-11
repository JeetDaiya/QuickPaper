// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paper_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PaperAdapter extends TypeAdapter<Paper> {
  @override
  final int typeId = 2;

  @override
  Paper read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Paper(
      filePath: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Paper obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.filePath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaperAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
