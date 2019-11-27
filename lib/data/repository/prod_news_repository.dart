import 'dart:convert';
import 'dart:math';

import 'package:mvp_flutter/data/model/news_response_model.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class ProdNewsRepository implements NewsRepository {
  var apiUrl =
      "https://newsapi.org/v2/everything?q=bitcoin&from=2019-10-27&sortBy=publishedAt&apiKey=b1422282ee3f4716ba138edcf5523d68";

  @override
  Future<List<Articles>> fetchArticles() async {

    List<Articles> articlesList = [];

    http.Response response = await http.get(apiUrl);
    final statusCode = response.statusCode;
    var jsonDecodeResponse = json.decode(response.body);


    if (jsonDecodeResponse['articles'] != null) {
      articlesList = new List<Articles>();
      jsonDecodeResponse['articles'].forEach((v) {
        articlesList.add(new Articles.fromJson(v));
      });
    }
    NewsResponseModel newsResponseModel =
    NewsResponseModel.fromJson(jsonDecodeResponse);


    if (statusCode != 200 || jsonDecodeResponse == null) {
      throw new FetchException('An Error occured :[status code :$statusCode ]');
    } else
      return newsResponseModel.articles;
  }

  @override
  Future<NewsResponseModel> fetchNewsResponse() async {
    http.Response response = await http.get(apiUrl);
    final statusCode = response.statusCode;
    var jsonDecodeResponse = json.decode(response.body);
    NewsResponseModel newsResponseModel =
        NewsResponseModel.fromJson(jsonDecodeResponse);
    if (statusCode != 200 || jsonDecodeResponse == null) {
      throw new FetchException('An Error occured :[status code :$statusCode ]');
    } else
      return newsResponseModel;
  }
}
