import 'dart:convert';

class CharactersModel {
  final int id;
  final String name;
  final String status;
  final String species;
  final String gender;
  final String image;
  final Origin? origin;
  final Location? location;
  final DateTime created;
  CharactersModel(
      {required this.id,
      required this.name,
      required this.status,
      required this.species,
      required this.gender,
      required this.image,
      required this.origin,
      required this.location,
      required this.created});

  factory CharactersModel.fromjson(Map<String, dynamic> json) =>
      CharactersModel(
        id: json['id'],
        name: json['name'],
        status: json['status'],
        species: json['species'],
        gender: json['gender'],
        image: json['image'],
        origin: Origin.fromJson(json['origin']),
        location: Location.formjson(json['location']),
        created: DateTime.parse(json['created']).toLocal(),
      );
}

class Origin {
  String name;
  String url;

  Origin({required this.name, required this.url});

  factory Origin.fromJson(Map<String, dynamic> json) =>
      Origin(name: json['name'], url: json['url']);
}

class Location {
  final String name;
  final String url;

  Location({required this.name, required this.url});

  factory Location.formjson(Map<String, dynamic> json) =>
      Location(name: json['name'], url: json['url']);
}
