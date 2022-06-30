import 'package:cached_network_image/cached_network_image.dart';
import 'package:common_base/AssetsColor.dart';
import 'package:flutter/material.dart';

class ProfileFragment extends StatefulWidget {
  @override
  State<ProfileFragment> createState() => ProfileState();
}

class ProfileState extends State<ProfileFragment> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _viewHeader(),
            Container(
              margin: const EdgeInsets.fromLTRB(24, 18, 24, 12),
              child: const Text(
                "Ikhwan\n(Software Engineer - Mobile)",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: AssetsColor.ColorGreen2),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(24, 32, 24, 0),
              child: const Text(
                  "My name is Ikhwan. I have 4+ years experience as a Software "
                  "Engineer (Mobile).\n\nI'm always learning any tech and enjoy "
                  "implementing it into the company. I write about tech on my "
                  "blog at yukngoding.id"),
            ),
            Expanded(
              child: Container(),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(24, 0, 24, 0),
              child: const Text(
                "“Always accompanies plans and desires with concrete actions”",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: AssetsColor.ColorYellow2),
              ),
            ),
            Container(height: 24),
          ],
        ),
      );

  Widget _viewHeader() => Container(
        color: AssetsColor.ColorGreen2,
        child: Stack(
          children: [
            CachedNetworkImage(
                imageUrl: "https://www.yukngoding.id/me/img/pp.jpg",
                imageBuilder: (context, imageProvider) => Center(
                      child: Container(
                          margin: const EdgeInsets.fromLTRB(0, 48, 0, 18),
                          width: 102,
                          height: 102,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      AssetsColor.ColorGreen1.withOpacity(0.8),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ))),
                    ),
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                    const Center(child: Icon(Icons.error)))
          ],
        ),
      );
}
