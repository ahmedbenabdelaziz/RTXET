import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../matiere/Cours/ApiCou/Api/ApiUser.dart';
part 'registre_event.dart';
part 'registre_state.dart';

class RegistreBloc extends Bloc<RegistreEvent, RegistreState> {
  final ApiUser user ;
  RegistreBloc(this.user) : super(RegistreInitial()) {
    on<Registree>((event, emit)async {
      final data =await user.RegistreUserEnseignant(event.nom, event.prenom, event.email, event.password, event.date, event.telephone, event.image,event.departement);
      if(data=="email déja existant"){
        emit(Registreerreur(message: 'email déja existant'));
      }else if(data=="Compte créé avec succès"){
      }   emit(RegistreStudentSuccessed());
    }
    );
  }
}
