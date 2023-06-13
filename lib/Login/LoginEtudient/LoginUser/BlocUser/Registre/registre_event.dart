part of 'registre_bloc.dart';

@immutable
abstract class RegistreEvent {}


class Registree extends  RegistreEvent {
  final String nom;
  final String prenom;
  final String email;
  final String password;
  final String date;
  final String telephone;
  final File image;
  final String departement;
  Registree({required this.nom,required this.prenom,required this.email,required this.password,required this.date,required this.telephone,required this.image,required this.departement});
}