part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoded extends LoginState {}

class LoginEnsegniantSuccessed extends LoginState {}

class LoginStudentSuccessed extends LoginState {

  final String token;
  final String nom;
  final String prenom;
  final String email;
  final String date_de_naissance;
  final String telephone;
  final String image;
  final String flag;

  LoginStudentSuccessed({required this.nom, required this.prenom, required this.email, required this.date_de_naissance, required this.telephone, required this.image, required this.flag,  required this.token});

}

class LoginError extends LoginState {
  final String emailError;
  final String passwordError;
  LoginError({required this.emailError, required this.passwordError});
}

class PasswordError extends LoginState {
  final String passwordError;
  PasswordError({required this.passwordError});}

class EmailError extends LoginState {
  final String emailError;
  EmailError({required this.emailError});}