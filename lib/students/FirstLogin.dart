import 'package:flutter/material.dart';
import 'package:untitled62/Login/LoginEtudient/LoginUser/LoginUser.dart';
import 'package:untitled62/Login/LoginEtudient/LoginUser/Registre.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:Color(0xFF0041c4),
        body:Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0,vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 350,
                child:Center(child: Image.asset('lib/students/iconacceuil/ah.png')),
              ),
              SizedBox(height: 10,),
              Text('ISIMM eCampus',style:TextStyle(color: Colors.white,fontSize: 35,fontWeight: FontWeight.bold,),),
              SizedBox(height: 20,),
              Text('Se former autrement...',style:TextStyle(color: Colors.white,fontSize: 15)),
              SizedBox(height: 5),
              Text('Gestion & Accessibilité',style:TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w500)),
              SizedBox(height: 40,),
              Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage('lib/assets/2790260.png')
                    ),
                    SizedBox(width: 5,)
                    ,InkWell(
                        onTap:(){
                          Navigator.push(context, MaterialPageRoute(builder:(context)=>Signin()));
                        }
                        ,child: Text('Se connecter ',style:TextStyle(color: Color(0xFF1550c8),fontSize: 18,fontWeight: FontWeight.bold)))
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color(0xFF0041c4),
                    border: Border.all(
                        width: 3,
                        color: Colors.white
                    )
                ),
                child: Center(child: GestureDetector(
                    onTap:(){
                      showDialog(context:(context), builder:(context){
                        return AlertDialog(
                          content:Container(
                            height: 100,
                            width: 100,
                            child:Row(
                              children: [
                                ElevatedButton(onPressed:(){}, child:Text('enseignant')),
                                SizedBox(width: 10,),
                                ElevatedButton(onPressed:(){}, child:Text('etudiant')),

                              ],
                            ),
                          ),
                        );
                      });
                    }
                    ,child: Text('Créer un compte',style:TextStyle(color: Colors.white,fontSize: 18),))),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Connectez-vous pour commencer.',style:TextStyle(color:Color(0xFF628bdc)),),
                  SizedBox(width: 5,),
                  InkWell(
                      onTap:(){
                        Navigator.push(context, MaterialPageRoute(builder:(context)=>Signin()));
                      }
                      ,child: Text('Bienvenue',style:TextStyle(color:Colors.white),)),
                ],
              ),
            ],
          ),
        )
    );
  }
}