import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(new MyApp());
//无状态组件
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Startup Name Generator',
        home: new RandomWords(),
        theme: new ThemeData(
            primaryColor: Colors.blue, primarySwatch: Colors.blue));
  }
}

//随机单词方法
class RandomWords extends StatefulWidget {
  @override
  createState() => new RandomWordsState();
}

//声明随机单词类
class RandomWordsState extends State<RandomWords> {
  //单词列表
  final _suggestions = <WordPair>[];
  //单词字体
  final _biggerFont = const TextStyle(fontSize: 18.0);
  //收藏
  final _saved = new Set<WordPair>();
  //构造函数
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Startup Name Generator'),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  //给收藏列表添加项目
  void _pushSaved() {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      final tiles = _saved.map((pair) {
        return new ListTile(
            title: new Text(pair.asPascalCase, style: _biggerFont),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return new AlertDialog(
                        title: new Text("标题"),
                        content: new Text("确定查看详情？"),
                        actions: <Widget>[
                          new FlatButton(
                              onPressed: () {
                                //点击取消关闭当前对话框
                                Navigator.of(context).pop();
                              },
                              child: new Text("取消")),
                          new FlatButton(
                            onPressed: () {
                              //关闭提示框
                              Navigator.of(context).pop();
                              //页面容器
                              var container = new Container(
                                  alignment: Alignment.topCenter,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[300], //背景色设置
                                      border: Border.all(
                                          color: Colors.grey,
                                          width: 1.0), //边框设置
                                      borderRadius:
                                          BorderRadius.circular(5) //圆角设置
                                      ),
                                  child: new Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        new Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            margin: EdgeInsets.only(top: 24.0),
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                child: new Image.asset(
                                                    'images/lake.jpg'))),
                                        new Container(
                                          alignment: Alignment.topCenter,
                                          margin: EdgeInsets.all(25),
                                          child: new Row(children: [
                                            new Expanded(
                                                child: new Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                  new Container(
                                                      padding: EdgeInsets.only(
                                                          bottom: 8.0),
                                                      child: new Text(
                                                          'Oeschinen Lake Campground',
                                                          style: new TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold))),
                                                  new Container(
                                                      padding: EdgeInsets.only(
                                                          bottom: 8.0),
                                                      child: new Text(
                                                          'Kandersteg, Switzerland',
                                                          style: new TextStyle(
                                                              color: Colors
                                                                  .grey[500])))
                                                ])),
                                            new Icon(
                                              Icons.star,
                                              color: Colors.red[500],
                                            ),
                                            new Text("41")
                                          ]),
                                        ),
                                        new Container(
                                          alignment: Alignment.topCenter,
                                          margin: EdgeInsets.all(25),
                                          child: new Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              buildButtonColumn(
                                                  Icons.call, "CALL"),
                                              buildButtonColumn(
                                                  Icons.near_me, "ROUTE"),
                                              buildButtonColumn(
                                                  Icons.share, "SHARE")
                                            ],
                                          ),
                                        ),
                                        new Container(
                                            padding: const EdgeInsets.all(32.0),
                                            child: new Text(
                                                '''COSCO SHIPPING Specialized operates more than a hundred vessels, including multi-purpose and heavy lift vessels, semi-submersible vessels, pure car carriers, logs carriers as well as asphalt carriers. It provides a wide variety of solutions for the transportation of various non-containerized cargo at sea.''',
                                                softWrap: true))
                                      ]));
                              //导航到新页面
                              Navigator.of(context).push(
                                  new MaterialPageRoute(builder: (context) {
                                return Scaffold(
                                    appBar: AppBar(title: Text('布局测试页面')),
                                    body: container);
                              }));
                            },
                            child: new Text("确认"),
                          )
                        ]);
                  });
            });
      });
      final divided = ListTile.divideTiles(
        context: context,
        tiles: tiles,
      ).toList();
      return new Scaffold(
        appBar: new AppBar(title: new Text('Saved Suggestions')),
        body: new ListView(children: divided),
      );
    }));
  }

  //构建行图标加文字区域
  Column buildButtonColumn(IconData icon, String label) {
    Color color = Theme.of(context).primaryColor;
    return new Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Icon(icon, color: color),
        new Container(
            margin: const EdgeInsets.only(top: 8.0),
            child: new Text(label,
                style: new TextStyle(
                    fontSize: 12.0, fontWeight: FontWeight.w400, color: color)))
      ],
    );
  }

  //声明建议列表方法
  Widget _buildSuggestions() {
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      // 对于每个建议的单词对都会调用一次itemBuilder，然后将单词对添加到ListTile行中
      // 在偶数行，该函数会为单词对添加一个ListTile row.
      // 在奇数行，该函数会添加一个分割线widget，来分隔相邻的词对。
      // 注意，在小屏幕上，分割线看起来可能比较吃力。
      itemBuilder: (context, i) {
        // 在每一列之前，添加一个1像素高的分隔线widget
        if (i.isOdd) {
          return new Divider();
        }
        // 语法 "i ~/ 2" 表示i除以2，但返回值是整形（向下取整），比如i为：1, 2, 3, 4, 5
        // 时，结果为0, 1, 1, 2, 2， 这可以计算出ListView中减去分隔线后的实际单词对数量
        final index = i ~/ 2;
        // 如果是建议列表中最后一个单词对
        if (index >= _suggestions.length) {
          // ...接着再生成10个单词对，然后添加到建议列表
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      },
    );
  }

  //根据建议列表构造text组件
  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return new ListTile(
        title: new Text(
          pair.asPascalCase,
          style: _biggerFont,
        ),
        subtitle: new Text(pair.asPascalCase, textDirection: TextDirection.ltr),
        //dense: true,
        trailing:
            new Icon(alreadySaved ? Icons.favorite : Icons.favorite_border,
                //Icons.keyboard_arrow_right,
                color: alreadySaved ? Colors.red : null),
        onTap: () {
          setState(() {
            if (alreadySaved) {
              _saved.remove(pair);
            } else {
              _saved.add(pair);
            }
          });
        });
  }
}
