import 'package:flutter/material.dart';
import 'package:client/core/hive/models/question_model.dart';

class QuestionBody extends StatelessWidget {
  final Question question;

  const QuestionBody({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    switch (question.questionType) {
      case 'MCQ':
        return McqOptions(options: question.additionalData?['options']);

      case 'Match the Pairs':
        return MatchPairs(pairs: question.additionalData?['pairs']);

      case 'Table data':
        return QuestionTable(
          headers: question.additionalData?['headers'],
          rows: question.additionalData?['rows'],
        );

      case 'Comprehension':
        return ComprehensionQuestion(questions: question.additionalData?['questions']);

      case 'Fill in the blank':
      case 'True False':
      case 'Short answer':
      case 'Long answer':
      case 'Error Correction':
        return const SizedBox(); // nothing extra

      default:
        return const SizedBox();
    }
  }
}


class McqOptions extends StatelessWidget {
  final List<dynamic>? options;

  const McqOptions({super.key, required this.options});

  @override
  Widget build(BuildContext context) {
    if (options == null || options!.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: options!
          .map(
            (opt) => Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            opt.toString(),
            style: const TextStyle(fontSize: 14),
          ),
        ),
      )
          .toList(),
    );
  }
}

class MatchPairs extends StatelessWidget {
  final List<dynamic>? pairs;

  const MatchPairs({super.key, required this.pairs});

  @override
  Widget build(BuildContext context) {
    if (pairs == null || pairs!.isEmpty) return const SizedBox();

    return Column(
      children: pairs!
          .map(
            (pair) => Row(
          children: [
            Expanded(child: Text(pair['left'])),
            const Text(' — '),
            Expanded(child: Text(pair['right'])),
          ],
        ),
      )
          .toList(),
    );
  }
}


class ComprehensionQuestion extends StatelessWidget{
    final List<dynamic>questions;
    const ComprehensionQuestion({
        super.key,
        required this.questions,
    });
    
    @override
    Widget build(BuildContext context){
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
            children: questions.map((question) {
              return Text(question['text'].toString().trim());
            }).toList()
        );
    }
}

class QuestionTable extends StatelessWidget {
  final List<dynamic>? headers;
  final List<dynamic>? rows;

  const QuestionTable({
    super.key,
    required this.headers,
    required this.rows,
  });

  @override
  Widget build(BuildContext context) {
    if (headers == null || rows == null) return const SizedBox();

    return Table(
      border: TableBorder.all(color: Colors.grey.shade300),
      children: [
        TableRow(
          decoration: BoxDecoration(color: Colors.grey.shade200),
          children: headers!
              .map((h) => Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              h.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ))
              .toList(),
        ),
        ...rows!.map(
              (row) => TableRow(
            children: row
                .map<Widget>(
                  (cell) => Padding(
                padding: const EdgeInsets.all(8),
                child: Text(cell.toString()),
              ),
            )
                .toList(),
          ),
        ),
      ],
    );
  }
}
