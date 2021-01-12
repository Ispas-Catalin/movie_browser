import 'package:movie_browser/src/actions/index.dart';
import 'package:movie_browser/src/models/index.dart';
import 'package:redux/redux.dart';

Reducer<AppState> reducer = combineReducers(<Reducer<AppState>>[
  TypedReducer<AppState, GetMoviesStart>(_getMoviesStart),
  TypedReducer<AppState, GetMoviesSuccessful>(_getMoviesSuccessful),
  TypedReducer<AppState, GetMoviesError>(_getMoviesError),
  TypedReducer<AppState, UpdateQuality>(_updateQuality),
  TypedReducer<AppState, UpdateGenre>(_updateGenre),
  TypedReducer<AppState, UpdateOrderBy>(_updateOrderBy),
  TypedReducer<AppState, SetSelectedMovie>(_setSelectedMovie),
]);

AppState _getMoviesStart(AppState state, GetMoviesStart action) {
  return state.rebuild((AppStateBuilder b) => b.isLoading = true);
}

AppState _getMoviesSuccessful(AppState state, GetMoviesSuccessful action) {
  return state.rebuild((AppStateBuilder b) {
    b
      ..movies.addAll(action.movies)
      ..isLoading = false
      ..page = state.page + 1;
  });
}

AppState _getMoviesError(AppState state, GetMoviesError action) {
  return state.rebuild((AppStateBuilder b) => b.isLoading = false);
}

AppState _updateQuality(AppState state, UpdateQuality action) {
  return state.rebuild((AppStateBuilder b) {
    b
      ..movies.clear()
      ..page = 1
      ..quality = action.quality;
  });
}

AppState _updateGenre(AppState state, UpdateGenre action) {
  return state.rebuild((AppStateBuilder b) {
    b
      ..movies.clear()
      ..page = 1
      ..genre = action.genre;
  });
}

AppState _updateOrderBy(AppState state, UpdateOrderBy action) {
  return state.rebuild((AppStateBuilder b) {
    b
      ..movies.clear()
      ..page = 1
      ..orderBy = action.orderBy;
  });
}

AppState _setSelectedMovie(AppState state, SetSelectedMovie action) {
  return state.rebuild((AppStateBuilder b) => b.selectedMovie = action.movieId);
}
