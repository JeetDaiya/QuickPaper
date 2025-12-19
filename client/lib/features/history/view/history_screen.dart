import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_file/open_file.dart';
import '../../../core/theme/app_pallete.dart';
import '../providers/saved_paper_provider.dart';
import '../repository/saved_papers_repository.dart';

class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  ConsumerState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    final papersList = ref.watch(getPapersProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
      ),
      body: papersList.isEmpty ?
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Color(0xFFE5E7EB),
              child: Icon(
                Icons.not_interested_outlined,
                color: Color(0xFF9AA0A6),
                size: 50,
              ),
            ),
            const SizedBox(height: 10),
            Text(
                'No Papers Made',
                style: TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            Text(
              'Create some papers to view them here',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () => {
                  Navigator.of(context).pop()
              },
              style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Pallete.primaryColor),
                  padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                  shape: WidgetStateProperty.all(RoundedRectangleBorder( borderRadius: BorderRadius.circular(10) ))
              ),
              child: Text(
                'Go To Home Page',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w300
                ),
              ),
            ),
          ],
        ),
      ) :
          ListView.builder(
            itemCount: papersList.length,
              itemBuilder: (context , index){
              final paper = papersList[index];
          return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  "Subject : ${paper.subject}",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  paper.dateOfCreation,
                  softWrap: true,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
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
                    OpenFile.open(paper.filePath);
                  },
                ),
                IconButton(
                  icon: const Icon(
                    Icons.delete_outline,
                  ),
                  color: Colors.redAccent,
                  onPressed: () {
                      showDialog(context: context, builder: (context) => AlertDialog(
                          title: Text("Delete Paper?"),
                          content: Text("Deleting will remove the paper from your history permanently."),
                          actions: [
                            TextButton(
                                child: Text("Discard Old"),
                                onPressed: () {
                                  // Delete paper
                                  ref.read(savedPapersRepositoryProvider).deletePaper(index);
                                  ref.invalidate(getPapersProvider);
                                  if(context.mounted){
                                  Navigator.pop(context);}
                                }
                            ),
                            TextButton(
                                child: Text("Cancel"),
                                onPressed: () {
                                  // Just navigate to screen
                                  Navigator.pop(context);
                                }
                            )
                          ]
                      ));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  })



    );
  }
}
