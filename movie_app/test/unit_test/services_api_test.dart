// import 'package:movie_app/model/api/service_api.dart';
// import 'package:movie_app/model/cast_list.dart';
// import 'package:movie_app/model/genre.dart';
// import 'package:movie_app/model/images.dart';
// import 'package:movie_app/model/movie_detail.dart';
// import 'package:movie_app/model/movie_image.dart';
// import 'package:movie_app/model/movie_model.dart';
// import 'package:movie_app/model/person.dart';
// import 'package:test/test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:mockito/annotations.dart';
// import 'services_api_test.mocks.dart';

// @GenerateMocks([ApiService])
// void main() {
//   group('Services API', () {
//     ApiService apiService = MockApiService();
//     test('Get Now Playing Movie', () async {
//       when(apiService.getNowPlayingMovie()).thenAnswer((_) async => <Movie>[
//             Movie(
//                 backdropPath: 'backdropPath',
//                 id: 1,
//                 originalLanguage: 'originalLanguage',
//                 originalTitle: 'originalTitle',
//                 overview: 'overview',
//                 popularity: 5,
//                 posterPath: 'posterPath',
//                 releaseDate: 'releaseDate',
//                 title: 'title',
//                 video: true,
//                 voteCount: 1,
//                 voteAverage: '2')
//           ]);
//       final movie = await apiService.getNowPlayingMovie();
//       expect(movie.isNotEmpty, true);
//     });

//     test('Get Popular Movie', () async {
//       when(apiService.getPopularMovie()).thenAnswer((_) async => <Movie>[
//             Movie(
//                 backdropPath: 'backdropPath',
//                 id: 1,
//                 originalLanguage: 'originalLanguage',
//                 originalTitle: 'originalTitle',
//                 overview: 'overview',
//                 popularity: 5,
//                 posterPath: 'posterPath',
//                 releaseDate: 'releaseDate',
//                 title: 'title',
//                 video: true,
//                 voteCount: 1,
//                 voteAverage: '2')
//           ]);
//       final movie = await apiService.getPopularMovie();
//       expect(movie.isNotEmpty, true);
//     });

//     test('Get Movie By Genre', () async {
//       when(apiService.getMovieByGenre(1)).thenAnswer((_) async => <Movie>[
//             Movie(
//                 backdropPath: 'backdropPath',
//                 id: 1,
//                 originalLanguage: 'originalLanguage',
//                 originalTitle: 'originalTitle',
//                 overview: 'overview',
//                 popularity: 5,
//                 posterPath: 'posterPath',
//                 releaseDate: 'releaseDate',
//                 title: 'title',
//                 video: true,
//                 voteCount: 1,
//                 voteAverage: '2')
//           ]);
//       final movie = await apiService.getMovieByGenre(1);
//       expect(movie.isNotEmpty, true);
//     });

//     test('Get List Genre', () async {
//       when(apiService.getGenreList())
//           .thenAnswer((_) async => <Genre>[Genre(id: 1, name: 'name')]);
//       final genre = await apiService.getGenreList();
//       expect(genre.isNotEmpty, true);
//     });

//     test('Get Trending Person', () async {
//       when(apiService.getTrendingPerson()).thenAnswer((_) async => <Person>[
//             Person(
//                 id: '1',
//                 gender: 'gender',
//                 name: 'name',
//                 profilePath: 'profilepath',
//                 knowForDepartment: 'KnowForDepartment',
//                 popularity: '2')
//           ]);
//       final person = await apiService.getTrendingPerson();
//       expect(person.isNotEmpty, true);
//     });

//     test('Get Detail Movie', () async {
//       when(apiService.getMovieDetail(1)).thenAnswer((_) async => MovieDetail(
//           id: 'id',
//           title: 'title',
//           backdropPath: 'backdrop_path',
//           budget: 'budget',
//           homePage: 'home_page',
//           originalTitle: 'original_title',
//           overview: 'overview',
//           releaseDate: 'release_date',
//           runtime: 'runtime',
//           voteAverage: 'vote_average',
//           voteCount: 'vote_count'));
//       final movie = await apiService.getMovieDetail(1);
//       expect(movie != null, true);
//     });

//     test('Get ID Youtube', () async {
//       when(apiService.getYoutubeId(1)).thenAnswer((_) async => '1');
//       final id = await apiService.getYoutubeId(1);
//       expect(id.isNotEmpty, true);
//     });

//     test('Get Movie Image', () async {
//       when(apiService.getMovieImage(1))
//           .thenAnswer((_) async => MovieImage(backdrops: [
//                 Images(
//                     aspect: 'aspect',
//                     imagePath: 'imagePath',
//                     height: 1,
//                     width: 2,
//                     countryCode: 'countryCode',
//                     voteAverage: 2,
//                     voteCount: 2)
//               ], posters: [
//                 Images(
//                     aspect: 'aspect',
//                     imagePath: 'imagePath',
//                     height: 1,
//                     width: 2,
//                     countryCode: 'countryCode',
//                     voteAverage: 1,
//                     voteCount: 2)
//               ]));
//       final image = await apiService.getMovieImage(1);
//       expect(image != null, true);
//     });

//     test('Get List Cast', () async {
//       when(apiService.getCastList(1)).thenAnswer((_) async => <Cast>[
//             Cast(
//                 name: 'name',
//                 profilePath: 'profilePath',
//                 character: 'character')
//           ]);
//       final person = await apiService.getCastList(1);
//       expect(person.isNotEmpty, true);
//     });
//   });
// }
