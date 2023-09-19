import 'package:flutter/material.dart';
import 'package:list_character_api/presentation/app_routers.dart';

void main() {
  runApp(RickAndMorty(appRouter: AppRouter(),));
}

class RickAndMorty extends StatelessWidget {
  final AppRouter appRouter;
  const RickAndMorty({super.key, required this.appRouter});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Rick And Morty',
      debugShowCheckedModeBanner: false,
      onGenerateRoute:  appRouter.generateRoute ,//class routeing
    );
  }
}


