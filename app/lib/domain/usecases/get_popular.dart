import 'package:dartz/dartz.dart';
import 'package:app/domain/entities/app_error.dart';
import 'package:app/domain/entities/movie_entity.dart';
import 'package:app/domain/entities/no_params.dart';
import 'package:app/domain/repositories/movie_repository.dart';
import 'package:app/domain/usecases/usecase.dart';

class GetPopular extends Usecase<List<MovieEntity>, NoParams> {
  GetPopular(MoviesRepository movieRepository) : super(movieRepository);

  Future<Either<AppError, List<MovieEntity>>> call(NoParams noParams) async {
    return await movieRepository.getPopular();
  }
}
