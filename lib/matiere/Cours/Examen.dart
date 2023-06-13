import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:pdf/pdf.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'ApiCou/Api/apiexamen.dart';
import 'Td.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
class Examen extends StatefulWidget {
  final int id;
  final int matid;
  final String type;

  final String token;
  const Examen({Key? key, required this.id, required this.token, required this.matid, required this.type}) : super(key: key);

  @override
  State<Examen> createState() => _ExamenState();
}

class _ExamenState extends State<Examen> {
  ExamenApi c =new ExamenApi();
  late String token;
  List? ListCours ;
  TextEditingController descchapitre=TextEditingController();
  TextEditingController nomchap=TextEditingController();
  TextEditingController titre=TextEditingController();
  TextEditingController description=TextEditingController();
  TextEditingController titre2=TextEditingController();
  TextEditingController description2=TextEditingController();
  TextEditingController cmntr=TextEditingController();
  String filecours=" ";
  String filecour=" ";
  late int idd;
  late String type;

  PickCours()async{
    final fil =await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf','jpg','png']
    );
    if(fil!=null){
      setState(() {
        filecours=fil.files.single.path!;
        filecour = (filecours != null ? filecours.substring(filecours.lastIndexOf("/") + 1) : null)!;
        print(filecour);
        print('00');
      });
    }
  }
  ReceivePort _port = ReceivePort();
