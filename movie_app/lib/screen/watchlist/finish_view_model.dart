import 'package:flutter/cupertino.dart';
import 'package:movie_app/model/api/service_api.dart';
import 'package:movie_app/model/movie_detail.dart';

enum FinishViewState {
  none,
  loading,
  error,
}

class FinishViewModel with ChangeNotifier {
  FinishViewState _state = FinishViewState.none;
  FinishViewState get state => _state;

  List<MovieDetail> _finish = [];
  List<MovieDetail> get finish => _finish;

  changeState(FinishViewState s) {
    _state = s;
    notifyListeners();
  }

  getMovieById(List id) async {
    changeState(FinishViewState.loading);
    try {
      for (int i = 0; i < id.length; i++) {
        final c = await ApiService.getMovieDetail(id[i]);
        _finish.add(c);
        notifyListeners();
      }
      changeState(FinishViewState.none);
    } catch (e) {
      changeState(FinishViewState.error);
    }
  }
}
