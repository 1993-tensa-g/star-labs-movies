import 'package:dartz/dartz.dart';
import 'package:app/data/models/movie_details.dart';

import 'package:app/domain/entities/app_error.dart';
import 'package:app/domain/entities/movie_entity.dart';

abstract class MoviesRepository {
  Future<Either<AppError, List<MovieEntity>>> getTrending();
  Future<Either<AppError, List<MovieEntity>>> getPopular();
  Future<Either<AppError, List<MovieEntity>>> getPlayingNow();
  Future<Either<AppError, List<MovieEntity>>> getComingSoon();
  Future<Either<AppError, MovieDetailsModel>> getMovieDetails(int id);
}
