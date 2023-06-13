import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:expandable_text/expandable_text.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
class page3 extends StatefulWidget {
  const page3({Key? key}) : super(key: key);

  @override
  State<page3> createState() => _page3State();
}

class _page3State extends State<page3> {


  StreamController<Map<String, dynamic>> _streamController = StreamController.broadcast();
  Future<Map<String, dynamic>> getSoci() async {
    Map<String, String> headers = {
      'Authorization': 'Bearer 36|ugNikWUQdUZE4VsqM5GMknB0QIjd9vHZyTAnIHL4',
      'Accept': 'application/json',

    };

    HttpClient client = new HttpClient()
      ..badCertificateCallback =
      ((X509Certificate cert, String host, int port) => true);
    final response = await http.get(
      Uri.parse('http://192.168.1.13/ISIMM_eCampus/public/api/societes'),
      headers: headers,
    );
    var data = jsonDecode(response.body) as Map<String,dynamic>;
    if (response.statusCode == 200) {
      print('z');
      print(data);
      return data;
    } else {
      return data;
    }
  }

  @override
  void initState() {
    getSoci();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(height: 32,color: Colors.white,),
          Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xFF012869),
            ),
            child: Row(
              children: [
                IconButton(onPressed:(){}, icon:Icon(Icons.arrow_back,color: Colors.white,)),
                Text('Actualités',style:TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 20,letterSpacing: 1),),
                SizedBox(width: 200,),
                CircleAvatar(
                  backgroundImage:AssetImage('lib/students/iconacceuil/sdq.jpg'),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              child: StreamBuilder(
                stream: Stream.fromFuture(getSoci()),
                builder: (BuildContext context,AsyncSnapshot<Map<String,dynamic>> snapshot){
                  var  data = snapshot.data!;
                  List<dynamic> soc = snapshot.data!['sociétés'];
                  return  ListView.builder(
                      itemCount: soc.length,
                      itemBuilder:(context,id){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Divider(thickness: 2,),
                          Row(
                            children: [
                              Text(soc[id]['nom']+" :",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                              Text(soc[id]['adresse'],style:TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.blue),),
                            ],
                          ),
                         SizedBox(height: 3,),
                          Container(
                              height: 140,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Image.network("https://192.168.1.13/ISIMM_eCampus/storage/app/public/${soc[id]['image']}",fit: BoxFit.cover,)),
                          SizedBox(height: 10,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: ExpandableText(
                                soc[id]['a_propos'],
                                textAlign: TextAlign.left,
                                expandText: 'Read More',
                                maxLines: 4,
                                linkColor: Colors.blue,
                                style: TextStyle(fontSize: 15,
                                    fontWeight: FontWeight.w500,color: Colors.black,
                                    height: 1.4),
                              ),
                            ),
                          ),
                          Container(
                            height: 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: [
                                  CircleAvatar(
                                    radius: 25,
                                    backgroundColor: Colors.white,
                                    child: Icon(Icons.email_outlined),
                                  ),
                                 Text(soc[id]['site_web'])
                                ],)
                              ],
                            ),
                          ),
                          Divider(thickness: 2,)
                        ],
                      ),
                    ); /* Container(
                      margin: EdgeInsets.only(left: 10,right: 10,bottom: 10),
                      height: 320,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow:[
                            BoxShadow(
                                color: Colors.black.withOpacity(0.7),
                                spreadRadius: 0,
                                blurRadius: 4,
                                offset: Offset(1,1)
                            )
                          ]
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Container(
                                height: 140,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Image.network("https://192.168.1.13/ISIMM_eCampus/storage/app/public/${soc[id]['image']}",fit: BoxFit.cover,)),
                        SizedBox(height: 10,),
                            SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: ExpandableText(
                                soc[id]['a_propos'],
                                textAlign: TextAlign.left,
                                expandText: 'Read More',
                                maxLines: 4,
                                linkColor: Colors.blue,
                                style: TextStyle(fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    height: 1.4),
                              ),
                            ),
                            Container(
                              height: 40,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.location_on_outlined,color:  Colors.blueAccent,),
                                      Text('Rue de Bagdad, Sousse'),
                                    ],
                                  ),
                                  Row(children: [
                                    CircleAvatar(
                                      radius: 25,
                                      backgroundColor: Colors.white,
                                      child: Icon(Icons.email_outlined),
                                    ),
                                    SizedBox(width: 5,),
                                    CircleAvatar(
                                      radius: 15,
                                      backgroundColor: Colors.white,
                                      backgroundImage: AssetImage('lib/imagsoc/8787518.png'),
                                    ),
                                    SizedBox(width: 5,),
                                    CircleAvatar(
                                      radius: 15,
                                      backgroundColor: Colors.white,
                                      backgroundImage: AssetImage('lib/societe/8743996.png'),
                                    ),
                                  ],)
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );*/
                  }
                  );
                }

              ),
            ),
          ),
        ],
      ),
    );
  }
}
