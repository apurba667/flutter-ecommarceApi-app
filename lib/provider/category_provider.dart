import 'package:ecommerceapiapp/api_service/custom_http.dart';
import 'package:ecommerceapiapp/model/category_model.dart';

import 'package:flutter/material.dart';


class CategoryProvider with ChangeNotifier{
  List<CategoryModel> categoryList=[];

  Future getCategoryData()async{
    categoryList =  await CustomHttp().fetchCategoryData();
    notifyListeners();

  }
}