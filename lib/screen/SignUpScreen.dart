import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mindsparkstudent/Utils/Util.dart';

import '../Utils/DataBase/database_helper.dart';
import '../models/User.dart';

void main() {
  runApp(const SignUpPage());
}

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MySignUpPage(title: 'HomePage',);
  }
}

class MySignUpPage extends StatefulWidget {
  const MySignUpPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MySignUpPage> createState() => _MySighUpPageState();
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

class _MySighUpPageState extends State<MySignUpPage> {
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

  var username = TextEditingController();
  var password = TextEditingController();
  bool isAvliable = false;
  DatabaseHelper databaseHelper = DatabaseHelper();

  Future<void> signup() async {
    String user = username.text.toString();
    String pass = password.text.toString();
    if(user.length==0 || pass.length==0){
       Util.showSnackBar(context, "Please enter your credentials...");
       return;
    }else if(user.length<3 || pass.length<3){
        Util.showSnackBar(context, "Please valid credentials...");
        return;
    }else {
       await databaseHelper.isAlredayExistUSer(user).then((value) =>
           setState(() {
             this.isAvliable = value as bool;
           })
       );

      if(this.isAvliable){
        Util.showSnackBar(context, "This credential allready axist . you can directly login");
        return;
      }else{
          User Nuser = new User(user, pass);
          databaseHelper.insertNote(Nuser).then((value) =>
              Util.showSnackBar(context, "New Credential created successfully ...")
          ).catchError((error)=>Util.showSnackBar(context, "Something is wrong ..."));
      }
    }
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Icon(
                        Icons.arrow_circle_left,
                        color: Color.fromRGBO(162,52,54,1),
                        size: 30.0,
                      ),
                    ),
                  ),
                  Container(
                    width: 200,
                    child: SvgPicture.asset('assets/images/logo.svg'),
                  )
                ],
              ),
            ),
            Container(
              child: Text("Sign Up",style: TextStyle(color: Colors.black,fontSize: 21),),
            ),
            Container(
              margin: EdgeInsets.only(left: 20,right: 20,top: 30),
              height: 50,
              child: TextField(
                controller: username,
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
                controller: password,
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
            InkWell(
              onTap: (){
                signup();
              },
              child: Container(
                margin: EdgeInsets.only(left: 20,right: 20,top: 15),
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255,96, 0, 1),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Center(child: Text("Sign Up",style: TextStyle(color: Colors.white,fontSize: 21),)),
              ),
            )
          ],
        )
    );
  }
}
