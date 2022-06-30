import 'package:common_base/AssetsColor.dart';
import 'package:common_base/PageRoutes.dart';
import 'package:flutter/material.dart';

class SplashActivity extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SplashStateActivity();
}

class SplashStateActivity extends State<SplashActivity> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2),
        () => Navigator.of(context).pushNamed(PageRoutes.linkHome));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      body: Container(
          decoration: const BoxDecoration(color: Colors.white),
          child: LayoutBuilder(
            builder: (context, constraint) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Align(
                      alignment: Alignment.center,
                      child: Text(
                        "The Movie",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AssetsColor.ColorGreen2),
                      ))
                ]),
          )));
}
