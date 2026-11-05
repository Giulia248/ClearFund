//mechanism to get the data from the server using the API

import 'dart:convert';

import 'package:http/http.dart';
import 'package:personal_flutter/network/models/meal_model.dart';
import 'package:personal_flutter/network/models/user_model.dart';
import 'package:personal_flutter/network/models/weather_model.dart';

class UserRepository {
  String userUrl = 'https://reqres.in/api/users?page=2';

  Future<List<UserModel>> getUsers() async {
    Response response = await get(Uri.parse(userUrl));

    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['data'];
      return result.map((e) => UserModel.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}

class MealRepository {
  // Lookup a single random meal
  String randomMealUrl = 'https://www.themealdb.com/api/json/v1/1/random.php';
  // List all meal categories
  String allCatUrl = 'https://www.themealdb.com/api/json/v1/1/categories.php';

  Future<List<MealModel>> getRandomMeal() async {
    Response response = await get(Uri.parse(randomMealUrl));

    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['meals'];
      return result.map((e) => MealModel.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<List<CategoryModel>> getAllCat() async {
    Response response = await get(Uri.parse(allCatUrl));

    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['categories'];
      return result.map((e) => CategoryModel.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  // Filter by Category, e.g. getMeal('Seafood')
  Future<List<MealModel>> getMeal(String category) async {
    final uri = Uri.https('www.themealdb.com', '/api/json/v1/1/filter.php', {
      'c': category,
    });
    Response response = await get(uri);

    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['meals'];
      return result.map((e) => MealModel.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}

class WeatherRepository {
  String base = 'https://worldtimeweather.com/api/v1/cities.json';

  Future<List<WeatherModel>> getCites() async {
    Response response = await get(Uri.parse(base));

    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['data'];
      return result.map((e) => WeatherModel.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<WeatherModel> getWeather(String city) async {
    Response response = await get(
      Uri.parse("https://worldtimeweather.com/api/v1/city/$city.json"),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);

      return WeatherModel.fromJson({
        ...data['weather'],
        'en': data['page']['en'],
        'slug': data['slug'],
        'name': data['name'],
      });
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
