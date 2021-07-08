import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:soundpool/soundpool.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> _texts = [
    /* サウンドボタンのTextリスト */
    'おめでとうございます',
    '合格です',
    'よくできました',
    '残念でした',
    '不合格です',
    '頑張りましょう'
  ];

  List<int> _soundIds = [0, 0, 0, 0, 0, 0];

  late Soundpool _soundpool;

  // 本来ここでは初期化Soundpool _soundpool = Soundpool();とすべきだが
  // 今回はinitState()メソッドを作成しているのでこの段階ではnullとするより他ない。よってlateを付与している。
  // 詳しい解説はセクション6:105.を参照

  @override
  void initState() async {
    /* Widget生成直後に1回だけ通るメソッド */
    super.initState();
    await _initSounds();
  }

  Future<void> _initSounds() async {
    _soundpool = Soundpool.fromOptions();

    /* サウンドリスト */
    _soundIds[0] = await loadSound('assets/sounds/sound1.mp3');
    _soundIds[1] = await loadSound('assets/sounds/sound2.mp3');
    _soundIds[2] = await loadSound('assets/sounds/sound3.mp3');
    _soundIds[3] = await loadSound('assets/sounds/sound4.mp3');
    _soundIds[4] = await loadSound('assets/sounds/sound5.mp3');
    _soundIds[5] = await loadSound('assets/sounds/sound6.mp3');
  }

  Future<int> loadSound(String soundPath) {
    /* rootBandleからサウンドデータを_soundpoolへ渡す */
    return rootBundle.load(soundPath).then((value) => _soundpool.load(value));
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
                  Expanded(
                      flex: 1, child: _soundButton(_texts[0], _soundIds[0])),
                  // 'おめでとうございます'ボタン
                  Expanded(
                      flex: 1, child: _soundButton(_texts[1], _soundIds[1])),
                  // '合格です'ボタン
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                      flex: 1, child: _soundButton(_texts[2], _soundIds[2])),
                  // 'よくできました'ボタン
                  Expanded(
                      flex: 1, child: _soundButton(_texts[3], _soundIds[3])),
                  // '残念でした'ボタン
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                      flex: 1, child: _soundButton(_texts[4], _soundIds[4])),
                  // '不合格です'ボタン
                  Expanded(
                      flex: 1, child: _soundButton(_texts[5], _soundIds[5])),
                  // '頑張りましょう'ボタン
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _soundButton(String displayText, int soundId) {
    // ここの'String'は型を明示しているだけなので無くても動く
    return Container(
      padding: EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () => _playSound(soundId), // 音を鳴らす
        child: Text(displayText),
      ),
    );
  }

  void _playSound(int soundId) {
    /* サウンドを再生する */
    _soundpool.play(soundId);

  }
}
