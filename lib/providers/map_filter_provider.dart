import 'package:flutter/widgets.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class MapFilterProvider with ChangeNotifier {
  String? currentLandholder;
  int? currentLandholderId;

  String? currentFarm;
  int? currentFarmId;

  String? currentBlock;
  int? currentBlockId;

  String? currentField;
  int? currentFieldId;

  String? currentCrop;

  List<Line>? highlightLines;
  Fill? highlightFill;

  List<Line>? highlightLinesBlock;
  Fill? highlightFillBlock;

  List<Line>? highlightLinesField;
  Fill? highlightFillField;

  bool isFarmDropdownEnabled = false;
  bool isBlockDropdownEnabled = false;
  bool isFieldDropdownEnabled = false;
  bool isCropDropdownEnabled = false;

  void onLandholderSelected() {
    isFarmDropdownEnabled = true;
    isBlockDropdownEnabled = false;
    isFieldDropdownEnabled = false;
    isCropDropdownEnabled = false;

    currentFarm = null;
    currentFarmId = null;
    currentBlock = null;
    currentBlockId = null;
    currentField = null;
    currentFieldId = null;
    notifyListeners();
  }

  void enableFarmDropdown() {
    isFarmDropdownEnabled = true;
    notifyListeners();
  }

  void enableBlockDropdown() {
    isBlockDropdownEnabled = true;
    notifyListeners();
  }

  void enableFieldDropdown() {
    isFieldDropdownEnabled = true;
    notifyListeners();
  }

  void enableCropDropdown() {
    isCropDropdownEnabled = true;
    notifyListeners();
  }
}
