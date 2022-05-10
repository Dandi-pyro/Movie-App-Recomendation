import 'package:flutter/cupertino.dart';
import 'package:movie_app/model/api/service_api.dart';
import 'package:movie_app/model/movie_detail.dart';

class DetailViewModel with ChangeNotifier {
  MovieDetail? movieDetail;

  getMovieDetail(int id) async {
    final c = await ApiService.getMovieDetail(id);
    movieDetail = c;
    notifyListeners();
  }
}