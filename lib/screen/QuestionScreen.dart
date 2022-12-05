import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mindsparkstudent/Utils/AppConstant.dart';
import 'package:mindsparkstudent/Utils/Util.dart';
import 'package:mindsparkstudent/screen/Login.dart';

class QuestionScreen extends StatelessWidget {
  // Declare a field that holds the Person data
  //final Person person;

  // In the constructor, require a Person
  QuestionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
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
                          print('hello menu ');
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 20,top: 10),
                          child: Util.getCustomBtnBackground(40,40,Color.fromRGBO(245,101, 35, 2),"Done",8,15),
                        ),
                      ),
                      Container(
                        //width: 150,
                        margin: EdgeInsets.only(top: 12),
                        child: Text("Shapes and Space",style: TextStyle(color: Colors.black,fontSize: 22),)
                      ),
                      SizedBox(
                        width: 40,
                      )
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
                  child: SizedBox(
                    height: height*0.7,
                    width: width*0.95,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: Container(
                        color: Colors.white,
                        child: Container(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 0,bottom: 20),
                                    child: Util.getCustomBtnBackgroundWithDiffRadius(40,40,Color.fromRGBO(58,137,252,1),"1",12,0,0,12,15),
                                  ),
                                  Spacer(),
                                  Container(
                                      height: 60,
                                    width: 60,
                                    child: Image.asset('assets/images/buddy_sad.png')
                                  )
                                ],
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                        InkWell(
                                          onTap: (){
                                            print("on question voice");
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: SizedBox(
                                                height: 45,
                                                  width: 45,
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.all(Radius.circular(12)),
                                                    child: Container(
                                                      color: Color.fromRGBO(245,101, 35, 2),
                                                      child: Padding(
                                                          padding: EdgeInsets.all(10),
                                                          child: Image.asset('assets/images/sound.png')
                                                      )
                                                    ),
                                                  )
                                              ),
                                            ),
                                          ),
                                        ),
                                      SizedBox(height: 10,),
                                      InkWell(
                                        onTap: (){
                                          print("on question decs");
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(left: 10),
                                          child: Align(
                                            alignment: Alignment.topLeft,
                                            child: SizedBox(
                                                height: 45,
                                                width: 45,
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.all(Radius.circular(12)),
                                                  child: Container(
                                                      color: Color.fromRGBO(245,101, 35, 2),
                                                      child: Padding(
                                                          padding: EdgeInsets.all(10),
                                                          child: Image.asset('assets/images/sound.png')
                                                      )
                                                  ),
                                                )
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                                        child: Text("Which of the threads shown below has NO length?",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                                        child: Image.asset('assets/images/Boy.png'),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                                        child: Text("Which of the threads shown below has NO length?",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                                          child: SizedBox(
                                          height: 80,
                                          width: MediaQuery.of(context).size.width,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(Radius.circular(8)),
                                            child: Container(
                                                color: Color.fromRGBO(235,249, 255, 10),
                                                child: Container(
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          height: 40,
                                                            width: 40,
                                                            margin: EdgeInsets.only(left: 15),
                                                            child: ClipRRect(
                                                              borderRadius: BorderRadius.all(Radius.circular(25)),
                                                              child: Container(
                                                                color: Color.fromRGBO(56,168, 223, 10),
                                                                child: Padding(
                                                                    padding: EdgeInsets.all(8),
                                                                    child: Center(child: Text("A",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25),))
                                                                ),
                                                              ),
                                                            ),
                                                        ),
                                                        Container(
                                                            margin: EdgeInsets.only(left: 15,right: 15),
                                                            child: Text("All the three threads have some length.",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15),),
                                                        )
                                                      ],
                                                    ),
                                                )
                                            ),
                                          )
                                       ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                                        child: SizedBox(
                                            height: 80,
                                            width: MediaQuery.of(context).size.width,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(Radius.circular(8)),
                                              child: Container(
                                                  color: Color.fromRGBO(235,249, 255, 10),
                                                  child: Container(
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          height: 40,
                                                          width: 40,
                                                          margin: EdgeInsets.only(left: 15),
                                                          child: ClipRRect(
                                                            borderRadius: BorderRadius.all(Radius.circular(25)),
                                                            child: Container(
                                                              color: Color.fromRGBO(56,168, 223, 10),
                                                              child: Padding(
                                                                  padding: EdgeInsets.all(8),
                                                                  child: Center(child: Text("B",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25),))
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          margin: EdgeInsets.only(left: 15,right: 15),
                                                          child: Text("All the three threads have some length.",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15),),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                              ),
                                            )
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                                        child: SizedBox(
                                            height: 80,
                                            width: MediaQuery.of(context).size.width,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(Radius.circular(8)),
                                              child: Container(
                                                  color: Color.fromRGBO(235,249, 255, 10),
                                                  child: Container(
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          height: 40,
                                                          width: 40,
                                                          margin: EdgeInsets.only(left: 15),
                                                          child: ClipRRect(
                                                            borderRadius: BorderRadius.all(Radius.circular(25)),
                                                            child: Container(
                                                              color: Color.fromRGBO(56,168, 223, 10),
                                                              child: Padding(
                                                                  padding: EdgeInsets.all(8),
                                                                  child: Center(child: Text("C",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25),))
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          margin: EdgeInsets.only(left: 15,right: 15),
                                                          child: Text("All the three threads have some length.",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15),),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                              ),
                                            )
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                                        child: SizedBox(
                                            height: 80,
                                            width: MediaQuery.of(context).size.width,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(Radius.circular(8)),
                                              child: Container(
                                                  color: Color.fromRGBO(235,249, 255, 10),
                                                  child: Container(
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          height: 40,
                                                          width: 40,
                                                          margin: EdgeInsets.only(left: 15),
                                                          child: ClipRRect(
                                                            borderRadius: BorderRadius.all(Radius.circular(25)),
                                                            child: Container(
                                                              color: Color.fromRGBO(56,168, 223, 10),
                                                              child: Padding(
                                                                  padding: EdgeInsets.all(8),
                                                                  child: Center(child: Text("C",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25),))
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          margin: EdgeInsets.only(left: 15,right: 15),
                                                          child: Text("All the three threads have some length.",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15),),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                              ),
                                            )
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 15,right: 15,bottom: 20),
                                      )

                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ),
                    ),
                  ),
              ),
              InkWell(
                onTap: (){
                  print("on subject click");
                },
                child: Container(
                  margin: EdgeInsets.only(top: 15,right: 15),
                  child: Align(
                      alignment: Alignment.bottomRight,
                      child: Util.getCustomBtnBackground(40,110,Color.fromRGBO(245,101, 35, 2),"Submit",10,20)
                  ),
                ),
              )
            ],
          )
      ),
    );
  }
}
