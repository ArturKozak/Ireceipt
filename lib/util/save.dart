import 'package:camera/camera.dart';
import 'package:ireceipt/data/models/receipt_product_model.dart/receipt_product_model.dart';

class Save {
  static late List<CameraDescription> cameras;
  static late List<ReceiptProductModel> receiptList;

  static Future<void> init() async {
    cameras = await availableCameras();
  }
}
