import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class ApiUser{
 List<String>? message;

  Future<Map<String,dynamic>> LoginUser(String email,String password) async {
    http.Response response = await http.post(Uri.parse("https://192.168.1.13/ISIMM_eCampus/public/api/login"),
         body : jsonEncode({
        'email': email,
        'password': password,
        }),
        headers: {
          'content-type':'application/json',
          'accept':'application/json',
        }
    );
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print(data);
      return data;
    } else {
      return data;
    }
  }


  RegistreUserEnseignant(String nom, String prenom, String email, String password, String date, String telephone, File image,String departement) async {
   try {
     var headers = {
       'Accept': 'application/json'
     };

     var request = http.MultipartRequest(
       'POST',
       Uri.parse('http://192.168.1.13/ISIMM_eCampus/public/api/register_enseignant'),
     );
     request.headers.addAll(headers);

     var imageStream = http.ByteStream(image.openRead());
     var imageLength = await image.length();
     var imageUploadRequest = http.MultipartFile(
       'image',
       imageStream,
       imageLength,
       filename: basename(image.path),
     );
     request.files.add(imageUploadRequest);

     request.fields['name'] = nom;
     request.fields['prenom'] = prenom;
     request.fields['email'] = email;
     request.fields['password'] = password;
     request.fields['password_confirmation'] = password;
     request.fields['date_de_naissance'] = date;
     request.fields['telephone'] = telephone;
     request.fields['departement'] = departement;

     print("1");
     var response = await request.send();
     if (response.statusCode == 200) {
       print("2");
       String responseText = await response.stream.bytesToString();
       Map<String, dynamic> responseData = jsonDecode(responseText);
       print(responseData);
       return responseData['message'];
     } else {
       String responseText = await response.stream.bytesToString();
       Map<String, dynamic> responseData = jsonDecode(responseText);
       print("3");
       print(responseData['message']);
       return responseData['message'];


     }
   } catch (e) {
     print("eee");
   }
 }


 RegistreUserEtudiant(String nom, String prenom, String email, String password, String date, String telephone, File image,String departement) async {
   try {
     var headers = {
       'Accept': 'application/json'
     };

     var request = http.MultipartRequest(
       'POST',
       Uri.parse('http://192.168.1.13/ISIMM_eCampus/public/api/register_enseignant'),
     );
     request.headers.addAll(headers);

     var imageStream = http.ByteStream(image.openRead());
     var imageLength = await image.length();
     var imageUploadRequest = http.MultipartFile(
       'image',
       imageStream,
       imageLength,
       filename: basename(image.path),
     );
     request.files.add(imageUploadRequest);

     request.fields['name'] = nom;
     request.fields['prenom'] = prenom;
     request.fields['email'] = email;
     request.fields['password'] = password;
     request.fields['password_confirmation'] = password;
     request.fields['date_de_naissance'] = date;
     request.fields['telephone'] = telephone;
     request.fields['departement'] = departement;

     print("1");
     var response = await request.send();
     if (response.statusCode == 200) {
       print("2");
       String responseText = await response.stream.bytesToString();
       Map<String, dynamic> responseData = jsonDecode(responseText);
       print(responseData);
       return responseData['message'];
     } else {
       String responseText = await response.stream.bytesToString();
       Map<String, dynamic> responseData = jsonDecode(responseText);
       print("3");
       print(responseData['message']);
       return responseData['message'];


     }
   } catch (e) {
     print("eee");
   }
 }

}