import 'package:flutter/material.dart';
import 'package:soundpool/soundpool.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> _texts = [
    'おめでとうございます',
    '合格です',
    'よくできました',
    '残念でした',
    '不合格です',
    '頑張りましょう'
  ];

  late Soundpool _soundpool;

  @override
  void initState() {
    /* Widget生成直後に1回だけ通るメソッド */
    _soundpool = Soundpool.fromOptions();
    super.initState();
  }

  @override
  void dispose() {
    /* Widget破棄直前に1回だけ通るメソッド */
    _soundpool.release();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ツッコミマシーン'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(flex: 1, child: _soundButton(_texts[0])),
                  // 'おめでとうございます'ボタン
                  Expanded(flex: 1, child: _soundButton(_texts[1])),
                  // '合格です'ボタン
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(flex: 1, child: _soundButton(_texts[2])),
                  // 'よくできました'ボタン
                  Expanded(flex: 1, child: _soundButton(_texts[3])),
                  // '残念でした'ボタン
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(flex: 1, child: _soundButton(_texts[4])),
                  // '不合格です'ボタン
                  Expanded(flex: 1, child: _soundButton(_texts[5])),
                  // '頑張りましょう'ボタン
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _soundButton(String displayText) {
    // ここの'String'は型を明示しているだけなので無くても動く
    return Container(
      padding: EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: null,
        child: Text(displayText),
      ),
    );
  }
}
