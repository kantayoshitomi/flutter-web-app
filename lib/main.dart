import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('ルーレットアプリ'),
            leading: Padding(
             padding: const EdgeInsets.all(8.0),
             child: Image.network('https://dopa-game.jp/dopa_new_logo.png'), // ロゴのURLを指定
          ),
        ),
        body: const RoulettePage(),
      ),
    );
  }
}

class RoulettePage extends StatefulWidget {
  const RoulettePage({super.key});

  @override
  State<RoulettePage> createState() => _RoulettePageState();
}

class _RoulettePageState extends State<RoulettePage> {
  final StreamController<int> _controller = StreamController<int>();
  final List<String> _items = ['A', 'B', 'C', 'D'];

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  void _spinRoulette() {
    final randomIndex = (DateTime.now().millisecondsSinceEpoch % _items.length);
    _controller.add(randomIndex); // ランダムに選択
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: 300,
              width: 300,
              child: FortuneWheel(
                selected: _controller.stream,
                items: _items.map((item) => FortuneItem(child: Text(item))).toList(),
              ),
            ),
            // 中央の画像
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage('https://dopa-game.jp/dopa_new_logo.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _spinRoulette,
          child: const Text('ルーレットを回す'), // childプロパティを追加
        ),
      ],
    );
  }
}
