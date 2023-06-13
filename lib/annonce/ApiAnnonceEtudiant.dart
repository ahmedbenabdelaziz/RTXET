import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
class ApiAnnonceEtudiant {



  Future<void> postAnnonce(String post, image, token) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'http://192.168.1.13/ISIMM_eCampus/public/api/etudiant/ajouter_annonce'),
    );

    request.fields['description'] = post;
    request.fields['titre'] = post;

    var headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };

    request.headers.addAll(headers);

    if (image != null) {
      request.files.add(await http.MultipartFile.fromPath('image', image));
    }

    var response = await request.send();
    var responseString = await response.stream.bytesToString();
    var jsonResponse = jsonDecode(responseString);

    if (response.statusCode == 200) {
      print(jsonResponse);
    } else {
      print(jsonResponse);

    }
  }
  Future<void> deleteAnnouncement(int annonceId,token) async {

    final response = await http.delete(
      Uri.parse('http://192.168.1.13/ISIMM_eCampus/public/api/supprimer_annonce/$annonceId'),
      headers: {
        'Authorization': 'Bearer ${token}',
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('Announcement deleted successfully');
      print(data);
    } else {
      print('An error occurred while deleting the announcement');
      print(response.body);
    }

  }


  UpdateAnnonce(String description, int idannonce,token) async {
    http.Response response = await http.post(Uri.parse(
        "http://192.168.1.13/ISIMM_eCampus/public/api/update_annonce/${idannonce}"),
        body: {
          'description': description,
        },
        headers: {
          'Authorization': 'Bearer ${token}',
          'Accept': 'application/json'
        }
    );
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print("Update avec succes");

      print(data);
    } else {
      print(data);
    }
  }

  LikeAnnonce(idAnnonce,token) async {
    http.Response response = await http.post(Uri.parse("http://192.168.1.13/ISIMM_eCampus/public/api/like/$idAnnonce",
    ),
        headers: {
          'Authorization': 'Bearer ${token}',
          'Accept': 'application/json'
        });
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {

    } else {
      print("erruuur");
      print(response.statusCode);
      print(data);
    }
  }


  void DisLikeAnnonce(idAnnonce,token)async{
    http.Response response = await http.post(Uri.parse("http://192.168.1.13/ISIMM_eCampus/public/api/deslike/$idAnnonce"),
        headers: {
          'Authorization': 'Bearer ${token}',
          'Accept': 'application/json'
        });
    var data =jsonDecode( response.body);
    if(response.statusCode==200){
      print("ok");
      print(data);

    }else{
      print("erruuur");
      print(response.statusCode);
      print(data);

    }
  }

}