import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ireceipt/module/camera_page/cubit/camera_cubit.dart';
import 'package:ireceipt/module/camera_page/cubit/flashlight_cubit.dart';
import 'package:ireceipt/module/main_page/cubit/main_animation_cubit.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => MainAnimationCubit()..init(this),
        ),
        BlocProvider(
          create: (_) => CameraCubit()..initControllers(),
        ),
        BlocProvider(
          create: (_) => FlashlightCubit(),
        ),
      ],
      child: Stack(
        children: [
          MainTopCustomPanel(),
          MainTopInfoPanel(),
          BottomAnimatedPanel(),
        ],
      ),
    );
  }
}
