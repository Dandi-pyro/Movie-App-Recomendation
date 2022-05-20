import 'package:equatable/equatable.dart';
import 'package:movie_app/model/images.dart';

class MovieImage extends Equatable {
  final List<Images>? backdrops;
  final List<Images>? posters;

  const MovieImage({this.backdrops, this.posters});

  factory MovieImage.fromJson(Map<String, dynamic> result) {
    return MovieImage(
      backdrops:
          (result['backdrops'] as List).map((b) => Images.fromJson(b)).toList(),
      posters:
          (result['posters'] as List).map((b) => Images.fromJson(b)).toList(),
    );
  }

  @override
  List<Object> get props => [backdrops!, posters!];
}
