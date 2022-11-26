import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const HomePage());
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});


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
      home: const MyHomePage(title: 'HomePage',),
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
class CommonStyle{
  static InputDecoration textFieldStyle({String labelTextStr="",String hintTextStr=""}) {return InputDecoration(
    contentPadding: EdgeInsets.all(12),
    labelText: labelTextStr,
    hintText:hintTextStr,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  );}
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

  @override
  Widget build(BuildContext context) {

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
                  width: 200,
                  child: SvgPicture.asset('assets/images/logo.svg'),
            ),
          ),
          Container(
             child: Text("Login",style: TextStyle(color: Colors.black,fontSize: 21),),
          ),
          Container(
            margin: EdgeInsets.only(left: 20,right: 20,top: 30),
            height: 50,
            child: TextField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: 'username',
                hintStyle: TextStyle(color: Colors.grey,),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(
                        color: Color.fromRGBO(213,229, 241, 1),
                        width: 1
                    )
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(
                      color: Color.fromRGBO(213,229, 241, 1),
                    width: 1
                  )
                )
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20,right: 20,top: 15),
            height: 50,
            child: TextField(
              textAlign: TextAlign.center,
              obscureText: true,
              decoration: InputDecoration(
                  hintText: 'password',
                  hintStyle: TextStyle(color: Colors.grey,),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(
                          color: Color.fromRGBO(213,229, 241, 1),
                          width: 1
                      )
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(
                          color: Color.fromRGBO(213,229, 241, 1),
                          width: 1
                      )
                  )
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20,right: 20,top: 15),
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color.fromRGBO(255,96, 0, 1),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Center(child: Text("Login",style: TextStyle(color: Colors.white,fontSize: 21),)),
          ),
          Container(
            margin: EdgeInsets.only(left: 20,right: 20,top: 15),
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color.fromRGBO(255,96, 0, 1),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Center(child: Text("Sign Up",style: TextStyle(color: Colors.white,fontSize: 21),)),
          )
        ],
      )
    );
  }
}