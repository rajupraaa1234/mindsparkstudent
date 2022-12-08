import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mindsparkstudent/Utils/AppConstant.dart';
import 'package:mindsparkstudent/Utils/Util.dart';
import 'package:mindsparkstudent/models/TopicListModal.dart';
import 'package:http/http.dart' as http;
import 'package:mindsparkstudent/screen/Login.dart';

import '../Utils/Dailog_helper.dart';
import '../models/MCQ.dart';

// void main() {
//   runApp(const QuestionScreen());
// }

class QuestionScreen extends StatelessWidget {
  const QuestionScreen({super.key, required TopicListModal this.data});
  final TopicListModal data;
  @override
  Widget build(BuildContext context) {

    return QuestionPage(title: 'HomePage sdff ',data:data);
  }
}

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key, required this.title,required TopicListModal this.data});
  final TopicListModal data;

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<QuestionPage> createState() => _QuestionPageState(data);
}

class _QuestionPageState extends State<QuestionPage> {

  // all 4 Options
  var optionAText = "Option A text";
  var optionBText = "Option B Text";
  var optionCText = "Option C Text";
  var optionDText = "Option D Text";

  // Question Description && Question Statement
  var QuestionDesc = "Question Description";
  var QuestionInst = "Question Instruction";

  // Question Image
  var QuestionImage = "assets/images/Boy.png";
  var sadBuddyImage = "assets/images/buddy_happy.png";

  //Options Color
  Color optionAColor = Color.fromRGBO(56,168, 223, 10);
  Color optionBColor = Color.fromRGBO(56,168, 223, 10);
  Color optionCColor = Color.fromRGBO(56,168, 223, 10);
  Color optionDColor = Color.fromRGBO(56,168, 223, 10);

  final TopicListModal data;
  bool loader = false;
  _QuestionPageState(TopicListModal this.data);
  late List<MCQ> questionList = [];
  


  @override
  void initState() {
    super.initState();
    fetchQuestion();
  }

  String getApiWithendpoint(){
    String id = data.id;
    String endpont = "Topic_${id}.json";
    String api = "http://rajupraaaa.github.io/Api/${endpont}";
    return api;
  }

  void fetchQuestion() async {
    setState(() {
      loader =true;
    });
    String api = getApiWithendpoint();

    try{
      final  res = await http.get(Uri.parse(api));
      String responseapi = res.body.toString().replaceAll("\n","");
      setState(() {
        questionList.addAll(List<MCQ>.from(json.decode(responseapi).map((x) => MCQ.fromJson(x))));
      });
      setState(() {
        loader =false;
      });
    }catch(e){
      setState(() {
        loader =false;
      });
      Util.showSnackBar(context, "Something is wrong...");
    }
  }

  void optionSelect(String option){
     print("options --> ${option}");
  }

  void onQuestionInstVoiceClick(){
    print("options --> inst");
  }

  void onQuestionDescriptionClick(){
    print("options --> voice");
  }

