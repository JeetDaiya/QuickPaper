import 'package:client/core/theme/app_pallete.dart';
import 'package:client/features/home/widget/stat_widget.dart';
import 'package:client/features/questions/view/question_screen.dart';
import 'package:client/features/questions/view/selected_questions_preview_screen.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey.shade200, width: 1)), // Subtle top border
        ),
        child: BottomNavigationBar(
          elevation: 0, // Flat look
          backgroundColor: Colors.white,
          selectedItemColor: Colors.blue[800],
          unselectedItemColor: Colors.grey[600],
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
          currentIndex: 0, // Update this dynamically

          onTap: (value) {
            // Your navigation logic here
            if(value == 0) return;
            if(value == 1) {Navigator.of(context).push(MaterialPageRoute(builder: (context) => const QuestionScreen()));}
            else if(value == 2) {Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SelectedQuestionsPreviewScreen()));}
          },

          items: [
            BottomNavigationBarItem(
              icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    // Subtle highlighting for the icon only
                    color: 0 == 0 ? Colors.blue.withOpacity(0.1) : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.home_rounded)
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.article_outlined),
              label: 'Questions',
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


