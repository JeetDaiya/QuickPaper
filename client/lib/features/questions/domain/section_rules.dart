import 'package:client/features/questions/domain/paper_section.dart';

final sections = [
  PaperSection(
    title: 'SECTION A',
    sectionInstruction:
    'Answer all questions. Each question carries 1 mark.',
    matcher: (q) => q.marks == 1,
  ),

  PaperSection(
    title: 'SECTION B',
    sectionInstruction:
    'Answer any FIVE questions. Each question carries 2 marks.',
    matcher: (q) => q.marks == 2,
  ),

  PaperSection(
    title: 'SECTION C',
    sectionInstruction:
    'Answer any FOUR questions. Each question carries 3 marks.',
    matcher: (q) => q.marks == 3,
  ),

  PaperSection(
    title: 'SECTION D',
    sectionInstruction:
    'Answer any THREE questions. Each question carries 4 marks.',
    matcher: (q) =>
    q.marks == 4 && q.questionType != 'MAP_WORK',
  ),

  PaperSection(
    title: 'SECTION E',
    sectionInstruction:
    'Attempt the following special questions.',
    matcher: (q) => q.questionType == 'MAP_WORK',
  ),
];
