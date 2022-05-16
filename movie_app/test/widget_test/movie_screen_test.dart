import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/screen/movie/movie_screen.dart';
import 'package:movie_app/screen/movie/movie_view_model.dart';
import 'package:movie_app/screen/movie/person_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Judul Halaman Movie', ((WidgetTester tester) async {
    await tester.pumpWidget(MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MovieViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => PersonViewModel(),
        ),
      ],
      child: MaterialApp(
        home: MovieScreen(),
      ),
    ));
    expect(find.text('Cineminfo'), findsOneWidget);
  }));
}
