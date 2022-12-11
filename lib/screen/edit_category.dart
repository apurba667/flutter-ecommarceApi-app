import 'dart:convert';
import 'dart:io';

import 'package:ecommerceapiapp/api_service/custom_http.dart';
import 'package:ecommerceapiapp/model/category_model.dart';
import 'package:ecommerceapiapp/widget/const.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:http/http.dart' as http;
class EditCategory extends StatefulWidget {
  EditCategory({Key? key,required this.categoryModel}) : super(key: key);
  CategoryModel ?categoryModel;

  @override
  State<EditCategory> createState() => _EditCategoryState();
}

class _EditCategoryState extends State<EditCategory> {
  TextEditingController? nameController;
  @override
  void initState() {
    nameController=TextEditingController(
      text: widget.categoryModel!.name
    );
    // TODO: implement initState
    super.initState();
  }
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
  Future updateCategory() async{
    var link = Uri.parse("${baseUrl}api/admin/category/${widget.categoryModel!.id}/update");
    var request = http.MultipartRequest("POST",link);
    request.headers.addAll(await CustomHttp().getHeaderWithToken());
    request.fields["name"]=nameController!.text.toString();
    if(icon != null){
      var iconPhoto = await http.MultipartFile.fromPath("icon",icon!.path);
      request.files.add(iconPhoto);
    }
    if(image !=null){
      var imagePhoto = await http.MultipartFile.fromPath("image",image!.path);
      request.files.add(imagePhoto);
    }
    setState(() {
      isVisible = true;
    });
    var responce = await request.send();
    setState(() {
      isVisible = false;
    });
    //multiPartRequest byte akare responce dey oita receive kore then string a convert korte hobe
    //status code 200 for normal login mane thik ache
    // but here status code 201 for registration
    var responceData = await responce.stream.toBytes();
    var responceString = String.fromCharCodes(responceData);
    var data = jsonDecode(responceString);
    print("jjjjjjjjjjjjjjjjjjjjjjjjjj$data");
    if(responce.statusCode == 200){
      showInToast("Successful");
      Navigator.of(context).pop();
    }
    else{
      showInToast("Unsuccessfull try again");
    }
  }
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isVisible,
      opacity: 0.1,
      blur: 0.1,
      progressIndicator: spinkit,
      child: Scaffold(
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
                            child: Image.network("https://apihomechef.antopolis.xyz/images/${widget.categoryModel!.icon}")
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
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text("Cover Image"),
                  Stack(
                    children: [
                      Container(
                          height: 320,
                          width: 400,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: image==null?InkWell(
                            onTap: (){
                              getImageGallery();
                            },
                            child: Image.network("https://apihomechef.antopolis.xyz/images/${widget.categoryModel!.image}")
                          ):Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit:BoxFit.cover,
                                  image: FileImage(image!),
                                )
                            ),
                          )
                      ),

                    ],
                  ),
                  Center(child: ElevatedButton(onPressed: (){
                    updateCategory();
                  }, child: Text(("Update Category"))))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
