import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:mindsparkstudent/Utils/AppConstant.dart';
import 'package:mindsparkstudent/Utils/Util.dart';
import 'package:mindsparkstudent/models/TopicListModal.dart';
import 'package:http/http.dart' as http;
import 'package:mindsparkstudent/screen/Login.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

import '../Utils/Dailog_helper.dart';
import '../models/MCQ.dart';


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
  State<QuestionPage> createState() => QuestionPageState(data);
}


class QuestionPageState extends State<QuestionPage> {


  final TopicListModal data;
  QuestionPageState(TopicListModal this.data);

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

  var buddyImage = "assets/images/buddy_happy.png";

  var sadBuddyImage = "assets/images/buddy_sad.png";
  var happyBuddyImage = "assets/images/buddy_happy.png";

  //Sound
  var correctSound = "assets/audio/correct.mp3";
  var inCorrectSound = "assets/audio/incorrect.mp3";

  //Options Color
  Color optionAColor = Color.fromRGBO(56,168, 223, 10);
  Color optionBColor = Color.fromRGBO(56,168, 223, 10);
  Color optionCColor = Color.fromRGBO(56,168, 223, 10);
  Color optionDColor = Color.fromRGBO(56,168, 223, 10);
  Color CorrectOptioncolor = Color.fromRGBO(0,200, 83, 2);
  Color InCorrectOptioncolor = Color.fromRGBO(252,60, 0, 2);


  // Widget Visibility
  bool questionIntVoice = false;
  bool questionDescVoice = false;
  bool questionInstruction = false;
  bool questionImage = false;
  bool questionDescVis = false;
  bool OptionsAvis = false;
  bool OptionsBvis = false;
  bool OptionsCvis = false;
  bool OptionsDvis = false;

  //Permission
  late final PermissionStatus permissionStatus;

  //OptionclickListner
  bool isClick = false;




  bool loader = false;
  late List<MCQ> questionList = [];
  int index = 0;
  int result = 0;
  int attempted = 0;


  //TopicName
  String topicName = "topic1";

  //Question Sequesnce number
  String qnumber = "1";
  double progress = 0.0;
  late String currentImgPath;
  AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer() ;
  Dio dio = Dio();

  @override
  void initState() {
    super.initState();
    downloadQuestion();
  }

  void playSound(String url) async {
    try{
      _assetsAudioPlayer = AssetsAudioPlayer.newPlayer();
      _assetsAudioPlayer!.open(
        url == correctSound || url == inCorrectSound ? Audio(url) :
        Audio.file(url),
        autoStart: true,
      );
    }catch(e){
        print("sound error...");
    }
  }
  void resetQuestionFrame(){
    setState(() {
       questionIntVoice = false;
       questionDescVoice = false;
       questionInstruction = false;
       questionImage = false;
       questionDescVis = false;
       OptionsAvis = false;
       OptionsBvis = false;
       OptionsCvis = false;
       OptionsDvis = false;
       isClick = false;
       optionAColor = Color.fromRGBO(56,168, 223, 10);
       optionBColor = Color.fromRGBO(56,168, 223, 10);
       optionCColor = Color.fromRGBO(56,168, 223, 10);
       optionDColor = Color.fromRGBO(56,168, 223, 10);
       buddyImage = happyBuddyImage;
    });
  }

