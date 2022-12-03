import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mindsparkstudent/screen/HomeScreen.dart';
import 'package:mindsparkstudent/screen/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Utils/AppConstant.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'HomePage sdff ',),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  bool isLoginState = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkforAlreadyLogin();
  }


  void checkforAlreadyLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Object? isLogin = sharedPreferences.get(AppConstant.isLogin);
    if(isLogin != null && isLogin==true){
        renderToHomePageMethod();
    }else {
      renderToLoginMethod();
    }
  }

  renderToLoginMethod() async {
    await Future.delayed(Duration(microseconds: 3000),(){});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
    Timer(Duration(seconds: 5),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context)  => HomePage()
            )
        )
    );
  }


  renderToHomePageMethod() async {
    await Future.delayed(Duration(microseconds: 3000),(){});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
    Timer(Duration(seconds: 5),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context)  =>  HomeScreen()
            )
        )
    );
  }

  @override
  Widget build(BuildContext context) {

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                height: 200,
                width: 200,
                child: Center(
                  child:SvgPicture.asset('assets/images/logo.svg'),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text("© 2009-2020, Educational Initiatives Pvt. Ltd.",style: TextStyle(color: Colors.black12),),
            )
          ],
        ),
      ),
    );
  }
}
