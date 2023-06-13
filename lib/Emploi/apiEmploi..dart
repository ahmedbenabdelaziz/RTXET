import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;


class ApiAnnonce {


  Future<Map<String, dynamic>> getEmploi() async {
    Map<String, String> headers = {
      'Authorization': 'Bearer 29|5hgVXla4KfqX6kArbvLDElBtabsbh3rIr4nrwRai',
      'Accept': 'application/json',

    };

    HttpClient client = new HttpClient()
      ..badCertificateCallback =
      ((X509Certificate cert, String host, int port) => true);
    final response = await http.get(
      Uri.parse('https://192.168.1.13/ISIMM_eCampus/public/api/annonces'),
      headers: headers,
    );
    print("k");
    var data = jsonDecode(response.body) as Map<String,dynamic>;
    if (response.statusCode == 200) {
      print('z');
      print(data);
      return data;
    } else {
      return data;
    }
  }




}