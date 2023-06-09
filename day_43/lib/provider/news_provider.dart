import 'package:day_43/http/custome_http.dart';
import 'package:day_43/model/news_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewsProvider with ChangeNotifier {
  NewsModel? newsModel;
  Future<NewsModel> getHomeData(int pageNo, String sortBy) async {
    newsModel = await CustomeHttpRequest.fetchHomeData(pageNo, sortBy);
    return newsModel!;
  }
}
