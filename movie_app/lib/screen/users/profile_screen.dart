import 'package:flutter/material.dart';
import 'package:movie_app/model/color.dart';
import 'package:movie_app/model/users/users.dart';
import 'package:movie_app/screen/drawer_screen.dart';
import 'package:movie_app/screen/users/change_password.dart';
import 'package:movie_app/screen/users/edit_screen.dart';

class ProfileScreen extends StatelessWidget {
  final Users user;
  const ProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hexStringToColor('333333'),
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: hexStringToColor('333333'),
      ),
      drawer: DrawerScreen(user: user),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 100,
              width: 100,
              child: InkWell(
                child: Image(image: AssetImage('assets/images/user.png')),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ListTile(
              leading: Icon(Icons.person_rounded,
                  color: Colors.white.withOpacity(0.9)),
              title: Text(
                'Name',
                style: TextStyle(color: Colors.white.withOpacity(0.9)),
              ),
              subtitle: Text(
                user.name!,
                style: TextStyle(color: Colors.white.withOpacity(0.9)),
              ),
            ),
            ListTile(
              leading: Icon(Icons.mail_rounded,
                  color: Colors.white.withOpacity(0.9)),
              title: Text(
                'Email',
                style: TextStyle(color: Colors.white.withOpacity(0.9)),
              ),
              subtitle: Text(
                user.email!,
                style: TextStyle(color: Colors.white.withOpacity(0.9)),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return EditScreen(user: user);
                        },
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          final tween = Tween(
                              begin: const Offset(0, 5), end: Offset.zero);
                          return SlideTransition(
                            position: animation.drive(tween),
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                  child: const Text(
                    'Edit Profile',
                    style: TextStyle(color: Colors.black87),
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          hexStringToColor('FFD74B'))),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return ChangePasswordScreen(user: user);
                        },
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          final tween = Tween(
                              begin: const Offset(0, 5), end: Offset.zero);
                          return SlideTransition(
                            position: animation.drive(tween),
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                  child: const Text(
                    'Change Password',
                    style: TextStyle(color: Colors.black87),
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          hexStringToColor('FFD74B'))),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
