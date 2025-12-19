// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filtered_questions_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$questionsBySubjectHash() =>
    r'5caf5a33e0d1048c4bd32d06088895e3e383b7e4';

/// See also [questionsBySubject].
@ProviderFor(questionsBySubject)
final questionsBySubjectProvider = FutureProvider<List<Question>>.internal(
  questionsBySubject,
  name: r'questionsBySubjectProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$questionsBySubjectHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef QuestionsBySubjectRef = FutureProviderRef<List<Question>>;
String _$filteredQuestionsHash() => r'25e33f181d9964e132e20914e8d675dcfdfbd8ac';

/// See also [filteredQuestions].
@ProviderFor(filteredQuestions)
final filteredQuestionsProvider = FutureProvider<List<Question>>.internal(
  filteredQuestions,
  name: r'filteredQuestionsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$filteredQuestionsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FilteredQuestionsRef = FutureProviderRef<List<Question>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
