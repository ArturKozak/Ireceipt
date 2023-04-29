import 'package:ireceipt/app/app_configuration.dart';
import 'package:ireceipt/app/ireceipt_launch.dart';

Future<void> main() async {
  await IReceiptLaunch.launch(ApplicationConfiguration.pl());
}
