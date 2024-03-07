import 'dart:io';
import 'dart:ui';
import 'package:EmpoweringLearningEdventure/routes.dart';
import 'package:EmpoweringLearningEdventure/screens/splash_screen/splash_screen.dart';
import 'package:EmpoweringLearningEdventure/theme.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  print(Firebase.apps.isEmpty);
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid ? await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyBqUssAGcVgx6qGBYLrRQYTHIqQSZfvEXo',
          appId: '1:853621482876:android:1ae5596f15b98342e530f9',
          messagingSenderId: '853621482876',
          projectId: 'empowering-learning-edve-d550f'
      )
  ) : await Firebase.initializeApp();
  runApp(MyApp());
  print(Firebase.apps.isEmpty);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //it requires 3 parameters
    //context, orientation, device
    //it always requires, see plugin documentation
    return Sizer(builder: (context, orientation, device){
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'School Brain',
        theme: CustomTheme().baseTheme,
        //initial route is splash screen
        //mean first screen
        initialRoute: SplashScreen.routeName,
        //define the routes file here in order to access the routes any where all over the app
        routes: routes,
      );
    });
  }
}