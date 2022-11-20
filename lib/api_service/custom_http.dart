import 'package:ecommerceapiapp/widget/const.dart';
import 'package:http/http.dart' as http;


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
      showInToast("Invalid emial of password");
      return "Something is Wrong";
    }
  }

}