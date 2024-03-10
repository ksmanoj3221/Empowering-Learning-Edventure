import 'package:EmpoweringLearningEdventure/components/custom_buttons.dart';
import 'package:EmpoweringLearningEdventure/constants.dart';
import 'package:EmpoweringLearningEdventure/screens/reset_password/reset_password.dart';
import 'package:EmpoweringLearningEdventure/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:EmpoweringLearningEdventure/auth/authenticationService.dart';
import 'package:firebase_core/firebase_core.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = 'LoginScreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late bool _passwordVisible = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late final AuthenticationService _authenticationService;
  late final FirebaseAuth _firebaseAuth;
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  //validate our form now
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _passwordVisible = true;
    _authenticationService = AuthenticationService(FirebaseAuth.instance);
    _firebaseAuth = FirebaseAuth.instance;
  }

  // Future<void> loginUser(String email, String password) async {
  //   try {
  //     // Use the login function from AuthenticationService
  //     await _authenticationService.login(context, email, password);
  //
  //     // Log the authentication state
  //     print("Auth state after login: ${FirebaseAuth.instance.currentUser}");
  //
  //     // Fetch user role from Firestore
  //     String? userRole = await _authenticationService
  //         .getUserRole(FirebaseAuth.instance.currentUser!.uid);
  //     print("userRole : $userRole");
  //
  //     // Navigate based on user role
  //     if (userRole == 'student') {
  //       // Navigate to student screen
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(builder: (context) => HomeScreen()),
  //       );
  //     } else if (userRole == 'teacher') {
  //       // Navigate to teacher screen
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(builder: (context) => TeacherHomeScreen()),
  //       );
  //     } else {
  //       // Handle unknown or missing role
  //       print('Unknown or missing user role');
  //     }
  //   } on FirebaseAuthException catch (ex) {
  //     // Show an alert dialog for incorrect login
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text('Alert..'),
  //           content: Text('Incorrect email or password'),
  //           actions: [
  //             ElevatedButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop(); // Close the dialog
  //               },
  //               child: Text('OK'),
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   }
  // }


  Future<void> login(
      BuildContext context, String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Log the authentication state
      print("Auth state after login: ${FirebaseAuth.instance.currentUser}");

      // Fetch user role from Firestore
      String? userRole = await _authenticationService
          .getUserRole(FirebaseAuth.instance.currentUser!.uid);
      print("userRole : $userRole");

      // Navigate based on user role
      if (userRole == 'student') {
        // Navigate to student screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );

      } else {
        // Handle unknown or missing role
        // Email/password account does not exist
        showAlertDialog(context, 'No account found');
      }
    } on FirebaseAuthException catch (ex) {
      // Show an alert dialog for incorrect login
      showAlertDialog(context,'Incorrect email or password');
    }
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
                    'assets/images/splash.png',
                    height: 20.h,
                    width: 40.w,
                  ),
                  Text(
                    'Hi Student',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    'Sign in to continue',
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
                    child: Column(
                      children: [
                        sizedBox,
                        buildEmailField(),
                        sizedBox,
                        buildPasswordField(),
                        sizedBox,
                        DefaultButton(
                          onPress: () {
                            login(
                              context,
                              emailController.text.toString(),
                              passwordController.text.toString(),
                            );
                          },
                          title: 'SIGN IN',
                          iconData: Icons.arrow_forward_outlined,
                        ),
                        sizedBox,
                        Align(
                          alignment: Alignment.bottomRight,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => ResetPasswordScreen()),
                              );
                            },
                            child: Text(
                              'Forgot Password',
                              textAlign: TextAlign.end,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                        ),
                      ],
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
