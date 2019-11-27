



import 'package:mvp_flutter/data/model/news_response_model.dart';
import 'package:mvp_flutter/di/dependency_injection.dart';


abstract class NewsListViewContract{
  void onLoadNewsComplete (List<Articles> articlesList);
  void onLoadNewsError();
}


class NewsListPresenter{
  NewsListViewContract _viewContract;
  NewsRepository _repository;



  NewsListPresenter(this._viewContract){

    _repository = new NewsInjector().newsRepository;
}


void loadArticles(){

    _repository.fetchArticles().then((c) => _viewContract.onLoadNewsComplete(c))
        .catchError((onError)=>_viewContract.onLoadNewsError());
}
}



