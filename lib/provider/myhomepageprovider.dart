import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:table/model/mydata.dart';

class MyHomePageProvider extends ChangeNotifier {
  MyData? data;

  Future getData(context) async {
    var response = await DefaultAssetBundle.of(context)
        .loadString('assets/raw/tabledata.json');

    var tabledata = jsonDecode(response);

    this.data = MyData.fromJson(tabledata);
    this.notifyListeners();
  }
}
