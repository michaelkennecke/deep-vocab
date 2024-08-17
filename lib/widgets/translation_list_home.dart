import 'package:vocablix/providers/box_collection_model.dart';
import 'package:vocablix/providers/box_model.dart';
import 'package:vocablix/providers/exam_box_model.dart';
import 'package:flutter/material.dart';

class TranslationList extends StatefulWidget {
  final BoxModel boxModel;
  final ExamBoxModel examBoxModel;
  final BoxCollectionModel boxCollectionModel;

  // constructor
  TranslationList(this.boxModel, this.examBoxModel, this.boxCollectionModel);

  @override
  _TranslationListState createState() => _TranslationListState();
}

class _TranslationListState extends State<TranslationList>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    widget.boxModel.loadSharedPreferencesAndData();
    widget.examBoxModel.loadSharedPreferencesAndData();
    widget.boxCollectionModel.loadSharedPreferencesAndData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      itemCount: this.widget.boxModel.box.length,
      itemBuilder: (BuildContext context, int index) {
        var translation = this.widget.boxModel.box[index];
        return Dismissible(
          key: ObjectKey(translation),
          onDismissed: (direction) {
            widget.boxModel.removeTranslation(index);
            widget.examBoxModel.removeTranslation(index);
          },
          direction: DismissDirection.endToStart,
          background: Container(
            padding: EdgeInsets.only(right: 20.0),
            alignment: Alignment.centerRight,
            color: Colors.redAccent,
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
          child: Container(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        translation.word,
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        translation.wordTranslated,
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}
