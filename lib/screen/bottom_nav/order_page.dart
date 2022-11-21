
import 'package:ecommerceapiapp/api_service/custom_http.dart';
import 'package:ecommerceapiapp/model/order_model.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  bool isLoading = false;
  List<OrderModel> orderList = [];
  @override
  void didChangeDependencies() async{
    setState(() {
        isLoading = true;
    });
    orderList = await CustomHttp().fetchOrderData();
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    setState(() {
    isLoading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Page"),
      ),
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        progressIndicator: CircularProgressIndicator(),
        blur: 1,
        child: Container(
          child: ListView.builder(
              itemCount: orderList.length,
              shrinkWrap: true,
              itemBuilder: (context,index){
              return ListTile(
                title: Text("${orderList[index].orderStatus!.orderStatusCategory!.name}"),
              );
          }),
        ),
      ),
    );
  }
}
