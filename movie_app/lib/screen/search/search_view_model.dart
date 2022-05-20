import 'package:flutter/cupertino.dart';
import 'package:movie_app/model/api/service_api.dart';
import 'package:movie_app/model/movie_model.dart';

enum SearchViewState {
  none,
  loading,
  error,
}

class SearchViewModel with ChangeNotifier {
  SearchViewState _state = SearchViewState.none;
  SearchViewState get state => _state;

  List<Movie> _movies = [];
  List<Movie> get movies => _movies;

  changeState(SearchViewState s) {
    _state = s;
    notifyListeners();
  }

  getMovies(String query) async {
    changeState(SearchViewState.loading);
    try {
      final c = await ApiService.searchMovie(query);
      _movies = c;
      print('data = ${_movies.length}');
      notifyListeners();
      changeState(SearchViewState.none);
    } catch (e) {
      changeState(SearchViewState.error);
    }
    // final c = await ApiService.searchMovie(query);
    // _movies = c;
    // print('data = ${_movies.length}');
    // notifyListeners();
  }
}
