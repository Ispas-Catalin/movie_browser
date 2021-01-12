part of models;

abstract class AppState implements Built<AppState, AppStateBuilder> {
  factory AppState([void Function(AppStateBuilder) updates]) = _$AppState;

  factory AppState.initialState() {
    final AppStateBuilder builder = AppStateBuilder();
    builder
      ..isLoading = true
      ..page = 1
      ..orderBy = 'desc';
    return builder.build();
  }

  AppState._();

  BuiltList<Movie> get movies;

  int get page;

  @nullable
  String get quality;

  @nullable
  String get genre;

  String get orderBy;

  bool get isLoading;

  @nullable
  int get selectedMovie;
}
