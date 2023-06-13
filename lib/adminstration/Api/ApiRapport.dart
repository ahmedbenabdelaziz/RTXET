import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
class ApiRapport {




  Future<void> postRapport(String titre,descrip,annee,File rapport,token) async {
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'http://192.168.1.13/ISIMM_eCampus/public/api/ajouter_rapport'));

    request.fields['titre'] = titre;
    request.fields['annee'] = annee;
    request.fields['description'] = descrip;

    var headers = {
      'Authorization': 'Bearer ${token}',
      'Accept': 'application/json'

    };

    request.headers.addAll(headers);

    if (rapport != null) {
      request.files.add(await http.MultipartFile.fromPath('rapport', rapport.path));
    }

    var response = await request.send();
    String responseBody = await response.stream.bytesToString();
    var errorJson = json.decode(responseBody);
    if (response.statusCode == 200) {
      print('Annonce postée avec succès');
    } else {
      print(errorJson);
    }
  }

  Future<void> deleteRapport(int annonceId,token) async {

    final response = await http.delete(
      Uri.parse('http://192.168.1.13/ISIMM_eCampus/public/api/supprimer_rapport/${annonceId}'),
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


  UpdateRapport(String titre,String description,  idannonce,token) async {
    http.Response response = await http.patch(Uri.parse(
        "http://192.168.1.13/ISIMM_eCampus/public/api/update_rapport/${idannonce}?titre=${titre}&description=${description}"),
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



}