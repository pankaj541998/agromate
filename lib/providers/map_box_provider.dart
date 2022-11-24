import 'package:flutter/foundation.dart';

class MapBoxProvider with ChangeNotifier {
  bool isUndoBtnEnabled = false;
  bool isClearPlotBtnEnabled = false;

  void enableUndoBtn() {
    isUndoBtnEnabled = true;
    notifyListeners();
  }

  void diasbleUndoBtn() {
    isUndoBtnEnabled = false;
    notifyListeners();
  }

  void enableClearPlotBtn() {
    isClearPlotBtnEnabled = true;
    notifyListeners();
  }

  void diasbleClearPlotBtn() {
    isClearPlotBtnEnabled = false;
    notifyListeners();
  }
}
