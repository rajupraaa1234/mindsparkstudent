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
                                        Container(
                                          child: Text("Question list..."),
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
