import 'package:vocablix/providers/box_collection_model.dart';
import 'package:vocablix/providers/language_model.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateBoxPage extends StatelessWidget {
  const CreateBoxPage();

  @override
  Widget build(BuildContext context) {
    final boxCollectionModel =
        Provider.of<BoxCollectionModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Box"),
        centerTitle: true,
      ),
      body: CreateBoxForm(boxCollectionModel.checkIfBoxAlreadyExists,
          boxCollectionModel.addBoxScaffoldToBoxCollection),
    );
  }
}

class CreateBoxForm extends StatefulWidget {
  final Function(String name) checkIfBoxAlreadyExistsCallback;
  final Function(String boxName, String from, String to) createBoxCallback;

  const CreateBoxForm(
      this.checkIfBoxAlreadyExistsCallback, this.createBoxCallback);

  @override
  _CreateBoxFormState createState() => _CreateBoxFormState();
}

class _CreateBoxFormState extends State<CreateBoxForm> {
  final titleController = TextEditingController();
  final fromController = TextEditingController();
  final toController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  FocusNode _focusNameInput = FocusNode();
  bool _isNameInputSelected = false;

  @override
  void initState() {
    this._focusNameInput.addListener(() {
      this._onFocusChangeNameInput();
    });
    super.initState();
  }

  void createBox() {
    this.widget.createBoxCallback(this.titleController.text,
        this.fromController.text, this.toController.text);
    Navigator.pop(context);
  }

  void _onFocusChangeNameInput() {
    setState(() {
      this._isNameInputSelected
          ? this._isNameInputSelected = false
          : this._isNameInputSelected = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(30, 30, 30, 50),
      child: Container(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 45, 0),
                child: TextFormField(
                  controller: this.titleController,
                  focusNode: this._focusNameInput,
                  autofocus: true,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.all_inbox,
                      color: this._isNameInputSelected == true
                          ? Color(0xFFB81d4fa)
                          : Colors.white70,
                    ),
                    hintText: 'Box-Name',
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFB81d4fa),
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a Box-Name';
                    }
                    if (this.widget.checkIfBoxAlreadyExistsCallback(value)) {
                      return 'A box with this name already exists';
                    }
                    return null;
                  },
                ),
              ),
              Row(
                children: <Widget>[
                  Flexible(
                    child: TextFormField(
                      controller: this.fromController,
                      readOnly: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please select a language';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        icon: Icon(Icons.language, color: Colors.white70),
                        hintText: "Translate from",
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white38,
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.add_box,
                      size: 30,
                    ),
                    onPressed: () => this.selectLanguage(true),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Flexible(
                    child: TextFormField(
                      controller: this.toController,
                      readOnly: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please select a language';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        icon: Icon(Icons.language, color: Colors.white70),
                        hintText: "Translate to",
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white38,
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.add_box,
                      size: 30,
                    ),
                    onPressed: () => this.selectLanguage(false),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      this.createBox();
                    }
                  },
                  child: Text("Create"),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xFFBffd265)),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> selectLanguage(bool isFromTextField) async {
    int? selected = await showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Select a language'),
            children: getOption(),
          );
        });
    setState(() {
      if (selected == null) {
        return;
      }
      if (isFromTextField) {
        this.fromController.text = Languages[selected];
      } else {
        this.toController.text = Languages[selected];
      }
    });
  }

  List<Widget> getOption() {
    List<Widget> options = [];
    for (int i = 0; i < Languages.length; i++) {
      options.add(
        SimpleDialogOption(
          onPressed: () {
            Navigator.pop(context, i);
          },
          child: Row(
            children: [
              // Flag(
              //   Flags[i],
              //   fit: BoxFit.contain,
              //   height: 30,
              //   width: 30,
              // ),
              Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(Languages[i]),
              )
            ],
          ),
        ),
      );
    }
    return options;
  }
}
