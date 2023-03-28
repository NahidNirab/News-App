import 'dart:convert';

import 'package:day_43/model/news_model.dart';
import 'package:http/http.dart' as http;

class CustomeHttpRequest {
  static Future<NewsModel> fetchHomeData(int pageNo, String sortBy) async {
    String url =
        "https://newsapi.org/v2/everything?q=football&sortBy=$sortBy&pageSize=10&page=${pageNo}&apiKey=aa41c297ee77440396358e22402b2198";

    NewsModel? newsModel;
    var responce = await http.get(Uri.parse(url));
    print("status code is ${responce.statusCode}");
    var data = jsonDecode(responce.body);
    print("our responce is ${data}");
    newsModel = NewsModel.fromJson(data);
    return newsModel!;
  }
}
