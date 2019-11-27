

import 'package:mvp_flutter/data/model/news_response_model.dart';
import 'package:mvp_flutter/data/repository/mock_news_repository.dart';
import 'package:mvp_flutter/data/repository/prod_news_repository.dart';

enum Flavor{PROD,MOCK}


class NewsInjector {
  static final NewsInjector _singleton = new NewsInjector._internal();
  static Flavor _flavor;

  static void configure (Flavor flavor){
    _flavor = flavor;
  }
  factory NewsInjector (){

    return _singleton;
  }
  NewsInjector._internal();


  NewsRepository get newsRepository{

    switch(_flavor){

      case Flavor.MOCK:
        return MockNewsRepository();
      default:
        return ProdNewsRepository();
    }
  }
}

