import 'package:app/presentation/journeys/home/movie_carousel/movie_backdrop_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/depen_injec/dev_get_data.dart';
import 'package:app/presentation/blocs/movie_details/movie_details_bloc.dart';
import 'package:app/presentation/journeys/movie_details/movie_details_arguments.dart';

import 'package:app/presentation/blocs/movie_backdrop/movie_backdrop_bloc.dart';
import 'package:app/presentation/blocs/movie_carousel/movie_carousel_bloc.dart';
import 'package:app/presentation/blocs/movie_tab/movie_tabbed_bloc.dart';
import 'package:app/presentation/journeys/drawer/drawer_widget.dart';
import 'package:app/presentation/journeys/home/movie_tabbed/movie_tabbed_widget.dart';
import 'package:app/presentation/widgets/app_progress_indicator.dart';

class MovieDetailsScreen extends StatefulWidget {
  final MovieDetailsArguments movieDetailsArguments;

  const MovieDetailsScreen({
    Key key,
    @required this.movieDetailsArguments,
  }) : super(key: key);

  @override
  _MovieDetailsScreenState createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  MovieDetailsBloc _movieDetailsBloc;
  MovieCarouselBloc _movieCarouselBloc;
  MovieBackdropBloc _movieBackdropBloc;
  MovieTabbedBloc _movieTabbedBloc;

  @override
  void initState() {
    super.initState();
    _movieDetailsBloc = getIt<MovieDetailsBloc>();
    _movieDetailsBloc
        .add(MovieDetailsLoadEvent(widget.movieDetailsArguments.movieId));

    _movieCarouselBloc = getIt<MovieCarouselBloc>();
    _movieBackdropBloc = _movieCarouselBloc.movieBackdropBloc;
    _movieTabbedBloc = getIt<MovieTabbedBloc>();
    _movieCarouselBloc.add(MovieCarouselLoadEvent());
  }

  @override
  void dispose() {
    _movieCarouselBloc?.close();
    _movieBackdropBloc?.close();
    _movieTabbedBloc?.close();
    _movieDetailsBloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      body: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: _movieCarouselBloc),
          BlocProvider.value(value: _movieBackdropBloc),
          BlocProvider.value(value: _movieTabbedBloc),
          BlocProvider.value(value: _movieDetailsBloc),
        ],
        child: BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
          builder: (context, state) {
            if (state is MovieCarouselLoading) {
              return AppProgressIndicator();
            }
            if (state is MovieDetailsErrorState) {
              return Center(child: Text("error"));
            }
            if (state is MovieDetailsLoadedState) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  FractionallySizedBox(
                    alignment: Alignment.topCenter,
                    heightFactor: 0.2,
                    child: Center(
                      child: Text("Movie Details Page"),
                    ),
                  ),
                  FractionallySizedBox(
                    alignment: Alignment.topCenter,
                    heightFactor: 0.4,
                    child: Center(
                      child: Text(state.movieDetailsEntity.title),
                    ),
                  ),
                  FractionallySizedBox(
                    alignment: Alignment.bottomCenter,
                    heightFactor: 0.25,
                    child: const MovieTabbedWidget(),
                  ),
                ],
              );
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
