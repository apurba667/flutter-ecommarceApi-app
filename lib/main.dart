
import 'package:ecommerceapiapp/provider/category_provider.dart';
import 'package:ecommerceapiapp/provider/order_provider.dart';
import 'package:ecommerceapiapp/screen/bottom_nav/bottom_nav_page.dart';

import 'package:ecommerceapiapp/screen/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
   bool hasToken = false;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token =  sharedPreferences.getString("token");
    print("My token is $token");
    if(token!=null){
      hasToken = true;
    }
    else {
      hasToken = false;
    }
    return hasToken;

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>OrderProvider()),
        ChangeNotifierProvider(create: (context)=>CategoryProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginPage()
      ),
    );
  }
}