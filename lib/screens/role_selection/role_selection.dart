import 'package:EmpoweringLearningEdventure/components/custom_buttons.dart';
import 'package:EmpoweringLearningEdventure/screens/login_screen/teacher_login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:EmpoweringLearningEdventure/screens/login_screen/login_screen.dart';
import 'package:EmpoweringLearningEdventure/constants.dart';

class RoleSelection extends StatefulWidget {
  const RoleSelection({super.key});

  static String routeName = 'RoleSelection';

  @override
  State<RoleSelection> createState() => _RoleSelectionState();
}

class _RoleSelectionState extends State<RoleSelection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: 100.w,
            height: 40.h,
            child: Column(children: [
              SizedBox(height: 55.0),
              Image.asset(
                'assets/images/logo.png',
                height: 20.h,
                width: 35.w,
              ),
              Text(
                'Empowering Learning',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontSize: 34.0),
              ),
              Text(
                'Edventure',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontSize: 34.0),
              ),
              SizedBox(
                height: kDefaultPadding / 2,
              ),
            ]),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              decoration: BoxDecoration(
                color: kOtherColor,
                borderRadius: kTopBorderRadius,
              ),
              child: Form(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        width: 100.w,
                        height: 20.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0,20.0),
                        child: Text(
                          'Select your profile to login:',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                  color: kTextBlackColor,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(height: kDefaultPadding / 2),
                      RoleButton(
                        onPress: () {
                          Navigator.pushNamed(context, TeacherLoginScreen.routeName);
                        },
                        title: 'Teacher',
                      ),
                      sizedBox,
                      RoleButton(onPress: () {
                        Navigator.pushNamed(context, LoginScreen.routeName);
                      }, title: 'Student')
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
