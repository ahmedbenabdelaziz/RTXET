import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:untitled62/Login/LoginEtudient/LoginUser/prof.dart';
import '../../../matiere/Cours/ApiCou/Api/ApiUser.dart';
import '../../Widgets/UserWidget/Text.dart';
import '../../Widgets/UserWidget/sizee.dart';
import 'BlocUser/Registre/registre_bloc.dart';

class Registre extends StatefulWidget {
  const Registre({Key? key}) : super(key: key);
  State<Registre> createState() => _RegistreState();
}
class _RegistreState extends State<Registre> {

  late RegistreBloc registreBloc;
    ApiUser reg=new ApiUser();
  @override
  void initState() {
    registreBloc = BlocProvider.of<RegistreBloc>(context);
    super.initState();
  }

  TextEditingController name =TextEditingController();
  TextEditingController username =TextEditingController();
  TextEditingController password =TextEditingController();
  TextEditingController cin =TextEditingController();
  TextEditingController email =TextEditingController();
  TextEditingController phone =TextEditingController();
  TextEditingController date = TextEditingController();
  GlobalKey<FormState> fo = GlobalKey<FormState>();
  sendReg() {
    if (fo.currentState!.validate()) {
      print("valide");
    }
  }


  File? image;
  void pickImage()async{
    FilePickerResult? img =await FilePicker.platform.pickFiles();
    setState(() {
      image=File(img!.files.single.path!);
    });
  }
   String? mot;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0041c4),
      body:BlocListener<RegistreBloc, RegistreState>(
      listener: (context, state) {
        if(state is Registreerreur){
          mot =state.message;
        }else if(state is RegistreEnsegniantSuccessed){
          Navigator.of(context).push(MaterialPageRoute(builder:(context)=>prof()));
        }
  },
  child: SingleChildScrollView(
       scrollDirection: Axis.vertical,
       child: Form(
         key: fo,
         child: Column(
           children: [
             Container(
               height: 830,
               decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.only(topLeft:Radius.circular(40),topRight:Radius.circular(40))
               ),
               padding: EdgeInsets.symmetric(horizontal: 40,vertical: 50),
               width: double.infinity,
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Center(
                     child: Stack(
                       children: [
                         CircleAvatar(
                             radius: 50,
                             backgroundImage:image==null?AssetImage('lib/assets/images/téléchargementt.png'):FileImage(image!) as ImageProvider)
                         ,  Positioned(
                             left: 60,
                             bottom: 0
                             ,child:IconButton(onPressed:(){
                           pickImage();
                         },icon:Icon(Icons.camera_alt_outlined,size: 30,color: Colors.white,),))
                       ],
                     ),
                   ),
                   text('Nom'),
                   sizeheight(10),
                   Container(
                     padding: EdgeInsets.symmetric(horizontal: 20),
                     height: 40,
                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(20),
                         color: Color(0xFFf6f7f9)
                     ),
                     child: TextFormField(
                       controller: name,
                       keyboardType: TextInputType.emailAddress,
                       validator: (text){
                         if(text!.isEmpty){
                           return " ne doit pas etre vide";
                         }
                       },
                       decoration: InputDecoration(
                           prefixIcon: Icon(Icons.person),
                           hintText: "Entrer Votre name",
                           border: InputBorder.none
                       ),
                     ),),
                   sizeheight(10),
                   text('Prenom'),
                   sizeheight(10),
                   Container(
                     padding: EdgeInsets.symmetric(horizontal: 20),
                     height: 40,
                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(20),
                         color: Color(0xFFf6f7f9)
                     ),
                     child: TextFormField(
                       controller: username,
                       keyboardType: TextInputType.emailAddress,
                       validator: (text){
                         if(text!.isEmpty){
                           return "prenom ne doit pas etre vide";
                         }
                       },
                       decoration: InputDecoration(
                           prefixIcon: Icon(Icons.person),
                           hintText: "Entrer Votre name",
                           border: InputBorder.none
                       ),
                     ),),                        text('Date'),
                   sizeheight(10),
                   Container(
                     padding: EdgeInsets.symmetric(horizontal: 20),
                     height: 40,
                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(20),
                         color: Color(0xFFf6f7f9)
                     ),
                     child: TextFormField(
                       controller: date,
                       keyboardType: TextInputType.datetime,
                       decoration: InputDecoration(
                           prefixIcon:IconButton(icon:Icon(Icons.date_range_sharp),onPressed:()async{
                             DateTime? dat=await showDatePicker(
                                 context: context,
                                 initialDate: DateTime.now(),
                                 firstDate: DateTime(1900),
                                 lastDate: DateTime.now());
                             if(dat!=null){
                               setState(() {
                                 String formattedDate =
                                 DateFormat('dd/MM/yyyy').format(dat);
                                 date.text=formattedDate.toString();
                               });
                             }
                           },),
                           hintText: "Entrer your Date Of Birth",
                           border: InputBorder.none
                       ),
                     ),
                   ),
                   text('Email'),
                   sizeheight(10),
                    Container(
                       padding: EdgeInsets.symmetric(horizontal: 20),
                       height: 40,
                       decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(20),
                           color: Color(0xFFf6f7f9)
                       ),
                   child: TextFormField(
                     controller: email,
                     keyboardType: TextInputType.emailAddress,
                     validator: (value) {
                       if(value!.isEmpty) {
                         return 'Email ne doit pas être vide';
                       }else if(mot!=null){
                         print("yeeeeeeeeee");
                         return mot;

                       }
                     },
                     decoration: InputDecoration(
                       prefixIcon: Icon(Icons.person),
                       hintText: "Entrer votre email",
                       border: InputBorder.none,
                     ),
                   )),
                   sizeheight(10),
                   text('Password'),
                   sizeheight(10),
                   Container(
                     padding: EdgeInsets.symmetric(horizontal: 20),
                     height: 40,
                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(20),
                         color: Color(0xFFf6f7f9)
                     ),
                     child: TextFormField(
                       controller: password,
                       keyboardType: TextInputType.emailAddress,
                       validator: (text){
                         if(text!.isEmpty){
                           return " ne doit pas etre vide";
                         }
                       },
                       decoration: InputDecoration(
                           prefixIcon: Icon(Icons.person),
                           hintText: "Entrer Votre name",
                           border: InputBorder.none
                       ),
                     ),),                        sizeheight(10),
                   text('Confirm Password'),
                   sizeheight(10),
                   Container(
                     padding: EdgeInsets.symmetric(horizontal: 20),
                     height: 40,
                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(20),
                         color: Color(0xFFf6f7f9)
                     ),
                     child: TextFormField(
                       keyboardType: TextInputType.emailAddress,
                       validator: (text){
                         if(text!.isEmpty){
                           return " ne doit pas etre vide";
                         }
                       },
                       decoration: InputDecoration(
                           prefixIcon: Icon(Icons.person),
                           hintText: "Entrer Votre name",
                           border: InputBorder.none
                       ),
                     ),),                        sizeheight(10),
                   Text('Phone',style:TextStyle(color: Colors.blue,letterSpacing: 1),),
                   sizeheight(10),
                   Container(
                     padding: EdgeInsets.symmetric(horizontal: 20),
                     height: 40,
                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(20),
                         color: Color(0xFFf6f7f9)
                     ),
                     child: TextFormField(
                       controller: phone,
                       validator: (text){
                         if(text!.isEmpty || text.length<8){
                           return "Phone is not Valid";
                         }
                       },
                       maxLength: 8,
                       keyboardType: TextInputType.number,
                       decoration: InputDecoration(
                           prefixIcon:Icon(Icons.phone),
                           hintText: "Entrer your Phone Number",
                           border: InputBorder.none
                       ),

                     ),
                   ),
                   sizeheight(10),
                   GestureDetector(
                     onTap:(){
                       registreBloc.add(Registree(nom:name.text,prenom:username.text,email: email.text,password:password.text,date:date.text,telephone: phone.toString(),image:File(image!.path), departement: 'info'));
                       sendReg();
                     },
                     child: Container(
                       width: double.infinity,
                       height: 40,
                       decoration: BoxDecoration(
                           color: Color(0xFF0041c4),
                           borderRadius: BorderRadius.circular(15)
                       ),
                       child:Center(
                         child: Text("Sign in", style: TextStyle(
                             color: Colors.white,
                             fontWeight: FontWeight.bold)),
                       ),
                     ),
                   ),
                   Expanded(child: Container()),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Text('Already have an account?',style:TextStyle(color:Color(0xFF628bdc)),),
                       SizedBox(width: 5,),
                       GestureDetector(
                           onTap:(){

                           }
                           ,child: Text('Sign up',style:TextStyle(color:Colors.blue),)),
                     ],
                   )
                 ],
               ),
             )
           ],
         ),
       ),
      ),
)
    );
  }
}
