
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Util{
  static void showSnackBar(BuildContext context,String msg){
    final snackbar = SnackBar(content: Text(msg));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}