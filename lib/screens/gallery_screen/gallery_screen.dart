import 'package:flutter/material.dart';
import 'package:EmpoweringLearningEdventure/constants.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({Key? key}) : super(key: key);
  static String routeName = 'GalleryScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gallery',
        style: TextStyle(
          fontWeight: FontWeight.w500,
        ),),
      ),
      body: Container( // Wrap the body with Container
        color: Colors.grey, // Set the background color here
        child: SafeArea(
          child: ListView(
            children: [
              SizedBox(height: 40),
              ImageItem(imageUrl: 'assets/images/Teacher_Student.png'),
              SizedBox(height: 40),
              ImageItem(imageUrl: 'assets/images/Shreedhar.png'),
              SizedBox(height: 40),
              ImageItem(imageUrl: 'assets/images/Manoj.png'),
              // Add more ImageItems as needed
            ],
          ),
        ),
      ),
    );
  }
}

class ImageItem extends StatelessWidget {
  final String imageUrl;

  const ImageItem({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.black, width: 1.0), // Add border
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.asset(
          imageUrl,
          width: 250, // Adjust the width as needed
          height: 250, // Adjust the height as needed
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}