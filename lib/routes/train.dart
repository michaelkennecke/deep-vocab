import 'package:vocablix/providers/box_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flip_card/flip_card.dart';

class TrainPage extends StatelessWidget {
  const TrainPage();

  @override
  Widget build(BuildContext context) {
    final boxModel = Provider.of<BoxModel>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: Text("Training"),
        centerTitle: true,
      ),
      body: TrainCards(boxModel),
    );
  }
}

class TrainCards extends StatefulWidget {
  final BoxModel boxModel;

  TrainCards(this.boxModel);

  @override
  _TrainCardsState createState() => _TrainCardsState();
}

class _TrainCardsState extends State<TrainCards> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "${widget.boxModel.index + 1}/ ${widget.boxModel.box.length}",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
          ),
          TranslationFlipCardWidget(
              widget.boxModel.getTranslationAtCurrentIndex().word,
              widget.boxModel.getTranslationAtCurrentIndex().wordTranslated),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                iconSize: 50,
                onPressed: () => widget.boxModel.getPreviousTranslation(),
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward),
                iconSize: 50,
                onPressed: () => widget.boxModel.getNextTranslation(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// The (flip)-Card is created in a seperaded Widget to make code more readable
class TranslationFlipCardWidget extends StatelessWidget {
  final word;
  final wordTranslated;

  TranslationFlipCardWidget(this.word, this.wordTranslated);

  @override
  Widget build(BuildContext context) {
    return FlipCard(
      direction: FlipDirection.HORIZONTAL,
      front: Container(
        height: 180,
        width: 250,
        child: Center(
          child: Text(
            word,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        // 0xFFB81d4fa
        color: const Color(0xFFBffd265),
      ),
      back: Container(
        height: 180,
        width: 250,
        child: Center(
          child: Text(
            wordTranslated,
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black87),
            textAlign: TextAlign.center,
          ),
        ),
        // 0xFFB4ba3c7
        color: const Color(0xFFB81d4fa),
      ),
    );
  }
}
