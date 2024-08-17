import 'dart:math';

import 'package:vocablix/providers/abstract_box_model.dart';

class ExamBoxModel extends AbstractBoxModel {
  var isBoxShuffled = false;
  var unshuffledBox;
  var answerStatus = 0;

  void shuffleBox() {
    if (!isBoxShuffled) {
      box.shuffle();
      Random random = new Random();
      for (var translation in box) {
        var changeOrder = random.nextBool();
        if (changeOrder) {
          var tmpWord = translation.word;
          translation.word = translation.wordTranslated;
          translation.wordTranslated = tmpWord;
        }
      }
      isBoxShuffled = true;
      notifyListeners();
    } else {
      return;
    }
  }

  @override
  void reset() {
    index = 0;
    isBoxShuffled = false;
    answerStatus = 0;
    notifyListeners();
  }

  double getPercentageOfExamCompletion() {
    double percentageOfExamCompletion = index / box.length;
    if (!percentageOfExamCompletion.isNaN) {
      return percentageOfExamCompletion;
    } else {
      return 0.0;
    }
  }

  double getPercentageOfExamCompletionAfterAnswering() {
    if (!(index + 1 >= box.length)) {
      double percentageOfExamCompletion = (index + 1) / box.length;
      if (!percentageOfExamCompletion.isNaN) {
        return percentageOfExamCompletion;
      } else {
        return 0.0;
      }
    } else {
      return 1.0;
    }
  }

  bool checkAnswer(String answer) {
    if (answer.toLowerCase() ==
        this.getTranslationAtCurrentIndex().wordTranslated.toLowerCase()) {
      return true;
    } else {
      return false;
    }
  }

  bool isLastTraslationOfBox() {
    if (index == box.length - 1) {
      return true;
    } else {
      return false;
    }
  }

  void printBox() {
    for (var translation in box) {
      print(
          "Word: ${translation.word} | Translation: ${translation.wordTranslated}");
    }
    print("");
  }
}
