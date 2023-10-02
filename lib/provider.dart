import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';

import 'constants/constants.dart';

//Provider file

class CounterProvider extends ChangeNotifier {
  int _counter = 0;

  int get value => _counter;

  void update(int val) async {
    _counter = val;
    final store = GetStorage();
    await store.write(Constants.COUNTER_VALUE, val.toString());
    notifyListeners();
  }

  void initialize() {
    final store = GetStorage();
    String val = store.read(Constants.COUNTER_VALUE);
    _counter = int.parse(val);
    notifyListeners();
  }

  void increase() {
    update(_counter + 1);
  }

  void decrease() {
    update(_counter - 1);
  }

  void reset() {
    update(0);
  }
}
