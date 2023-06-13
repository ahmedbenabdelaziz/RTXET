import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
class ApiPfeBook {




  Future<void> postpfebook(String soc, String desc, File file,descc,token) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://192.168.1.13/ISIMM_eCampus/public/api/ajouter_pfeBook'),
    );

    request.fields['societe'] = soc;
    request.fields['titre'] = desc;
    request.fields['description'] = descc;

    var headers = {
      'Authorization': 'Bearer ${token}',
      'Accept': 'application/json',
    };

    request.headers.addAll(headers);
print('object');
    if (file != null) {
      request.files.add(await http.MultipartFile.fromPath('rapport', file.path));
    }

    var response = await request.send();
    String responseBody = await response.stream.bytesToString();
    var errorJson = json.decode(responseBody);
    if (response.statusCode == 200) {
      print('Annonce postée avec succès');
    } else {
      print(response.statusCode);
      print(errorJson);
    }
  }

  Future<void> deletepfebook(int annonceId,token) async {

    final response = await http.delete(
      Uri.parse('http://192.168.1.13/ISIMM_eCampus/public/api/supprimer_pfeBook/${annonceId}'),
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


  UpdatePfeBook(String titre,String description,  idannonce,token) async {
    http.Response response = await http.patch(Uri.parse(
        "http://192.168.1.13/ISIMM_eCampus/public/api/update_pfeBook/${idannonce}?titre=${titre}&description=${description}"),
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