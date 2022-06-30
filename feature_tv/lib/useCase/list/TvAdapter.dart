import 'package:cached_network_image/cached_network_image.dart';
import 'package:common_base/AssetsColor.dart';
import 'package:feature_tv/repo/model/TvsModel.dart';
import 'package:flutter/material.dart';

class TvAdapter extends StatelessWidget {
  final Tv tv;
  final String url;
  final Function(int) onClick;

  TvAdapter(this.tv, this.url, this.onClick);

  @override
  Widget build(BuildContext context) => InkWell(
      onTap: () {
        onClick(tv.id);
      },
      child: Container(
        height: 206,
        padding: const EdgeInsets.fromLTRB(12, 0, 24, 0),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(16))),
        child: Row(
          children: [
            Container(
                width: 137,
                height: 206,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(24))),
                child: CachedNetworkImage(
                    imageUrl: url,
                    imageBuilder: (context, imageProvider) => Container(
                        margin: const EdgeInsets.fromLTRB(0, 12, 12, 12),
                        width: 137,
                        height: 206,
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16)),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                              // colorFilter: const ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                            ))),
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Center(child: Icon(Icons.error)))),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(height: 12),
                  Text(tv.name,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600)),
                  Container(height: 8),
                  Expanded(
                      child: Text(tv.overview,
                          maxLines: 5, overflow: TextOverflow.ellipsis)),
                  Row(
                    children: [
                      const Icon(Icons.star, color: AssetsColor.ColorYellow2),
                      Container(width: 8),
                      Text("${tv.voteAverage} / 10",
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: AssetsColor.ColorYellow2))
                    ],
                  ),
                  Container(height: 12),
                ],
              ),
            )
          ],
        ),
      ));
}
