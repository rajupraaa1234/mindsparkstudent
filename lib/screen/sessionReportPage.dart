import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mindsparkstudent/screen/Login.dart';

import '../Utils/Util.dart';

// void main() {
//   runApp(const SessionReportPage());
// }

class SessionReportPage extends StatelessWidget {
  const SessionReportPage({super.key,required this.topicname});
  final String topicname;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return ReportPage(title: 'HomePage sdff ', topicname : topicname );
  }
}

class ReportPage extends StatefulWidget {
  const ReportPage({super.key, required this.title, required String this.topicname});
  final String topicname;

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<ReportPage> createState() => _ReportPageState(topicname);
}

class _ReportPageState extends State<ReportPage> {
  final String topicname;
  _ReportPageState(String this.topicname);


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async{
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
                            showDialog(context: context, builder: (BuildContext context) => Util.getCustomDialog(context,topicname),barrierDismissible: false);
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 20,top: 10),
                            child: Util.getCustomBtnBackground(40,40,Color.fromRGBO(245,101, 35, 2),"Done",8,15),
                          ),
                        ),
                        Container(
                          //width: 150,
                            margin: EdgeInsets.only(top: 12),
                            child: Text(topicname,style: TextStyle(color: Colors.black,fontSize: 22),)
                        ),
                        SizedBox(
                          width: 40,
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 30),
                    child: Text("you did 0 Questions",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Container(
                              child: Util.getCustomBtnBackground(50,50,Color.fromRGBO(0,200, 83, 2),"0",8,25),
                            ),
                            Container(
                              margin: EdgeInsets.only(top:8),
                              child: Text("right",style: TextStyle(color: Colors.white),),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 30),
                        child: Column(
                          children: [
                            Container(
                              child: Util.getCustomBtnBackground(50,50,Color.fromRGBO(252,60, 0, 2),"0",8,25),
                            ),
                            Container(
                              margin: EdgeInsets.only(top:8),
                              child: Text("wrong",style: TextStyle(color: Colors.white),),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 30),
                        child: Column(
                          children: [
                            Container(
                              child: Util.getCustomBtnBackground(50,50,Color.fromRGBO(0,0, 0, 1),"0",8,25),
                            ),
                            Container(
                              margin: EdgeInsets.only(top:8),
                              child: Text("skip",style: TextStyle(color: Colors.white),),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top:20),
                    child : Text("you did 0 Questions",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),)
                ),
                Center(
                  child: Container(
                      height: 60,
                      width: 60,
                      margin: EdgeInsets.only(top:30),
                      child: Center(
                        child: Wrap(
                            direction: Axis.vertical,
                          children: [
                            Container(
                              child: Center(child: Image.asset('assets/images/timetaken.png')),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 8),
                              child: Column(
                                children: [
                                  Container(
                                    child: const Text("Time Taken",style: TextStyle(color: Colors.white,fontSize: 20),),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 5),
                                    child: const Text("00:15",style: TextStyle(color: Colors.white,fontSize: 20),),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                  ),
                )
              ],
            )
        ),
      ),
    );
  }
}
