import 'package:common_base/AssetsColor.dart';
import 'package:common_base/LocalStatus.dart';
import 'package:feature_movie/useCase/list/MoviesFragment.dart';
import 'package:feature_profile/ProfileFragment.dart';
import 'package:feature_tv/useCase/list/TvsFragment.dart';
import 'package:flutter/material.dart';
import 'package:the_movie/useCase/home/HomeBloc.dart';

class HomeActivity extends StatefulWidget {
  @override
  State<HomeActivity> createState() => _HomeState();
}

class _HomeState extends State<HomeActivity> {
  final HomeBloc _bloc = HomeBloc();

  @override
  void initState() {
    super.initState();
    _bloc.initData();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder(
          initialData: _bloc.localStatus.subjectStatus,
          stream: _bloc.localStatus.observableStatus,
          builder: (ctx, snapshot) {
            switch (snapshot.data) {
              case LocalStatus.isSuccess:
                return _viewBody();
              case LocalStatus.isError:
                return const Center(
                  child: Text("Error ..."),
                );
              case LocalStatus.isLoading:
              default:
                return const Center(
                  child: Text("Loading ..."),
                );
            }
          },
        ),
        bottomNavigationBar: _viewBottomNav(),
      );

  Widget _viewBody() => StreamBuilder(
        initialData: 0,
        stream: _bloc.streamMenu,
        builder: (ctx, snapshot) {
          var menu = snapshot.data as int;
          switch (menu) {
            case 0:
              return MoviesFragment();
            case 1:
              return TvFragment();
            case 2:
            default:
              return ProfileFragment();
          }
        },
      );

  Widget _viewBottomNav() => StreamBuilder(
        initialData: 0,
        stream: _bloc.streamMenu,
        builder: (ctx, snapshot) {
          var selectedIndex = snapshot.data as int;
          return BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.movie),
                  label: 'Movies',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.tv),
                  label: 'Tv',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.emoji_people),
                  label: 'Profile',
                ),
              ],
              currentIndex: selectedIndex,
              selectedItemColor: AssetsColor.ColorYellow2,
              onTap: _onItemTapped);
        },
      );

  ///
  void _onItemTapped(int index) {
    _bloc.setMenu(index);
  }
}
