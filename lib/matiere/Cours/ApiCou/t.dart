import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

typedef DownloadProgress = void Function(int total, int downloaded, double progress);

class HttpDownloader {
  static Future<void> download(String url, DownloadProgress progressCallback) async {
    String token = 'Bearer 29|5hgVXla4KfqX6kArbvLDElBtabsbh3rIr4nrwRai';
    final completer = Completer<void>();
    final client = http.Client();
    final request = http.Request('GET', Uri.parse(url));
    request.headers['Authorization'] = token;
    final response = await client.send(request);
    int downloadedBytes = 0;
    int totalBytes = response.contentLength ?? 0;
    List<List<int>> chunkList = [];

    response.stream.listen(
          (List<int> chunk) {
        chunkList.add(chunk);
        downloadedBytes += chunk.length;
        double progress = (downloadedBytes / totalBytes) * 100;
        progressCallback(totalBytes, downloadedBytes, progress);
      },
      onDone: () async {
        double progress = (downloadedBytes / totalBytes) * 100;
        progressCallback(totalBytes, downloadedBytes, progress);

        int start = 0;
        final bytes = Uint8List(totalBytes);
        for (var chunk in chunkList) {
          bytes.setRange(start, start + chunk.length, chunk);
          start += chunk.length;
        }

        await _saveFile(bytes, 'example.pdf'); // Specify the desired file name

        completer.complete();
      },
      onError: (error) => completer.completeError(error),
    );

    return completer.future;
  }

  static Future<void> _saveFile(Uint8List bytes, String fileName) async {
    final directory = await getExternalStorageDirectory();
    final filePath = '${directory!.path}/$fileName';
    final file = File(filePath);
    await file.writeAsBytes(bytes);
  }
}

class DownloadButton extends StatefulWidget {
  @override
  _DownloadButtonState createState() => _DownloadButtonState();
}

class _DownloadButtonState extends State<DownloadButton> {
  String url =
      'http://192.168.1.13/ISIMM_eCampus/public/api/download_cours?filename=bPFSJhq3zMFuP1spYFMB';
  bool downloading = false;
  int progress = 0;

  Future<void> startDownload() async {
    setState(() {
      downloading = true;
      progress = 0;
    });

    try {
      await HttpDownloader.download(url, (total, downloaded, progress) {
        setState(() {
          this.progress = progress.toInt();
        });
      });

      setState(() {
        downloading = false;
        progress = 100;
      });
      print('Download completed');
    } catch (error) {
      setState(() {
        downloading = false;
        progress = 0;
      });
      print('An error occurred during download: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Download'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: startDownload,
              child: Text('Download PDF'),
            ),
            SizedBox(height: 16),
            if (downloading)
              CircularProgressIndicator()
            else
              Text('Progress: $progress%'),
          ],
        ),
      ),
    );
  }
}