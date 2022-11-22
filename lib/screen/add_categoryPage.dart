import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class AddCategoryPage extends StatefulWidget {
  const AddCategoryPage({Key? key}) : super(key: key);

  @override
  State<AddCategoryPage> createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  TextEditingController nameController = TextEditingController();
  String? fileName;
  bool isVisible = false;
  final _fromkey = GlobalKey<FormState>();
  File? icon,image;
  final picker = ImagePicker();
  Future getIconGallery()async{
    print("On the way of Gallary");
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if(pickedImage!=null){
        icon = File(pickedImage.path);
        print("Image founf");
        print("$icon");
      }
      else{
        print("No image found");
      }

    }
    );
  }
  Future getImageGallery()async{
    print("On the way of Gallary");
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if(pickedImage!=null){
        image = File(pickedImage.path);
        print("Image founf");
        print("$image");

      }
      else{
        print("No image found");
      }

    }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add new Category"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
        child: SingleChildScrollView(
          child: Form(
            key: _fromkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Category name"),
                SizedBox(height: 10,),
                TextFormField(
                  controller: nameController,
                  onSaved: (name){
                    fileName = name;
                  },validator: (value){
                    if(value!.isEmpty){
                      return "Write Category Name";
                    }
                    if(value.length<3){
                      return"Write more then three words";
                    }

                },decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    gapPadding: 5,
                    borderSide: BorderSide(color: Colors.cyan),

                  ),
                  hintText: "Enter Category Name"
                ),
                ),
                SizedBox(height: 10,),
                Text("Category Icon"),
                SizedBox(height: 10,),
                Stack(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: icon==null?InkWell(
                        onTap: (){
                          getIconGallery();
                        },
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.image,color: Colors.red,size: 40,),
                              Text("Upload")

                            ],
                          ),
                        ),
                      ):Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit:BoxFit.cover,
                            image: FileImage(icon!),
                          )
                        ),
                      )
                    ),

                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
