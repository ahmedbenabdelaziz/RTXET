import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';


class Screenn extends StatefulWidget {
  const Screenn({Key? key}) : super(key: key);

  @override
  State<Screenn> createState() => _ScreennState();
}

class _ScreennState extends State<Screenn> {

  StreamController<Map<String, dynamic>> _streamController = StreamController.broadcast();
  Future<Map<String, dynamic>> getSoc() async {
    Map<String, String> headers = {
      'Authorization': 'Bearer 36|ugNikWUQdUZE4VsqM5GMknB0QIjd9vHZyTAnIHL4',
      'Accept': 'application/json',

    };

    HttpClient client = new HttpClient()
      ..badCertificateCallback =
      ((X509Certificate cert, String host, int port) => true);
    final response = await http.get(
      Uri.parse('https://192.168.1.13/ISIMM_eCampus/public/api/societes'),
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
    super.initState();
    getSoc();
    setState(() {
      _streamController =  StreamController.broadcast();
      getSoc();
    });
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body:Column(
          children: [
            Container(height: 100,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFF9b73ef),Color(0xFF6763d5)]
                  )
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color:Colors.white,
                  borderRadius: BorderRadius.only(topRight:Radius.circular(40),topLeft: Radius.circular(40))
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all( 10),
                    width: double.infinity,
                    height: 70,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Popular société",style:TextStyle(color:Colors.black,fontSize: 25,fontWeight: FontWeight.bold),)
                            ,TextButton(onPressed:(){
                            //  Navigator.push(context, MaterialPageRoute(builder:(context)=>Soc()));
                            }, child:Text("See All",style:TextStyle(color: Color(0xFF2c76dd)),)
                            )
                          ],
                        ),

                      ],
                    ),
                  ),
                  Container(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Column(
                              children: [
                                Container(
                                  height: 70,
                                  width: 70,
                                  decoration: BoxDecoration(
                                      boxShadow:[
                                        BoxShadow(
                                            spreadRadius: 1,
                                            blurRadius: 0,
                                            offset: Offset(0.5,0.5),
                                            color: Colors.black.withOpacity(0.2)
                                        ),
                                      ],
                                      gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [Color(0xFF9b73ef),Color(0xFF6763d5)]
                                      ),
                                      borderRadius: BorderRadius.circular(20)
                                  ),
                                  child: Image.asset('lib/societe/logo-actia.png',fit: BoxFit.contain,),
                                ),
                                SizedBox(height: 8,),
                                Text(
                                  "ACTIA",
                                  style: TextStyle(fontSize: 18,),
                                ),
                              ],
                            ),
                          );
                        },
                      )
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Rapport pfe",style:TextStyle(color:Colors.black,fontSize: 25,fontWeight: FontWeight.bold),)
                            ,TextButton(onPressed:(){
                             // Navigator.push(context, MaterialPageRoute(builder:(context)=>Soc()));
                            }, child:Text("See All",style:TextStyle(color: Color(0xFF2c76dd)),)
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 250,
                        child: StreamBuilder<Map<String,dynamic>>(
                          builder:(BuildContext context ,AsyncSnapshot<Map<String,dynamic>> snapshot) {
                            var  data = snapshot.data!;
                            List<dynamic> soc = snapshot.data!['sociétés'];
                            return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: 3,itemBuilder:(context,id){
                              return Container(
                                margin: EdgeInsets.only(top: 20,left: 12,bottom: 20),
                                height: 120,
                                width: 300,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.shade300,
                                          spreadRadius: 3,
                                          blurRadius: 10,
                                          offset: Offset(8,8)
                                      ),
                                      BoxShadow(
                                          color: Colors.grey.shade300,
                                          spreadRadius: 2,
                                          blurRadius: 2,
                                          offset: Offset(-2,-2)
                                      ),
                                    ]
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start, // pour aligner le texte en haut du conteneur
                                    children: [
                                      CircleAvatar(
                                        radius: 30,
                                        backgroundImage:NetworkImage("https://192.168.1.13/ISIMM_eCampus/storage/app/public/${soc[id]['image']}"),
                                      ),
                                      SizedBox(width: 20,),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start, // pour aligner le texte à gauche du conteneur
                                          children: [
                                            Text('Conception et ealisation dune application mobile',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                            SizedBox(height: 10,),
                                            Text('12-05-2023',style: TextStyle(color: Colors.grey),),
                                            SizedBox(height: 5,),
                                            /*                                        RatingBar.builder(
                                            minRating: 0,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemSize: 20,
                                            itemBuilder: (context, index) {
                                              // Les trois premières étoiles auront la couleur jaune, les autres auront la couleur ambrée par défaut
                                              Color color = index < 3 ? Colors.yellow : Colors.amber;

                                              return Icon(
                                                Icons.star,
                                                color: color,
                                              );
                                            },
                                            onRatingUpdate: (rating) {
                                              print(rating);
                                            },
                                          )
*/
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );

                            });
                        }
                        ),
                      ),
                    ],
                  )

                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}

class CustomClippathh extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final radius = size.width / 2;
    final center = Offset(radius, size.height);
    path.lineTo(0, size.height);
    path.arcToPoint(Offset(size.width, size.height), radius: Radius.circular(radius));
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.arcToPoint(center, radius: Radius.circular(radius), clockwise: false);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    throw UnimplementedError();
  }
}
