
import 'package:ecommerceapiapp/api_service/custom_http.dart';
import 'package:ecommerceapiapp/model/order_model.dart';
import 'package:ecommerceapiapp/provider/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  void initState() {
    Provider.of<OrderProvider>(context,listen: false).getOrderData();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    var orderList = Provider.of<OrderProvider>(context).orderList;

    return Scaffold(
      appBar: AppBar(
        title: Text("Order Page"),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: orderList.length,
            shrinkWrap: true,
            itemBuilder: (context,index){
            return ListTile(
              title: Text("${orderList[index].orderStatus!.orderStatusCategory!.name}"),
            );
        }),
      ),
    );
  }
}
