import 'package:flutter/material.dart';
import 'package:flutter_speechtotext/simple_permission.dart';
import 'package:flutter_speechtotext/speech_recognition.dart';
import 'package:flutter_speechtotext/speech_to_text.dart';
import 'package:flutter_speechtotext/text_to_speech.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home:Tabs() ,
    );
  }






}

class Tabs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Assistance'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            RaisedButton(
              child: Text('Simple Permission'),
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> SimplePermissionTab()));
              },
            ),
            RaisedButton(
              child: Text('Speech Recognition Package'),
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> SpeechRecognitionTab()));
              },
            ),
            RaisedButton(
              child: Text('Speech To Text'),
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> SpeechToTextTab()));
              },
            ),
            RaisedButton(
              child: Text('Text To Speech'),
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> TextToSpeechTab()));
              },
            ),
          ],
        )
    );
  }
}
