import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vocablix/providers/box_collection_model.dart';

import '../models/translation.dart';

abstract class AbstractBoxModel with ChangeNotifier {
  late String boxId;
  late String from;
  late String to;
  late int fillGrade;
  List<Translation> box = [];
  int index = 0;
  late SharedPreferences sharedPreferences;

  void setBoxScaffoldParameters(
      String boxId, String from, String to, int fillGrade) {
    this.boxId = boxId;
    this.from = from;
    this.to = to;
    this.fillGrade = fillGrade;
    saveBoxScaffoldParameters();
    loadData();
    notifyListeners();
  }

  void addTranslation(String word, String wordTranslated) {
    box.add(Translation(word, wordTranslated));
    this.fillGrade += 1;
    saveData();
    notifyListeners();
  }

  void removeTranslation(int deletionIndex) {
    this.index = 0;
    this.fillGrade -= 1;
    if (fillGrade < 0) {
      this.fillGrade = 0;
    }
    box.removeAt(deletionIndex);
    saveData();
    notifyListeners();
  }

  Translation getTranslationAtCurrentIndex() {
    if (box.isNotEmpty) {
      return box.elementAt(index);
    } else {
      index = 0;
      return Translation("-", "-");
    }
  }

  Translation getNextTranslation() {
    if (index >= box.length - 1) {
      index = 0;
    } else {
      index++;
    }
    notifyListeners();
    return getTranslationAtCurrentIndex();
  }

  Translation getPreviousTranslation() {
    if (index <= 0) {
      index = box.length - 1;
    } else {
      index--;
    }
    notifyListeners();
    return getTranslationAtCurrentIndex();
  }

  void reset() {
    index = 0;
    notifyListeners();
  }

  void loadSharedPreferencesAndData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    loadData();
    notifyListeners();
  }

  void loadBoxScaffoldParameters() {
    var tmpSelectedBoxId = sharedPreferences.getString("selectedBoxId");
    var tmpFrom = sharedPreferences.getString("from");
    var tmpTo = sharedPreferences.getString("to");
    var tmpFillGrade = sharedPreferences.getInt("fillGrade");
    if (tmpSelectedBoxId == null && boxId == null) {
      this.boxId = BoxCollectionModel.DEFAULT_BOX_NAME;
      this.from = BoxCollectionModel.DEFAULT_BOX_TRANSLATE_FROM_LANGUAGE;
      this.to = BoxCollectionModel.DEFAULT_BOX_TRANSLATE_TO_LANGUAGE;
      this.fillGrade = 0;
    } else {
      this.boxId = tmpSelectedBoxId!;
      this.from = tmpFrom!;
      this.to = tmpTo!;
      this.fillGrade = tmpFillGrade!;
    }
  }

  void loadBox() {
    List<String>? boxStringList = sharedPreferences.getStringList(this.boxId);
    if (boxStringList != null) {
      var tmpBox = boxStringList
          .map((item) => Translation.fromMap(json.decode(item)))
          .toList();
      box = tmpBox;
    } else {
      this.box = [];
    }
  }

  void loadData() async {
    loadBoxScaffoldParameters();
    loadBox();
  }

  void saveBoxScaffoldParameters() {
    sharedPreferences.setString("selectedBoxId", boxId);
    sharedPreferences.setString("from", from);
    sharedPreferences.setString("to", to);
    sharedPreferences.setInt("fillGrade", fillGrade);
  }

  void saveBox() {
    List<String> boxStringList =
        this.box.map((item) => json.encode(item.toMap())).toList();
    sharedPreferences.setStringList(this.boxId, boxStringList);
  }

  void saveData() {
    saveBoxScaffoldParameters();
    saveBox();
  }

  void deleteBox(String deleteBoxId, String deleteFrom, String deleteTo,
      int deleteFillGrade) {
    final previousBoxId = this.boxId;
    final previousFrom = this.from;
    final previousTo = this.to;
    final previousFillGrade = this.fillGrade;
    this.setBoxScaffoldParameters(
        deleteBoxId, deleteFrom, deleteTo, deleteFillGrade);
    this.box = [];
    this.fillGrade = 0;
    this.saveData();
    this.setBoxScaffoldParameters(
        previousBoxId, previousFrom, previousTo, previousFillGrade);
  }
}
