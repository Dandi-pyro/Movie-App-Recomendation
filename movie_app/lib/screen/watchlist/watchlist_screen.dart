import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/model/color.dart';
import 'package:movie_app/model/users/users.dart';
import 'package:movie_app/screen/drawer_screen.dart';
import 'package:movie_app/screen/watchlist/dropped_view_model.dart';
import 'package:movie_app/screen/watchlist/finish_view_model.dart';
import 'package:movie_app/screen/watchlist/watchlist_view_model.dart';
import 'package:provider/provider.dart';

class WatchlistScreen extends StatefulWidget {
  final Users user;
  const WatchlistScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  late Users user;
  @override
  void initState() {
    super.initState();
    user = widget.user;
    Provider.of<WatchlistViewModel>(context, listen: false).watchlist.clear();
    Provider.of<DroppedViewModel>(context, listen: false).dropped.clear();
    Provider.of<FinishViewModel>(context, listen: false).finish.clear();
    Provider.of<WatchlistViewModel>(context, listen: false)
        .getMovieById(user.movieWatch!);
    Provider.of<DroppedViewModel>(context, listen: false)
        .getMovieById(user.movieDropped!);
    Provider.of<FinishViewModel>(context, listen: false)
        .getMovieById(user.movieFinish!);
  }

