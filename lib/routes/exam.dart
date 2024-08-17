import 'package:vocablix/models/translation.dart';
import 'package:vocablix/providers/box_model.dart';
import 'package:vocablix/providers/exam_box_model.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class ExamPage extends StatelessWidget {
  const ExamPage();

  @override
  Widget build(BuildContext context) {
    final boxModel = Provider.of<BoxModel>(context, listen: false);
    final examBoxModel = Provider.of<ExamBoxModel>(context, listen: true);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: ExitExam(examBoxModel.reset),
        title: Text("Vocabulary Test"),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          ExamBody(examBoxModel, boxModel.box),
        ],
      ),
    );
  }
}

class ExitExam extends StatefulWidget {
  final Function resetExamCallback;

  ExitExam(this.resetExamCallback);

  @override
  _ExitExamState createState() => _ExitExamState();
}

class _ExitExamState extends State<ExitExam> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {
        _showAlertDialog();
      },
    );
  }

  void _showAlertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('End test'),
          content: Text(
              'Do you really want to stop the test? The progress of the test will not be saved.'),
          actions: <Widget>[
            TextButton(
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: Color(0xFFB81d4fa),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            TextButton(
              child: const Text(
                'End',
                style: TextStyle(
                  color: Colors.redAccent,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                this.widget.resetExamCallback();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}

class ExamBody extends StatefulWidget {
  final ExamBoxModel examBoxModel;
  final List<Translation> standardBox;

  const ExamBody(this.examBoxModel, this.standardBox);

  @override
  _ExamBodyState createState() => _ExamBodyState();
}

class _ExamBodyState extends State<ExamBody> {
  final answerController = TextEditingController();
  var answerTextFieldFocusNode = FocusNode();
  var userAnswer = "";
  var percentageOfExamCompletion = 0.0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      percentageOfExamCompletion =
          widget.examBoxModel.getPercentageOfExamCompletion();
      widget.examBoxModel.shuffleBox();
    });
  }

  Widget? getAnswerWidget(int answerStatus, String correctAnswer) {
    switch (answerStatus) {
      case 0:
        {
          return NoAnswerWidget();
        }
        break;

      case 1:
        {
          return CorecctAnswerWidget();
        }
        break;

      case -1:
        {
          return WrongAnswerWidget(correctAnswer);
        }
        break;
      default:
        {
          return null;
        }
    }
  }

  void answer(value) {
    setState(() {
      this.userAnswer = value;
      if (widget.examBoxModel.checkAnswer(value)) {
        widget.examBoxModel.answerStatus = 1;
      } else {
        widget.examBoxModel.answerStatus = -1;
      }
    });
    percentageOfExamCompletion =
        widget.examBoxModel.getPercentageOfExamCompletionAfterAnswering();
    showNextQuestionDelayed();
  }

  Future showNextQuestionDelayed() {
    return new Future.delayed(
        const Duration(seconds: 3),
        () => {
              widget.examBoxModel.answerStatus = 0,
              if (widget.examBoxModel.isLastTraslationOfBox())
                {
                  widget.examBoxModel.reset(),
                  Navigator.pop(context),
                }
              else
                {
                  widget.examBoxModel.getNextTranslation(),
                },
              this.answerController.clear(),
              answerTextFieldFocusNode.requestFocus(),
            });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(20, 40, 5, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                LinearPercentIndicator(
                  width: 250.0,
                  lineHeight: 35.0,
                  percent: this.percentageOfExamCompletion,
                  center: Text(
                      "${(percentageOfExamCompletion * 100).toStringAsFixed(0)} %"),
                  backgroundColor: Colors.grey,
                  progressColor: const Color(0xFFB81d4fa),
                  alignment: MainAxisAlignment.center,
                ),
                IconButton(
                  icon: Icon(Icons.replay),
                  iconSize: 35,
                  onPressed: () => {
                    widget.examBoxModel.reset(),
                    percentageOfExamCompletion = 0.0,
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(
              widget.examBoxModel.getTranslationAtCurrentIndex().word,
              style: TextStyle(fontSize: 32),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: getAnswerWidget(
                widget.examBoxModel.answerStatus,
                widget.examBoxModel
                    .getTranslationAtCurrentIndex()
                    .wordTranslated),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(100, 30, 100, 0),
            child: TextField(
              focusNode: answerTextFieldFocusNode,
              autofocus: true,
              controller: this.answerController,
              onSubmitted: (value) => {
                this.answer(value),
              },
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.question_answer,
                  color: const Color(0xFFBffd265),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: const Color(0xFFBffd265),
                  ),
                ),
                hintText: "Enter your answer",
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NoAnswerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
      child: Visibility(
        visible: false,
        maintainSize: true,
        maintainAnimation: true,
        maintainState: true,
        child: Icon(
          Icons.check,
          size: 50,
        ),
      ),
    );
  }
}

class CorecctAnswerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
      child: Column(
        children: <Widget>[
          Icon(
            Icons.check,
            size: 50,
            color: Colors.green,
          ),
          Text("Correct!"),
        ],
      ),
    );
  }
}

class WrongAnswerWidget extends StatelessWidget {
  final correctAnswer;

  const WrongAnswerWidget(this.correctAnswer);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
      child: Column(
        children: <Widget>[
          Icon(
            Icons.clear,
            size: 50,
            color: Colors.red,
          ),
          Text(
            "Correct Answer: $correctAnswer",
          ),
        ],
      ),
    );
  }
}
