import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/model/color.dart';
import 'package:movie_app/model/movie_model.dart';
import 'package:movie_app/model/users/users.dart';
import 'package:movie_app/screen/movie/movie_description.dart';
import 'package:movie_app/screen/search/search_view_model.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  final Users user;
  const SearchScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final controller = TextEditingController();
  List<Movie> movies = [];

  @override
  void initState() {
    super.initState();
    Provider.of<SearchViewModel>(context, listen: false).getMovies();
  }

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchViewModel>(context);
    if (movies.isEmpty) {
      movies = Provider.of<SearchViewModel>(context, listen: false).movies;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Movie'),
        centerTitle: true,
        backgroundColor: hexStringToColor('333333'),
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search_rounded),
                hintText: 'Movie Title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                )),
            onChanged: searchMovie,
          ),
        ),
        Expanded(child: body(searchProvider)),
      ]),
    );
  }

  Widget body(SearchViewModel viewModel) {
    final isLoading = viewModel.state == SearchViewState.loading;
    final isError = viewModel.state == SearchViewState.error;

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (isError) {
      return const Center(
        child: Text("Can't get the data"),
      );
    }

    return _searchWidget(viewModel);
  }

  Widget _searchWidget(SearchViewModel viewModel) {
    return movies.isEmpty
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : ListView.builder(
            itemBuilder: (context, index) {
              final movie = movies[index];
              return ListTile(
                leading: ClipPath(
                  child: ClipRRect(
                    child: CachedNetworkImage(
                      imageUrl:
                          'https://image.tmdb.org/t/p/original/${movie.backdropPath}',
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                    ),
                  ),
                ),
                title: Text(movie.title),
                onTap: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return MovieDetailScreen(
                            movie: movie, user: widget.user);
                      },
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        final tween =
                            Tween(begin: const Offset(0, 5), end: Offset.zero);
                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    ),
                  );
                },
              );
            },
            itemCount: movies.length);
  }

  searchMovie(String query) {
    final viewModel = Provider.of<SearchViewModel>(context, listen: false);
    final suggestions = viewModel.movies.where((movie) {
      final movieTitle = movie.title.toLowerCase();
      final input = query.toLowerCase();

      return movieTitle.contains(input);
    }).toList();

    setState(() => movies = suggestions);
  }
}
