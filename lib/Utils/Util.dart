
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Util{
  static void showSnackBar(BuildContext context,String msg){
    final snackbar = SnackBar(content: Text(msg));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
  static Widget getCustomBtnBackground(double ht,double wh,Color color,String btname,double rad,double fontsize){
    return SizedBox(
      height: ht,
      width: wh,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(rad)),
        child: Container(
          color: color,
          child: Center(child: Text(btname,style: TextStyle(color: Colors.white,fontSize: fontsize,fontWeight: FontWeight.bold),)),
        ),
      ),
    );
  }

  static Widget getCustomBtnBackgroundWithDiffRadius(double ht,double wh,Color color,String btname,double tlrad,double trrad,double blrad,double brrad,double fontsize){
    return SizedBox(
      height: ht,
      width: wh,
      child: ClipRRect(
        borderRadius: BorderRadius.only(topRight: Radius.circular(trrad),topLeft: Radius.circular(tlrad),bottomRight: Radius.circular(brrad),bottomLeft: Radius.circular(blrad)),
        child: Container(
          color: color,
          child: Center(child: Text(btname,style: TextStyle(color: Colors.white,fontSize: fontsize,fontWeight: FontWeight.bold),)),
        ),
      ),
    );
  }

  static Dialog getCustomDialog(BuildContext context){
    Dialog errorDialog = Dialog(

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)), //this right here
      child: Container(
        height: 200.0,
        width: 200.0,

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Padding(
                padding:  EdgeInsets.only(left: 15,right: 15,bottom: 30),
                child: Center(child: Text('Do you want to submit your session ?', style: TextStyle(color: Colors.black,fontSize: 20),)),
              ),
            ),
            Container(
              child: Row(
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 30),
                      child: Util.getCustomBtnBackground(40,70,Color.fromRGBO(245,101, 35, 2),"Cancel",8,15),
                    ),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: (){
                      print('done click ');
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 30),
                      child: Util.getCustomBtnBackground(40,70,Color.fromRGBO(245,101, 35, 2),"Done",8,15),
                    ),
                  )
                ],
              ),
            )
            //Padding(padding: EdgeInsets.only(top: 50.0)),
            // TextButton(onPressed: () {
            //   Navigator.of(context).pop();
            // },
            //     child: Text('Got It!', style: TextStyle(color: Colors.purple, fontSize: 18.0),))
          ],
        ),
      ),
    );
    return errorDialog;
  }

}