import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../matiere/Cours/ApiCou/Api/ApiUser.dart';


part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final ApiUser Loginuser;
  LoginBloc(this.Loginuser) : super(LoginInitial()) {
    on<Loginn>((event, emit)async {
      var resultat = await Loginuser.LoginUser(event.email, event.password);
      if(resultat['message']=='Vérifier vos informations'){
        emit(EmailError(emailError: 'Vérifier vos informations'));

      }else{
        emit(LoginStudentSuccessed(nom: resultat['user']['nom'], prenom:resultat['user']['prenom'], email:resultat['user']['email'], date_de_naissance:resultat['user']['date_de_naissance'], telephone:resultat['user']['telephone'], image:resultat['user']['image'], flag: resultat['flag'], token:resultat['token'],));
      }

    });
  }
}
