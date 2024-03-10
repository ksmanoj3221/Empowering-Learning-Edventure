import 'package:EmpoweringLearningEdventure/components/custom_buttons.dart';
import 'package:EmpoweringLearningEdventure/constants.dart';
import 'package:EmpoweringLearningEdventure/screens/home_screen/home_screen.dart';
import 'package:EmpoweringLearningEdventure/screens/home_screen/TeacherHomeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:EmpoweringLearningEdventure/auth/authenticationService.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  static String routeName = 'ForgetPasswordScreen';

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  late bool _passwordVisible = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late final AuthenticationService _authenticationService;
  late final FirebaseAuth _firebaseAuth;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  //validate our form now
  final _formKey = GlobalKey<FormState>();


  Future passwordReset() async {
    try {
      String email = emailController.text.trim();

      // Check if the email is already in use in Firestore
      QuerySnapshot query = await FirebaseFirestore.instance
          .collection('users')
          .where("email", isEqualTo: email)
          .get();
      print(query.docs);

      if (query.docs.isNotEmpty) {
        // Email exists in Firestore, send password reset email
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        showAlertDialog(context, 'Password reset email sent successfully. Check your email.');
      } else {
        // Email does not exist in Firestore
        showAlertDialog(context, 'Email does not exist in our records. Please enter a valid email address.');
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      showAlertDialog(context, e.message.toString());
    }
  }


// Call this function when the app initializes or after the user logs in
  void initializePasswordListener() {

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
              height: 40.h,
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
                  Text(
                    'Enter your email to get',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Text(
                    'Password reset link',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
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
                      padding: const EdgeInsets.fromLTRB(0.0,20.0,0.0,0.0),
                      child: Column(
                        children: [
                          sizedBox,
                          buildEmailField(),
                          sizedBox,
                          DefaultButton(
                            onPress: () {
                              passwordReset();
                            },
                            title: 'RESET PASSWORD',
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

  TextFormField buildEmailField() {
    return TextFormField(
      controller: emailController,
      textAlign: TextAlign.start,
      keyboardType: TextInputType.emailAddress,
      style: kInputTextStyle,
      decoration: InputDecoration(
        labelText: 'Email',
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: (value) {
        RegExp regExp = new RegExp(emailPattern);
        if (value == null) {
          return 'Please enter some text';
        } else if (value.isEmpty) {
          return 'Email cannot be empty';
        } else if (!regExp.hasMatch(value)) {
          return 'Please enter a valid email address';
        }
      },
    );
  }

  TextFormField buildPasswordField() {
    return TextFormField(
      controller: passwordController,
      obscureText: _passwordVisible,
      textAlign: TextAlign.start,
      keyboardType: TextInputType.visiblePassword,
      style: kInputTextStyle,
      decoration: InputDecoration(
        labelText: 'Password',
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
