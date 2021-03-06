import 'package:flutter/widgets.dart';
import 'package:flutter_translation/flutter_translation.dart';
import 'package:app/common/translations/app_languages.dart';
import 'package:app/common/translations/app_translator.dart';

import 'package:app/depen_injec/dev_get_data.dart';

class AppLocalizations extends ILocalizations<AppTranslator> {
  AppLocalizations.singleton(Locale locale) : super(locale);

  @override
  AppTranslator getTranslator(String languageCode) {
    return getIt<AppLanguages>().findByCode(languageCode).translator;
  }
}

class AppLocalizationsDelegate
    extends ILocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  List<LanguageEntity> getLanguages() => getIt<AppLanguages>().languages;

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations.singleton(locale);
  }
}
