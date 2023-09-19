import 'package:flutter/material.dart';
import 'package:list_character_api/Data/models/charaters.dart';
import 'package:list_character_api/constants/colors.dart';
import 'package:list_character_api/constants/strings.dart';

class CharatersItems extends StatelessWidget {
  //deal with 1 character
  final CharactersModel charaters;

  const CharatersItems({Key? key, required this.charaters}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //one grid
    return Container(
      width: double.infinity,
      margin: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: const EdgeInsetsDirectional.all(4),
      decoration: BoxDecoration(
        color: MyColors.myWhite,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: ()=>Navigator.pushNamed(context, characterDetailsScreen,arguments: charaters),
        child: GridTile(
          footer: Hero(
            tag: charaters.id,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              color: Colors.black54,
              alignment: Alignment.bottomCenter,
              child: Text(
                charaters.name,
                style: const TextStyle(
                  height: 1.3,
                  fontSize: 16,
                  color: MyColors.myWhite,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          child: Container(
            color: MyColors.myGrey,
            child: charaters.image.isNotEmpty
                ? FadeInImage.assetNetwork(
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: 'assets/images/loading.gif',
                    image: charaters.image)
                : Image.asset('assets/images/placeholder.jpg'),
          ),
        ),
      ),
    );
  }
}
