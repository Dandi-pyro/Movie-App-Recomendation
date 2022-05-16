import 'package:flutter/cupertino.dart';
import 'package:movie_app/model/api/service_api.dart';
import 'package:movie_app/model/movie_detail.dart';

enum DroppedViewState {
  none,
  loading,
  error,
}

class DroppedViewModel with ChangeNotifier {
  DroppedViewState _state = DroppedViewState.none;
  DroppedViewState get state => _state;

  List<MovieDetail> _dropped = [];
  List<MovieDetail> get dropped => _dropped;

  changeState(DroppedViewState s) {
    _state = s;
    notifyListeners();
  }

  getMovieById(List id) async {
    changeState(DroppedViewState.loading);
    try {
      for (int i = 0; i < id.length; i++) {
        final c = await ApiService.getMovieDetail(id[i]);
        _dropped.add(c);
        notifyListeners();
      }
      changeState(DroppedViewState.none);
    } catch (e) {
      changeState(DroppedViewState.error);
    }
  }
}
