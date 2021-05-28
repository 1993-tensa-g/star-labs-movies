import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translation/flutter_translation.dart';
import 'package:app/common/translations/app_languages.dart';
import 'package:app/common/translations/app_localizations.dart';

import 'package:app/depen_injec/dev_get_data.dart';
import 'package:app/presentation/blocs/language_bloc/language_bloc.dart';
import 'package:app/common/constants/color_constants.dart';
import 'package:app/common/constants/text_constants.dart';
import 'package:app/presentation/wiredash_app.dart';
import './journeys/home/home_screen.dart';

class MoviesApp extends StatefulWidget {
  const MoviesApp({Key key}) : super(key: key);

  @override
  _MoviesAppState createState() => _MoviesAppState();
}

class _MoviesAppState extends State<MoviesApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  LanguageBloc _languageBloc;

  @override
  void initState() {
    super.initState();
    _languageBloc = getIt<LanguageBloc>();
  }

  @override
  void dispose() {
    _languageBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _languageBloc,
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, state) {
          if (state is LanguageLoadedState) {
            return WiredashApp(
              navigatorKey: _navigatorKey,
              locale: state.locale,
              child: MaterialApp(
                navigatorKey: _navigatorKey,
                debugShowCheckedModeBanner: false,
                title: 'Movies App',
                theme: ThemeData(
                  primaryColor: AppColors.vulcan,
                  accentColor: AppColors.royalBlue,
                  unselectedWidgetColor: AppColors.royalBlue,
                  scaffoldBackgroundColor: AppColors.vulcan,
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                  appBarTheme: const AppBarTheme(elevation: 0),
                  textTheme: TextThemes.getTextTheme(),
                ),
                supportedLocales: getIt<AppLanguages>()
                    .languages
                    .map((lang) => lang.toLocale()),
                locale: state.locale,
                localizationsDelegates: [
                  AppLocalizationsDelegate(),
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                home: HomeScreen(),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
