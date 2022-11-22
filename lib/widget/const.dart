import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


 String baseUrl = "https://apihomechef.antopolis.xyz/";

 String imagelink = "https://apihomechef.antopolis.xyz/images/";
 showInToast(String title){
   Fluttertoast.showToast(
       msg: "$title",
       toastLength: Toast.LENGTH_SHORT,
       gravity: ToastGravity.CENTER,
       timeInSecForIosWeb: 1,
       backgroundColor: Colors.red,
       textColor: Colors.white,
       fontSize: 16.0
   );
 }