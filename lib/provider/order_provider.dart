import 'package:ecommerceapiapp/api_service/custom_http.dart';
import 'package:ecommerceapiapp/model/order_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderProvider with ChangeNotifier{
  List<OrderModel> orderList=[];

  Future getOrderData()async{
    orderList =  await CustomHttp().fetchOrderData();
    notifyListeners();
  }
}