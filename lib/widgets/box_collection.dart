import 'package:vocablix/models/box_scaffold.dart';
import 'package:vocablix/providers/box_collection_model.dart';
import 'package:vocablix/providers/box_model.dart';
import 'package:vocablix/providers/exam_box_model.dart';
import 'package:flutter/material.dart';

class BoxCollectionWidget extends StatefulWidget {
  final BoxCollectionModel boxCollectionModel;
  final BoxModel boxModel;
  final ExamBoxModel examBoxModel;

  const BoxCollectionWidget(
      this.boxCollectionModel, this.boxModel, this.examBoxModel);

  @override
  _BoxCollectionWidgetState createState() => _BoxCollectionWidgetState();
}

class _BoxCollectionWidgetState extends State<BoxCollectionWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        widget.boxCollectionModel.setFillGradeAt(
            widget.boxCollectionModel.currentIndex, widget.boxModel.fillGrade);
      });
    });
  }

  void changeSelectedBox(String name, int index) {
    widget.boxCollectionModel.changeSelectedBox(name, index);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            itemCount: this.widget.boxCollectionModel.boxCollection.length,
            itemBuilder: (BuildContext context, int index) {
              var boxScaffold =
                  this.widget.boxCollectionModel.boxCollection[index];
              return Container(child: buildListItem(boxScaffold, index));
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          ),
        ),
      ],
    );
  }

  Widget buildListItem(BoxScaffold boxScaffold, int index) {
    return Dismissible(
      direction:
          (index != 0) ? DismissDirection.endToStart : DismissDirection.none,
      background: Container(
        padding: EdgeInsets.only(right: 20.0),
        alignment: Alignment.centerRight,
        color: Colors.redAccent,
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      key: ObjectKey(boxScaffold),
      onDismissed: (direction) {
        widget.boxCollectionModel.removeBoxScaffold(index);
        widget.boxModel.deleteBox(boxScaffold.boxName, boxScaffold.from,
            boxScaffold.to, boxScaffold.fillGrade);
        widget.examBoxModel.deleteBox(boxScaffold.boxName, boxScaffold.from,
            boxScaffold.to, boxScaffold.fillGrade);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Row(
              children: [
                CircleAvatar(
                  child: Icon(Icons.all_inbox, size: 22, color: Colors.black87),
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: buildBoxDescription(boxScaffold)),
              ],
            ),
          ),
          IconButton(
            icon: (boxScaffold.boxName ==
                    widget.boxCollectionModel.selectedBoxName)
                ? Icon(Icons.radio_button_checked, color: Colors.lightGreen)
                : Icon(Icons.radio_button_off, color: Colors.white),
            onPressed: () =>
                {this.changeSelectedBox(boxScaffold.boxName, index)},
          ),
        ],
      ),
    );
  }

  Widget buildBoxDescription(BoxScaffold boxScaffold) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "${boxScaffold.boxName}",
          style: TextStyle(fontSize: 16),
        ),
        Text(
          "${boxScaffold.fillGrade} | ${boxScaffold.from} - ${boxScaffold.to}",
          style: TextStyle(
            color: Colors.white70,
          ),
        ),
      ],
    );
  }
}
