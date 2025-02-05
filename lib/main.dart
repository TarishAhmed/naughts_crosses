import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String?> _board = List.filled(9, null);
  bool _isXTurn = true;
  String? _winner;

  void _handleTap(int index) {
    if (_board[index] != null || _winner != null) return;
    setState(() {
      _board[index] = _isXTurn ? 'X' : 'O';
      _isXTurn = !_isXTurn;
      _winner = _checkWinner();
    });
  }

  String? _checkWinner() {
    final List<List<int>> winningCombos = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];
    for (var combo in winningCombos) {
      final a = combo[0], b = combo[1], c = combo[2];
      if (_board[a] != null &&
          _board[a] == _board[b] &&
          _board[a] == _board[c]) {
        return _board[a];
      }
    }
    if (!_board.contains(null)) return 'Draw';
    return null;
  }

  void _resetGame() {
    setState(() {
      _board = List.filled(9, null);
      _isXTurn = true;
      _winner = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20,
          children: [
            Text(
              _winner == null
                  ? 'Turn: ${_isXTurn ? 'X' : 'O'}'
                  : _winner == 'Draw'
                      ? 'Game Drawn'
                      : 'Winner: $_winner',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(
              width: 300,
              height: 300,
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                ),
                itemCount: 9,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => _handleTap(index),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                      ),
                      child: Center(
                        child: Text(
                          _board[index] ?? '',
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _resetGame,
              child: Row(
                spacing: 8,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Restart'),
                  Icon(Icons.refresh),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
