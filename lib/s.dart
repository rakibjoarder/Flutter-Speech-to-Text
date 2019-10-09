//import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
//import 'package:simple_permissions/simple_permissions.dart';
//
//void main() => runApp(new MyApp());
//
//class MyApp extends StatefulWidget {
//  @override
//  _MyAppState createState() => new _MyAppState();
//}
//
//class _MyAppState extends State<MyApp> {
//  String _platformVersion = 'Unknown';
//  Permission permission = Permission.RecordAudio;
//
//  @override
//  initState() {
//    super.initState();
//  }
//
//
//
//  @override
//  Widget build(BuildContext context) {
//    return new MaterialApp(
//      home: new Scaffold(
//        appBar: new AppBar(
//          title: new Text('Plugin example app'),
//        ),
//        body: new Center(
//          child: new Column(children: <Widget>[
//            new RaisedButton(
//                onPressed: checkPermission,
//                child: new Text("Check permission")),
//            new RaisedButton(
//                onPressed: requestPermission,
//                child: new Text("Request permission")),
//            new RaisedButton(
//                onPressed: getPermissionStatus,
//                child: new Text("Get permission status")),
//            new RaisedButton(
//                onPressed: SimplePermissions.openSettings,
//                child: new Text("Open settings"))
//          ]),
//        ),
//      ),
//    );
//  }
//
//  requestPermission() async {
//    final res = await SimplePermissions.requestPermission(permission);
//    print("permission request result is " + res.toString());
//  }
//
// Future<bool> checkPermission() async {
//    bool res = await SimplePermissions.checkPermission(permission);
//    print("permission is " + res.toString());
//    return res ;
//  }
//
//  getPermissionStatus() async {
//    final res = await SimplePermissions.getPermissionStatus(permission);
//    print("permission status is " + res.toString());
//  }
//
//
//
//}