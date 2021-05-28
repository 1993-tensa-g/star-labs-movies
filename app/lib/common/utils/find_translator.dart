import 'package:flutter/widgets.dart';
import 'package:app/common/translations/app_translator.dart';
import 'package:app/depen_injec/dev_get_data.dart';

class Utils {
  static AppTranslator findTranslator(BuildContext context) {
    return getIt.get<AppTranslator>(param1: context);
  }
}