  void downloadQuestion() async {
    setState(() {
      topicName = data.name;
    });
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.get(data.id) != null){
      print("no need to download");
      updateQuestionList();
    }else{
      print("need to download");
      fetchQuestion();
    }
  }
  
  void updateQuestionList() async {
    String tdata = DateFormat("hh:mm:ss").format(DateTime.now());
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(AppConstant.startTime, tdata);
    setState(() {
      questionList = MCQ.decode(sharedPreferences.get(data.id) as String);
    });
    print("list --> ${questionList[0].question_seq}");
      setState(() {
        int temp = index + 1;
        qnumber = temp.toString();
      });
    updateQuestion();

  }
  void updateQuestion(){
    MCQ firstQuestion = questionList[index];
    if(!firstQuestion.question_image.isEmpty){
      QuestionImage = firstQuestion.question_image;
      questionImage = true;
    }
    if(!firstQuestion.question_inst.isEmpty){
        setState(() {
          questionIntVoice = true;
        });
    }
    if(!firstQuestion.question_voice.isEmpty){
      setState(() {
        questionDescVoice = true;
      });
    }
    if(!firstQuestion.question_desc.isEmpty){
       setState(() {
         questionDescVis = true;
         QuestionDesc = firstQuestion.question_desc;
       });
    }
    if(!firstQuestion.question_body.isEmpty){
      setState(() {
        questionInstruction = true;
        QuestionInst = firstQuestion.question_body;
      });
    }
    if(!firstQuestion.mcq_1.isEmpty){
      optionAText = firstQuestion.mcq_1;
      OptionsAvis = true;
    }
    if(!firstQuestion.mcq_2.isEmpty){
      optionBText = firstQuestion.mcq_2;
      OptionsBvis = true;
    }
    if(!firstQuestion.mcq_3.isEmpty){
      optionCText = firstQuestion.mcq_3;
      OptionsCvis = true;
    }
    if(!firstQuestion.mcq_4.isEmpty){
      optionDText = firstQuestion.mcq_4;
      OptionsDvis = true;
    }
    if(!firstQuestion.question_inst.isEmpty){
        onQuestionInstVoiceClick();
    }
  }

  String getApiWithendpoint(){
    String id = data.id;
    setState(() {
      topicName = data.name;
    });
    String endpont = "Topic_${id}.json";
    String api = "http://rajupraaaa.github.io/Api/${endpont}";
    return api;
  }

  void onSubmit(){

    if(isClick == false){
        Util.showSnackBar(context, "please give your answer...");
    }else {
        _assetsAudioPlayer!.stop();
        if (index == questionList.length - 1) {
          saveResultInLocal();
          showDialog(context: context, builder: (BuildContext context) => Util.getCustomDialog(context,topicName),barrierDismissible: false);
          //print("Question end ${result}");
        }
        else if (index < questionList.length) {
          setState(() {
            index++;
            qnumber = (index + 1).toString();
          });
          resetQuestionFrame();
          updateQuestion();
        }
    }
  }

  String getFileNameFromUrl(String url) {
    String fileName = url.split('/').toList().last;
    return fileName;
  }


  void checkforPermission() async {
    permissionStatus = await Permission.storage.status;
    if (permissionStatus != PermissionStatus.granted) {
        PermissionStatus permissionStatus= await Permission.storage.request();
        setState(() {
        permissionStatus = permissionStatus;
        });
    }
  }

  Future<String> startDownloading(String url,String fileName) async {
    String path = await _getFilePath(fileName);
    setState(() {
      currentImgPath = path;
    });
    //print("path -------> ${path}");
    await dio.download(
      url,
      path,
      onReceiveProgress: (recivedBytes, totalBytes) {
        setState(() {
          progress = recivedBytes / totalBytes;
        });
        //print("progress------> ${progress}");
      },
      deleteOnError: true,
    ).then((_) {
      return path;
    });
    return path;
  }

  Future<String> _getFilePath(String filename) async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    return "${dir}/$filename";
  }


  void saveAllQuestioninLocal() async {
    late List<MCQ> storelist = [];
    String id = data.id;
    questionList.forEach((element) async {
         late String imgurl = "";
         late String voiceinstUrl = "";
         late String voiceQuesUrl = "";

         if(!element.question_image.isEmpty){
                String Imgurl = element.question_image;
                imgurl = await startDownloading(Imgurl,"${id}${element.question_seq}.jpg",) as String;
             //  storelist.add(new MCQ(element.question_seq, element.question_body,element.question_type, element.question_options, element.mcq_1, element.mcq_2, element.mcq_3, element.mcq_4, element.question_inst, element.question_voice, element.correct, element.question_desc, imgurl));
        }
         if(!element.question_inst.isEmpty){
             String Imgurl = element.question_inst;
             voiceinstUrl = await startDownloading(Imgurl,"inst${id}${element.question_seq}.mp3",) as String;
             print("inst ---> ${voiceinstUrl}");
         }
         if(!element.question_voice.isEmpty){
             String Imgurl = element.question_voice;
             voiceQuesUrl = await startDownloading(Imgurl,"voice${id}${element.question_seq}.mp3",) as String;
             print("voice ---> ${voiceQuesUrl}");
         }
         storelist.add(new MCQ(element.question_seq, element.question_body,element.question_type, element.question_options, element.mcq_1, element.mcq_2, element.mcq_3, element.mcq_4, voiceinstUrl, voiceQuesUrl, element.correct, element.question_desc, imgurl));

    });

    Future.delayed(Duration(seconds: 6), () async{
       final String encodedData = MCQ.encode(storelist);
       SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString(data.id, encodedData);
      updateQuestionList();
      setState(() {
        loader =false;
      });
    });
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
      saveAllQuestioninLocal();
      // setState(() {
      //   loader =false;
      //
      //   //updateQuestion();
      // });
    }catch(e){
      setState(() {
        loader =false;
      });
      Util.showSnackBar(context, "Something is wrong...");
    }
  }

  String decodeAns(String str){
     if(str == "a") return "1";
     else if(str == "b") return "2";
     else if(str == "c") return "3";
     else return "4";
  }

  void optionSelect(String option){
    if(isClick ==false) {
      setState(() {
        attempted++;
      });
      _assetsAudioPlayer!.stop();
      String ans = questionList[index].correct;
      String userAns = decodeAns(option);
      bool isCorrect = ans == userAns ? true : false;
      if(isCorrect){
         setState(() {
           buddyImage = happyBuddyImage;
         });
      }else{
         setState(() {
           buddyImage = sadBuddyImage;
         });
      }
      isClick = true;
      if (option == "a") {
        if (isCorrect) {
          playSound(correctSound);
          setState(() {
            optionAColor = CorrectOptioncolor;
            result++;
          });
        } else {
          playSound(inCorrectSound);
          setState(() {
            optionAColor = InCorrectOptioncolor;
          });
        }
      } else if (option == "b") {
        if (isCorrect) {
          playSound(correctSound);
          setState(() {
            optionBColor = CorrectOptioncolor;
            result++;
          });
        } else {
          playSound(inCorrectSound);
          setState(() {
            optionBColor = InCorrectOptioncolor;
          });
        }
      } else if (option == "c") {
        if (isCorrect) {
          playSound(correctSound);
          setState(() {
            optionCColor = CorrectOptioncolor;
            result++;
          });
        } else {
          playSound(inCorrectSound);
          setState(() {
            optionCColor = InCorrectOptioncolor;
          });
        }
      } else {
        if (isCorrect) {
          playSound(correctSound);
          setState(() {
            optionDColor = CorrectOptioncolor;
            result++;
          });
        } else {
          playSound(inCorrectSound);
          setState(() {
            optionDColor = InCorrectOptioncolor;
          });
        }
      }
    }
  }

  void onQuestionInstVoiceClick(){
      String voiceUrl = questionList[index].question_inst;
      _assetsAudioPlayer!.stop();
      playSound(voiceUrl);
  }

  void onQuestionDescriptionClick(){
    String voiceUrl = questionList[index].question_voice;
    _assetsAudioPlayer!.stop();
    playSound(voiceUrl);
  }

  Widget questionItem(){
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Visibility(
              visible: questionIntVoice,
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
              visible: questionDescVoice,
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
              visible: questionInstruction,
              child: Container(
                margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                child: Text(QuestionInst,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
              ),
            ),
            Visibility(
              visible: questionImage,
              child: Container(
                margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                child: Image.file(
                  File(QuestionImage),
                  width: 400,
                  height: 300,
                )
              ),
            ),
            Visibility(
              visible: questionDescVis,
              child:
               Container(
                  margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                  child: Text(QuestionDesc,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
               ),
            ),
            Container(
              child: loader ?  DialogHelper.loading("please wait we are downloading the Question content...") : null,
            ),
            Visibility(
              visible: OptionsAvis,
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
              visible: OptionsBvis,
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
              visible: OptionsCvis,
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
              visible: OptionsDvis,
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

  void saveResultInLocal() async {

    String tdata = DateFormat("hh:mm:ss").format(DateTime.now());
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt(AppConstant.attempt, attempted);
    sharedPreferences.setInt(AppConstant.result, result);
    sharedPreferences.setInt(AppConstant.total, questionList.length);
    sharedPreferences.setString(AppConstant.endTime, tdata);
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
                          saveResultInLocal();
                          showDialog(context: context, builder: (BuildContext context) => Util.getCustomDialog(context,topicName),barrierDismissible: false);
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 20,top: 10),
                          child: Util.getCustomBtnBackground(40,40,Color.fromRGBO(245,101, 35, 2),"Done",8,15),
                        ),
                      ),
                      Container(
                        //width: 150,
                          margin: EdgeInsets.only(top: 12),
                          child: Text(topicName,style: TextStyle(color: Colors.black,fontSize: 22),)
                      ),
                      SizedBox(
                        width: 35,
                      )
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5),
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
                                    child: Util.getCustomBtnBackgroundWithDiffRadius(40,40,Color.fromRGBO(58,137,252,1),qnumber,12,0,0,12,15),
                                  ),
                                  Spacer(),
                                  Container(
                                      height: 60,
                                      width: 60,
                                      child: Image.asset(buddyImage)
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
                  onSubmit();
                  //print("on subject click");
                },
                child: Container(
                  margin: EdgeInsets.only(right: 15,top: 8),
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
