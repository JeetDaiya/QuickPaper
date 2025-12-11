// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuestionAdapter extends TypeAdapter<Question> {
  @override
  final int typeId = 0;

  @override
  Question read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Question(
      id: fields[0] as String,
      text: fields[1] as String,
      questionType: fields[2] as String,
      additionalData: (fields[3] as Map?)?.cast<String, dynamic>(),
      hasImage: fields[5] as bool,
      imageUrl: fields[7] as String?,
      chapter: fields[6] as String?,
      standard: fields[8] as String?,
      marks: fields[9] as int,
    )..subject = fields[4] as String?;
  }

  @override
  void write(BinaryWriter writer, Question obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.text)
      ..writeByte(2)
      ..write(obj.questionType)
      ..writeByte(3)
      ..write(obj.additionalData)
      ..writeByte(4)
      ..write(obj.subject)
      ..writeByte(5)
      ..write(obj.hasImage)
      ..writeByte(6)
      ..write(obj.chapter)
      ..writeByte(7)
      ..write(obj.imageUrl)
      ..writeByte(8)
      ..write(obj.standard)
      ..writeByte(9)
      ..write(obj.marks);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
