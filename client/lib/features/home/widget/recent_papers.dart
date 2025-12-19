import 'dart:math';

import 'package:client/core/hive/models/paper_model.dart';
import 'package:client/features/history/providers/saved_paper_provider.dart';
import 'package:client/features/history/repository/saved_papers_repository.dart';
import 'package:client/features/history/view/history_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_file/open_file.dart';

class RecentPapers extends ConsumerWidget {
  const RecentPapers({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final papers = ref.watch(getPapersProvider);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Paper',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => HistoryScreen()),
                );
              },
              child: Text(
                'View All',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
          ],
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: min(papers.length, 10),
          itemBuilder: (context, index) {
            final paper = papers[index];
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Subject : ${paper.subject}",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          paper.dateOfCreation,
                          softWrap: true,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.remove_red_eye_outlined,
                            color: Colors.grey[700],
                          ),
                          color: Colors.redAccent,
                          onPressed: () {
                            OpenFile.open(
                                paper.filePath,
                              type: 'application/pdf'
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
