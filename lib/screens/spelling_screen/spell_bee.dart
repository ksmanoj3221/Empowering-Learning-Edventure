import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:EmpoweringLearningEdventure/screens/spelling_screen/controller.dart';
import 'package:EmpoweringLearningEdventure/screens/spelling_screen/home_page.dart';

class SpellBee extends StatelessWidget {
  const SpellBee({Key? key}) : super(key: key);
  static String routeName = 'SpellBee';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Controller(),
      child: _SpellBeeMain(),
    );
  }
}

class _SpellBeeMain extends StatelessWidget {
  const _SpellBeeMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Spelling Bee',
      theme: ThemeData(
        textTheme: const TextTheme(
          headline1: TextStyle(
            fontFamily: 'PartyConfetti',
            fontSize: 60,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}