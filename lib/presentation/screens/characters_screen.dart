import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:list_character_api/Business%20Logic/cubit/characters_cubit.dart';
import 'package:list_character_api/constants/colors.dart';
import 'package:list_character_api/presentation/widgets/charaters_items.dart';

class CharacterScreens extends StatefulWidget {
  const CharacterScreens({Key? key}) : super(key: key);

  @override
  State<CharacterScreens> createState() => _CharacterScreensState();
}

class _CharacterScreensState extends State<CharacterScreens> {
  List<dynamic> allCharacters = [];
  List<dynamic> searchForCharaters =
      []; //list have charaters that you will search with it
  bool isSearch = false; // if search or not
  final searchTextController = TextEditingController();

  Widget buildSearchField() {
    return TextField(
      controller: searchTextController,
      cursorColor: MyColors.myGrey,
      decoration: const InputDecoration(
        hintText: 'Find a Characters',
        border: InputBorder.none,
        hintStyle: TextStyle(
          color: MyColors.myGrey,
          fontSize: 18,
        ),
      ),
      style: const TextStyle(
        color: MyColors.myGrey,
        fontSize: 18,
      ),
      onChanged: (searchCharaters) {
        addSearchedForItemToSearchList(searchCharaters);
      },
    );
  }

  void addSearchedForItemToSearchList(String searchCharaters) {
    //list search character that i want to put in it info that i want to search on it

    searchForCharaters = allCharacters
        .where((character) =>
            character.name.toLowerCase().startsWith(searchCharaters))
        .toList();
    setState(() {});
  }

//this for appbar icons
  List<Widget> buildAppBarAction() {
    if (isSearch) {
      return [
        IconButton(
            //for x convert to normal appbar
            onPressed: () {
              clearSearch();
              //to go main screen cuz when i make start search it goes for new route
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.clear,
              color: MyColors.myGrey,
            )),
      ];
    } else {
      return [
        IconButton(
            //when i press on search icon
            onPressed: startSearch,
            icon: const Icon(
              Icons.search,
              color: MyColors.myGrey,
            ))
      ];
    }
  }

  void startSearch() {
    //for that arrow when you press on search icon
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: stopSearch));
    setState(() {
      isSearch = !isSearch;
    });
  }

  void stopSearch() {
    //clear data form controller or cleartext
    clearSearch();
    setState(() {
      isSearch = !isSearch;
    });
  }

  void clearSearch() {
    setState(() {
      searchTextController.clear();
    });
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharactersCubit>(context).getAllCharater();
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
        builder: (context, state) {
      if (state is CharactersLoaded) {
        allCharacters = (state).character;
        return buildLoadedListWidgets();
      } else {
        return showLoadingIndicator();
      }
    });
  }

  Widget showLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: MyColors.myYellow,
      ),
    );
  }

  Widget buildLoadedListWidgets() {
    return SingleChildScrollView(
      child: Container(
        color: MyColors.myGrey,
        child: Column(
          children: [
            buildCharatersList(),
          ],
        ),
      ),
    );
  }

  Widget buildCharatersList() {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
        ),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: searchTextController.text.isEmpty
            ? allCharacters.length
            : searchForCharaters.length,
        itemBuilder: (context, index) {
          return CharatersItems(
            charaters: searchTextController.text.isEmpty
                ? allCharacters[index]
                : searchForCharaters[index],
          );
        });
  }

  Widget buildAppBarTitle() {
    return const Text(
      'Rick and Morty',
      style: TextStyle(color: MyColors.myGrey),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: isSearch
            ? const BackButton(
                color: MyColors.myGrey,
              )
            : Container(),
        backgroundColor: MyColors.myYellow,
        title: isSearch ? buildSearchField() : buildAppBarTitle(),
        actions: buildAppBarAction(),
      ),
      body: OfflineBuilder(
          connectivityBuilder: (
              BuildContext context,
              ConnectivityResult connectivity,
              Widget child,
          ){
            final bool connected = connectivity != ConnectivityResult.none;
            if(connected)
            {
              return buildBlocWidget();
            }else
            {
              return buildNoInternetWidget();
            }
          },
        child: showLoadingIndicator(),
      ),
    );
  }

  Widget buildNoInternetWidget()
  {
    return  Center(
      child: Container(
        color: MyColors.myWhite,
        child: Column(
          children:  [
            const SizedBox(
              height: 20,
            ),
            const Text('Can\'t Connect check internet ',
            style: TextStyle(
              fontSize: 22,
              color: MyColors.myGrey
            ),
            ),
            Image.asset('assets/images/no_internet.png'),

          ],
        ),
      ),
    );
  }
}
