import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/model/color.dart';
import 'package:movie_app/model/users/users.dart';
import 'package:movie_app/screen/movie/movie_screen.dart';

class ChangePasswordScreen extends StatefulWidget {
  final Users user;
  const ChangePasswordScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  late Users user;

  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  @override
  void initState() {
    super.initState();
    user = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hexStringToColor('333333'),
      appBar: AppBar(
        title: const Text('Change Password'),
        backgroundColor: hexStringToColor('333333'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                    autofocus: false,
                    controller: passwordController,
                    obscureText: true,
                    style: TextStyle(color: Colors.white.withOpacity(0.9)),
                    validator: (value) {
                      RegExp regex = new RegExp(r'^.{6,}$');
                      if (value!.isEmpty) {
                        return ("Password is required for login");
                      }
                      if (!regex.hasMatch(value)) {
                        return ("Enter Valid Password(Min. 6 Character)");
                      }
                    },
                    onSaved: (value) {
                      nameController.text = value!;
                    },
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.vpn_key,
                        color: Colors.white70,
                      ),
                      contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                      label: Text("Password"),
                      labelStyle:
                          TextStyle(color: Colors.white.withOpacity(0.9)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      fillColor: Colors.white.withOpacity(0.3),
                    )),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                    autofocus: false,
                    controller: confirmPasswordController,
                    style: TextStyle(color: Colors.white.withOpacity(0.9)),
                    obscureText: true,
                    validator: (value) {
                      if (confirmPasswordController.text !=
                          passwordController.text) {
                        return "Password don't match";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      confirmPasswordController.text = value!;
                    },
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.vpn_key,
                        color: Colors.white70,
                      ),
                      contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                      label: Text("Confirm Password"),
                      labelStyle:
                          TextStyle(color: Colors.white.withOpacity(0.9)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      fillColor: Colors.white.withOpacity(0.3),
                    )),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    FirebaseFirestore.instance
                        .collection('users')
                        .doc(user.id)
                        .update({
                      'password': passwordController.text,
                    });
                    FirebaseAuth.instance.currentUser!
                        .updatePassword(passwordController.text)
                        .then((value) => Navigator.pushAndRemoveUntil(
                            (context),
                            MaterialPageRoute(
                                builder: (context) => MovieScreen()),
                            (route) => false));
                  },
                  child: const Text(
                    'Submit',
                    style: TextStyle(color: Colors.black87),
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          hexStringToColor('FFD74B'))),
                ),
              ],
            )),
      ),
    );
  }
}
