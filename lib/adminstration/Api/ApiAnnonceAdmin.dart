/*import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
class ApiAnnonceAD {





  Future<void> deleteAnnouncement(int annonceId) async {

    final response = await http.post(
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


  UpdateAnnonce(String description, int idannonce) async {
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

  LikeAnnonce(idAnnonce) async {
    http.Response response = await http.post(Uri.parse("http://192.168.1.13/ISIMM_eCampus/public/api/like/$idAnnonce",
    ),
        headers: {
          'Authorization': 'Bearer 8|vPWnz3i58JNfNRHMYL2w48bS5KFjkxgvgFFqYVbd',
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


  void DisLikeAnnonce(idAnnonce)async{
    http.Response response = await http.post(Uri.parse("http://192.168.1.13/ISIMM_eCampus/public/api/deslike/1"),
        headers: {
          'Authorization': 'Bearer 8|vPWnz3i58JNfNRHMYL2w48bS5KFjkxgvgFFqYVbd',
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

}*/