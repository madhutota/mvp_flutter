import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvp_flutter/data/model/news_response_model.dart';
import 'package:mvp_flutter/module/news_presenter.dart';

class NewsHomePage extends StatefulWidget {
  @override
  _NewsHomePageState createState() {
    return _NewsHomePageState();
  }
}

class _NewsHomePageState extends State<NewsHomePage>
    implements NewsListViewContract {
  List<Articles> _articles;
  bool _isLoading;

  NewsListPresenter _newsListPresenter;
  final List<MaterialColor> _colors = [Colors.blue, Colors.indigo, Colors.red];

  _NewsHomePageState() {
    _newsListPresenter = NewsListPresenter(this);
  }

  @override
  void initState() {
    super.initState();

    _isLoading = true;
    _newsListPresenter.loadArticles();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: _isLoading
                ? new Center(
                    child: new CircularProgressIndicator(),
                  )
                : _getArticleWidget()));
  }

  Widget _getArticleWidget() {
    return new Container(
      child: new Column(
        children: <Widget>[
          new Flexible(
              child: ListView.builder(
            itemCount: _articles.length,
            itemBuilder: (BuildContext context, int index) {
              final Articles _article = _articles[index];
              final MaterialColor color = _colors[index % _colors.length];

              return _getListItemTile(_article, color);
            },
          ))
        ],
      ),
    );
  }

  ListTile _getListItemTile(Articles articles, Color color) {
    return new ListTile(
      leading: new CircleAvatar(
        backgroundColor: color,
        //child: Text(articles.author[0]),
      ),
      title: Text(articles.author,
          style: new TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(
        articles.description,
        style: new TextStyle(fontWeight: FontWeight.bold),
        maxLines: 2,
      ),
    );
  }

  @override
  void onLoadNewsComplete(List<Articles> articlesList) {
    setState(() {
      _isLoading = false;
      _articles = articlesList;
    });
  }

  @override
  void onLoadNewsError() {
    // TODO: implement onLoadNewsError
  }
}
