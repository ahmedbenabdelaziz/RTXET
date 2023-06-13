import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
class ApiComment {

  Future<List<dynamic>> GetCommantaire(ide,token) async {
      http.Response response = await http.get(Uri.parse("http://192.168.1.13/ISIMM_eCampus/public/api/remarques?matiere_id=${ide}&classe_id=1"),
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer ${token}',
        }
    );
    var data = jsonDecode(response.body)['remarques'];
    if (response.statusCode == 200) {
      print(data.reversed.toList());
    return data;
    } else {
      print(response.statusCode);
      return data.reversed.toList();


    }
  }

  AjouterCommantaire(String cmntr,desc,token,int ide,) async {
      http.Response response = await http.post(Uri.parse("http://192.168.1.13/ISIMM_eCampus/public/api/ajouter_remarque?matiere_id=${ide}&classe_id=1"),
        body:
            {
              'description': desc,
              'titre': cmntr,
            },

        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer ${token}',
        }
    );
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print("Commanaire ajuter");
      print(data);
    } else {
      print(data);

    }
  }


  UpdateCommantaire(String cmntr,desc,int id,token) async {
    http.Response response = await http.post(Uri.parse("http://192.168.1.13/ISIMM_eCampus/public/api/update_remarque/${id}"),
    body: {
      'description': desc,
      'titre': cmntr,
    },
      headers: {
        'accept': 'application/json',
        'Authorization': 'Bearer ${token}',
      }
    );
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print(data);
    } else {
      print(response.statusCode);
      print(data);
    }
  }


    DeleteCommantaire(int id,token,ide) async {
      http.Response response = await http.delete(
          Uri.parse("http://192.168.1.13/ISIMM_eCampus/public/api/supprimer_remarques/"+ id.toString() +"?matiere_id=${ide}&classe_id=1"),
      headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer ${token}',
      }
      );

      var data = jsonDecode(response.body);
      if (response.statusCode == 200 ) {
        print(data);
      } else {
        print("s");
        print(data);
      }
    }}
