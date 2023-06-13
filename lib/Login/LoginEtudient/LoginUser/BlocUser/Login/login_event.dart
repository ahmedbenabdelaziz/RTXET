part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}
class Loginn extends  LoginEvent {
   final String email;
   final String password;
  Loginn({required this.email,required this.password});
}