  @override
  Widget build(BuildContext context) {
    final watchlistProvider = Provider.of<WatchlistViewModel>(context);
    final droppedProvider = Provider.of<DroppedViewModel>(context);
    final finishProvider = Provider.of<FinishViewModel>(context);
    // if (watchlistProvider.watchlist.isEmpty) {
    //   watchlistProvider.getMovieById(widget.user.movieWatch!);
    //   droppedProvider.getMovieById(widget.user.movieDropped!);
    // }
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: hexStringToColor('333333'),
        appBar: AppBar(
          title: const Text('Watchlist'),
          backgroundColor: hexStringToColor('333333'),
          bottom: const TabBar(
            tabs: [
              Tab(
                text: 'Current Watch',
              ),
              Tab(
                text: 'Dropped',
              ),
              Tab(
                text: 'Done',
              ),
            ],
          ),
        ),
        drawer: DrawerScreen(user: user),
        body: TabBarView(
          children: [
            watchlistBody(watchlistProvider, droppedProvider, finishProvider),
            droppedBody(watchlistProvider, droppedProvider),
            finishWidget(finishProvider),
          ],
        ),
      ),
    );
  }

  Widget watchlistBody(WatchlistViewModel watchlistViewModel,
      DroppedViewModel droppedViewModel, FinishViewModel finishViewModel) {
    final isLoading = watchlistViewModel.state == WatchlistViewState.loading;
    final isError = watchlistViewModel.state == WatchlistViewState.error;

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (isError) {
      return const Center(
        child: Text("Can't get the data"),
      );
    }

    return watchlistWidget(
        watchlistViewModel, droppedViewModel, finishViewModel);
  }

  Widget droppedBody(WatchlistViewModel watchlistViewModel,
      DroppedViewModel droppedViewModel) {
    final isLoading = watchlistViewModel.state == DroppedViewState.loading;
    final isError = watchlistViewModel.state == DroppedViewState.error;

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (isError) {
      return const Center(
        child: Text("Can't get the data"),
      );
    }

    return droppedWidget(watchlistViewModel, droppedViewModel);
  }

  Widget finishBody(FinishViewModel finishViewModel) {
    final isLoading = finishViewModel.state == FinishViewState.loading;
    final isError = finishViewModel.state == FinishViewState.error;

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (isError) {
      return const Center(
        child: Text("Can't get the data"),
      );
    }

    return finishWidget(finishViewModel);
  }

  Widget watchlistWidget(WatchlistViewModel watchlistViewModel,
      DroppedViewModel droppedViewModel, FinishViewModel finishViewModel) {
    return watchlistViewModel.watchlist.isEmpty
        ? const Center(
            child: Text(
              'there is no movie you are watching now',
              style: TextStyle(color: Colors.white),
            ),
          )
        : ListView.separated(
            itemBuilder: (context, index) {
              return Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: hexStringToColor('333333'),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(shape: BoxShape.rectangle),
                          child: ClipPath(
                            child: ClipRRect(
                              child: CachedNetworkImage(
                                imageUrl:
                                    'https://image.tmdb.org/t/p/original/${watchlistViewModel.watchlist[index].backdropPath}',
                                height: MediaQuery.of(context).size.height / 3,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 18,
                        width: 200,
                        child: Text(
                          watchlistViewModel.watchlist[index].title!,
                          style:
                              TextStyle(color: Colors.white.withOpacity(0.8)),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              child: Column(
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      List movie = [];
                                      movie.add(int.parse(watchlistViewModel
                                          .watchlist[index].id!));
                                      final docUser = FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(user.id);
                                      docUser.update({
                                        "movieDropped":
                                            FieldValue.arrayUnion(movie)
                                      });
                                      docUser.update({
                                        "movieWatch":
                                            FieldValue.arrayRemove(movie)
                                      });
                                      FirebaseFirestore.instance
                                          .collection("users")
                                          .doc(user.id)
                                          .get()
                                          .then((value) {
                                        user = Users.fromMap(value.data());
                                        setState(() {
                                          print('users = ${user.movieDropped}');
                                          watchlistViewModel.watchlist.clear();
                                          droppedViewModel.dropped.clear();
                                          watchlistViewModel
                                              .getMovieById(user.movieWatch!);
                                          droppedViewModel
                                              .getMovieById(user.movieDropped!);
                                        });
                                      });
                                    },
                                    child: const Text(
                                      'Drop',
                                      style: TextStyle(color: Colors.black45),
                                    ),
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                        hexStringToColor('FFD74B'),
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      List movie = [];
                                      movie.add(int.parse(watchlistViewModel
                                          .watchlist[index].id!));
                                      final docUser = FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(user.id);
                                      docUser.update({
                                        "movieFinish":
                                            FieldValue.arrayUnion(movie)
                                      });
                                      docUser.update({
                                        "movieWatch":
                                            FieldValue.arrayRemove(movie)
                                      });
                                      FirebaseFirestore.instance
                                          .collection("users")
                                          .doc(user.id)
                                          .get()
                                          .then((value) {
                                        user = Users.fromMap(value.data());
                                        setState(() {
                                          print('users = ${user.movieFinish}');
                                          watchlistViewModel.watchlist.clear();
                                          finishViewModel.finish.clear();
                                          watchlistViewModel
                                              .getMovieById(user.movieWatch!);
                                          finishViewModel
                                              .getMovieById(user.movieFinish!);
                                        });
                                      });
                                    },
                                    child: const Text(
                                      'Finish',
                                      style: TextStyle(color: Colors.black45),
                                    ),
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                        hexStringToColor('FFD74B'),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => const VerticalDivider(),
            itemCount: watchlistViewModel.watchlist.length,
          );
  }

  Widget droppedWidget(WatchlistViewModel watchlistViewModel,
      DroppedViewModel droppedViewModel) {
    return droppedViewModel.dropped.isEmpty
        ? const Center(
            child: Text(
              'There are no movies you dropped',
              style: TextStyle(color: Colors.white),
            ),
          )
        : ListView.separated(
            itemBuilder: (context, index) {
              return Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: hexStringToColor('333333'),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(shape: BoxShape.rectangle),
                          child: ClipPath(
                            child: ClipRRect(
                              child: CachedNetworkImage(
                                imageUrl:
                                    'https://image.tmdb.org/t/p/original/${droppedViewModel.dropped[index].backdropPath}',
                                height: MediaQuery.of(context).size.height / 3,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 18,
                        width: 200,
                        child: Text(
                          droppedViewModel.dropped[index].title!,
                          style:
                              TextStyle(color: Colors.white.withOpacity(0.8)),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Center(
                            child: ElevatedButton(
                              onPressed: () {
                                List movie = [];
                                movie.add(int.parse(
                                    droppedViewModel.dropped[index].id!));
                                final docUser = FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(user.id);
                                docUser.update({
                                  "movieWatch": FieldValue.arrayUnion(movie)
                                });
                                docUser.update({
                                  "movieDropped": FieldValue.arrayRemove(movie)
                                });
                                FirebaseFirestore.instance
                                    .collection("users")
                                    .doc(user.id)
                                    .get()
                                    .then((value) {
                                  user = Users.fromMap(value.data());
                                  setState(() {
                                    print('users = ${user.movieDropped}');
                                    watchlistViewModel.watchlist.clear();
                                    droppedViewModel.dropped.clear();
                                    watchlistViewModel
                                        .getMovieById(user.movieWatch!);
                                    droppedViewModel
                                        .getMovieById(user.movieDropped!);
                                  });
                                });
                              },
                              child: const Text(
                                'Watch Again',
                                style: TextStyle(color: Colors.black45),
                                maxLines: 2,
                                textAlign: TextAlign.center,
                              ),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  hexStringToColor('FFD74B'),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => const VerticalDivider(),
            itemCount: droppedViewModel.dropped.length,
          );
  }

  Widget finishWidget(FinishViewModel finishViewModel) {
    return finishViewModel.finish.isEmpty
        ? const Center(
            child: Text('there are no movies you finished watching'),
          )
        : ListView.separated(
            itemBuilder: (context, index) {
              return Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: hexStringToColor('333333'),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(shape: BoxShape.rectangle),
                          child: ClipPath(
                            child: ClipRRect(
                              child: CachedNetworkImage(
                                imageUrl:
                                    'https://image.tmdb.org/t/p/original/${finishViewModel.finish[index].backdropPath}',
                                height: MediaQuery.of(context).size.height / 3,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 18,
                        width: 250,
                        child: Text(
                          finishViewModel.finish[index].title!,
                          style:
                              TextStyle(color: Colors.white.withOpacity(0.8)),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      // Expanded(
                      //   child: Padding(
                      //     padding: const EdgeInsets.only(right: 16),
                      //     child: Center(
                      //       child: ElevatedButton(
                      //         onPressed: () {
                      //           List movie = [];
                      //           movie.add(int.parse(
                      //               droppedProvider.dropped[index].id!));
                      //           final docUser = FirebaseFirestore.instance
                      //               .collection('users')
                      //               .doc(user.id);
                      //           docUser.update({
                      //             "movieWatch": FieldValue.arrayUnion(movie)
                      //           });
                      //           docUser.update({
                      //             "movieDropped":
                      //                 FieldValue.arrayRemove(movie)
                      //           });
                      //           FirebaseFirestore.instance
                      //               .collection("users")
                      //               .doc(user.id)
                      //               .get()
                      //               .then((value) {
                      //             user = Users.fromMap(value.data());
                      //             setState(() {
                      //               print('users = ${user.movieDropped}');
                      //               watchlistProvider.watchlist.clear();
                      //               droppedProvider.dropped.clear();
                      //               watchlistProvider
                      //                   .getMovieById(user.movieWatch!);
                      //               droppedProvider
                      //                   .getMovieById(user.movieDropped!);
                      //             });
                      //           });
                      //         },
                      //         child: const Text(
                      //           'Watch Again',
                      //           style: TextStyle(color: Colors.black45),
                      //           maxLines: 2,
                      //           textAlign: TextAlign.center,
                      //         ),
                      //         style: ButtonStyle(
                      //           backgroundColor: MaterialStateProperty.all(
                      //             hexStringToColor('FFD74B'),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => const VerticalDivider(),
            itemCount: finishViewModel.finish.length,
          );
  }
}
