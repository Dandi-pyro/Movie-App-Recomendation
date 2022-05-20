import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/model/color.dart';
import 'package:movie_app/widgets/reusable_widgets.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();
  final _emailTextController = TextEditingController();

  @override
  void dispose() {
    _emailTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Reset Password",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: hexStringToColor('333333'),
          child: SingleChildScrollView(
              child: Padding(
            padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                Form(
                  key: _formKey,
                  child: TextFormField(
                      autofocus: false,
                      controller: _emailTextController,
                      keyboardType: TextInputType.emailAddress,
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
                        _emailTextController.text = value!;
                      },
                      textInputAction: TextInputAction.next,
                      style: TextStyle(color: Colors.white.withOpacity(0.9)),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.mail, color: Colors.white70),
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
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    resetPassword();
                  },
                  child: const Text(
                    'Reset Password',
                    style: TextStyle(color: Colors.black45),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      hexStringToColor('FFD74B'),
                    ),
                  ),
                )
              ],
            ),
          ))),
    );
  }

  Future resetPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailTextController.text.trim());
      const SnackBar(content: Text('Password Reset Email Sent'));
      Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      print('error message : $e');
      SnackBar(content: Text(e.message!));
      Navigator.of(context).pop();
    }
  }
}
