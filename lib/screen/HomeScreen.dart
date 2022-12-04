import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mindsparkstudent/Widgets/CustomNavigationDrawer.dart';
import 'package:mindsparkstudent/screen/Login.dart';

import 'QuestionScreen.dart';

void main() {
  runApp(const HomeScreen());
}


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});




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
      home: const MyHomePage(title: 'Dashboard Screen',),
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final GlobalKey<ScaffoldState> scafoldKey = new GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scafoldKey,
      drawer: CustomNavigationDrawer(scafoldKey: scafoldKey),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             Container(
                 height: 150,
                 width: double.infinity,
                 decoration: BoxDecoration(
                   image: DecorationImage(
                     alignment: Alignment.topCenter,
                     image: AssetImage("assets/images/header.png"),
                   ),
                 ),
               child: Center(
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     InkWell(
                       onTap: (){
                         scafoldKey.currentState?.openDrawer();
                         print('hello menu ');
                       },
                       child: Container(
                         height: 40,
                           width: 40,
                         margin: EdgeInsets.only(left: 20,top: 10),
                         decoration: BoxDecoration(
                           image: DecorationImage(
                             image: AssetImage("assets/images/menu.png"),
                           ),
                         ),
                       ),
                     ),
                     Container(
                         width: 150,
                         margin: EdgeInsets.only(top: 10),
                         child: SvgPicture.asset('assets/images/logo.svg'),
                       ),

                     SizedBox(
                       width: 50,
                     )
                   ],
                 ),
               ),
             ),
            InkWell(
                child: Container(
                    width:200,
                    height: 100,
                    margin: EdgeInsets.only(top: 30),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image:AssetImage("assets/images/btn.png"),
                            fit:BoxFit.fill
                        )),
                  child: Center(child: Text("Topics",style: TextStyle(color: Color.fromRGBO(128, 0, 0,3),fontSize: 25,),)),
                ),onTap:(){
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder:
                              (context) =>
                                  QuestionScreen()));
                      //print("you clicked me");
                 }),
             Container(
                  child: Expanded(
                    child: Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: Container(
                          child: Image.asset('assets/images/footer.png'),
                      )
                    ),
                  ),
             )
          ],
        )
      ),
    );
  }
}
