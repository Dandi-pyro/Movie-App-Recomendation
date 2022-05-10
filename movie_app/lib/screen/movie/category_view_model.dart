import 'package:flutter/cupertino.dart';
import 'package:movie_app/model/api/service_api.dart';
import 'package:movie_app/model/genre.dart';

class CategoryViewModel with ChangeNotifier {
  List<Genre> _genres = [];
  List<Genre> get genres => _genres;

  getGenreList() async {
    final c = await ApiService.getGenreList();
    _genres = c;
    notifyListeners();
  }
}