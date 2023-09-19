import 'package:flutter/material.dart';
import 'package:list_character_api/Data/models/charaters.dart';
import 'package:list_character_api/constants/colors.dart';
import 'package:intl/intl.dart';

class CharactersDetailsScreen extends StatelessWidget {
  final CharactersModel characters;

  const CharactersDetailsScreen({Key? key, required this.characters})
      : super(key: key);

  Widget buildSilverAppBar() {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.myGrey,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          characters.name,
          style: const TextStyle(color: MyColors.myWhite),
        ),
        background: Hero(
          tag: characters.id,
          child: Image.network(
            characters.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget characterInfo(String title, String value) {
    //title is ex status ||value is alive
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(
                color: MyColors.myWhite,
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(color: MyColors.myWhite, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      height: 30,
      endIndent: endIndent, //width of line
      color: MyColors.myYellow,
      thickness: 2,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      body: CustomScrollView(
        slivers: [
          buildSilverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      characterInfo('Status : ', characters.status),
                      buildDivider(295), //space from start to end
                      characterInfo('Species : ', characters.species),
                      buildDivider(295),
                      characterInfo('Gender : ', characters.gender),
                      buildDivider(295),
                      characterInfo('Origin : ', characters.origin!.name),
                      buildDivider(295),
                      characterInfo('Location : ', characters.location!.name),
                      buildDivider(275),
                      characterInfo(
                          'Created : ',
                          DateFormat('dd MMMM yyyy hh:mm a')
                              .format(characters.created)),
                      buildDivider(280),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 500,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
