import 'dart:convert';
import 'dart:io';
import 'dart:convert';
import 'dart:io';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' as http;
class TdApi{

  late List list;
  // envoie cours
  Future<void> _openPdf(String filePath) async {
    try {
      await OpenFile.open(filePath);
    } catch (e) {
      print('Failed to open PDF: $e');
    }
  }

  Future<File?> downloadFile(String filename) async {
    final String fileUrl =
        'http://192.168.1.13/ISIMM_eCampus/public/api/download_exercices?filename=${filename}';

    var httpClient = http.Client();

    var request = http.Request('GET', Uri.parse(fileUrl));
    request.headers['Authorization'] =
    'Bearer 28|sf0P9jkN6WnwYmaxj9XSvhVDIh7KsTjxo1MCAvcl';
    request.headers['Accept'] = 'application/pdf';

    var response = await httpClient.send(request);

    var httpResponse = await http.Response.fromStream(response);

    var bytes = httpResponse.bodyBytes;
    var contentType = httpResponse.headers['content-type'];
    if (contentType != 'application/pdf') {
      var responseBody = utf8.decode(bytes);
      var jsonResponse = jsonDecode(responseBody);
      var errorMessage = jsonResponse['message'];
      print('Erreur: $errorMessage');
      return null;
    }

    Directory? downloadsDir = await getExternalStorageDirectory();
    String downloadsPath = downloadsDir!.path;

    String filePath = '$downloadsPath/$filename.pdf';
    File file = new File(filePath);
    await file.writeAsBytes(bytes);

    await _openPdf(file.path);

    httpClient.close();

    return file;
  }
  Future<void> PostTd(String title, String subtitle, File pdf,token,matid ) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse("http://192.168.1.13/ISIMM_eCampus/public/api/upload_exercice"),
    );

    request.headers['Authorization'] = 'Bearer ${token}';
    request.headers['Content-type'] = 'application/json';
    request.headers['Accept'] = 'application/json';

    request.fields['titre'] = subtitle;
    request.fields['description'] = title;
    request.fields['matiere_id'] = matid;
    request.fields['classe_id'] = '1';

    var fichierStream = http.ByteStream(Stream.castFrom(pdf.openRead()));
    var fichierlength = await pdf.length();
    var uploadFileRequest = http.MultipartFile(
      'file',
      fichierStream,
      fichierlength,
      filename: '$title.pdf',
    );
    request.files.add(uploadFileRequest);

    var response = await request.send();
    var responseString = await response.stream.bytesToString();
    var decodedJson = jsonDecode(responseString);
    if (response.statusCode == 200) {
      print("File Uploaded");

      // Decode the response body

      print(decodedJson);
    } else {
      print(response.statusCode);
      print(decodedJson);

      print("Error");
    }
  }

  downloadTd(filename,token) async {
    String url = "";
    http.Response response = await http.get(Uri.parse(
        'http://192.168.1.25/ISIMM_eCampus/public/api/download_exercice?filename=H1654SBhg8VmuRecqNNL'),
        headers: {
          'Authorization': 'Bearer ${token}',
          'Accept': 'application/json'
        });
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print(data);
    } else {
      print(data);
    }
  }

  // Supprimer cours
  DeleteTd(idex, matid,token) async {
    String url = "";
    http.Response response = await http.post(Uri.parse(
        "http://192.168.1.13/ISIMM_eCampus/public/api/supprimer_exercice/${idex}?matiere_id=${matid}&classe_id=1"),
        headers: {
          'Authorization': 'Bearer ${token}',
          'Content-type': 'application/json',
          'Accept': 'application/json'
        }
    );
    var data = jsonDecode(response.body);
    if (response == 200) {
      print(data);
      return data;
    } else {
      print(data);
      return data;
    }
  }

  //Update cours
  UpdateTd(String title, String subtitle,id,token,matierid) async {
    http.Response response = await http.post(Uri.parse(
        "http://192.168.1.13/ISIMM_eCampus/public/api/update_exercice/${id}?matiere_id=${matierid}&classe_id=1"),
        body: {
          'titre': title,
          'description': subtitle,
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