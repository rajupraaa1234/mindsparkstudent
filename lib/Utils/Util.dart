
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
}