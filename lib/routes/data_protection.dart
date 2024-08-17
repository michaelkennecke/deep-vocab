import 'package:flutter/material.dart';

class DataProtectionPage extends StatelessWidget {
  const DataProtectionPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data protection'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(25),
        child: ListView(
          children: <Widget>[
            Text(
              'Collection of personla data',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                'Whenever you contact us via e-mail, the data transmitted by you will be stored by us in order to answer your questions and to be able to respond to your suggestions for improvement. We delete the data accruing in this context after the saving is no longer necessary or restrict the processing if there are legal retention periods. If you wish to have your e-mails deleted, please contact: mkennecke@icloud.com',
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                'Data usage of the app',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                'All boxes you create are stored locally on your device. This also applies to any vocabulary you save in a box. There is no saving outside of your device. The translation of vocabulary is done with help of the Google Translator API. For this purpose, your input is sent to the Google server.',
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                'License',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text('MIT License'),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5),
              child: Text('Copyright (c) 2021 Michael Kennecke'),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5),
              child: Text(
                  'Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:'),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5),
              child: Text(
                  'The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.'),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5),
              child: Text(
                  'THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.'),
            ),
          ],
        ),
      ),
    );
  }
}
