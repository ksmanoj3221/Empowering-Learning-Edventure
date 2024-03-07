import 'package:flutter/material.dart';
import 'package:EmpoweringLearningEdventure/constants.dart';

class NoticeScreen extends StatelessWidget {
  const NoticeScreen({Key? key}) : super(key: key);
  static String routeName = 'NoticeScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Notice Panel',
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: kPrimaryColor,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              child: Text(
                'Important Announcement !!!',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 12),
              color: Colors.red,
            ),
            SizedBox(height: 20), // Adding space between text and image
            Image(
              image: AssetImage('assets/images/notice.jpg'),
              width: 350,
              height: 350,
            ),
          ],
        ),
      ),
    );
  }
}
