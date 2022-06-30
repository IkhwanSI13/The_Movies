import 'package:flutter/widgets.dart';

class PageRoutes {
  static const linkSplash = "/";
  static const linkHome = "/Home";
  static const linkDetailMovie = "/DetailMovie";
  static const linkDetailTv = "/DetailTv";
}

///
class CustomPageRoute extends PageRouteBuilder {
  final Widget? page;

  CustomPageRoute({this.page})
      : super(
          pageBuilder: (_, __, ___) => page!,
          transitionsBuilder: (_, animation, __, child) => FadeTransition(
            opacity: animation,
            child: child,
          ),
          transitionDuration: Duration(milliseconds: 250),
        );
}
