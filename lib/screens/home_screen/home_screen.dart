import 'package:EmpoweringLearningEdventure/change_password/change_password.dart';
import 'package:EmpoweringLearningEdventure/constants.dart';
import 'package:EmpoweringLearningEdventure/screens/assignment_screen/assignment_screen.dart';
import 'package:EmpoweringLearningEdventure/screens/datesheet_screen/datesheet_screen.dart';
import 'package:EmpoweringLearningEdventure/screens/fee_screen/fee_screen.dart';
import 'package:EmpoweringLearningEdventure/screens/gallery_screen/gallery_screen.dart';
import 'package:EmpoweringLearningEdventure/screens/login_screen/login_screen.dart';
import 'package:EmpoweringLearningEdventure/screens/my_profile/my_profile.dart';
import 'package:EmpoweringLearningEdventure/screens/quiz_screen/quiz_screen.dart';
import 'package:EmpoweringLearningEdventure/screens/spelling_screen/spell_bee.dart';
import 'package:EmpoweringLearningEdventure/screens/video_screen/video_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'widgets/student_data.dart';
import 'package:EmpoweringLearningEdventure/auth/authenticationService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:EmpoweringLearningEdventure/screens/role_selection/role_selection.dart';
import 'package:EmpoweringLearningEdventure/screens/notice_screen/notice_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  static String routeName = 'HomeScreen';
  final AuthenticationService _authenticationService = AuthenticationService(FirebaseAuth.instance);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //we will divide the screen into two parts
          //fixed height for first half
          Container(
            width: 100.w,
            height: 30.h,
            padding: EdgeInsets.all(kDefaultPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 30.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        StudentName(
                          studentName: 'Aisha',
                        ),
                        kHalfSizedBox,
                        StudentClass(
                            studentClass: 'Class II A | Roll no: 12'),
                        kHalfSizedBox,
                        StudentYear(studentYear: '2023-2024'),
                      ],
                    ),
                    kHalfSizedBox,
                    StudentPicture(
                        picAddress: 'assets/images/student_profile.jpeg',
                        onPress: () {
                          // go to profile detail screen here
                          Navigator.pushNamed(
                              context, MyProfileScreen.routeName);
                        }),
                  ],
                ),
                sizedBox,

              ],
            ),
          ),

          //other will use all the remaining height of screen
          Expanded(
            child: Container(
              padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
              width: 100.w,
              decoration: BoxDecoration(
                color: kOtherColor,
                borderRadius: kTopBorderRadius,
              ),
              child: SingleChildScrollView(
                //for padding
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        HomeCard(
                          onPress: () {
                            Navigator.pushNamed(context, QuizScreen.routeName);
                          },
                          icon: 'assets/icons/quiz.svg',
                          title: 'Quiz',
                        ),

                        HomeCard(
                          onPress: () {},
                          icon: 'assets/icons/resume.svg',
                          title: 'Puzzle',
                        ),

                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        HomeCard(
                          onPress: () {
                            // Navigator.pushNamed(
                            //     context, NoticeScreen.routeName);
                          },
                          icon: 'assets/icons/story.svg',
                          title: 'Stories',
                        ),

                        HomeCard(
                          onPress: () {
                            // Navigator.pushNamed(
                            //     context, VideoScreen.routeName);
                          },
                          icon: 'assets/icons/gallery.svg',
                          title: 'Videos',
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        HomeCard(
                          onPress: () {
                            Navigator.pushNamed(
                                context, NoticeScreen.routeName);
                          },
                          icon: 'assets/icons/result.svg',
                          title: 'Notice',
                        ),

                        HomeCard(
                          onPress: () {
                            Navigator.pushNamed(
                                context, GalleryScreen.routeName);
                          },
                          icon: 'assets/icons/gallery.svg',
                          title: 'Gallery',
                        ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        HomeCard(
                          onPress: () {
                            // Navigator.pushNamed(
                            //     context, NoticeScreen.routeName);
                          },
                          icon: 'assets/icons/result.svg',
                          title: 'Missing Words',
                        ),

                        HomeCard(
                          onPress: () {
                            Navigator.pushNamed(
                                context, SpellBee.routeName);
                          },
                          icon: 'assets/icons/gallery.svg',
                          title: 'Blank Spelling',
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        HomeCard(
                          onPress: () {},
                          icon: 'assets/icons/holiday.svg',
                          title: 'Holidays',
                        ),
                        HomeCard(
                          onPress: () {},
                          icon: 'assets/icons/timetable.svg',
                          title: 'Time Table',
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        HomeCard(
                          onPress: () {
                            //go to assignment screen here
                            Navigator.pushNamed(
                                context, AssignmentScreen.routeName);
                          },
                          icon: 'assets/icons/assignment.svg',
                          title: 'Assignments',
                        ),

                        HomeCard(
                          onPress: () {
                            Navigator.pushNamed(
                                context, DateSheetScreen.routeName);
                          },
                          icon: 'assets/icons/datesheet.svg',
                          title: 'DateSheet',
                        ),

                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        HomeCard(
                          onPress: () {
                            Navigator.pushNamed(context, ChangePasswordScreen.routeName);
                          },
                          icon: 'assets/icons/lock.svg',
                          title: 'Change\nPassword',
                        ),
                        HomeCard(
                          onPress: () async {
                            // Perform logout when the card is pressed
                            await _authenticationService.logOut();
                            // Navigate back to the login screen or any other screen you want
                            Navigator.pushNamedAndRemoveUntil(context, RoleSelection.routeName,(route) => false);  // Go back to login screen
                          },
                          icon: 'assets/icons/logout.svg',
                          title: 'Logout',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeCard extends StatelessWidget {
  const HomeCard(
      {Key? key,
        required this.onPress,
        required this.icon,
        required this.title})
      : super(key: key);
  final VoidCallback onPress;
  final String icon;
  final String title;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        margin: EdgeInsets.only(top: 1.h),
        width: 40.w,
        height: 20.h,
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(kDefaultPadding / 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              height: SizerUtil.deviceType == DeviceType.tablet ? 30.sp : 40.sp,
              width: SizerUtil.deviceType == DeviceType.tablet ? 30.sp : 40.sp,
              color: kOtherColor,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
      ),
    );
  }
}