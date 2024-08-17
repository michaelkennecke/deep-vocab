import 'dart:convert';

import 'package:vocablix/models/box_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BoxCollectionModel with ChangeNotifier {
  static const BOX_COLLECTION_NAME = "BoxCollection";
  static const DEFAULT_BOX_NAME = "DefaultBox";
  static const DEFAULT_BOX_TRANSLATE_FROM_LANGUAGE = "English";
  static const DEFAULT_BOX_TRANSLATE_TO_LANGUAGE = "German";

  late SharedPreferences sharedPreferences;
  List<BoxScaffold> boxCollection = [];
  late int currentIndex;
  late String selectedBoxName;

  void setFillGradeAt(index, fillGrade) {
    if (this.boxCollection != null) {
      boxCollection[index].fillGrade = fillGrade;
      saveData();
      notifyListeners();
    }
  }

  bool checkIfBoxAlreadyExists(String name) {
    for (var box in boxCollection) {
      if (box.boxName == name) {
        return true;
      }
    }
    return false;
  }

  void addBoxScaffoldToBoxCollection(String boxName, String from, String to,
      [int fillGrade = 0]) {
    boxCollection.add(BoxScaffold(boxName, from, to, fillGrade));
    saveData();
    notifyListeners();
  }

  void removeBoxScaffold(int deletionIndex) {
    if (boxCollection[deletionIndex].boxName == selectedBoxName) {
      selectedBoxName = DEFAULT_BOX_NAME;
    }
    if (deletionIndex == currentIndex) {
      currentIndex = 0;
    }
    boxCollection.removeAt(deletionIndex);
    saveData();
    notifyListeners();
  }

  void changeSelectedBox(String name, int index) {
    currentIndex = index;
    selectedBoxName = name;
    saveData();
    notifyListeners();
  }

  void loadSharedPreferencesAndData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    loadData();
    notifyListeners();
  }

  void loadData() async {
    var tmpSelected = sharedPreferences.getString("selected");
    var tmpCurrentIndex = sharedPreferences.getInt("currentIndex");
    if (tmpSelected == null || tmpSelected == " ") {
      selectedBoxName = DEFAULT_BOX_NAME;
      currentIndex = 0;
    } else {
      selectedBoxName = tmpSelected;
      currentIndex = tmpCurrentIndex!;
    }
    List<String>? listString =
        sharedPreferences.getStringList(BOX_COLLECTION_NAME);
    if (listString != null) {
      var tmpBoxCollection = listString
          .map((item) => BoxScaffold.fromMap(json.decode(item)))
          .toList();
      boxCollection = tmpBoxCollection;
    }
    if (boxCollection.isEmpty || this.boxCollection.length == 0) {
      this.addBoxScaffoldToBoxCollection(
          DEFAULT_BOX_NAME,
          DEFAULT_BOX_TRANSLATE_FROM_LANGUAGE,
          DEFAULT_BOX_TRANSLATE_TO_LANGUAGE,
          0);
    }
  }

  void saveData() {
    sharedPreferences.setString("selected", selectedBoxName);
    sharedPreferences.setInt("currentIndex", currentIndex);
    List<String> stringList =
        this.boxCollection.map((item) => json.encode(item.toMap())).toList();
    sharedPreferences.setStringList(BOX_COLLECTION_NAME, stringList);
  }
}
