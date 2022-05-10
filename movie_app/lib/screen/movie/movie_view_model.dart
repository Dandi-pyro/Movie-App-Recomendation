import 'package:flutter/cupertino.dart';
import 'package:movie_app/model/api/service_api.dart';
import 'package:movie_app/model/movie_model.dart';

class MovieViewModel with ChangeNotifier {
  List<Movie> _movies = [];
  List<Movie> get movies => _movies;

  getCurrentPlayMovies(int id) async {
    if (id == 0) {
      final c = await ApiService.getNowPlayingMovie();
      print('Total Movie ${c.length}');
      _movies = c;
    } else {
      final c = await ApiService.getMovieByGenre(id);
      _movies = c;
    }
    notifyListeners();
  }
}