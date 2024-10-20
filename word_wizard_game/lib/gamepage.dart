import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:word_wizard_game/background.dart';
import 'package:word_wizard_game/rules/rules.dart';
import 'gameprovider.dart'; // Import your GameProvider
import 'components/tileline.dart'; // Import your Tiles widget

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  GameProvider gm = GameProvider();
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode =
      FocusNode(); // Focus node to control the keyboard

  bool isCorrectGuess(List<int> A) {
    const listEquality = ListEquality<int>();
    return listEquality.equals(A, [1, 2, 3, 4, 5]);
  }

  void handleTries(int tries, bool correctGuess, int triesCount) {
    if (!correctGuess) {
      if (tries == 0) {
        print('You Lose');
        gm.updateWordToBeGuessed();
        gm.resetUsedTries(0);
        gm.resetTriesLeft(5);
      } else {
        print('Try again');
        gm.updateTriesLeft(gm.triesLeft);
        gm.updateTriesUsed(gm.triesUsed);
      }
    } else {
      print('You Win after ${triesCount + 1} tries');
      gm.updateWordToBeGuessed();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWrapper(
      child: Scaffold(
       appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back, size: 30 , color: Colors.white,),
        onPressed: () {
         Navigator.pop(context);}
         ),
         backgroundColor: const Color.fromARGB(0, 255, 255, 255),),
         

        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              Consumer<GameProvider>(
                builder: (context, gameProvider, child) {
                  return Text(
                    'Word to be guessed: ${gm.wordToBeGuessed}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
              const SizedBox(height: 30),
              Stack(
                alignment: Alignment.center,
                children: [
                  // Tiles with GestureDetector for tap interaction
                  Consumer<GameProvider>(
                    builder: (context, gameProvider, child) {
                      return GestureDetector(
                        onTap: () {
                          FocusScope.of(context).requestFocus(_focusNode);
                        },
                        child: Tiles(
                          tileIndex: gm.pagetileIndex,
                          textEntered: gameProvider.inputText,
                          tileCount: 5,
                          onTileTap: (String letter) {
                            String newText = gameProvider.inputText;
                            context.read<GameProvider>().updateInputText(newText);
                            FocusScope.of(context).requestFocus(_focusNode);
                          },
                        ),
                      );
                    },
                  ),
                  // Invisible TextField to receive input
                  Positioned.fill(
                    child: Opacity(
                      opacity: 0.0, // Make it invisible
                      child: TextField(
                        controller: _controller,
                        focusNode: _focusNode,
                        onChanged: (value) {
                          context.read<GameProvider>().updateInputText(value);
                        },
                        onSubmitted: (value) {
                          gm.clearInput();
                          _controller.clear();
                        },
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        style: const TextStyle(color: Colors.transparent),
                        cursorColor: Colors.transparent,
                        maxLines: 1,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  print(
                      'Word to be guessed: ${gm.splitword(gm.wordToBeGuessed, 5)}');
                  print('Word guessed: ${gm.splitword(gm.inputText, 5)}');
                  print(
                    'Word equality: ${Rules.checkStringEquality(gm.wordToBeGuessed, gm.inputText)}',
                  );
                  handleTries(
                    gm.triesLeft,
                    isCorrectGuess(Rules.checkStringEquality(
                        gm.wordToBeGuessed, gm.inputText)),
                    gm.triesUsed,
                  );
                  setState(() {
                    context.read<GameProvider>().clearInput();
                    _controller.clear();
                  });
                },
                child: const Text('Check word'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}