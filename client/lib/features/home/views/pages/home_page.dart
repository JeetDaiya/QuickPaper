import 'package:client/core/theme/app_pallete.dart';
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
            top: 130,
            left: 25,
            right: 25,
            child: Container(
              height: 125,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10),
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
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 240, 253, 250),
                              borderRadius: BorderRadius.circular(5.0)

                          ),
                          height: 40,
                          width: 40,
                          child: Icon(Icons.insert_drive_file_rounded, color: Color.fromARGB(255, 26, 150, 136), size: 30),
                        ),
                        SizedBox(width: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '45',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              'Papers Created',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black54,
                              ),
                            )
                          ],
                        )

                      ],
                    ),
                    const SizedBox(width: 10),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 239, 246, 255),
                              borderRadius: BorderRadius.circular(5.0)

                          ),
                          height: 40,
                          width: 40,
                          child: Icon(Icons.question_answer, color: Color.fromARGB(255, 23, 95, 252), size: 30,),
                        ),
                        SizedBox(width: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '1001',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              'Questions in\nbank',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.black54,
                              ),
                            )
                          ],
                        )

                      ],
                    )
                  ]
              ),
            ),
          ),


        ],
      ),
    );
  }
}


