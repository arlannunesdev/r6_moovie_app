import '../../../../../domain/entities/movie.dart';

abstract class LocalDataSourceMovies {
  Future<List<Movie>> getFavorites();

  Future<void> addToFavorites(Movie movie);

  Future<bool> isFavorite(int id);

  Future<void> removeFromFavorites(Movie movie);
}
