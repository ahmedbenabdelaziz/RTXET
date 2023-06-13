import 'package:flutter/material.dart';
class page2 extends StatefulWidget {
  const page2({Key? key}) : super(key: key);

  @override
  State<page2> createState() => _page2State();
}

class _page2State extends State<page2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        children: [
          Container(
            height: 120,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF9b73ef),Color(0xFF6763d5)]
                ),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30))
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 60.0,),
              child: Row(
                children: [
                  IconButton(onPressed:(){}, icon:Icon(Icons.arrow_back,size:30,color: Colors.white,))
                  ,Container(
                    height: 45,
                    width: 285,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            spreadRadius: 0,
                            blurRadius: 0.5,
                            offset: Offset(3,3)
                        ),
                        BoxShadow(
                            color: Colors.black12,
                            spreadRadius: 0,
                            blurRadius: 0.5,
                            offset: Offset(-3,-3)
                        )
                      ],
                      color: Colors.white.withOpacity(0.7),
                    ),
                    child: Center(
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.search,color: Colors.white,),
                          hintText: "Search for anything ..",
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 5,),
                  CircleAvatar(
                    backgroundImage:AssetImage('lib/societe/téléchargement.png'),
                  )
                ],
              ),
            ),
          ),
          Container(
            padding:EdgeInsets.only(top: 25,left: 20,) ,
            height: 270,
            child: Column(
              children: [
                Row(children: [
                  GestureDetector(
                    onTap:(){
                    },
                    child: Container(
                      height: 110,
                      width: 172,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.centerRight,
                              end: Alignment.centerLeft,
                              colors: [
                                Color(0xFFd7e8ff),
                                Color(0xFFf7f9fa)
                              ]
                          ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow:[
                            BoxShadow(
                                color: Colors.black12,
                                spreadRadius: 0,
                                blurRadius: 1,
                                offset: Offset(2,4)
                            ),
                            BoxShadow(
                                color: Colors.black12,
                                spreadRadius: 0,
                                blurRadius: 1,
                                offset: Offset(-2,-4)
                            )
                          ]
                      ),
                      child: Column(
                        mainAxisAlignment:MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            child: Image.asset('lib/PFE/assets/5099601.png'),
                          ),
                          TextButton(onPressed: () {
                          },
                            child: Text('COURS',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 23,color:Color(0xFF0a0a48))),),

                        ],
                      ),
                    ),
                  ) ,
                  SizedBox(width: 10,),
                  GestureDetector(
                    onTap:(){
                    },
                    child: Container(
                      height: 110,
                      width: 172,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                Color(0xFF3aaaff),
                                Color(0xFF27d8f6)
                              ]
                          ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow:[
                            BoxShadow(
                                color: Colors.black12,
                                spreadRadius: 0,
                                blurRadius: 1,
                                offset: Offset(2,4)
                            ),
                            BoxShadow(
                                color: Colors.black12,
                                spreadRadius: 0,
                                blurRadius: 1,
                                offset: Offset(-2,-4)
                            )
                          ]
                      ),
                      child: Column(
                        mainAxisAlignment:MainAxisAlignment.center,
                        children: [
                          Container(
                              height: 50,
                              width: 50,
                              child:Image.asset('lib/PFE/assets/1009236.png')
                          ),
                          TextButton(onPressed: () {
                          },
                            child: Text('TD/Execice',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color:Colors.white)),),

                        ],
                      ),
                    ),
                  ) ,            ],),
                SizedBox(height: 10,),
                Row(children: [
                  GestureDetector(
                    onTap:(){
                    },
                    child: Container(
                      height: 110,
                      width: 172,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color(0xFFccd6e7),
                                Color(0xFF9486f9)
                              ]
                          ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow:[
                            BoxShadow(
                                color: Colors.black12,
                                spreadRadius: 0,
                                blurRadius: 1,
                                offset: Offset(2,4)
                            ),
                            BoxShadow(
                                color: Colors.black12,
                                spreadRadius: 0,
                                blurRadius: 1,
                                offset: Offset(-2,-4)
                            )
                          ]
                      ),
                      child: Column(
                        mainAxisAlignment:MainAxisAlignment.center,
                        children: [
                          Container(
                              height: 50,
                              width: 70
                              ,child: Image.asset('lib/PFE/assets/5136976.png',)),
                          TextButton(onPressed: () {
                          },
                            child: Text('Examen',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Color(0xFF0a0a48))),),

                        ],
                      ),
                    ),
                  ) ,
                  SizedBox(width: 10,),
                  GestureDetector(
                    onTap:(){
                    },
                    child: Container(
                      height: 110,
                      width: 172,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                Color(0xFFdad0cb),
                                Color(0xFFf5f0eb)
                              ]
                          ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow:[
                            BoxShadow(
                                color: Colors.black12,
                                spreadRadius: 0,
                                blurRadius: 1,
                                offset: Offset(2,4)
                            ),
                            BoxShadow(
                                color: Colors.black12,
                                spreadRadius: 0,
                                blurRadius: 1,
                                offset: Offset(-2,-4)
                            )
                          ]
                      ),
                      child: Column(
                        mainAxisAlignment:MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            child: Image.asset('lib/PFE/assets/3022307.png'),
                          ),
                          TextButton(onPressed: () {
                          },
                            child: Text('Other Files',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Color(0xFF0a0a48))),),

                        ],
                      ),
                    ),
                  ) ,
                ],)

              ],
            ),
          ),
          Row(
            children: [
              Container(height: 40,
                padding: EdgeInsets.only(left: 20,top: 10),
                child:Text('Question :',style:TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 25),),
              ),
              Expanded(child: Container()),
            ],
          ),
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: 3,itemBuilder:(context,id){
              return Container(
                margin: EdgeInsets.only(left: 20,right: 20,bottom: 20),
                height: 200,
                width: 100,
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
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start, // pour aligner le texte en haut du conteneur
                    children: [
                      Center(
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage('lib/PFE/img/207190.png'),
                        ),
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start, // pour aligner le texte à gauche du conteneur
                          children: [
                            Text('Fawzi ben abdeslam',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                            SizedBox(height: 10,),
                            Text('12-05-2023',style: TextStyle(color: Colors.grey),),
                            SizedBox(height: 5,),
                            Text(
                              'proxym est un regroupement de pharmaciens propriétaires indépendants, dont la priorité est la pratique professionnelle. Les pharmacies sont de surface moyenne.',style:TextStyle(color: Colors.black87),
                              softWrap: true,
                              overflow: TextOverflow.visible, // permet d'afficher le texte qui dépasse
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );

            }),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.green,
        selectedItemColor: Colors.red,
        unselectedItemColor: Color(0xFF385b9f),
        items: [
          BottomNavigationBarItem(icon:Icon(Icons.home),label: "Home"),
          BottomNavigationBarItem(icon:Icon(Icons.message),label: "Home"),
          BottomNavigationBarItem(icon:Icon(Icons.settings),label: "Home"),
          BottomNavigationBarItem(icon:Icon(Icons.notifications),label: "Home"),

        ],
      ),
    );
  }
}
