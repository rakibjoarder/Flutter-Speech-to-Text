import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:simple_permissions/simple_permissions.dart';
import 'package:speech_recognition/speech_recognition.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: VoiceHome(),
    );
  }
}

class VoiceHome extends StatefulWidget {
  @override
  _VoiceHomeState createState() => _VoiceHomeState();
}

class _VoiceHomeState extends State<VoiceHome> {
  SpeechRecognition _speechRecognition;
  bool _isAvailable = false;
  bool _isListening = false;
  bool openMicrophoneContainer = false;
  String resultText = "";
  var animationType ="stop";
  @override
  void initState() {
    super.initState();

   initialize();
  }
   initialize() async{
     var checkPer = await checkPermission();
     if(checkPer){
       initSpeechRecognizer();
     }else{
       var res = await requestPermission();
       if (res == PermissionStatus.authorized) {
         initSpeechRecognizer();
       };
     }
   }
  Permission permission = Permission.RecordAudio;
  void initSpeechRecognizer() {
    _speechRecognition = SpeechRecognition();

    _speechRecognition.setAvailabilityHandler(
          (bool result) => setState(() => _isAvailable = true),
    );

    _speechRecognition.setRecognitionStartedHandler(
          () => setState((){
            _isListening = true;
            animationType = "record";
          }),
    );

    _speechRecognition.setRecognitionResultHandler(
          (String speech) => setState((){
            resultText = speech;
          }),
    );

    _speechRecognition.setRecognitionCompleteHandler(
          () => setState(() {
            _isListening = false;
            animationType = "stop";
          }),
    );

    _speechRecognition.activate().then(
          (result) => setState(() => _isAvailable = result),
    );
  }

    requestPermission() async {
    final res = await SimplePermissions.requestPermission(permission);
    print("permission request result is " + res.toString());
    return res;

    }

   checkPermission() async {
    bool res = await SimplePermissions.checkPermission(permission);
    print("permission is " + res.toString());
    return res ;
  }

  getPermissionStatus() async {
    final res = await SimplePermissions.getPermissionStatus(permission);
    print("permission status is " + res.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                      child: SizedBox( width:70,height:70 ,child: FlareActor("assets/mic.flr", alignment:Alignment.center, fit:BoxFit.contain, animation:animationType)), //stop record
                      onTap: _isListening == false ? () {
                        openMicrophoneContainer = true;
                        if (_isAvailable && !_isListening)
                          _speechRecognition
                              .listen(locale: "en_US")
                              .then((result) => print('$result')).catchError((onError){
                            print(onError);
                          });
                      } : () {
                        if (_isListening)
                          _speechRecognition.stop().then(
                                (result) => setState(() => _isListening = result),
                          );
                      },
                    ),

                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.cyanAccent[100],
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 12.0,
                  ),
                  child: Text(
                    resultText,
                    style: TextStyle(fontSize: 24.0),
                  ),
                )
              ],
            ),
            openMicrophoneContainer  ?  Stack(
              alignment: Alignment.topRight,
              children: <Widget>[
             Stack(
                  alignment: Alignment.topCenter,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      color : Colors.blueGrey,
                      child: Center(
                        child: InkWell(
                          child: SizedBox( width:110,height:110 ,child: FlareActor("assets/mic.flr", alignment:Alignment.center, fit:BoxFit.contain, animation:animationType)), //stop record
                          onTap: _isListening == false ? () {
                            openMicrophoneContainer = true;
                            if (_isAvailable && !_isListening)
                              _speechRecognition
                                  .listen(locale: "en_US")
                                  .then((result) => print('$result')).catchError((onError){
                                print(onError);
                              });
                          } : () {
                            if (_isListening)
                              _speechRecognition.stop().then(
                                    (result) => setState(() => _isListening = result),
                              );
                          },
                        ),
                      ),
                    ) ,

                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: _isListening ?  Text('Tap to pause',style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w600),) :
                     Text('Tap to play',style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w600),),
                   ),

                  ],
                ) ,
                IconButton(
                  icon: Icon(Icons.cancel),
                  color: Colors.white,
                  onPressed: () {
                    if (_isListening){
                      _speechRecognition.cancel().then(
                            (result) => setState(() {
                          _isListening = result;
                          resultText = "";
                          openMicrophoneContainer = false;
                        }),
                      );
                    }else{
                      setState(() {
                        openMicrophoneContainer = false;
                      });
                    }
                  },
                ),
              ],
            ): SizedBox()
          ],
        ),
      ),
    );
  }
}