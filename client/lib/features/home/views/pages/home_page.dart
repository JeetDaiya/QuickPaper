import 'package:client/core/theme/app_pallete.dart';
import 'package:client/features/home/widget/stat_widget.dart';
import 'package:client/features/questions/providers/filtered_questions_provider.dart';
import 'package:client/features/questions/providers/marks_filter_provider.dart';
import 'package:client/features/questions/providers/marks_options_provider.dart';
import 'package:client/features/questions/providers/question_type_filter_provider.dart';
import 'package:client/features/questions/view/question_screen.dart';
import 'package:client/features/questions/view/selected_questions_preview_screen.dart';
import 'package:client/features/questions/viewmodel/question_viewmodel.dart';
import 'package:client/features/subject/providers/paper_flow_provider.dart';
import 'package:client/features/subject/providers/selected_subject_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../questions/providers/selected_questions_provider.dart';
import '../../../subject/domain/subject.dart';
import '../../../subject/view/subject_picker_sheet.dart';



class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
    @override
    Widget build(BuildContext context) {
      final status = ref.watch(paperFlowProvider);
      int selectedIndex = 0;
      return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: status == PaperStep.selectQuestions ? Padding(
            padding: EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: FloatingActionButton.extended(
              backgroundColor: Colors.white,
                onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => QuestionScreen()));
            }, label: Row(
              children: [
                const Text('Continue Making Paper', style: TextStyle(color: Pallete.primaryColor, fontSize: 16),),
                const SizedBox(width: 10),
                const Icon(Icons.arrow_forward_outlined, color: Pallete.primaryColor,)

              ],
            )),
          ),
        ) : null,
        body: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AppBar(
                elevation: 0,
                toolbarHeight: 130,
                titleTextStyle: TextStyle(color: Colors.white),
                backgroundColor: Pallete.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                title: Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10, bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome,',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Let's create something great today",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 140,
              left: 20,
              right: 20,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.15,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54,
                      offset: const Offset(0.0, 6.0),
                      blurRadius: 12.0,
                      spreadRadius: 0.0,
                    ), //BoxShadow
                  ],
                ),
                child: StatWidget(),
              ),
            ),
            Positioned(
              top: 300,
              left: 20,
              right: 20,
              child: GestureDetector(
                onTap: () async {
                  if(status == PaperStep.selectSubject){
                    final selected = await showModalBottomSheet<Subject>(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                      ),
                      builder: (_) => SafeArea(child: const SubjectPickerSheet()),
                    );
                    if (!context.mounted) return;
                    if (selected != null && mounted) {
                      ref.read(paperFlowProvider.notifier).goToQuestions();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const QuestionScreen(),
                        ),
                      );
                    }
                  }
                  else {
                    showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                            title: Text("Resume Paper?"),
                            content: Text("You have an unfinished paper."),
                            actions: [
                              TextButton(
                                  child: Text("Discard Old"),
                                  onPressed: () {
                                    // Reset and start new
                                    ref.read(selectedQuestionsProvider.notifier).clear();
                                    ref.read(selectedSubjectProvider.notifier).clear();
                                    ref.read(paperFlowProvider.notifier).goToSubject();
                                    ref.invalidate(questionViewmodelProvider);
                                    Navigator.pop(ctx);
                                  }
                              ),
                              TextButton(
                                  child: Text("Continue"),
                                  onPressed: () {
                                    // Just navigate to screen
                                    Navigator.pop(ctx);
                                  }
                              )
                            ]
                        )
                    );
                  }
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Pallete.primaryColor
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_outlined , color: Colors.white,),
                      const SizedBox(width: 10),
                      Text(
                        'Create New Paper',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: Colors.grey.shade200, width: 1),
            ), // Subtle top border
          ),
          child: BottomNavigationBar(
            elevation: 0, // Flat look
            backgroundColor: Colors.white,
            selectedItemColor: Colors.blue[800],
            unselectedItemColor: Colors.grey[600],
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
            currentIndex: 0, // Update this dynamically

            onTap: (value) {
              // Your navigation logic here
              if (value == selectedIndex) return;
              setState(() {
                selectedIndex = value;
              });
              if (value == 0) { Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const HomePage()),
              );}
             else if (value == 1) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SelectedQuestionsPreviewScreen(),
                  ),
                );
              }
            },

            items: [
              BottomNavigationBarItem(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    // Subtle highlighting for the icon only
                    color: 0 == 0
                        ? Colors.blue.withOpacity(0.1)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.home_rounded),
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.checklist_rtl_rounded),
                label: 'Preview',
              ),
            ],
          ),
        ),
      );
    }
  }

