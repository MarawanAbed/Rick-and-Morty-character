import 'package:list_character_api/Data/api%20Services/characters_api.dart';
import 'package:list_character_api/Data/models/charaters.dart';

class CharactersRepo
{
  //data come here
  final CharacterWebServices characterWebServices;

  CharactersRepo({required this.characterWebServices});

  Future<List<dynamic>>fetchAllCharacters()async
  {
    final characters = await characterWebServices.getAllCharacters();
    return characters.map((character) => CharactersModel.fromjson(character)).toList();

  }
}