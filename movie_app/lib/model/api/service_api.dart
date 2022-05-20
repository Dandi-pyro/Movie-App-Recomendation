import 'package:dio/dio.dart';
import 'package:movie_app/model/cast_list.dart';
import 'package:movie_app/model/genre.dart';
import 'package:movie_app/model/movie_detail.dart';
import 'package:movie_app/model/movie_image.dart';
import 'package:movie_app/model/movie_model.dart';
import 'package:movie_app/model/person.dart';

class ApiService {
  static Future<List<Movie>> getNowPlayingMovie() async {
    final Dio _dio = Dio();
    final String baseUrl = 'https://api.themoviedb.org/3';
    final String apiKey = 'api_key=df6f3cc06fc84af97a0568c3bb8e44ce';
    try {
      final url = '$baseUrl/movie/now_playing?$apiKey';
      final response = await _dio.get(url);
      var movies = response.data['results'] as List;
      List<Movie> movieList = movies.map((m) => Movie.fromJson(m)).toList();
      return movieList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  static Future<List<Movie>> getPopularMovie() async {
    final Dio _dio = Dio();
    final String baseUrl = 'https://api.themoviedb.org/3';
    final String apiKey = 'api_key=df6f3cc06fc84af97a0568c3bb8e44ce';
    try {
      final url = '$baseUrl/movie/popular?$apiKey';
      final response = await _dio.get(url);
      var movies = response.data['results'] as List;
      List<Movie> movieList = movies.map((m) => Movie.fromJson(m)).toList();
      return movieList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  static Future<List<Movie>> getMovieByGenre(int movieId) async {
    final Dio _dio = Dio();
    final String baseUrl = 'https://api.themoviedb.org/3';
    final String apiKey = 'api_key=df6f3cc06fc84af97a0568c3bb8e44ce';
    try {
      final url = '$baseUrl/discover/movie?with_genres=$movieId&$apiKey';
      final response = await _dio.get(url);
      var movies = response.data['results'] as List;
      List<Movie> movieList = movies.map((m) => Movie.fromJson(m)).toList();
      return movieList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  static Future<List<Genre>> getGenreList() async {
    final Dio _dio = Dio();
    final String baseUrl = 'https://api.themoviedb.org/3';
    final String apiKey = 'api_key=df6f3cc06fc84af97a0568c3bb8e44ce';
    try {
      final response = await _dio.get('$baseUrl/genre/movie/list?$apiKey');
      var genres = response.data['genres'] as List;
      List<Genre> genreList = genres.map((g) => Genre.fromJson(g)).toList();
      return genreList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  static Future<List<Person>> getTrendingPerson() async {
    final Dio _dio = Dio();
    final String baseUrl = 'https://api.themoviedb.org/3';
    final String apiKey = 'api_key=df6f3cc06fc84af97a0568c3bb8e44ce';
    try {
      final response = await _dio.get('$baseUrl/trending/person/week?$apiKey');
      var persons = response.data['results'] as List;
      List<Person> personList = persons.map((p) => Person.fromJson(p)).toList();
      return personList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  static Future<MovieDetail> getMovieDetail(int movieId) async {
    final Dio _dio = Dio();
    final String baseUrl = 'https://api.themoviedb.org/3';
    final String apiKey = 'api_key=df6f3cc06fc84af97a0568c3bb8e44ce';
    try {
      final response = await _dio.get('$baseUrl/movie/$movieId?$apiKey');
      MovieDetail movieDetail = MovieDetail.fromJson(response.data);

      movieDetail.trailerId = await getYoutubeId(movieId);

      movieDetail.movieImage = await getMovieImage(movieId);

      movieDetail.castList = await getCastList(movieId);

      return movieDetail;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  static Future<String> getYoutubeId(int id) async {
    final Dio _dio = Dio();
    final String baseUrl = 'https://api.themoviedb.org/3';
    final String apiKey = 'api_key=df6f3cc06fc84af97a0568c3bb8e44ce';
    try {
      final response = await _dio.get('$baseUrl/movie/$id/videos?$apiKey');
      var youtubeId = response.data['results'][0]['key'];
      return youtubeId;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  static Future<MovieImage> getMovieImage(int movieId) async {
    final Dio _dio = Dio();
    final String baseUrl = 'https://api.themoviedb.org/3';
    final String apiKey = 'api_key=df6f3cc06fc84af97a0568c3bb8e44ce';
    try {
      final response = await _dio.get('$baseUrl/movie/$movieId/images?$apiKey');
      // print('data = ${response.data}');
      return MovieImage.fromJson(response.data);
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  static Future<List<Cast>> getCastList(int movieId) async {
    final Dio _dio = Dio();
    final String baseUrl = 'https://api.themoviedb.org/3';
    final String apiKey = 'api_key=df6f3cc06fc84af97a0568c3bb8e44ce';
    try {
      final response =
          await _dio.get('$baseUrl/movie/$movieId/credits?$apiKey');
      var list = response.data['cast'] as List;
      List<Cast> castList = list
          .map((c) => Cast(
              name: c['name'],
              profilePath: c['profile_path'],
              character: c['character']))
          .toList();
      return castList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  static Future<List<Movie>> searchMovie(String query) async {
    final Dio _dio = Dio();
    final String baseUrl = 'https://api.themoviedb.org/3';
    final String apiKey = 'api_key=df6f3cc06fc84af97a0568c3bb8e44ce';
    try {
      final response = await _dio.get(
          '$baseUrl/search/movie?$apiKey&query=$query&include_adult=false');
      var movies = response.data['results'] as List;
      List<Movie> movieList = movies.map((m) => Movie.fromJson(m)).toList();
      return movieList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }
}
