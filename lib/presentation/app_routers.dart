import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:list_character_api/Business%20Logic/cubit/characters_cubit.dart';
import 'package:list_character_api/Data/api%20Services/characters_api.dart';
import 'package:list_character_api/Data/models/charaters.dart';
import 'package:list_character_api/Data/repository/character_repo.dart';
import 'package:list_character_api/constants/strings.dart';
import 'package:list_character_api/presentation/screens/characters_details_screen.dart';
import 'package:list_character_api/presentation/screens/characters_screen.dart';

class AppRouter {
  late CharactersRepo charactersRepo;
  late CharactersCubit charactersCubit;

  AppRouter() {
    charactersRepo =
        CharactersRepo(characterWebServices: CharacterWebServices());
    charactersCubit = CharactersCubit(charactersRepo);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case characterScreen: // home screen
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (BuildContext context) => CharactersCubit(charactersRepo),
                child: const CharacterScreens()));
      case characterDetailsScreen:
        final character=settings.arguments as CharactersModel; //send obj from to details screen
        return MaterialPageRoute(
            builder: (_) => CharactersDetailsScreen(characters: character,));
    }
  }
}
