import 'package:ecommerceapiapp/provider/category_provider.dart';
import 'package:ecommerceapiapp/screen/add_categoryPage.dart';
import 'package:ecommerceapiapp/screen/edit_category.dart';
import 'package:ecommerceapiapp/widget/const.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  var _controller = ScrollController();
  @override
  void initState() {
    Provider.of<CategoryProvider>(context,listen: false).getCategoryData();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var categoryList = Provider.of<CategoryProvider>(context).categoryList;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Category page"
        ),
      ),
      body:  Container(

        child: ListView.builder(
            itemCount: categoryList.length,
            shrinkWrap: true,
            itemBuilder: (context,index){
              return Stack(
                children: [
                Positioned(child: Container(
                  height: 300,
                  width: double.infinity,

                  child: Column(
                    children: [
                      Expanded(
                      flex: 1
                          ,child: Container(
                        width: double.infinity,
                        child: Image.network("$imagelink${categoryList[index].image}",fit: BoxFit.cover,),
                      )),
                      Expanded(
                          flex: 1,
                          child: Container(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Center(
                                  child: Text("${categoryList[index].name}",style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue
                                  ),),
                                ),
                                SizedBox(height: 70,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    InkWell(
                                      onTap: (){
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EditCategory(
                                          categoryModel: categoryList[index],
                                        ))).then((value) => Provider.of<CategoryProvider>(context,listen: false).getCategoryData());
                                      },
                                      child: Container(
                                        child: Row(
                                          children: [
                                            Icon(Icons.edit),
                                            Text("Edit")
                                          ],
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: (){},
                                      child: Container(
                                        child: Row(
                                          children: [
                                            Icon(Icons.delete),
                                            Text("Delete")
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ))
                    ],
                  )
                )),
                  Positioned(
                    bottom: 110,
                      left: 290,
                      child: CircleAvatar(
                        radius: 35,
                    backgroundImage: NetworkImage("$imagelink${categoryList[index].icon}")
                  ))
                ],
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddCategoryPage()));
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddCategoryPage())).then((value) => Provider.of<CategoryProvider>(context,listen: false).getCategoryData());
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }
}