import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/model/color.dart';
import 'package:movie_app/model/users/users.dart';
import 'package:movie_app/screen/movie/movie_screen.dart';

class EditScreen extends StatefulWidget {
  final Users user;
  const EditScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final _formKey = GlobalKey<FormState>();
  late Users user;

  // editing controller
  final nameEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    nameEditingController.dispose();
    emailEditingController.dispose();
  }

  @override
  void initState() {
    super.initState();
    user = widget.user;
    nameEditingController.text = widget.user.name!;
    emailEditingController.text = widget.user.email!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hexStringToColor('333333'),
      appBar: AppBar(
        title: const Text('Edit Profile'),
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
                    controller: nameEditingController,
                    keyboardType: TextInputType.name,
                    style: TextStyle(color: Colors.white.withOpacity(0.9)),
                    validator: (value) {
                      RegExp regex = RegExp(r'^.{3,}$');
                      if (value!.isEmpty) {
                        return ("First Name cannot be Empty");
                      }
                      if (!regex.hasMatch(value)) {
                        return ("Enter Valid name(Min. 3 Character)");
                      }
                      return null;
                    },
                    onSaved: (value) {
                      nameEditingController.text = value!;
                    },
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.account_circle,
                        color: Colors.white70,
                      ),
                      contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
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
                    controller: emailEditingController,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(color: Colors.white.withOpacity(0.9)),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("Please Enter Your Email");
                      }
                      // reg expression for email validation
                      if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                          .hasMatch(value)) {
                        return ("Please Enter a valid email");
                      }
                      return null;
                    },
                    onSaved: (value) {
                      nameEditingController.text = value!;
                    },
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.mail,
                        color: Colors.white70,
                      ),
                      contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                      label: Text("Email"),
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
                      'name': nameEditingController.text,
                      'email': emailEditingController.text
                    });
                    FirebaseAuth.instance.currentUser!
                        .updateEmail(emailEditingController.text)
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
