// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filtered_questions_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$questionsBySubjectHash() =>
    r'3b0fec51c22fc846f2a85dab7463d462a6a26fef';

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
String _$filteredQuestionsHash() => r'2553c3066a7c71c4e450e47dc8767d4f9a0e2ac9';

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
