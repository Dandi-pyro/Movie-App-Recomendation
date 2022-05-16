import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/model/users/users.dart';
import 'package:movie_app/screen/movie/movie_screen.dart';
import 'package:movie_app/screen/users/profile_screen.dart';
import 'package:movie_app/screen/streams/signin_screen.dart';
import 'package:movie_app/screen/watchlist/watchlist_screen.dart';

class DrawerScreen extends StatelessWidget {
  final Users user;
  DrawerScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Color.fromARGB(214, 5, 22, 21)),
              accountName: Text(user.name!),
              currentAccountPicture: const CircleAvatar(
                backgroundImage: AssetImage('assets/images/user.png'),
              ),
              accountEmail: Text(user.email!)),
          DrawerListTile(
            iconData: Icons.person_rounded,
            title: 'Profile',
            onTilePressed: () {
              Navigator.pushAndRemoveUntil(
                  (context),
                  MaterialPageRoute(
                      builder: (context) => ProfileScreen(
                            user: user,
                          )),
                  (route) => false);
            },
          ),
          DrawerListTile(
            iconData: Icons.movie_rounded,
            title: 'Movie',
            onTilePressed: () {
              Navigator.pushAndRemoveUntil(
                  (context),
                  MaterialPageRoute(builder: (context) => MovieScreen()),
                  (route) => false);
            },
          ),
          DrawerListTile(
            iconData: Icons.tv_rounded,
            title: 'Watchlist',
            onTilePressed: () {
              Navigator.pushAndRemoveUntil(
                  (context),
                  MaterialPageRoute(
                      builder: (context) => WatchlistScreen(
                            user: user,
                          )),
                  (route) => false);
            },
          ),
          const Divider(),
          DrawerListTile(
            iconData: Icons.logout_rounded,
            title: 'Log Out',
            onTilePressed: () {
              FirebaseAuth.instance.signOut().then((value) {
                print("Signed Out");
                Navigator.pushAndRemoveUntil(
                    (context),
                    MaterialPageRoute(builder: (context) => SignInScreen()),
                    (route) => false);
              });
            },
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  final IconData iconData;
  final String title;
  final VoidCallback onTilePressed;

  const DrawerListTile(
      {Key? key,
      required this.iconData,
      required this.title,
      required this.onTilePressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTilePressed,
      dense: true,
      leading: Icon(iconData),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }
}
