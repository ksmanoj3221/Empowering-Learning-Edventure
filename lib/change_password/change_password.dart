import 'package:EmpoweringLearningEdventure/components/custom_buttons.dart';
import 'package:EmpoweringLearningEdventure/constants.dart';
import 'package:EmpoweringLearningEdventure/screens/home_screen/home_screen.dart';
import 'package:EmpoweringLearningEdventure/screens/home_screen/TeacherHomeScreen.dart';
import 'package:EmpoweringLearningEdventure/screens/role_selection/role_selection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:EmpoweringLearningEdventure/auth/authenticationService.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  static String routeName = 'ChangePasswordScreen';

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  late bool _passwordVisible = true;
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  late final AuthenticationService _authenticationService;
  late final FirebaseAuth _firebaseAuth;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  //validate our form now
  final _formKey = GlobalKey<FormState>();

  var auth = FirebaseAuth.instance;
  var currentUser = FirebaseAuth.instance.currentUser;

  changePassword(email, oldPassword, newPassword) async {
    var cred = EmailAuthProvider.credential(
        email: email, password: oldPassword);
    String content = "Password Changed successfully, Log in Again";
    await currentUser?.reauthenticateWithCredential(cred).then((value) {
      currentUser?.updatePassword(newPassword);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Success',
              style: TextStyle(color: kPrimaryColor),
            ),
            content: Text(
              content,
              style: TextStyle(
                  color: kTextBlackColor,
                  fontWeight: FontWeight.w100
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () async {
                  // Logout the user
                  await FirebaseAuth.instance.signOut();
                  // Navigate to the role selection screen
                  Navigator.pushNamedAndRemoveUntil(context, RoleSelection.routeName, (route) => false);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                ),
                child: Text(
                  'OK',
                  style: TextStyle(color: kTextWhiteColor),
                ),
              ),
            ],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            backgroundColor: kOtherColor,
          );
        },
      );
    }).catchError((error) {
      print(error.toString());
    });
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Column(
          children: [
            Container(
              width: 100.w,
              height: 35.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 35.0),
                  Image.asset(
                    'assets/images/logo.png',
                    height: 25.h,
                    width: 40.w,
                  ),
                  // Text(
                  //   'Enter your email to get',
                  //   style: Theme.of(context).textTheme.titleSmall,
                  // ),
                  // Text(
                  //   'Password reset link',
                  //   style: Theme.of(context).textTheme.titleSmall,
                  // ),
                  SizedBox(
                    height: kDefaultPadding / 2,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                decoration: BoxDecoration(
                  color: kOtherColor,
                  borderRadius: kTopBorderRadius,
                ),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                      child: Column(
                        children: [
                          sizedBox,
                          buildOldPasswordField(),
                          sizedBox,
                          buildNewPasswordField(),
                          sizedBox,
                          DefaultButton(
                            onPress: () async {
                              await changePassword(
                                  FirebaseAuth.instance.currentUser?.email,
                                  oldPasswordController.text.toString(),
                                  newPasswordController.text.toString()
                              );
                            },
                            title: 'CHANGE PASSWORD',
                            iconData: Icons.arrow_forward_outlined,
                          ),
                          sizedBox,

                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextFormField buildOldPasswordField() {
    return TextFormField(
      controller: oldPasswordController,
      obscureText: _passwordVisible,
      textAlign: TextAlign.start,
      keyboardType: TextInputType.visiblePassword,
      style: kInputTextStyle,
      decoration: InputDecoration(
        labelText: 'Enter Old Password',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
          icon: Icon(
            _passwordVisible
                ? Icons.visibility_off_outlined
                : Icons.visibility_off_outlined,
          ),
          iconSize: kDefaultPadding,
        ),
      ),
      validator: (value) {
        if (value!.length < 5) {
          return 'Must be more than 5 characters';
        }
      },
    );
  }

  TextFormField buildNewPasswordField() {
    return TextFormField(
      controller: newPasswordController,
      obscureText: _passwordVisible,
      textAlign: TextAlign.start,
      keyboardType: TextInputType.visiblePassword,
      style: kInputTextStyle,
      decoration: InputDecoration(
        labelText: 'Enter New Password',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
          icon: Icon(
            _passwordVisible
                ? Icons.visibility_off_outlined
                : Icons.visibility_off_outlined,
          ),
          iconSize: kDefaultPadding,
        ),
      ),
      validator: (value) {
        if (value!.length < 5) {
          return 'Must be more than 5 characters';
        }
      },
    );
  }
}
