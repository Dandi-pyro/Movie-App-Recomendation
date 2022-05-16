import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/model/cast_list.dart';
import 'package:movie_app/model/color.dart';
import 'package:movie_app/model/images.dart';
import 'package:movie_app/model/movie_model.dart';
import 'package:movie_app/model/users/users.dart';
import 'package:movie_app/screen/movie/detail_view_model.dart';
import 'package:movie_app/screen/movie/movie_screen.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieDetailScreen extends StatefulWidget {
  final Users user;
  final Movie movie;
  const MovieDetailScreen({Key? key, required this.movie, required this.user})
      : super(key: key);

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<DetailViewModel>(context, listen: false)
        .getMovieDetail(widget.movie.id);
  }

  bool getButton(int id, List movie) {
    bool found = false;
    for (int i = 0; i < movie.length; i++) {
      if (movie[i] == id) {
        found = true;
      }
    }
    return found;
  }

  @override
  Widget build(BuildContext context) {
    final detailProvider = Provider.of<DetailViewModel>(context);
    return Scaffold(
      body: body(detailProvider),
    );
  }

  Widget body(DetailViewModel viewModel) {
    final isLoading = viewModel.state == DetailViewState.loading;
    final isError = viewModel.state == DetailViewState.error;

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (isError) {
      return const Center(
        child: Text("Can't get the data"),
      );
    }

    return _detailMovie(viewModel);
  }

  Widget _detailMovie(DetailViewModel viewModel) {
    return Stack(
      children: [
        ClipPath(
          child: ClipRRect(
            child: CachedNetworkImage(
              imageUrl:
                  'https://image.tmdb.org/t/p/original/${viewModel.movieDetail!.backdropPath}',
              height: MediaQuery.of(context).size.height / 3,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (context, url) => CircularProgressIndicator(),
            ),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            Container(
              padding: EdgeInsets.only(top: 25),
              child: GestureDetector(
                onTap: () async {
                  Uri youtubeUrl = Uri.parse(
                      'https://www.youtube.com/embed/${viewModel.movieDetail!.trailerId}');
                  await launchUrl(youtubeUrl);
                },
                child: Center(
                  child: Column(
                    children: [
                      const Icon(
                        Icons.play_circle_outline,
                        color: Colors.yellow,
                        size: 65,
                      ),
                      Text(
                        viewModel.movieDetail!.title!.toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 75,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Overview'.toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ]),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 60,
                    child: Text(
                      viewModel.movieDetail!.overview!,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Release date'.toUpperCase(),
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              viewModel.movieDetail!.releaseDate!,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .copyWith(
                                      color: Colors.yellow[800], fontSize: 12),
                            ),
                          ]),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'run time'.toUpperCase(),
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              viewModel.movieDetail!.runtime!,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .copyWith(
                                      color: Colors.yellow[800], fontSize: 12),
                            ),
                          ]),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'budget'.toUpperCase(),
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              viewModel.movieDetail!.budget!,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .copyWith(
                                      color: Colors.yellow[800], fontSize: 12),
                            ),
                          ]),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Screenshots'.toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .caption!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Container(
                    height: 150,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        Images image =
                            viewModel.movieDetail!.movieImage.backdrops[index];
                        return Container(
                          child: Card(
                            elevation: 3,
                            borderOnForeground: true,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: CachedNetworkImage(
                                imageUrl:
                                    'https://image.tmdb.org/t/p/w500${image.imagePath}',
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const VerticalDivider(
                        color: Colors.transparent,
                        width: 5,
                      ),
                      itemCount:
                          viewModel.movieDetail!.movieImage.backdrops.length,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Casts'.toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .caption!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Container(
                    height: 120,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        Cast cast = viewModel.movieDetail!.castList![index];
                        return Container(
                          child: Column(
                            children: [
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                elevation: 3,
                                child: cast.profilePath == null
                                    ? const Image(
                                        image: AssetImage(
                                            'assets/images/user.png'),
                                        height: 80,
                                        width: 80,
                                      )
                                    : ClipRRect(
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              'https://image.tmdb.org/t/p/w200${cast.profilePath}',
                                          imageBuilder:
                                              (context, imageBuilder) {
                                            return Container(
                                              width: 80,
                                              height: 80,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(100)),
                                                  image: DecorationImage(
                                                    image: imageBuilder,
                                                    fit: BoxFit.cover,
                                                  )),
                                            );
                                          },
                                          placeholder: (context, url) =>
                                              Container(
                                            width: 80,
                                            height: 80,
                                            child: Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                          ),
                                        ),
                                      ),
                              ),
                              Container(
                                child: Center(
                                  child: Text(
                                    cast.name!.toUpperCase(),
                                    style: const TextStyle(
                                      color: Colors.black54,
                                      fontSize: 12,
                                    ),
                                    maxLines: 1,
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  cast.character!.toUpperCase(),
                                  style: const TextStyle(
                                    color: Colors.black54,
                                    fontSize: 12,
                                  ),
                                  maxLines: 1,
                                ),
                              )
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const VerticalDivider(
                        color: Colors.transparent,
                        width: 5,
                      ),
                      itemCount: viewModel.movieDetail!.castList!.length,
                    ),
                  ),
                  Center(
                    child: getButton(int.parse(viewModel.movieDetail!.id!),
                            widget.user.movieWatch!)
                        ? ElevatedButton(
                            onPressed: () {},
                            child: const Text(
                              'Added To Watch List',
                              style: TextStyle(color: Colors.black45),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                hexStringToColor('FFD74B'),
                              ),
                            ),
                          )
                        : getButton(int.parse(viewModel.movieDetail!.id!),
                                widget.user.movieDropped!)
                            ? ElevatedButton(
                                onPressed: () {},
                                child: const Text(
                                  'This movie is dropped',
                                  style: TextStyle(color: Colors.black45),
                                ),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                    hexStringToColor('FFD74B'),
                                  ),
                                ),
                              )
                            : getButton(int.parse(viewModel.movieDetail!.id!),
                                    widget.user.movieFinish!)
                                ? ElevatedButton(
                                    onPressed: () {},
                                    child: const Text(
                                      'You finish watching this movie',
                                      style: TextStyle(color: Colors.black45),
                                    ),
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                        hexStringToColor('FFD74B'),
                                      ),
                                    ),
                                  )
                                : ElevatedButton(
                                    onPressed: () {
                                      List movie = [];
                                      movie.add(int.parse(
                                          viewModel.movieDetail!.id!));
                                      final docUser = FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(widget.user.id);
                                      docUser.update({
                                        "movieWatch":
                                            FieldValue.arrayUnion(movie)
                                      });
                                      Navigator.pushAndRemoveUntil(
                                          (context),
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MovieScreen()),
                                          (route) => false);
                                    },
                                    child: const Text(
                                      'Add to Watchlist',
                                      style: TextStyle(color: Colors.black45),
                                    ),
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                        hexStringToColor('FFD74B'),
                                      ),
                                    ),
                                  ),
                  )
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
