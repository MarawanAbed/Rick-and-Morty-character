import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:list_character_api/Data/repository/character_repo.dart';
import 'package:meta/meta.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepo characterRepo;
   List<dynamic>myCharater=[];
  CharactersCubit(this.characterRepo) : super(CharactersInitial());

   List<dynamic>getAllCharater()
   {
     characterRepo.fetchAllCharacters().then((listCharacter)
     {
       emit(CharactersLoaded(character: listCharacter));
       myCharater=listCharacter;
     }
     );
     return myCharater;
   }
}