  Widget questionItem(){
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Visibility(
              visible: false,
              child: InkWell(
                onTap: (){
                  onQuestionInstVoiceClick();
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
            ),
            SizedBox(height: 10,),
            Visibility(
              visible: false,
              child: InkWell(
                onTap: (){
                  onQuestionDescriptionClick();
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
            ),
            Visibility(
              child: Container(
                margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                child: Text(QuestionInst,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
              ),
            ),
            Visibility(
              child: Container(
                margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                child: Image.asset(QuestionImage),
              ),
            ),
            Visibility(child:
               Container(
                  margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                  child: Text(QuestionDesc,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
               ),
            ),
            Container(
              child: loader ?  DialogHelper.loading() : null,
            ),
            Visibility(
              child: InkWell(
                onTap: (){
                  optionSelect("a");
                },
                child: Container(
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
                                        color: optionAColor,
                                        child: Padding(
                                            padding: EdgeInsets.all(8),
                                            child: Center(child: Text("A",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25),))
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 15,right: 15),
                                    child: Text(optionAText,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15),),
                                  )
                                ],
                              ),
                            )
                        ),
                      )
                  ),
                ),
              ),
            ),
            Visibility(
                child: InkWell(
                  onTap: (){
                    optionSelect("b");
                  },
                  child: Container(
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
                                          color: optionBColor,
                                          child: Padding(
                                              padding: EdgeInsets.all(8),
                                              child: Center(child: Text("B",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25),))
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 15,right: 15),
                                      child: Text(optionBText,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15),),
                                    )
                                  ],
                                ),
                              )
                          ),
                        )
                    ),
                  ),
                ),
            ),
            Visibility(
              child: InkWell(
                onTap: (){
                  optionSelect("c");
                },
                child: Container(
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
                                        color: optionCColor,
                                        child: Padding(
                                            padding: EdgeInsets.all(8),
                                            child: Center(child: Text("C",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25),))
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 15,right: 15),
                                    child: Text(optionCText,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15),),
                                  )
                                ],
                              ),
                            )
                        ),
                      )
                  ),
                ),
              ),
            ),
            Visibility(
                child: InkWell(
                  onTap: (){
                    optionSelect("d");
                  },
                  child: Container(
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
                                          color: optionDColor,
                                          child: Padding(
                                              padding: EdgeInsets.all(8),
                                              child: Center(child: Text("D",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25),))
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 15,right: 15),
                                      child: Text(optionDText,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15),),
                                    ),
                                  ],
                                ),
                              )
                          ),
                        )
                    ),
                  ),
                ),
            ),
            Container(
              margin: EdgeInsets.only(left: 15,right: 15,bottom: 20),
            )

          ],
        ),
      ),
    );
  }


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
                                      child: Image.asset(sadBuddyImage)
                                  )
                                ],
                              ),
                              questionItem(),
                              // Expanded(
                              //   child: SingleChildScrollView(
                              //     child: Column(
                              //       children: [
                              //         InkWell(
                              //           onTap: (){
                              //             onQuestionInstVoiceClick();
                              //           },
                              //           child: Container(
                              //             margin: EdgeInsets.only(left: 10),
                              //             child: Align(
                              //               alignment: Alignment.topLeft,
                              //               child: SizedBox(
                              //                   height: 45,
                              //                   width: 45,
                              //                   child: ClipRRect(
                              //                     borderRadius: BorderRadius.all(Radius.circular(12)),
                              //                     child: Container(
                              //                         color: Color.fromRGBO(245,101, 35, 2),
                              //                         child: Padding(
                              //                             padding: EdgeInsets.all(10),
                              //                             child: Image.asset('assets/images/sound.png')
                              //                         )
                              //                     ),
                              //                   )
                              //               ),
                              //             ),
                              //           ),
                              //         ),
                              //         SizedBox(height: 10,),
                              //         InkWell(
                              //           onTap: (){
                              //             onQuestionDescriptionClick();
                              //           },
                              //           child: Container(
                              //             margin: EdgeInsets.only(left: 10),
                              //             child: Align(
                              //               alignment: Alignment.topLeft,
                              //               child: SizedBox(
                              //                   height: 45,
                              //                   width: 45,
                              //                   child: ClipRRect(
                              //                     borderRadius: BorderRadius.all(Radius.circular(12)),
                              //                     child: Container(
                              //                         color: Color.fromRGBO(245,101, 35, 2),
                              //                         child: Padding(
                              //                             padding: EdgeInsets.all(10),
                              //                             child: Image.asset('assets/images/sound.png')
                              //                         )
                              //                     ),
                              //                   )
                              //               ),
                              //             ),
                              //           ),
                              //         ),
                              //         Container(
                              //           margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                              //           child: Text(QuestionInst,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
                              //         ),
                              //         Container(
                              //           margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                              //           child: Image.asset(QuestionImage),
                              //         ),
                              //         Container(
                              //           margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                              //           child: Text(QuestionDesc,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
                              //         ),
                              //         Container(
                              //           child: loader ?  DialogHelper.loading() : null,
                              //         ),
                              //         InkWell(
                              //           onTap: (){
                              //             optionSelect("a");
                              //           },
                              //           child: Container(
                              //             margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                              //             child: SizedBox(
                              //                 height: 80,
                              //                 width: MediaQuery.of(context).size.width,
                              //                 child: ClipRRect(
                              //                   borderRadius: BorderRadius.all(Radius.circular(8)),
                              //                   child: Container(
                              //                       color: Color.fromRGBO(235,249, 255, 10),
                              //                       child: Container(
                              //                         child: Row(
                              //                           children: [
                              //                             Container(
                              //                               height: 40,
                              //                               width: 40,
                              //                               margin: EdgeInsets.only(left: 15),
                              //                               child: ClipRRect(
                              //                                 borderRadius: BorderRadius.all(Radius.circular(25)),
                              //                                 child: Container(
                              //                                   color: optionAColor,
                              //                                   child: Padding(
                              //                                       padding: EdgeInsets.all(8),
                              //                                       child: Center(child: Text("A",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25),))
                              //                                   ),
                              //                                 ),
                              //                               ),
                              //                             ),
                              //                             Container(
                              //                               margin: EdgeInsets.only(left: 15,right: 15),
                              //                               child: Text(optionAText,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15),),
                              //                             )
                              //                           ],
                              //                         ),
                              //                       )
                              //                   ),
                              //                 )
                              //             ),
                              //           ),
                              //         ),
                              //         InkWell(
                              //           onTap: (){
                              //               optionSelect("b");
                              //               },
                              //           child: Container(
                              //             margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                              //             child: SizedBox(
                              //                 height: 80,
                              //                 width: MediaQuery.of(context).size.width,
                              //                 child: ClipRRect(
                              //                   borderRadius: BorderRadius.all(Radius.circular(8)),
                              //                   child: Container(
                              //                       color: Color.fromRGBO(235,249, 255, 10),
                              //                       child: Container(
                              //                         child: Row(
                              //                           children: [
                              //                             Container(
                              //                               height: 40,
                              //                               width: 40,
                              //                               margin: EdgeInsets.only(left: 15),
                              //                               child: ClipRRect(
                              //                                 borderRadius: BorderRadius.all(Radius.circular(25)),
                              //                                 child: Container(
                              //                                   color: optionBColor,
                              //                                   child: Padding(
                              //                                       padding: EdgeInsets.all(8),
                              //                                       child: Center(child: Text("B",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25),))
                              //                                   ),
                              //                                 ),
                              //                               ),
                              //                             ),
                              //                             Container(
                              //                               margin: EdgeInsets.only(left: 15,right: 15),
                              //                               child: Text(optionBText,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15),),
                              //                             )
                              //                           ],
                              //                         ),
                              //                       )
                              //                   ),
                              //                 )
                              //             ),
                              //           ),
                              //         ),
                              //         InkWell(
                              //           onTap: (){
                              //             optionSelect("c");
                              //           },
                              //           child: Container(
                              //             margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                              //             child: SizedBox(
                              //                 height: 80,
                              //                 width: MediaQuery.of(context).size.width,
                              //                 child: ClipRRect(
                              //                   borderRadius: BorderRadius.all(Radius.circular(8)),
                              //                   child: Container(
                              //                       color: Color.fromRGBO(235,249, 255, 10),
                              //                       child: Container(
                              //                         child: Row(
                              //                           children: [
                              //                             Container(
                              //                               height: 40,
                              //                               width: 40,
                              //                               margin: EdgeInsets.only(left: 15),
                              //                               child: ClipRRect(
                              //                                 borderRadius: BorderRadius.all(Radius.circular(25)),
                              //                                 child: Container(
                              //                                   color: optionCColor,
                              //                                   child: Padding(
                              //                                       padding: EdgeInsets.all(8),
                              //                                       child: Center(child: Text("C",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25),))
                              //                                   ),
                              //                                 ),
                              //                               ),
                              //                             ),
                              //                             Container(
                              //                               margin: EdgeInsets.only(left: 15,right: 15),
                              //                               child: Text(optionCText,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15),),
                              //                             )
                              //                           ],
                              //                         ),
                              //                       )
                              //                   ),
                              //                 )
                              //             ),
                              //           ),
                              //         ),
                              //         InkWell(
                              //           onTap: (){
                              //             optionSelect("d");
                              //           },
                              //           child: Container(
                              //             margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                              //             child: SizedBox(
                              //                 height: 80,
                              //                 width: MediaQuery.of(context).size.width,
                              //                 child: ClipRRect(
                              //                   borderRadius: BorderRadius.all(Radius.circular(8)),
                              //                   child: Container(
                              //                       color: Color.fromRGBO(235,249, 255, 10),
                              //                       child: Container(
                              //                         child: Row(
                              //                           children: [
                              //                             Container(
                              //                               height: 40,
                              //                               width: 40,
                              //                               margin: EdgeInsets.only(left: 15),
                              //                               child: ClipRRect(
                              //                                 borderRadius: BorderRadius.all(Radius.circular(25)),
                              //                                 child: Container(
                              //                                   color: optionDColor,
                              //                                   child: Padding(
                              //                                       padding: EdgeInsets.all(8),
                              //                                       child: Center(child: Text("D",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25),))
                              //                                   ),
                              //                                 ),
                              //                               ),
                              //                             ),
                              //                             Container(
                              //                               margin: EdgeInsets.only(left: 15,right: 15),
                              //                               child: Text(optionDText,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15),),
                              //                             ),
                              //                           ],
                              //                         ),
                              //                       )
                              //                   ),
                              //                 )
                              //             ),
                              //           ),
                              //         ),
                              //         Container(
                              //           margin: EdgeInsets.only(left: 15,right: 15,bottom: 20),
                              //         )
                              //
                              //       ],
                              //     ),
                              //   ),
                              // )
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
