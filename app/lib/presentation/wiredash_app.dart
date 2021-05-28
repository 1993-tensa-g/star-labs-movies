import 'package:flutter/material.dart';
import 'package:app/common/constants/color_constants.dart';
import 'package:wiredash/wiredash.dart';

class WiredashApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final Widget child;
  final Locale locale;

  const WiredashApp({
    Key key,
    @required this.navigatorKey,
    @required this.child,
    @required this.locale,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wiredash(
      projectId: 'star-labs-movies-3a8z5fu',
      secret: 'SECRET_TOBE_REPLACED_FOR_BUILD',
      navigatorKey: navigatorKey,
      options: WiredashOptionsData(
        locale: locale,
      ),
      theme: WiredashThemeData(
        brightness: Brightness.dark,
        primaryColor: AppColors.royalBlue,
        secondaryColor: AppColors.violet,
        secondaryBackgroundColor: AppColors.vulcan,
        dividerColor: AppColors.vulcan,
      ),
      child: child,
    );
  }
}
