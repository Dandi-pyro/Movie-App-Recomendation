import 'package:movie_app/model/cast_list.dart';
import 'package:movie_app/model/movie_image.dart';

class MovieDetail {
  final String? id;
  final String? title;
  final String? backdropPath;
  final String? budget;
  final String? homePage;
  final String? originalTitle;
  final String? overview;
  final String? releaseDate;
  final String? runtime;
  final String? voteAverage;
  final String? voteCount;

  late String trailerId;

  late MovieImage movieImage;

  late List<Cast>? castList;

  MovieDetail(
      { this.id,
       this.title,
       this.backdropPath,
       this.budget,
       this.homePage,
       this.originalTitle,
       this.overview,
       this.releaseDate,
       this.runtime,
       this.voteAverage,
       this.voteCount});

  factory MovieDetail.fromJson(dynamic json) {
    return MovieDetail(
        id: json['id'].toString(),
        title: json['title'].toString(),
        backdropPath: json['backdrop_path'].toString(),
        budget: json['budget'].toString(),
        homePage: json['home_page'].toString(),
        originalTitle: json['original_title'].toString(),
        overview: json['overview'].toString(),
        releaseDate: json['release_date'].toString(),
        runtime: json['runtime'].toString(),
        voteAverage: json['vote_average'].toString(),
        voteCount: json['vote_count'].toString());
  }
}