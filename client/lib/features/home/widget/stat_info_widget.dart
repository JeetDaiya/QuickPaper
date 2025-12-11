import 'package:flutter/material.dart';

class StatInfoCard extends StatelessWidget {
  final String text1;
  final String text2;
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;


  const StatInfoCard({super.key, required this.text1, required this.text2, required this.icon, required this.backgroundColor, required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Container(
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(5.0),
              ),
              height: 40,
              width: 40,
              child: Icon(
                icon,
                color: iconColor,
                size: 30,
              ),
            ),
          ),
          SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text1,
                style: TextStyle(fontSize: 20),
              ),
              Text(
                text2,
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
