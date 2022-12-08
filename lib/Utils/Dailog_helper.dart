import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogHelper {
  //show error dialog
  static void showErroDialog({String title = 'Error', String? description = 'Something went wrong'}) {
    Get.dialog(
      Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: Get.textTheme.headline4,
              ),
              Text(
                description ?? '',
                style: Get.textTheme.headline6,
              ),
              ElevatedButton(
                onPressed: () {
                  if (Get.isDialogOpen!) Get.back();
                },
                child: Text('Okay'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //show toast
  //show snack bar
  //show loading
  static Widget showLoading([String? message]) {
    return Scaffold(
        body: Center(
          child: SizedBox(
              width: 40.0,
              height: 40.0,
              child: const CircularProgressIndicator(
                  backgroundColor: Colors.black,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.red))),
        ));
  }

  static Widget loading(){
     return Container(
       child: Column(
         children: <Widget>[
           new Container(
             alignment: AlignmentDirectional.center,
             child: new Container(
               decoration: new BoxDecoration(
                   borderRadius: new BorderRadius.circular(10.0)
               ),
               alignment: AlignmentDirectional.center,
               child: new Column(
                 crossAxisAlignment: CrossAxisAlignment.center,
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: <Widget>[
                   new Center(
                     child: new SizedBox(
                       child: new CircularProgressIndicator(
                         value: null,
                         strokeWidth: 7.0,
                         color: Colors.red,
                       ),
                     ),
                   ),
                   new Container(
                     margin: const EdgeInsets.only(top: 25.0),
                     child: new Center(
                       child: new Text(
                         "loading..",
                         style: new TextStyle(
                             color: Colors.white
                         ),
                       ),
                     ),
                   ),
                 ],
               ),
             ),
           ),
         ],
       ),
     );
  }

  //hide loading
  static void hideLoading() {
    if (Get.isDialogOpen!) Get.back();
  }
}