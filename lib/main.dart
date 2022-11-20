
import 'package:ecommerceapiapp/screen/home_page.dart';
import 'package:ecommerceapiapp/screen/login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
 static Future<bool> isLogin()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token =  sharedPreferences.getString("token");
    print("My token is $token");
    if(token!=null){
      return true;
    }
    return false;

  }
  @override
  void initState() {
   isLogin();
    // TODO: implement initState
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isLogin()==true? LoginPage():HomePage(),
    );
  }
}