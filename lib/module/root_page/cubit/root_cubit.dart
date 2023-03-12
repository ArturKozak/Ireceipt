import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ireceipt/module/analytics_page/analytics_page.dart';
import 'package:ireceipt/module/main_page/main_page.dart';

part 'root_state.dart';

class RootCubit extends Cubit<RootState> {
  RootCubit() : super(RootInitial());

  late final PageController _pageController;
  late final _pages = [
    AnalyticsPage(),
    MainPage(),
  ];

  PageController get pageController => _pageController;
  List<Widget> get pages => _pages;

  void init() {
    _pageController = PageController(
      initialPage: 1,
    );
  }
}
