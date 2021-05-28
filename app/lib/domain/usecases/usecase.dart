import 'package:dartz/dartz.dart';

import 'package:app/domain/entities/app_error.dart';
import 'package:app/domain/repositories/movie_repository.dart';

abstract class Usecase<Type, Params> {
  final MoviesRepository movieRepository;

  const Usecase(this.movieRepository);

  Future<Either<AppError, Type>> call(Params params);
}
