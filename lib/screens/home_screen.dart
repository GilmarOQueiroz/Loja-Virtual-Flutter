import 'package:flutter/material.dart';

import '../tabs/home_tab.dart';
import '../widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key key}) : super(key: key);

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {

    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          body: HomeTab(),
          drawer: CustomDrawer(),
        )

      ],
    );
  }
}