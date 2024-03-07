import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:EmpoweringLearningEdventure/screens/home_screen/home_screen.dart';
import 'package:EmpoweringLearningEdventure/screens/home_screen/TeacherHomeScreen.dart';

class AuthenticationService{
  late final FirebaseAuth _firebaseAuth;
  AuthenticationService(this._firebaseAuth);
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> login(BuildContext context, String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Log the authentication state
      print("Auth state after login: ${FirebaseAuth.instance.currentUser}");

      // Fetch user role from Firestore
      String? userRole = await getUserRole(FirebaseAuth.instance.currentUser!.uid);
      print("userRole : $userRole");

      // Navigate based on user role
      if (userRole == 'student') {
        // Navigate to student screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else if (userRole == 'teacher') {
        // Navigate to teacher screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => TeacherHomeScreen()),
        );
      } else {
        // Handle unknown or missing role
        print('Unknown or missing user role');
      }
    } on FirebaseAuthException catch (ex) {
      // Show an alert dialog for incorrect login
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Alert..'),
            content: Text('Incorrect email or password'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }


  Future<void> logOut() async{
    await _firebaseAuth.signOut();
  }

  Future<String?> getUserRole(String userId) async{
    try{
      // Retrieve user role from Firestore
      DocumentSnapshot<Map<String,dynamic>> userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
      if(userDoc.exists){
        // If user document exists, return the role
        return userDoc.get('role');
      } else{
        return null;
      }
    } catch(e) {
      print("Error fetching user role $e");
      return null;
    }
  }
}

