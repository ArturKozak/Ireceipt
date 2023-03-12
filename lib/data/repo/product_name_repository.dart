import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ensure_initialized/ensure_initialized.dart';
import 'package:ireceipt/data/models/product_name_model.dart/product_name_model.dart';
import 'package:ireceipt/data/models/receipt_product_model.dart/receipt_product_model.dart';
import 'package:ireceipt/util/app_constants.dart';

class ProductNameRepository with EnsureInitializedMixin {
  late final productList = <ProductNameModel>[];

  final _collection = FirebaseFirestore.instance
      .collection(AppConstants.productNameCollection)
      .withConverter<ProductNameModel>(
        fromFirestore: (snapshot, options) =>
            ProductNameModel.fromJson(snapshot.data()!),
        toFirestore: (value, _) => value.toJson(),
      );

  Future<void> addClearName(List<ReceiptProductModel> list) async {
    for (final element in list) {
      final name = element.name;

      final models = productList.where((element) => element.name == name);

      if (models.isNotEmpty) {
        continue;
      }

      await _collection.add(ProductNameModel(name: name));
    }
  }

  Future<List<ProductNameModel>> getAll() async {
    final list = <ProductNameModel>[];
    final snapshot = await _collection.get();

    if (snapshot.docs.isEmpty) {
      return <ProductNameModel>[];
    }

    for (final doc in snapshot.docs) {
      final model = doc.data();

      list.add(model);
    }

    productList.addAll(list);

    initializedSuccessfully();

    return list;
  }
}
