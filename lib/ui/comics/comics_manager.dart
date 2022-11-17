import 'package:flutter/foundation.dart';
import '../../models/comic.dart';
import '../../models/auth_token.dart';
import '../../services/comics_service.dart';

class ComicsManager with ChangeNotifier {
    List<Comic> _comic = [];

  final ComicsService _comicsService;

  ComicsManager([AuthToken? authToken])
      : _comicsService = ComicsService(authToken);

  set authToken(AuthToken? authToken) {
    _comicsService.authToken = authToken;
  }

  Future<void> fetchComics([bool filterByUser = false]) async {
    _comic = await _comicsService.fetchComics(filterByUser);
    notifyListeners();
  }   
    int get comicCount {
      return _comic.length;
    }

    List<Comic> get comic{
      return [..._comic];
    }

    List<Comic> get favoritecomic{
      return _comic.where((comItem) => comItem.isFavorite).toList();
    }
    Comic findById(String id) {
    return _comic.firstWhere((com) => com.id == id);  
    }  
   Future<void> addComic(Comic comic)  async {
    final newComic = await _comicsService.addComic(comic);
    if (newComic != null) {
      _comic.add(newComic);
      notifyListeners();
    }
   }
   Future<void> updateComic(Comic comic) async{
      final index = _comic.indexWhere((item) => item.id==comic.id);
      if (index >= 0 ){
        _comic[index] = comic;
        if (await _comicsService.updateComic(comic)){
           _comic[index] = comic;
        notifyListeners();
        }    
      }
    }
     Future<void> toggleFavoriteStatus(Comic comic) async {
      final savedStatus = comic.isFavorite;
      comic.isFavorite = !savedStatus;
       if(!await _comicsService.saveFavoriteStatus(comic)){
        comic.isFavorite = savedStatus;
      }
    }
   Future <void> deleteComic(String id) async{
      final index = _comic.indexWhere((item) => item.id==id);
      Comic? existingComic = _comic[index];
      _comic.removeAt(index);
      notifyListeners();
      if (!await _comicsService.deleteComic(id)){
        _comic.insert(index, existingComic);
        notifyListeners();
      }
    }

}