import 'package:expenso_492/data/local/models/cat_model.dart';

class AppConstants{

  static const String PREF_USER_ID = "userId";

  static List<CatModel> mCategories = [
    CatModel(id: 1, name: 'Cafe', imgPath: 'assets/icons/coffee.png'),
    CatModel(id: 2, name: 'Petrol', imgPath: 'assets/icons/vehicles.png'),
    CatModel(id: 3, name: 'Shopping', imgPath: 'assets/icons/hawaiian-shirt.png'),
    CatModel(id: 4, name: 'Fast Food', imgPath: 'assets/icons/fast-food.png'),
    CatModel(id: 5, name: 'Travel', imgPath: 'assets/icons/travel.png'),
    CatModel(id: 6, name: 'Movie', imgPath: 'assets/icons/popcorn.png'),
    CatModel(id: 7, name: 'Restaurant', imgPath: 'assets/icons/restaurant.png'),
  ];

}