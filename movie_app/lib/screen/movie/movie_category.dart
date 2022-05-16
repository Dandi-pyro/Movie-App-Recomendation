import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/model/genre.dart';
import 'package:movie_app/model/movie_model.dart';
import 'package:movie_app/model/users/users.dart';
import 'package:movie_app/screen/movie/category_view_model.dart';
import 'package:movie_app/screen/movie/movie_description.dart';
import 'package:movie_app/screen/movie/movie_view_model.dart';
import 'package:provider/provider.dart';

class CategoryWidget extends StatefulWidget {
  final Users user;
  final int selectedGenre;
  const CategoryWidget({Key? key, this.selectedGenre = 28, required this.user})
      : super(key: key);

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  int? selectedGenre;
  @override
  void initState() {
    super.initState();
    selectedGenre = widget.selectedGenre;
    Provider.of<MovieViewModel>(context, listen: false)
        .getCurrentPlayMovies(selectedGenre!);
    Provider.of<CategoryViewModel>(context, listen: false).getGenreList();
  }

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryViewModel>(context);
    final movieProvider = Provider.of<MovieViewModel>(context);
    return movieProvider.movies.isEmpty
        ? const CircularProgressIndicator()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 45,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Column(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              Genre genre = categoryProvider.genres[index];
                              selectedGenre = genre.id;
                              movieProvider
                                  .getCurrentPlayMovies(selectedGenre!);
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black45,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(25),
                              ),
                              color: (categoryProvider.genres[index].id ==
                                      selectedGenre)
                                  ? Colors.black45
                                  : Colors.white,
                            ),
                            child: Text(
                              categoryProvider.genres[index].name.toUpperCase(),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: (categoryProvider.genres[index].id ==
                                        selectedGenre)
                                    ? Colors.white
                                    : Colors.black45,
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const VerticalDivider(
                    color: Colors.transparent,
                    width: 5,
                  ),
                  itemCount: categoryProvider.genres.length,
                ),
              ),
              Container(
                child: Text(
                  'new playing'.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black45,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 200,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    Movie movie = movieProvider.movies[index];
                    return movie == null
                        ? const CircularProgressIndicator()
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation,
                                          secondaryAnimation) {
                                        return MovieDetailScreen(
                                            movie: movie, user: widget.user);
                                      },
                                      transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) {
                                        final tween = Tween(
                                            begin: const Offset(0, 5),
                                            end: Offset.zero);
                                        return SlideTransition(
                                          position: animation.drive(tween),
                                          child: child,
                                        );
                                      },
                                    ),
                                  );
                                },
                                child: ClipRRect(
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        'https://image.tmdb.org/t/p/original/${movie.backdropPath}',
                                    imageBuilder: (context, imageProvider) {
                                      return Container(
                                        width: 100,
                                        height: 160,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(12),
                                          ),
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      );
                                    },
                                    placeholder: (context, url) => Container(
                                      width: 100,
                                      height: 150,
                                      child: const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                width: 100,
                                child: Text(
                                  movie.title.toUpperCase(),
                                  style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.black45,
                                      fontWeight: FontWeight.bold),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                      size: 14,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                      size: 14,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                      size: 14,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                      size: 14,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                      size: 14,
                                    ),
                                    Text(movie.voteAverage,
                                        style: TextStyle(
                                          color: Colors.black45,
                                        ))
                                  ],
                                ),
                              )
                            ],
                          );
                  },
                  separatorBuilder: (context, index) => const VerticalDivider(
                    color: Colors.transparent,
                    width: 15,
                  ),
                  itemCount: movieProvider.movies.length,
                ),
              ),
            ],
          );
  }
}
