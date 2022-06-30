import 'package:common_base/PageRoutes.dart';
import 'package:feature_movie/repo/MovieRepo.dart';
import 'package:feature_movie/useCase/detail/MovieDetailActivity.dart';
import 'package:feature_tv/repo/TvRepo.dart';
import 'package:feature_tv/useCase/detail/TvDetailActivity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_movie/useCase/SplashActivity.dart';
import 'package:the_movie/useCase/home/HomeActivity.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => MovieRepoProvider()),
    ChangeNotifierProvider(create: (_) => TvRepoProvider())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'The Movie',
        theme: ThemeData(primarySwatch: Colors.blue),
        // home: const MyHomePage(title: 'Flutter Demo Home Page'),
        onGenerateRoute: _getRoute,
      );

  Route _getRoute(RouteSettings settings) {
    final Map<String, dynamic>? arguments =
        settings.arguments as Map<String, dynamic>?;
    switch (settings.name) {

      /// Umum
      case PageRoutes.linkSplash:
        return CustomPageRoute(page: SplashActivity());
      case PageRoutes.linkHome:
        return CustomPageRoute(page: HomeActivity());
      case PageRoutes.linkDetailMovie:
        return CustomPageRoute(page: MovieDetailActivity(arguments!["01"]));
      case PageRoutes.linkDetailTv:
        return CustomPageRoute(page: TvDetailActivity(arguments!["01"]));
    }
    return CustomPageRoute(page: SplashActivity());
  }
}
