
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mindsparkstudent/Utils/AppConstant.dart';
import 'package:mindsparkstudent/Widgets/CustomNavigationDrawer.dart';
import 'package:mindsparkstudent/screen/TopicListingScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';



void main() {
  runApp(const HomeScreen());
}


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});




  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MyHomePage(title: 'Dashboard Screen',);
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
    getUserDetails();
    downloadQuestion();
  }
  final GlobalKey<ScaffoldState> scafoldKey = new GlobalKey<ScaffoldState>();

  late String username = "username";
  late Icon download = Icon(
                            Icons.download,
                            color: Colors.red,
                            size: 30,
                       );


  void downloadQuestion() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.get(AppConstant.Topics) != null){
      setState(() {
          download = Icon(
            Icons.check,
            color: Colors.green,
            size: 30,
          );
      });
    }else{
      setState(() {
        download = Icon(
          Icons.download,
          color: Colors.red,
          size: 30,
        );
      });
    }
  }


  void getUserDetails() async {
     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
     setState(() {
       username = sharedPreferences.get(AppConstant.UserName) as String;
     });
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        return false;
      },
      child: Scaffold(
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
                           //print('hello menu ');
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
                         child: Container(
                             width: 150,
                             margin: EdgeInsets.only(top: 10),
                             child: SvgPicture.asset('assets/images/logo.svg'),
                           ),
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
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: Center(child: Text("Topics",style: TextStyle(color: Color.fromRGBO(128, 0, 0,3),fontSize: 25,),)),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            child: download
                          )
                        ],
                      ),
                    ),
                  ),onTap:() async {
                         SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                         bool down1 = false;
                         bool down2 = false;
                         if(sharedPreferences.get(AppConstant.Topic_1) != null){
                           setState(() {
                             down1 = true;
                           });
                         }
                         if(sharedPreferences.get(AppConstant.Topic_2) != null){
                           setState(() {
                             down2 = true;
                           });
                         }
                        var temp = await Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => TopicListing(down1:down1,down2:down2)),
                          );
                        if(temp){
                          downloadQuestion();
                        }
                   }),
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
      ),
    );
  }
}