late int matid;
  late StreamController<List<dynamic>> _streamController ;
  late Stream<List<dynamic>> stream;
  Future<Map<String, dynamic>> GetExamen(token) async {
    http.Response response = await http.get(Uri.parse("http://192.168.1.13/ISIMM_eCampus/public/api/examens?matiere_id=${matid}&classe_id=1"),
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer ${token}',
        }
    );
    var data = jsonDecode(response.body)as Map<String,dynamic>;
    if (response.statusCode == 200) {
      print("e");
      print(data);
     return data;
    } else {
      print("d");
      print(response.statusCode);
      print(data);
//      _streamController.add(data.reversed.toList());
  return data;
    }
  }
  Future<String> downloadExamen(String filename) async {
    try {
      http.Response response = await http.get(
        Uri.parse(
            'http://192.168.1.13/ISIMM_eCampus/public/api/telecharger_pfeBook?filename=gy43QsYruLlEqaPpUtKC'),
        headers: {
          'Authorization': 'Bearer ${token}',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final baseStorage = await getExternalStorageDirectory();
        File file = File('${baseStorage!.path}/$filename');
        await file.writeAsBytes(response.bodyBytes);
        print(file);
        print("ok");
        return file.path;
      } else {
        print("Erreur de téléchargement : ${response.statusCode}");
        return 'Erreur de téléchargement : ${response.statusCode}';
      }
    } catch (e) {
      print('Erreur de téléchargement : $e');
      return 'Erreur de téléchargement : $e';
    }
  }

  Future<void> download(String url) async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      final baseStorage = await getExternalStorageDirectory();
      await FlutterDownloader.enqueue(
        url: url,
        headers: {}, // optional: headers send with the url (auth token, etc.)
        savedDir: baseStorage!.path,
        showNotification: true, // show download progress in the status bar (for Android)
        openFileFromNotification: true, // click on notification to open the downloaded file (for Android)
      );
    }
  }


  @override
  void initState() {
    token=widget.token;
    matid=widget.matid;
    type=widget.type;
    print(token);
    GetExamen(token);
    IsolateNameServer.registerPortWithName(_port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = DownloadTaskStatus(data[1]);
      int progress = data[2];
      if(status==DownloadTaskStatus.complete){
        print("download complete");
      }
      setState((){ });
    });

    FlutterDownloader.registerCallback(downloadCallback);
    super.initState();
    setState(() {
      idd=widget.id;
      _streamController =  StreamController.broadcast();;
      stream =_streamController.stream;
      GetExamen(token);
    });
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    _streamController.close();
    super.dispose();
  }
  @pragma('vm:entry-point')
  static void downloadCallback(String id, int status, int progress) {
    final SendPort? send = IsolateNameServer.lookupPortByName('downloader_send_port');
    send!.send([id, status, progress]);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 32,
            color: Colors.white,
          ),
          Container(
            padding: EdgeInsets.only(right: 10,left:10,top: 20),
            height:270,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40),bottomRight: Radius.circular(40)),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF012869),Color(0xFF012869),
                    ]
                )
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Row(
                              children: [
                                IconButton(onPressed:(){
                                  Navigator.push(context,MaterialPageRoute(builder:(context)=>Examen(id: idd, token:token, matid: matid, type: type,)));
                                }, icon:Icon(Icons.arrow_back,color: Colors.white,)),
                                Text('Espace Examen',style:TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                              ],
                            ),
                            SizedBox(width: 150,),
                            Icon(Icons.notifications,color: Colors.white,)
                          ],
                        ),
                        SizedBox(height: 10,),
                        Container(
                          height: 50,
                          width: 350,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white.withOpacity(0.08)
                          ),
                          child: TextFormField(
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.search,color: Colors.white,)
                                ,
                                border: InputBorder.none
                                ,
                                hintText: "Recherche Examen ...",
                                hintStyle:TextStyle(
                                    color: Colors.white
                                )
                            ),
                          ),
                        )
                      ],
                    ),

                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Image.asset('lib/matiere/Cours/image/1362248.png',fit: BoxFit.contain,),
                            )),
                        SizedBox(height: 10,),
                        TextButton(
                            onPressed:(){}
                            ,child: Text('TD',style:TextStyle(color:Color(0xFFc2daee),fontWeight: FontWeight.bold,fontSize: 20),))
                      ],
                    ),
                    SizedBox(width: 10,),
                    SizedBox(width: 10,),
                    Column(
                      children: [
                        Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Image.asset('lib/matiere/Cours/image/760205.png',fit: BoxFit.contain,),
                            )),
                        SizedBox(height: 10,),
                        TextButton(
                            onPressed:(){}
                            ,child: Text('Cours',style:TextStyle(color:Color(0xFFc2daee),fontWeight: FontWeight.bold,fontSize: 20),))
                      ],
                    ),
                    SizedBox(width: 8,),
                    Column(
                      children: [
                        Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Image.asset('lib/matiere/Cours/image/1263925.png',fit: BoxFit.contain,),
                            )),
                        SizedBox(height: 10,),
                        TextButton(
                            onPressed:(){}
                            ,child: Text('Other Files',style:TextStyle(color:Color(0xFFc2daee),fontWeight: FontWeight.bold,fontSize: 20),))
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          Expanded(child:Container(

            child: StreamBuilder<Map<String,dynamic>>(
              stream:Stream.fromFuture(GetExamen(token)),
              builder: (BuildContext context, AsyncSnapshot<Map<String,dynamic>> snapshot) {

               if (!snapshot.hasData) {
    return Center(child: Text("Pas d'examen Pour le moment"));
    } else if (snapshot.hasError) {
    return Text("${snapshot.error}");
    } else {
                  List<dynamic> examen = snapshot.data!['examens'];
                  print(examen);
                  // utilise la méthode reversed() pour inverser l'ordre des commentaires
                  return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount:examen.length
                      ,itemBuilder:(context,id){
                    return Container(
                      margin: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Colors.grey.withOpacity(0.07),
                                Colors.grey.withOpacity(0.09),
                              ]
                          ),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: ListTile(
                        leading:CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 20,
                            child: Image.asset('lib/matiere/Cours/image/format-de-fichier-pdf.png')),
                        subtitle: Text(examen[id]['titre']),
                        title:Text(examen[id]['description'],style:TextStyle(fontWeight: FontWeight.bold),),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            type=="enseignant"?        PopupMenuButton(itemBuilder: (BuildContext context)=>[
                          PopupMenuItem(value: 'modifier', child: Text('Modifier')),
                      PopupMenuItem(value: 'supprimer', child: Text('Supprimer')),
                      ],
                            onSelected:(value){
                              if(value=='supprimer'){
                                print(examen[id]['id']);
                               c.DeleteExamen(examen[id]['id'],token,matid);
                              }else if (value=='modifier') {
                                print('modifier');
                                final tita2 = TextEditingController(
                                    );
                                final desca2 = TextEditingController(
                                    );
                                showDialog(
                                    context: context, builder: (context) {
                                  return AlertDialog(
                                    content: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 20),
                                      height: 320,
                                      width: 100,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Text("Titre d'examen"),
                                          SizedBox(height: 3,),
                                          TextFormField(
                                            controller: desca2,
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                    borderRadius: BorderRadius
                                                        .circular(10),
                                                    borderSide: BorderSide(
                                                        color: Colors.blue
                                                    )
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius
                                                        .circular(10),
                                                    borderSide: BorderSide(
                                                        color: Colors.blue
                                                    )
                                                ),
                                                hintText: ('nom du chapitre...')
                                            ),
                                          ),
                                          SizedBox(height: 10,),
                                          Text("Desciption d'examen"),
                                          SizedBox(height: 3,),
                                          TextFormField(
                                            controller: tita2,
                                            maxLines: 2,
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                    borderRadius: BorderRadius
                                                        .circular(10),
                                                    borderSide: BorderSide(
                                                        color: Colors.blue
                                                    )
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius
                                                        .circular(10),
                                                    borderSide: BorderSide(
                                                        color: Colors.blue
                                                    )
                                                ),
                                                hintText: ('description examen...')
                                            ),
                                          ),
                                          SizedBox(height: 25,),
                                          ElevatedButton(onPressed: () {

                                            print("dddf");
                                            c.UpdateExamen(tita2.text, desca2.text,token,examen[id]['id'],matid.toString());
                                            GetExamen(token);
                                            print(examen[id]['id']);
                                            Navigator.pop(context, null);
                                          }, child: Center(
                                              child: Text('Modifier Examen')))
                                        ],
                                      ),
                                    ),
                                  );
                                });
                              }
                            },):Text(' '),
                            CircleAvatar(
                              backgroundColor: Colors.grey.withOpacity(0.05),
                              radius: 13,
                              child: IconButton(icon:Icon(Icons.download),onPressed:() async {
                                print(examen[id]['file'].substring(0, examen[id]['file'].length - 4));
                                c.downloadFile(examen[id]['file'].substring(0, examen[id]['file'].length - 4));

                              },),
                            )
                          ],
                        ),
                      ),
                    );
                  });}
                }

            ),
          ))
        ],
      ),
      floatingActionButton: Visibility(
        visible: type=="enseignant",
        child: CircleAvatar(
          backgroundColor:Color(0xFF3b4790),
          child: IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Container(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        height: 400,
                        width: 100,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Titre d'examen"),
                            SizedBox(height: 5,),
                            TextFormField(
                              controller: description,
                              decoration: InputDecoration(
                                  hintText: ("nom d'examen...")
                              ),
                            ),
                            SizedBox(height: 30,),
                            Text("Description d'examen"),
                            SizedBox(height: 5,),
                            TextFormField(
                              controller: titre,
                              decoration: InputDecoration(
                                  hintText: ("Description d'Examen...")
                              ),
                            ),
                            SizedBox(height: 5,),
                            TextButton(
                                onPressed: () {
                                  PickCours();
                                },
                                child: Text('Téléverser Examen')
                            ),
                            SizedBox(height: 5,),
                            Text(filecour ?? ''),
                            SizedBox(height: 30,),
                            ElevatedButton(
                              onPressed: () {
                                c.PostTd(titre.text, description.text,File(filecours),token,matid);
                             GetExamen(token);
                              Navigator.of(context).pop(null);
                              },
                              child: Center(
                                  child: Text('Ajouter Examen')
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }
              );
            },
            icon: Icon(Icons.add),
            color: Colors.white,
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor:Color(0xFF012869),
        selectedItemColor: Colors.red,
        unselectedItemColor: Color(0xFF385b9f),
        items: [
          BottomNavigationBarItem(icon:Icon(Icons.home),label: "Acceuil"),
          BottomNavigationBarItem(icon:IconButton(onPressed: (){
            //      Navigator.of(context).push(MaterialPageRoute(builder:(context)=>ChatUi()));
          },icon:Icon(Icons.message)),label: "chat"),
          BottomNavigationBarItem(icon:IconButton(onPressed: (){
            //   Navigator.of(context).push(MaterialPageRoute(builder:(context)=>Screen()));
          },icon:Icon(Icons.info_outline)),label: "About"),
          BottomNavigationBarItem(icon:IconButton(onPressed: (){
            //Navigator.of(context).push(MaterialPageRoute(builder:(context)=>EditProfile(img: 'f', nom: nom, token: token, prenom: prenom, email: email, date_de_naissance: date_de_naissance, telephone: telephone, image: image,)));
          },icon:Icon(Icons.settings)),label: "settings"),

        ],
      ),
    );
  }
}
