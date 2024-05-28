import '../entities/movie.dart';

abstract class MoviesRepository {
  Future<List<Movie>> getPopularMovies();

  Future<List<Movie>> getFavorites();

  Future<void> addToFavorites(Movie movie);

  Future<bool> isFavorite(int id);

  Future<void> removeFromFavorites(Movie movie);
}
