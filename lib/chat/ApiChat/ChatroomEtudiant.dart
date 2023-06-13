
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
class ApiChatEtudiantt {


  enregistrerMsg(String msg, int chatId) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer 34|5swDq3pxoOYX1ZuAeCovj2DW10pjUyr73BXh9uXC',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    final response = await http.post(
      Uri.parse('http://192.168.1.13/ISIMM_eCampus/public/api/messages'),
      headers: headers,
      body: json.encode({
        'chat_id': 4,
        'text': "dfdsfdsf",
      }),
    );

    final jsonData = json.decode(response.body) as Map<String, dynamic>;
    if (response.statusCode == 200) {
      print("enregistre");
      print(jsonData);
    } else {
      print(" non enregistre");
      print(jsonData);
    }
  }

  Future<List<dynamic>> getMsg() async {
    Map<String, String> headers = {
      'Authorization': 'Bearer 34|5swDq3pxoOYX1ZuAeCovj2DW10pjUyr73BXh9uXC',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    final response = await http.get(
      Uri.parse('http://192.168.1.13/ISIMM_eCampus/public/api/messages/4'),
      headers: headers,
    );
    final jsonData = json.decode(response.body)['messages'] as List<dynamic>;
    if (response.statusCode == 200) {
      print('1');
      print(jsonData);
      print("1");
      return jsonData;
    } else {
      return jsonData;
      throw Exception('Failed to load data');
    }
  }


  getChat()async{
    http.Response response = await http.get(Uri.parse('http://192.168.1.13/ISIMM_eCampus/public/api/enseignants'));
    if(response.statusCode==200){
      var data = jsonDecode(response.body);
      print("ok");
      print(data);
    }else{
      print(response.statusCode);
      return jsonDecode(response.body);
    }
  }



  Future<void> deleteEnseignant(int ense) async {

    final response = await http.delete(
      Uri.parse('http://192.168.1.13/ISIMM_eCampus/public/api/supprimer_enseignant/$ense'),
      headers: {
        'Authorization': 'Bearer 8|vPWnz3i58JNfNRHMYL2w48bS5KFjkxgvgFFqYVbd',
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




}