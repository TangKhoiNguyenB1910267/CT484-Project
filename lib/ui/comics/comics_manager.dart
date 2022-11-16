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
    void updateComic(Comic comic){
      final index = _comic.indexWhere((comic) => comic.id==comic.id);
      if (index >= 0 ){
        _comic[index] = comic;
        notifyListeners();
      }
    }
    void toggleFavoriteStatus(Comic comic){
      final savedStatus = comic.isFavorite;
      comic.isFavorite = !savedStatus;
    }
    void deleteComic(String id){
      final index = _comic.indexWhere((comic) => comic.id==id);
      _comic.removeAt(index);
      notifyListeners();
    }

}