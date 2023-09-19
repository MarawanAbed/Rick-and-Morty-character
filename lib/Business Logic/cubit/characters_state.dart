part of 'characters_cubit.dart';

@immutable
abstract class CharactersState {}

class CharactersInitial extends CharactersState {}
class CharactersLoading extends CharactersState{}
class CharactersLoaded extends CharactersState
{
  final List<dynamic>character;
  CharactersLoaded({required this.character});
}
class CharactersError extends CharactersState
{
  final String message;
  CharactersError({required this.message});
}

