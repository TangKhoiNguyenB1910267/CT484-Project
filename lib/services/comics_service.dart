import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/comic.dart';
import '../models/auth_token.dart';

import 'firebase_service.dart';

class ComicsService extends FirebaseService {
  ComicsService([AuthToken? authToken]) : super(authToken);

  Future<List<Comic>> fetchComics([bool filterByUser = false]) async {
    final List<Comic> comics = [];

    try{
      final filters = 
          filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
      final comicsUrl = 
          Uri.parse('$databaseUrl/comics.json?auth=$token&$filters');
      final response = await http.get(comicsUrl);
      final comicsMap = json.decode(response.body) as Map<String, dynamic>;

      if (response.statusCode != 200) {
        print(comicsMap['error']);
        return comics;
      }

      final userFavoritesUrl = 
        Uri.parse('$databaseUrl/userFavorites/$userId.json?auth=$token');
      final userFavoritesResponse = await http.get(userFavoritesUrl);
      final userFavoritesMap = json.decode(userFavoritesResponse.body);

      comicsMap.forEach((comicId, comic) {
        final isFavorite = (userFavoritesMap == null)
            ? false
            : (userFavoritesMap[comicId] ?? false);
        comics.add(
          Comic.fromJson({
            'id': comicId,
            ...comic,
          }).copyWith(isFavorite: isFavorite),
        );    
      });
      return comics;    
    } catch (error) {
      print(error);
      return comics;
    }
  }

  Future<Comic?> addComic(Comic comic) async {
    try{
      final url = Uri.parse('$databaseUrl/comics.json?auth=$token');
      final response = await http.post(
        url,
        body: json.encode(
          comic.toJson()
            ..addAll({
              'creatorId': userId,
            }),
        ),
      );

      if (response.statusCode != 200) {
        throw Exception(json.decode(response.body)['error']);
      }

      return comic.copyWith(
        id: json.decode(response.body)['name'],
      );
    } catch(error) {
      print(error);
      return null;
    }
  }
}