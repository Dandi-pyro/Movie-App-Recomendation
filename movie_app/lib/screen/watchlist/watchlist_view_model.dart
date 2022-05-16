import 'package:flutter/cupertino.dart';
import 'package:movie_app/model/api/service_api.dart';
import 'package:movie_app/model/movie_detail.dart';

enum WatchlistViewState {
  none,
  loading,
  error,
}

class WatchlistViewModel with ChangeNotifier {
  WatchlistViewState _state = WatchlistViewState.none;
  WatchlistViewState get state => _state;

  List<MovieDetail> _watchlist = [];
  List<MovieDetail> get watchlist => _watchlist;

  changeState(WatchlistViewState s) {
    _state = s;
    notifyListeners();
  }

  getMovieById(List id) async {
    changeState(WatchlistViewState.loading);
    try {
      for (int i = 0; i < id.length; i++) {
        final c = await ApiService.getMovieDetail(id[i]);
        _watchlist.add(c);
        notifyListeners();
      }
      changeState(WatchlistViewState.none);
    } catch (e) {
      changeState(WatchlistViewState.error);
    }
  }
}
