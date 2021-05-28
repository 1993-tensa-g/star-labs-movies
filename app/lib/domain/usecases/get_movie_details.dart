import 'package:dartz/dartz.dart';

import 'package:app/data/models/movie_details.dart';
import 'package:app/domain/entities/app_error.dart';
import 'package:app/domain/entities/movie_params.dart';
import 'package:app/domain/repositories/movie_repository.dart';
import 'package:app/domain/usecases/usecase.dart';

class GetMovieDetails extends Usecase<MovieDetailsModel, MovieParams> {
  GetMovieDetails(MoviesRepository movieRepository) : super(movieRepository);

  @override
  Future<Either<AppError, MovieDetailsModel>> call(MovieParams params) {
    return movieRepository.getMovieDetails(params.id);
  }
}
