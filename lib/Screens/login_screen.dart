import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signUserIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
    } catch (e) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Wrong email or password"),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.close))
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return Material(
      child: Container(
        color: Colors.black,
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 50),
        child: Column(
          children: [
            const Text(
              "Budget Tracker",
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 48,
                  decoration: TextDecoration.none),
            ),
            const SizedBox(
              height: 100,
            ),
            const Text(
              "Login to get access to the budget tracker app",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w200,
                  decoration: TextDecoration.none),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
              color: Colors.white,
              child: Column(
                children: [
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        hintText: "User Email",
                        prefixIcon: Icon(Icons.mail, color: Colors.grey)),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                        hintText: "User password",
                        prefixIcon: Icon(Icons.lock, color: Colors.grey)),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  const Text(
                    "Don't remember your password?",
                    style: TextStyle(color: Colors.blue),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RawMaterialButton(
                    onPressed: signUserIn,
                    fillColor: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: const Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.login,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  ),
                  RawMaterialButton(
                    onPressed: () async {
                      late String email;
                      late String password;
                      String? name;
                      await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Add user"),
                              content: Form(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextFormField(
                                      onChanged: (value) {
                                        email = value;
                                      },
                                      decoration: const InputDecoration(
                                          labelText: "User email"),
                                    ),
                                    TextFormField(
                                      onChanged: (value) {
                                        password = value;
                                      },
                                      decoration: const InputDecoration(
                                          labelText: "Password"),
                                    ),
                                    TextFormField(
                                      onChanged: (value) {
                                        name = value;
                                      },
                                      decoration: const InputDecoration(
                                          labelText: "User name"),
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("Cancel")),
                                TextButton(
                                  onPressed: () {
                                    if (name != null) {
                                      setState(() async {
                                        UserCredential userCredential =
                                            await FirebaseAuth.instance
                                                .createUserWithEmailAndPassword(
                                                    email: email,
                                                    password: password);
                                        if (userCredential.user != null) {
                                          String userUid =
                                              userCredential.user!.uid;
                                          await users.doc(userUid).set(
                                              {'name': name, 'email': email});
                                        }
                                        Navigator.of(context).pop();
                                      });
                                    }
                                  },
                                  child: const Text('Save'),
                                ),
                              ],
                            );
                          });
                    },
                    fillColor: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: const Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.login,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Register",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
