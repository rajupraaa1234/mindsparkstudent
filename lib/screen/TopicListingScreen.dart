import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mindsparkstudent/screen/Login.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Utils/AppConstant.dart';
import '../Utils/Dailog_helper.dart';
import '../models/TopicListModal.dart';
import 'QuestionScreen.dart';

void main() {
  runApp(const TopicListing());
}

class TopicListing extends StatelessWidget {
  const TopicListing({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return TopicListingPage(title: 'HomePage sdff ',);
  }
}

class TopicListingPage extends StatefulWidget {
  const TopicListingPage({super.key, required this.title});


  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<TopicListingPage> createState() => _TopicListingPageState();
}

class _TopicListingPageState extends State<TopicListingPage> {

  late List<TopicListModal> topicList = [];
  bool loader = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchTopiclist();
    getUserDetails();
  }

  late String username = "username";

  void getUserDetails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      username = sharedPreferences.get(AppConstant.UserName) as String;
    });
  }

  Future<void> fetchTopiclist() async {
    setState(() {
      loader =true;
    });
     final  res = await http.get(Uri.parse('https://rajupraaaa.github.io/Api/topicslist.json'));
    String responseapi = res.body.toString().replaceAll("\n","");
    setState(() {
      topicList.addAll(List<TopicListModal>.from(json.decode(responseapi).map((x) => TopicListModal.fromJson(x))));
    });
    setState(() {
     loader =false;
     //Navigator.pop(context);
    });
  }

  void onTopicList(var position){
    Navigator.push(
        context,
        MaterialPageRoute(
        builder: (context) => QuestionScreen(data: topicList[position]),
    ));
  }

  Widget getListItem(var position){
    return Container(
      width:200,
      height: 100,
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
          image: DecorationImage(
              image:AssetImage("assets/images/btn.png"),
              fit:BoxFit.fill
          )),
      child: Center(child: Text(topicList[position].name,style: TextStyle(color: Color.fromRGBO(128, 0, 0,3),fontSize: 25,),)),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          Navigator.of(context).maybePop();
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          margin: EdgeInsets.only(left: 20,top: 10),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/home.png"),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: Container(
                          width: 150,
                          margin: EdgeInsets.only(top: 10),
                          child: Center(child: Text("Active Topics",style: TextStyle(color: Color.fromRGBO(128, 0, 0,3),fontSize: 25,),)),
                        ),
                      ),
                      SizedBox(
                        width: 50,
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  //width: 300,
                  padding: EdgeInsets.only(left: 10,right: 10),
                  child: ListView.builder(
                    itemBuilder: (context, position) {
                      return InkWell(
                          onTap: (){
                            onTopicList(position);
                          },
                          child: new Flexible(child: getListItem(position))
                      );
                    },
                    itemCount: topicList.length,
                  ),
                ),
              ),
              Container(
                child: loader ?  DialogHelper.loading() : null,
              ),
              Container(
                child: Expanded(
                  child: Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: Container(
                        height: 110,
                        // width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/footer.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Container(
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 30),
                                height: 80,
                                child: Image.asset("assets/images/Boy.png"),
                              ),
                              Container(
                                  margin: EdgeInsets.only(left: 20),
                                  child: Text(username,style: TextStyle(color: Colors.white,fontSize: 22),)
                              )
                            ],
                          ),
                        ),
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
