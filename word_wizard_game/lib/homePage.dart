import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:word_wizard_game/components/tile.dart';
import 'package:word_wizard_game/rules/rules.dart';
import 'gameprovider.dart'; // Import your GameProvider
import 'components/tileline.dart'; // Import your Tiles widget

class HomePage extends StatefulWidget {
   const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  GameProvider gm = GameProvider();
   final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode(); // Focus node to control the keyboard

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Word Wizard')),
      body: SafeArea(
        child: Column(
          children: [
            Consumer<GameProvider>(
              builder: (context, gameProvider, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Word to be guessed: ${gm.wordToBeGuessed}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                );
              },
            ),

            // GestureDetector to trigger focus and keyboard input
            Consumer<GameProvider>(
              builder: (context, gameProvider, child) {
                return GestureDetector(
                  onTap: () {
                    // Request focus to show keyboard
                    FocusScope.of(context).requestFocus(_focusNode);
                  },
                  child: Column(
                    children: [
                      Tiles(
                        tileIndex: gm.pagetileIndex,
                        textEntered: gameProvider.inputText,
                        tileCount: 5,
                        onTileTap: (String letter) {
                          // Update input text through the provider
                          String newText = gameProvider.inputText ;
                          context.read<GameProvider>().updateInputText(newText);

                          // Request focus to show the keyboard after updating input
                          FocusScope.of(context).requestFocus(_focusNode);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),

            // Invisible TextField to receive input
            TextField(
              controller: _controller,
              focusNode: _focusNode,
              onChanged: (value) {
                context.read<GameProvider>().updateInputText(value);
              },
              onSubmitted: (value) {
                // Instead of creating a new GameProvider instance, use the existing one.
                gm.updateWordToBeGuessed(); // This updates the current gameProvider's wordToBeGuessed
                // Clear the input
                gm.clearInput();
                _controller.clear();
                print(gm.inputText + 'on submitted');
              },
              decoration: const InputDecoration(
                border:
                    InputBorder.none, // Remove border to make it look invisible
                fillColor: Colors.transparent, // Transparent background
                filled: true,
              ),
              style:
                  const TextStyle(color: Colors.transparent), // Hide the text
              cursorColor: Colors.transparent, // Hide the cursor
              maxLines: 1, // Single line input
            ),

            ElevatedButton(
              onPressed: () {

                 // Use gameProvider instead of creating a new GameProvider instance
                print(
                    'word to be guessed: ${gm.splitword(gm.wordToBeGuessed, 5)}');
                print(
                    'word guessed: ${gm.splitword(GameProvider().inputText, 5)}');
                print(
                    'word equality: ${Rules.checkStringEquality(gm.wordToBeGuessed, GameProvider().inputText)}');

                // Clear input and generate new word
              setState(() {
                  // Force UI rebuild
                 
                  final gameProvider = context.read<GameProvider>();
                  gameProvider.clearInput();
                  _controller.clear();
                  gameProvider.updateWordToBeGuessed();
                });
              },
              child: const Text('Check word'),
            ),
          ],
        ),
      ),
    );
  }
}
