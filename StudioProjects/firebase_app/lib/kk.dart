import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/loginpage.dart';
import 'package:firebase_app/utils/custom_Textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();


  signupAuthenticate(email, password, name) async {
    try {
      var ref = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      if (ref.user!.uid != null) {
        print("Account created");
        await registration(name, email, password,ref.user!.uid);
        await saveUserDataToFirestore(ref.user!.uid);
      }
    } catch (e) {
      print("Authentication exception");
    }
  }

  registration(name, email, password, docid) async {
    var data = {
      "name": name,
      "email": email,
      "password": password,

    };
    final ref = FirebaseFirestore.instance.collection("Users").doc(docid).set(data);
  }

  Future<void> saveUserDataToFirestore(String userId) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'name': nameController.text,
        'email': emailController.text,
        'password': passController.text,

      });
      print('User data saved successfully.');
    } catch (e) {
      print('Error saving user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Photo Storage",
            style: TextStyle(
              color: Colors.purple,
              fontSize: 26,
            ),
          ),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(4),
          child: Text(
            "ENABLE . TRANSFORM . ACCELERATE",
            style: TextStyle(color: Colors.purple, fontSize: 10),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextField(hint: 'Name', controller: nameController),
                CustomTextField(hint: 'Email', controller: emailController),

                CustomTextField(hint: 'Password', controller: passController),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: ElevatedButton(
                    onPressed: () {
                      signupAuthenticate(
                        emailController.text,
                        passController.text,
                        nameController.text,

                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple.shade300,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Submit",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


