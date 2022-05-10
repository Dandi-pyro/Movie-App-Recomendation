import 'package:flutter/material.dart';
import 'package:movie_app/screen/movie/category_view_model.dart';
import 'package:movie_app/screen/movie/detail_view_model.dart';
import 'package:movie_app/screen/movie/movie_screen.dart';
import 'package:movie_app/screen/movie/movie_view_model.dart';
import 'package:movie_app/screen/movie/person_view_model.dart';
import 'package:provider/provider.dart';

void main() {
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
      ],
      child: MaterialApp(
        title: "Movie App",
        debugShowCheckedModeBanner: false,
        home: MovieScreen(),
      ),
    ),
  );
}