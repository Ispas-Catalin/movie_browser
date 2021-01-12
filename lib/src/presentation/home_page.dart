import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:movie_browser/src/actions/index.dart';
import 'package:movie_browser/src/containers/index.dart';
import 'package:movie_browser/src/models/index.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      builder: (BuildContext context, int page) {
        return IsLoadingContainer(
          builder: (BuildContext context, bool isLoading) {
            return Scaffold(
              appBar: AppBar(
                title: Text('${page - 1}'),
                actions: <Widget>[
                  OrderByContainer(
                    builder: (BuildContext context, String orderBy) {
                      return IconButton(
                        icon: Icon(orderBy == 'desc'
                            ? Icons.keyboard_arrow_down
                            : Icons.keyboard_arrow_up),
                        onPressed: () {
                          StoreProvider.of<AppState>(context) //
                            ..dispatch(UpdateOrderBy(
                                orderBy == 'desc' ? 'asc' : 'desc'))
                            ..dispatch(const GetMovies());
                        },
                      );
                    },
                  ),
                ],
              ),
              body: Column(
                children: <Widget>[
                  QualityContainer(
                    builder: (BuildContext context, String quality) {
                      return DropdownButton<String>(
                        onChanged: (String value) {
                          StoreProvider.of<AppState>(context) //
                            ..dispatch(UpdateQuality(value))
                            ..dispatch(const GetMovies());
                        },
                        value: quality,
                        items: <String>['720p', '1080p', '2160p', '3D']
                            .map((String quality) {
                          return DropdownMenuItem<String>(
                            value: quality,
                            child: Text(quality),
                          );
                        }).toList(),
                      );
                    },
                  ),
                  GenreContainer(
                    builder: (BuildContext context, String genre) {
                      return Wrap(
                        spacing: 8.0,
                        children: <String>[
                          'Action',
                          'Adventure',
                          'Animation',
                          'Biography',
                          'Comedy',
                          'Crime',
                          'Documentary',
                          'Drama',
                          'Family',
                          'Fantasy',
                          'Film Noir',
                          'History',
                          'Horror',
                          'Music',
                          'Musical',
                          'Mystery',
                          'Romance',
                          'Sci-Fi',
                          'Sport',
                          'Superhero',
                          'Thriller',
                          'War',
                          'Western',
                        ].map((String value) {
                          return ChoiceChip(
                            label: Text(value),
                            selected: value == genre,
                            onSelected: (bool selected) {
                              if (selected) {
                                StoreProvider.of<AppState>(context)
                                  ..dispatch(UpdateGenre(value))
                                  ..dispatch(const GetMovies());
                              }
                            },
                          );
                        }).toList(),
                      );
                    },
                  ),
                  Expanded(
                    child: Builder(
                      builder: (BuildContext context) {
                        if (isLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        return MoviesContainer(
                          builder:
                              (BuildContext context, BuiltList<Movie> movies) {
                            return Column(
                              children: <Widget>[
                                Expanded(
                                  child: GridView.builder(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisSpacing: 4.0,
                                      crossAxisSpacing: 4.0,
                                      crossAxisCount: 3,
                                    ),
                                    itemCount: movies.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final Movie movie = movies[index];

                                      return InkWell(
                                        onTap: () {
                                          StoreProvider.of<AppState>(context)
                                              .dispatch(
                                                  SetSelectedMovie(movie.id));

                                          Navigator.pushNamed(
                                              context, '/movieDetail');
                                        },
                                        child: GridTile(
                                          child: Image.network(
                                              movie.mediumCoverImage),
                                          footer: GridTileBar(
                                            title: Text(movie.title),
                                            subtitle:
                                                Text(movie.genres.join(', ')),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                FlatButton(
                                  child: const Text('Load more'),
                                  onPressed: () {
                                    StoreProvider.of<AppState>(context)
                                        .dispatch(const GetMovies());
                                  },
                                )
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}