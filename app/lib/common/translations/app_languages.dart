import 'package:app/common/translations/jp_translator.dart';
import 'package:flutter_translation/flutter_translation.dart';

import 'en_translator.dart';

class AppLanguages extends ILanguages {
  AppLanguages.singleton();

  @override
  LanguageEntity get defaultLanguage => this.findByCode('en');

  @override
  List<LanguageEntity> createLanguages() {
    return [
      const LanguageEntity(
        code: 'en',
        name: 'English',
        translator: const EnTranslator(),
      ),
      const LanguageEntity(
        code: 'ja',
        name: 'Japanese',
        translator: const JpTranslator(),
      ),
    ];
  }
}
