import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About"),
      ),
      body: Padding(
        padding: EdgeInsets.all(6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20, top: 10),
              child: Text(
                "About Elamly’s Market",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
            ),
            Text(
              "Elamly’s Market is your trusted destination for quality products at competitive prices. We specialize in offering a wide range of items to meet your everyday needs—from fresh groceries and household essentials to specialty goods and seasonal items. At Elamly’s Market, customer satisfaction is our top priority. We are committed to providing a convenient and reliable shopping experience, both in-store and online. Whether you’re stocking up for the week or searching for something unique, Elamly’s Market has you covered with friendly service and products you can count on.",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
            ),
          ],
        ),
      ),
    );
  }
}
