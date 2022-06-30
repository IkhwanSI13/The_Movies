import 'package:flutter/material.dart';

class BaseListWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BaseListState();
}

class BaseListState<T extends BaseListWidget> extends State<T>
    with WidgetsBindingObserver {
  final keyActivity = GlobalKey<ScaffoldState>();
  final ScrollController scrollController = ScrollController();

  Color getBackgroundColor() => const Color(0xffF6F7FB);

  @override
  Widget build(BuildContext context) {
    scrollController.addListener(() {
      double maxScroll = scrollController.position.maxScrollExtent;
      double currentScroll = scrollController.position.pixels;
      double delta = 0.0;
      if (maxScroll - currentScroll <= delta) {
        onLoadMore();
      }
    });

    return Container(
      color: getBackgroundColor(),
      child: RefreshIndicator(
        onRefresh: () async {
          await onRefresh();
        },
        child: SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsets.only(top: 42, bottom: 12),
          child: getBody(),
        ),
      ),
    );
  }

  Widget getBody() => Container();

  Widget? getBottom() => null;

  ///
  void onLoadMore() {}

  onRefresh() async {}
}
