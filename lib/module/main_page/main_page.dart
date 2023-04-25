import 'package:flutter/material.dart';
import 'package:ireceipt/module/main_page/widgets/bottom_animated_panel.dart';
import 'package:ireceipt/module/main_page/widgets/main_top_custom_panel.dart';
import 'package:ireceipt/module/main_page/widgets/main_top_info_panel.dart';

class MainPage extends StatefulWidget {
  MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MainTopCustomPanel(),
        MainTopInfoPanel(),
        BottomAnimatedPanel(),
      ],
    );
  }
}
