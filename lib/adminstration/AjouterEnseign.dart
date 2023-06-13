import 'package:flutter/material.dart';
class AjoutEnse extends StatefulWidget {
  const AjoutEnse({Key? key}) : super(key: key);

  @override
  State<AjoutEnse> createState() => _AjoutEnseState();
}

class _AjoutEnseState extends State<AjoutEnse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      body:Container(
        child:Column(children: [
          Container(
            height: 70,
            padding:EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            color: Colors.white,
            child:Row(
              children: [
                CircleAvatar(),
                SizedBox(width: 10,),
                Text('ISIMM_eCAMPUS',style:TextStyle(fontSize: 30),),
                SizedBox(width: 50,),
                Container(
                  width: 40,
                  height: 40,
                  decoration:BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue
                  ),
                  child:Center(
                    child:Icon(Icons.dashboard,color: Colors.white,),
                  ),
                ),
                SizedBox(width: 20,),
                Container(
                    width: 300,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius:BorderRadius.circular(10)
                    )
                    ,child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration:InputDecoration(
                        border: InputBorder.none,
                        hintText: "search..."
                    ),
                  ),
                )),
                Expanded(child:Container()),
                Container(
                  padding: EdgeInsets.all(8),
                  child:Stack(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration:BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black.withOpacity(0.2),
                        ),
                      ),
                      Positioned(
                          top: 5,
                          left: 5,
                          right: 5,
                          bottom: 5
                          ,child:CircleAvatar())
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  child:Stack(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration:BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black.withOpacity(0.2),
                        ),
                      ),
                      Positioned(
                          top: 5,
                          left: 5,
                          right: 5,
                          bottom: 5
                          ,child:CircleAvatar())
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  child:Stack(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration:BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black.withOpacity(0.2),
                        ),
                      ),
                      Positioned(
                          top: 5,
                          left: 5,
                          right: 5,
                          bottom: 5
                          ,child:CircleAvatar())
                    ],
                  ),
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(right:5),
                      child:Stack(
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration:BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black.withOpacity(0.2),
                            ),
                          ),
                          Positioned(
                              top: 5,
                              left: 5,
                              right: 5,
                              bottom: 5
                              ,child:CircleAvatar())
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('ISIMM',style:TextStyle(fontWeight: FontWeight.bold),),
                          Text('Adminstration',style:TextStyle(color: Colors.blue),)

                        ],
                      ),
                    )
                    ,Icon(Icons.girl_outlined)
                  ],
                )
              ],
            ),
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: 530,
                width: 200,
                color: Colors.white,
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Main Menu',style:TextStyle(color:Colors.black38,fontSize: 20
                    ),),
                    SizedBox(height: 20,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(Icons.dashboard),
                                SizedBox(width: 25,),
                                Text('Students',style:TextStyle(color:Colors.black38,)),
                                Expanded(child: Container()),
                                Icon(Icons.arrow_back)
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(Icons.dashboard),
                                SizedBox(width: 25,),
                                Text('Students',style:TextStyle(color:Colors.black38,)),
                                Expanded(child: Container()),
                                Icon(Icons.arrow_back)
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(Icons.dashboard),
                                SizedBox(width: 25,),
                                Text('Students',style:TextStyle(color:Colors.black38,)),
                                Expanded(child: Container()),
                                Icon(Icons.arrow_back)
                              ],
                            ),
                          ),


                        ],
                      ),
                    ),
                    SizedBox(height: 15,),
                    Text('Extra',style:TextStyle(color:Colors.black38,fontSize: 20
                    ),),
                    SizedBox(height: 20,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(Icons.dashboard),
                                SizedBox(width: 25,),
                                Text('Students',style:TextStyle(color:Colors.black38,)),
                                Expanded(child: Container()),
                                Icon(Icons.arrow_back)
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(Icons.dashboard),
                                SizedBox(width: 25,),
                                Text('Students',style:TextStyle(color:Colors.black38,)),
                                Expanded(child: Container()),
                                Icon(Icons.arrow_back)
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(Icons.dashboard),
                                SizedBox(width: 25,),
                                Text('Students',style:TextStyle(color:Colors.black38,)),
                                Expanded(child: Container()),
                                Icon(Icons.arrow_back)
                              ],
                            ),
                          ),


                        ],
                      ),
                    ),
                    Text('Managment',style:TextStyle(color:Colors.black38,fontSize: 20
                    ),),
                    SizedBox(height: 20,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(Icons.dashboard),
                                SizedBox(width: 25,),
                                Text('Students',style:TextStyle(color:Colors.black38,)),
                                Expanded(child: Container()),
                                Icon(Icons.arrow_back)
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(Icons.dashboard),
                                SizedBox(width: 25,),
                                Text('Students',style:TextStyle(color:Colors.black38,)),
                                Expanded(child: Container()),
                                Icon(Icons.arrow_back)
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(Icons.dashboard),
                                SizedBox(width: 25,),
                                Text('Students',style:TextStyle(color:Colors.black38,)),
                                Expanded(child: Container()),
                                Icon(Icons.arrow_back)
                              ],
                            ),
                          ),


                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 50,right: 30,left: 30),
                width: 1080,
                height: 530,
                color: Color(0xFff7f7fa),
                child:Column(
                  children: [
                    Row(
                      children: [
                        Text('Ajouter Enseignant',style:TextStyle(fontSize: 20,fontWeight: FontWeight.w800),)
                        ,Expanded(child: Container()),
                        Text('Home   /'),
                        Text('   Ajouter',style:TextStyle(color: Colors.black38),)
                      ],
                    ),
                    SizedBox(height: 20,),
                    Container(
                      height: 430,
                      width: 1050,
                      decoration:BoxDecoration(
                        color: Colors.white,
                        borderRadius:BorderRadius.circular(10)
                      ),
                    )
                  ],
                ),
              ),
            ],
          )
        ],),
      ),
    );
  }
}
