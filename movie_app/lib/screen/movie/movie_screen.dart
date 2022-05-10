import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/model/movie_model.dart';
import 'package:movie_app/model/person.dart';
import 'package:movie_app/screen/movie/movie_category.dart';
import 'package:movie_app/screen/movie/movie_description.dart';
import 'package:movie_app/screen/movie/movie_view_model.dart';
import 'package:movie_app/screen/movie/person_view_model.dart';
import 'package:provider/provider.dart';

class MovieScreen extends StatefulWidget {
  MovieScreen({Key? key}) : super(key: key);

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<MovieViewModel>(context, listen: false).getCurrentPlayMovies(0);
    Provider.of<PersonViewModel>(context, listen: false).getTrendingPerson();
  }
  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieViewModel>(context);
    final personProvider = Provider.of<PersonViewModel>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Movie-App'),
      ),
      body: movieProvider.movies.isEmpty?const CircularProgressIndicator(): LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CarouselSlider.builder(
                    itemCount: movieProvider.movies.length,
                    itemBuilder: (BuildContext context, int index, int pageViewIndex) {
                      Movie movie = movieProvider.movies[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,MaterialPageRoute(
                              builder: (context) => MovieDetailScreen(movie: movie),
                            ),
                          );
                        },
                        child: Stack(
                          alignment: Alignment.bottomLeft,
                          children: [
                            ClipRRect(
                              child: CachedNetworkImage(
                                imageUrl: 'https://image.tmdb.org/t/p/original/${movie.backdropPath}',
                                height:MediaQuery.of(context).size.height / 3,
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.cover,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15,left: 15,),
                              child: Text(
                                movieProvider.movies[index].title.toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    options: CarouselOptions(
                      enableInfiniteScroll: true,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 5),
                      autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                      pauseAutoPlayOnTouch: true,
                      viewportFraction: 0.8,
                      enlargeCenterPage: true,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      children: [
                        SizedBox(height: 12),
                        CategoryWidget(),
                        SizedBox(height: 12),
                        Text(
                          'Trending persons on this week'.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black45,
                          ),
                        ),
                        SizedBox(height: 12),
                        Column(
                          children: [
                            Container(
                              height: 130,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  Person persons = personProvider.persons[index];
                                  return Container(
                                    child: Column(
                                      children: [
                                        Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(100)
                                          ),
                                          elevation: 3,
                                          child: persons.profilePath=='null'?const Image(
                                            image: AssetImage('assets/images/user.png'),
                                            height: 80,
                                            width: 80,
                                          ):
                                          ClipRRect(
                                            child: CachedNetworkImage(
                                              imageUrl: 'https://image.tmdb.org/t/p/w500${persons.profilePath}',
                                              imageBuilder: (context, imageProvider) {
                                                return Container(
                                                  width:  80,
                                                  height: 80,
                                                  decoration: BoxDecoration(
                                                    borderRadius: const BorderRadius.all(Radius.circular(100)),
                                                    image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Center(
                                            child: Text(persons.name!.toUpperCase()),
                                          ),
                                        ),
                                        Container(
                                          child: Center(
                                            child: Text(persons.knowForDepartment!.toUpperCase()),
                                          ),
                                        )
                                      ]
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) => const VerticalDivider(),
                                itemCount: personProvider.persons.length,
                              ),
                            )
                          ]
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}