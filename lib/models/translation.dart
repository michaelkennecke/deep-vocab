class Translation {
  late String word;
  late String wordTranslated;

  Translation(this.word, this.wordTranslated);

  Translation.fromMap(Map map) {
    this.word = map['word'];
    this.wordTranslated = map['wordTranslated'];
  }

  Map toMap() {
    return {
      'word': this.word,
      'wordTranslated': this.wordTranslated,
    };
  }
}
