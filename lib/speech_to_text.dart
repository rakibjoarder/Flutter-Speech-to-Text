import 'package:flutter/material.dart';
import 'dart:async';

import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_recognition_error.dart';



class SpeechToTextTab extends StatefulWidget {
  @override
  _SpeechToTextTabState createState() => _SpeechToTextTabState();
}

class _SpeechToTextTabState extends State<SpeechToTextTab> {
  bool _hasSpeech = false;
  String lastWords = "";
  String lastError = "";
  String lastStatus = "";
  final SpeechToText speech = SpeechToText();

  @override
  void initState() {
    super.initState();
    initSpeechState();
  }

  Future<void> initSpeechState() async {
    bool hasSpeech = await speech.initialize(onError: errorListener, onStatus: statusListener );

    if (!mounted) return;
    setState(() {
      _hasSpeech = hasSpeech;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Speech to Text Example'),
        ),
        body: _hasSpeech
            ? Column(children: [
          Expanded(
            child: Center(
              child: Text('Speech recognition available'),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  child: Text('Start'),
                  onPressed: startListening,
                ),
                FlatButton(
                  child: Text('Stop'),
                  onPressed: stopListening,
                ),
                FlatButton(
                  child: Text('Cancel'),
                  onPressed:cancelListening,
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Center(
                  child: Text('Recognized Words'),
                ),
                Center(
                  child: Text(lastWords),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Center(
                  child: Text('Error'),
                ),
                Center(
                  child: Text(lastError),
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: speech.isListening ? Text("I'm listening...") : Text( 'Not listening' ),
            ),
          ),
        ])
            : Center( child: Text('Speech recognition unavailable', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold))),
      ),
    );
  }

  void startListening() {
    lastWords = "";
    lastError = "";
    speech.listen(onResult: resultListener );
    setState(() {

    });
  }

  void stopListening() {
    speech.stop( );
    setState(() {

    });
  }

  void cancelListening() {
    speech.cancel( );
    setState(() {

    });
  }

  void resultListener(SpeechRecognitionResult result) {
    setState(() {
      if(result.finalResult == true){
        lastWords = "${result.recognizedWords} - ${result.finalResult}";
      }
    });
  }

  void errorListener(SpeechRecognitionError error ) {
    setState(() {
      lastError = "${error.errorMsg} - ${error.permanent}";
    });
  }
  void statusListener(String status ) {
    setState(() {
      lastStatus = "$status";

    });
  }
}