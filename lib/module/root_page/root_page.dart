import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ireceipt/kit/page_base/receipt_page_base.dart';
import 'package:ireceipt/module/root_page/cubit/root_cubit.dart';
import 'package:ireceipt/module/root_page/widgets/page_indicator.dart';
import 'package:ireceipt/router/app_router.gr.dart';

class RootPage extends ReceiptPageBase {
  RootPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => RootCubit()..init(),
      child: this,
    );
  }

  @override
  Widget readyContent(BuildContext context, ColorScheme scheme, Size? size) {
    return ColoredBox(
      color: scheme.background,
      child: AutoTabsRouter.pageView(
        routes: [
          MainRoute(),
          AnalyticsRoute(),
        ],
        homeIndex: 1,
        builder: (context, child, controller) => Scaffold(
          body: BlocBuilder<RootCubit, RootState>(
            builder: (context, state) {
              if (state is RootInitial) {
                return Stack(
                  children: [
                    Positioned.fill(
                      child: child,
                    ),
                    Align(
                      alignment: Alignment(0, -0.91),
                      child: PageIndicator(
                        itemCount: context.read<RootCubit>().pages.length,
                        controller: controller,
                      ),
                    ),
                  ],
                );
              }

              return SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
