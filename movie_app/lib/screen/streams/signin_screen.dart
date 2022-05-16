// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:movie_app/model/color.dart';
// import 'package:movie_app/screen/movie/movie_screen.dart';
// import 'package:movie_app/screen/streams/reset_password.dart';
// import 'package:movie_app/screen/streams/signup_screen.dart';
// import 'package:movie_app/widgets/reusable_widgets.dart';

// class SignInScreen extends StatefulWidget {
//   const SignInScreen({Key? key}) : super(key: key);

//   @override
//   State<SignInScreen> createState() => _SignInScreenState();
// }

// class _SignInScreenState extends State<SignInScreen> {
//   TextEditingController _passwordTextController = TextEditingController();
//   TextEditingController _emailTextController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           color: hexStringToColor('333333'),
//         ),
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.fromLTRB(
//                 20,
//                 MediaQuery.of(context).size.height * 0.2,
//                 20,
//                 MediaQuery.of(context).size.height * 0.251),
//             child: Column(
//               children: [
//                 logoWidget("assets/images/Cineminfo.png"),
//                 const Text(
//                   'Cineminfo',
//                   style: TextStyle(fontSize: 40, color: Colors.white),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 reusableTextField("Enter Email", Icons.person_outline, false,
//                     _emailTextController),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 reusableTextField("Enter Password", Icons.lock_outline, true,
//                     _passwordTextController),
//                 const SizedBox(
//                   height: 5,
//                 ),
//                 forgetPassword(context),
//                 firebaseUIButton(context, "Sign In", () {
//                   FirebaseAuth.instance
//                       .signInWithEmailAndPassword(
//                           email: _emailTextController.text,
//                           password: _passwordTextController.text)
//                       .then((value) {
//                     Navigator.push(context,
//                         MaterialPageRoute(builder: (context) => MovieScreen()));
//                   }).onError((error, stackTrace) {
//                     print("Error ${error.toString()}");
//                   });
//                 }),
//                 signUpOption(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Row signUpOption() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         const Text("Don't have account?",
//             style: TextStyle(color: Colors.white70)),
//         GestureDetector(
//           onTap: () {
//             Navigator.push(context,
//                 MaterialPageRoute(builder: (context) => SignUpScreen()));
//           },
//           child: const Text(
//             " Sign Up",
//             style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//           ),
//         )
//       ],
//     );
//   }

//   Widget forgetPassword(BuildContext context) {
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       height: 35,
//       alignment: Alignment.bottomRight,
//       child: TextButton(
//         child: const Text(
//           "Forgot Password?",
//           style: TextStyle(color: Colors.white70),
//           textAlign: TextAlign.right,
//         ),
//         onPressed: () => Navigator.push(
//             context, MaterialPageRoute(builder: (context) => ResetPassword())),
//       ),
//     );
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movie_app/model/color.dart';
import 'package:movie_app/screen/movie/movie_screen.dart';
import 'package:movie_app/screen/streams/reset_password.dart';
import 'package:movie_app/screen/streams/signup_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  // form key
  final _formKey = GlobalKey<FormState>();

  // editing controller
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // firebase
  final _auth = FirebaseAuth.instance;

  // string for displaying the error Message
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    //email field
    final emailField = TextFormField(
        autofocus: false,
        controller: emailController,
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
          emailController.text = value!;
        },
        textInputAction: TextInputAction.next,
        style: TextStyle(color: Colors.white.withOpacity(0.9)),
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail, color: Colors.white70),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          label: Text("Email"),
          labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          filled: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          fillColor: Colors.white.withOpacity(0.3),
        ));

    //password field
    final passwordField = TextFormField(
        autofocus: false,
        controller: passwordController,
        obscureText: true,
        validator: (value) {
          RegExp regex = RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Password is required for login");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid Password(Min. 6 Character)");
          }
        },
        onSaved: (value) {
          passwordController.text = value!;
        },
        textInputAction: TextInputAction.done,
        style: TextStyle(color: Colors.white.withOpacity(0.9)),
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key, color: Colors.white70),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          label: Text("Password"),
          labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          filled: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          fillColor: Colors.white.withOpacity(0.3),
        ));

    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: hexStringToColor('FFD74B'),
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            signIn(emailController.text, passwordController.text);
          },
          child: const Text(
            "Login",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: Colors.black87),
          )),
    );

    return Scaffold(
      backgroundColor: hexStringToColor('333333'),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                      height: 200,
                      child: Image.asset(
                        "assets/images/Cineminfo.png",
                        fit: BoxFit.contain,
                      )),
                  SizedBox(height: 45),
                  emailField,
                  SizedBox(height: 25),
                  passwordField,
                  SizedBox(height: 5),
                  forgetPassword(context),
                  SizedBox(height: 5),
                  loginButton,
                  SizedBox(height: 15),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Don't have an account? ",
                          style:
                              TextStyle(color: Colors.white.withOpacity(0.3)),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) {
                                  return const SignUpScreen();
                                },
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  final tween = Tween(
                                      begin: const Offset(0, 5),
                                      end: Offset.zero);
                                  return SlideTransition(
                                    position: animation.drive(tween),
                                    child: child,
                                  );
                                },
                              ),
                            );
                          },
                          child: Text(
                            "SignUp",
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.3),
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        )
                      ])
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget forgetPassword(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 35,
      alignment: Alignment.bottomRight,
      child: TextButton(
          child: const Text(
            "Forgot Password?",
            style: TextStyle(color: Colors.white70),
            textAlign: TextAlign.right,
          ),
          onPressed: () => Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return const ResetPassword();
                  },
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    final tween =
                        Tween(begin: const Offset(0, 5), end: Offset.zero);
                    return SlideTransition(
                      position: animation.drive(tween),
                      child: child,
                    );
                  },
                ),
              )),
    );
  }

  // login function
  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) => {
                  Fluttertoast.showToast(msg: "Login Successful"),
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => MovieScreen())),
                });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";

            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }
}
