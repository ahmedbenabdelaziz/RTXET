part of 'registre_bloc.dart';

@immutable
abstract class RegistreState {}

class RegistreInitial extends RegistreState {}

class RegistreLoded extends RegistreState {}

class RegistreEnsegniantSuccessed extends RegistreState {}

class RegistreStudentSuccessed extends RegistreState {}

class Registreerreur extends RegistreState {
  final String message;
  Registreerreur({required this.message});
}