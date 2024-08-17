import 'package:vocablix/providers/box_collection_model.dart';
import 'package:vocablix/providers/box_model.dart';
import 'package:vocablix/providers/exam_box_model.dart';
import 'package:vocablix/widgets/footer.dart';
import 'package:vocablix/widgets/translation_input_home.dart';
import 'package:vocablix/widgets/translation_list_home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocablix/routes.dart';

class HomePage extends StatefulWidget {
  const HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late BoxModel boxModel;
  late BoxCollectionModel boxCollectionModel;
  late ExamBoxModel examBoxModel;

  void refreshData() {
    boxModel.setBoxScaffoldParameters(
        boxCollectionModel.selectedBoxName,
        boxCollectionModel.boxCollection[boxCollectionModel.currentIndex].from,
        boxCollectionModel.boxCollection[boxCollectionModel.currentIndex].to,
        boxCollectionModel
            .boxCollection[boxCollectionModel.currentIndex].fillGrade);
    examBoxModel.setBoxScaffoldParameters(
        boxCollectionModel.selectedBoxName,
        boxCollectionModel.boxCollection[boxCollectionModel.currentIndex].from,
        boxCollectionModel.boxCollection[boxCollectionModel.currentIndex].to,
        boxCollectionModel
            .boxCollection[boxCollectionModel.currentIndex].fillGrade);
  }

  @override
  Widget build(BuildContext context) {
    //gives you the instance of the Provider which gives you access to the model object
    boxModel = Provider.of<BoxModel>(context, listen: true);
    examBoxModel = Provider.of<ExamBoxModel>(context, listen: true);
    boxCollectionModel = Provider.of<BoxCollectionModel>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: Text("Deep Vocab"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.all_inbox),
            onPressed: () => Navigator.of(context)
                ?.pushNamed(RouteGenerator.boxSelectionPage)
                ?.whenComplete(() => refreshData()),
            tooltip: "Boxes",
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () =>
                Navigator.of(context).pushNamed(RouteGenerator.settingsPage),
            tooltip: "Settings",
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          TranslationInputWidget(
              boxModel.addTranslation, examBoxModel.addTranslation, boxModel),
          Expanded(
            child: TranslationList(boxModel, examBoxModel, boxCollectionModel),
          ),
        ],
      ),
      bottomNavigationBar: Footer(),
    );
  }
}
