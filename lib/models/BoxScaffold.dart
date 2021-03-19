import 'package:easy_vocab/models/translation.dart';

class BoxScaffold {
  String boxName;
  String from;
  String to;
  int fillGrade;

  List<Translation> box;

  BoxScaffold(this.boxName, this.from, this.to, [this.fillGrade = 0]);

  BoxScaffold.fromMap(Map map) {
    this.boxName = map['boxName'];
    this.from = map['from'];
    this.to = map['to'];
    this.fillGrade = map['fillGrade'];
  }

  Map toMap() {
    return {
      'boxName': this.boxName,
      'from': this.from,
      'to': this.to,
      'fillGrade': this.fillGrade,
    };
  }
}
