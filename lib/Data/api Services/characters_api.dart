import 'package:dio/dio.dart';
import 'package:list_character_api/Data/models/charaters.dart';
import 'package:list_character_api/constants/strings.dart';

class CharacterWebServices
{
    late Dio dio;
    CharacterWebServices()
    {
      BaseOptions options=BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
      );
      dio=Dio(options);
    }


    Future<List<dynamic>>getAllCharacters()async
    {
      try {
        Response response = await dio.get('character');
        return response.data['results'];
      }catch(e)
      {
        print(e);
        return [];
      }
    }
}