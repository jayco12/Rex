import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:rex/screens/cart_screen/models/Gaz.dart';

late Box<Gaz> gazBox;
late Box<String?>? locationBox;

class HiveHelper {
  saveLocation(String location) {
     locationBox!.put('location', location);
  }
  deleteInfo(int index) {
    gazBox.deleteAt(index);
    if (kDebugMode) {
      print('Item deleted from box at index:$index');
    }
  }

  List<Gaz> getDataList() {
    final dataList = gazBox.values.toList();
    return dataList;
  }

  deleteAll() {
    gazBox.clear();
  }

  totalItems() {
    var data = getDataList();
    if (data.isEmpty) {
      return 0;
    }
    var total = (data.fold<int?>(data.first.price,
        (previousValue, element) => previousValue! + element.price));
    return (total);
  }
}
