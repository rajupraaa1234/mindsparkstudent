import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screen/Login.dart';

class CustomNavigationDrawer extends StatefulWidget {
  final GlobalKey<ScaffoldState> scafoldKey;

  const CustomNavigationDrawer({Key? key, required this.scafoldKey}) : super(key: key);
  @override
  _CustomNavigationDrawerState createState() => _CustomNavigationDrawerState(scafoldKey);
}

class _CustomNavigationDrawerState extends State<CustomNavigationDrawer> {
   GlobalKey<ScaffoldState> scafoldKey;
  _CustomNavigationDrawerState( this.scafoldKey){
    this.scafoldKey = scafoldKey;
  }

   Future<void> onLogout() async {
     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
     sharedPreferences.clear();
     Navigator.pushReplacement(context,
         MaterialPageRoute(builder:
             (context) =>
                 HomePage()));
   }

  @override
  Widget build(BuildContext context){
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height*.85,
      width: width*0.6,
      child: ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20),bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
        child: Scaffold(
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/drawer.png"),
                fit: BoxFit.cover
              ),
            ),
            child: Column(
              children: [
                Container(
                    height: height*0.25,
                    color: Colors.white,

                ),
                SizedBox(height:30,),
                Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: (){
                            this.scafoldKey!.currentState!.closeDrawer();
                          },
                          child: ListTile(
                            leading: Icon(Icons.home,color: Colors.white,size: 35,),
                            title: Text("Home",style: TextStyle(color: Colors.white,fontSize: 22),),
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            onLogout();
                            this.scafoldKey!.currentState!.closeDrawer();
                          },
                          child: ListTile(
                            leading: Icon(Icons.logout_outlined,color: Colors.white,size: 35,),
                            title: Text("Logout",style: TextStyle(color: Colors.white,fontSize: 22),),
                          ),
                        )
                      ],
                    ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}