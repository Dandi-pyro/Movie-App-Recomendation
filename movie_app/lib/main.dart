import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/screen/movie/category_view_model.dart';
import 'package:movie_app/screen/movie/detail_view_model.dart';
import 'package:movie_app/screen/movie/movie_view_model.dart';
import 'package:movie_app/screen/movie/person_view_model.dart';
import 'package:movie_app/screen/search/search_view_model.dart';
import 'package:movie_app/screen/streams/signin_screen.dart';
import 'package:movie_app/screen/watchlist/dropped_view_model.dart';
import 'package:movie_app/screen/watchlist/finish_view_model.dart';
import 'package:movie_app/screen/watchlist/watchlist_view_model.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MovieViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => DetailViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => CategoryViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => PersonViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => WatchlistViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => DroppedViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => FinishViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => SearchViewModel(),
        ),
      ],
      child: const MaterialApp(
        title: "Movie App",
        debugShowCheckedModeBanner: false,
        home: SignInScreen(),
      ),
    ),
  );
}
