import 'package:camera/camera.dart';
import 'package:ireceipt/app/app_configuration.dart';
import 'package:ireceipt/app/base/configuration_base.dart';
import 'package:ireceipt/app/pl_configuration.dart';

class Valut {
  static late List<CameraDescription> cameras;
  static late ConfigurationBase configuration;

  static final _allConfiguration = <ApplicationVersion, ConfigurationBase>{
    ApplicationVersion.pl: PlCofiguration(),
  };

  static Future<void> init() async {
    cameras = await availableCameras();
  }

  static Future<void> getConfiguration(
    ApplicationVersion applicationVersion,
  ) async {
    configuration = _allConfiguration[applicationVersion]!;
  }
}
