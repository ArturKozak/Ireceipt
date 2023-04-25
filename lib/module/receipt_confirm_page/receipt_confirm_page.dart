import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:ireceipt/data/repo/product_name_repository.dart';
import 'package:ireceipt/kit/page_base/receipt_page_base.dart';
import 'package:ireceipt/module/receipt_confirm_page/cubit/receipt_confirm_cubit.dart';
import 'package:ireceipt/module/receipt_confirm_page/widgets/tax_panel.dart';

class ReceiptConfirmPage extends ReceiptPageBase {
  static final _iconSize = 35.0.r;

  final RecognizedText recognizedText;
  final InputImage inputImage;

  ReceiptConfirmPage({
    required this.recognizedText,
    required this.inputImage,
    super.key,
  });

  @override
  Widget wrappedRoute(BuildContext context) {
    final repo = ProductNameRepository()..getAll();
    final cubit = ReceiptConfirmCubit(repo)..init(recognizedText);

    return RepositoryProvider<ProductNameRepository>(
      create: (context) => repo,
      child: BlocProvider(
        create: (_) => cubit,
        child: this,
      ),
    );
  }

  @override
  Widget readyContent(BuildContext context, ColorScheme scheme, Size? size) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: scheme.background,
        bottomOpacity: 0.0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: FaIcon(
            FontAwesomeIcons.angleLeft,
            size: _iconSize,
            color: scheme.primary,
          ),
        ),
        elevation: 0,
      ),
      backgroundColor: scheme.background,
      bottomSheet: BlocBuilder<ReceiptConfirmCubit, ReceiptConfirmState>(
        builder: (context, state) {
          if (state is ReceiptConfirmCompleted) {
            return TaxPanel(state: state);
          }

          return SizedBox();
        },
      ),
      body: BlocBuilder<ReceiptConfirmCubit, ReceiptConfirmState>(
        builder: (context, state) {
          if (state is ReceiptConfirmCompleted) {
            return Column(
              children: [
                Expanded(
                  child: AnimatedList(
                    key: context.read<ReceiptConfirmCubit>().listKey,
                    initialItemCount: state.groupedProduct.length,
                    padding: EdgeInsets.only(
                      bottom: 0.36.sh,
                    ).r,
                    itemBuilder: (
                      BuildContext context,
                      int index,
                      Animation<double> animation,
                    ) {
                      return context
                          .read<ReceiptConfirmCubit>()
                          .buildReceiptCard(
                            state.groupedProduct[index],
                            state,
                            index,
                            animation,
                          );
                    },
                  ),
                ),
                TaxPanel(state: state),
              ],
            );
          }

          return SizedBox();
        },
      ),
    );
  }
}
