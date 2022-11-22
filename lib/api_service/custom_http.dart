import 'dart:convert';

import 'package:ecommerceapiapp/model/category_model.dart';
import 'package:ecommerceapiapp/model/order_model.dart';
import 'package:ecommerceapiapp/widget/const.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class CustomHttp{
  static const Map<String,String> defaultHeader ={
    "Accept":"Applicaton/json"
  };

 Future<String> loginUser(String email, String password)async{
    var link = "${baseUrl}api/admin/sign-in";
    var map = Map<String,dynamic>();
    map["email"]=email;
    map["password"]=password;
    var responce = await http.post(Uri.parse(link),body: map,headers: defaultHeader);
    print("Responce is ${responce.body}");
    if(responce.statusCode==200){
      showInToast("Login Successfull");
      return responce.body;
    }
    else{
      showInToast("Invalid email of password");
      return "Something is Wrong";
    }
  }


  Future<Map<String,String>> getHeaderWithToken()async{
   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
   var Map = {
     "Accept":"Applicaton/json",
     "Authorization" : "bearer ${sharedPreferences.getString("token")}"
   };
   print("Uer Token issss ${sharedPreferences.getString("token")}");
   return Map;
  }


  Future<List<OrderModel>> fetchOrderData()async{
   List<OrderModel> orderList = [];
   OrderModel orderModel;
   try{
     var link = "${baseUrl}api/admin/all/orders";
     var responce = await http.get(Uri.parse(link),headers: await getHeaderWithToken());
  print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa${responce.body}");
     if(responce.statusCode==200){
       var data = jsonDecode(responce.body);
       for(var i in data){
         orderModel = OrderModel.fromJson(i);
         orderList.add(orderModel);
       }
       return orderList;
     }
    else{
      showInToast("Something is Wrong!!");
      return orderList;
     }

   } catch(e){
     print("The problem is $e");
     return orderList;
   }
  }
  Future<List<CategoryModel>> fetchCategoryData()async{
    List<CategoryModel> categoryList = [];
    CategoryModel categoryModel;
    try{
      var link = "${baseUrl}api/admin/category";
      var responce = await http.get(Uri.parse(link),headers: await getHeaderWithToken());
      print("bbbbbbbbbbbbbbbb${responce.body}");
      if(responce.statusCode==200){
        var data = jsonDecode(responce.body);
        for(var i in data){
          categoryModel = CategoryModel.fromJson(i);
          categoryList.add(categoryModel);
        }
        return categoryList;
      }
      else{
        showInToast("Something is Wrong!!");
        return categoryList;
      }

    } catch(e){
      print("The problem is $e");
      return categoryList;
    }
  }


}