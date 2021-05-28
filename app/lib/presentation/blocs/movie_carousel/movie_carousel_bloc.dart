import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:app/domain/entities/app_error.dart';

import 'package:app/domain/entities/movie_entity.dart';
import 'package:app/domain/entities/no_params.dart';
import 'package:app/domain/usecases/get_trending.dart';
import 'package:app/presentation/blocs/movie_backdrop/movie_backdrop_bloc.dart';

part 'movie_carousel_event.dart';
part 'movie_carousel_state.dart';

class MovieCarouselBloc extends Bloc<MovieCarouselEvent, MovieCarouselState> {
  final GetTrending getTrending;
  final MovieBackdropBloc movieBackdropBloc;

  MovieCarouselBloc({
    @required this.getTrending,
    @required this.movieBackdropBloc,
  }) : super(MovieCarouselInitial());

  @override
  Stream<MovieCarouselState> mapEventToState(
    MovieCarouselEvent event,
  ) async* {
    if (event is MovieCarouselLoadEvent) {
      yield MovieCarouselLoading();
      final eitherMovies = await getTrending(NoParams());
      yield eitherMovies.fold(
        (error) => MovieCarouselLoadError(error.appErrorType),
        (movies) {
          movieBackdropBloc.add(MovieBackdropChangedEvent(movies.first));
          return MovieCarouselLoaded(
            movies: movies,
          );
        },
      );
    }
  }
}