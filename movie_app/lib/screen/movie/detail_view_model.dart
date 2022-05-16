import 'package:flutter/cupertino.dart';
import 'package:movie_app/model/api/service_api.dart';
import 'package:movie_app/model/movie_detail.dart';

enum DetailViewState {
  none,
  loading,
  error,
}

class DetailViewModel with ChangeNotifier {
  DetailViewState _state = DetailViewState.none;
  DetailViewState get state => _state;

  MovieDetail? movieDetail;

  changeState(DetailViewState s) {
    _state = s;
    notifyListeners();
  }

  getMovieDetail(int id) async {
    changeState(DetailViewState.loading);
    try {
      final c = await ApiService.getMovieDetail(id);
      movieDetail = c;
      notifyListeners();
      changeState(DetailViewState.none);
    } catch (e) {
      changeState(DetailViewState.error);
    }
  }
}
