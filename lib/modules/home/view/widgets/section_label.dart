import 'package:flutter/material.dart';
  

class SectionLabel extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  const SectionLabel({super.key, required this.onTap, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
         
        ],
      ),
    );
  }
}
