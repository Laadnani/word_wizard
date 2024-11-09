import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui'; // For BackdropFilter
import 'package:word_wizard_game/background.dart';
import 'gameprovider.dart';
import 'second.dart'; // Ensure correct import path

class Secondgame extends StatefulWidget {
  const Secondgame({super.key});

  @override
  State<Secondgame> createState() => _SecondgameState();
}

class _SecondgameState extends State<Secondgame> {
  final GameProvider gm = GameProvider();
  List<TextEditingController>? _controllers;
  List<FocusNode>? _focusNodes;
  int _currentLineIndex = 0;
  bool _hasShownPopup = false;
  int numberOfTiles = 5;
  late String wordToGuess;
  late String hint;
  late List<Color> origintileColors =
      List.generate(numberOfTiles, (_) => Colors.grey);

  // Create a list of GlobalKeys to manage ScrabbleStack instances
  final List<GlobalKey<ScrabbleStackState>> _scrabbleStackKeys = List.generate(
    5,
    (_) => GlobalKey<ScrabbleStackState>(),
  );

  @override
  void initState() {
    super.initState();
    _focusNodes = List.generate(5, (_) => FocusNode());
    _controllers = List.generate(5, (_) => TextEditingController());
    gm.updateWordToBeGuessed();
    wordToGuess = gm.wordToBeGuessed;
    hint = gm.hint;
  }

// HINT POPUP managing state
  bool _isPopupVisible = false; // Manage visibility state here

  void _togglePopupVisibility() {
   
    setState(() {
      _isPopupVisible = !_isPopupVisible; // Toggle visibility
    });
  }

  @override
  void dispose() {
    _controllers?.forEach((controller) => controller.dispose());
    _focusNodes?.forEach((focusNode) => focusNode.dispose());

    super.dispose();
  }

// Show a congratulations popup when the word is correct

 void _showCongratulationsPopup(String guessedWord) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent, // Set background transparent
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15), // Rounded corners
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Glass Effect Background
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Container(
                  color: Colors.black.withOpacity(0.2), // Slight transparency
                  width: 300, // Set the width of the dialog
                  height: 200, // Set the height of the dialog
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Title
                      const Text(
                        'Congratulations!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Content
                      Text(
                        'The word was $guessedWord',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white.withOpacity(0.8),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      // Action Button
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[700],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 24,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                          for (var controller in _controllers!) {
                            controller.clear();
                          }
                          setState(() {
                            _currentLineIndex = 0;
                            gm.updateWordToBeGuessed();
                            origintileColors = colorBack();
                            wordToGuess = gm.wordToBeGuessed;
                            hint = gm.hint;
                            _hasShownPopup = false;  // Reset the flag for the next game
                          });
                          _focusNodes![0].requestFocus();
                        },
                        child: const Text(
                          'Guess another word',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}


   void _ShowHint() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent, // Set background transparent
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15), // Rounded corners
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Glass Effect Background
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(
                    color: Colors.black.withOpacity(0.2), // Slight transparency
                    width: 300, // Set the width of the dialog
                    height: 200, // Set the height of the dialog
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Title
                        const Text(
                          'Hint !',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Content
                        Text(gm.hint,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white.withOpacity(0.8),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        // Action Button
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green[700],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 24),
                          ),
                          onPressed: () {
                            // Close the popup and reset the game state
                            Navigator.of(context).pop();
                        
                          },
                          child: const Text(
                            'Hide Hint',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _focusNextLine() {
    TextEditingController currentController = _controllers![_currentLineIndex];
    if (currentController.text.length == 5 ) {
      // Color tiles based on comparison for the current line
      final currentScrabbleStackKey = _scrabbleStackKeys[_currentLineIndex];
      currentScrabbleStackKey.currentState
          ?.colorTilesBasedOnComparison(wordToGuess);

      // Check if the entered word matches the word to guess
     if (currentController.text.toUpperCase() == wordToGuess.toUpperCase()) {
        // If the word matches, show the popup only if the flag is not set
        if (!_hasShownPopup) {
          _showCongratulationsPopup(wordToGuess);
          _hasShownPopup = true;
        }
      }

      // Check if it's not the last line
      if (_currentLineIndex < _focusNodes!.length - 1) {
        setState(() {
          _currentLineIndex++;
        });
        _focusNodes![_currentLineIndex].requestFocus();
      } else {
        // If it's the last line, clear all controllers and reset
         if (currentController.text.toUpperCase() == wordToGuess.toUpperCase()) {
          // If the word matches, show the popup
          if (!_hasShownPopup) {
            _showCongratulationsPopup(wordToGuess); // Pass the current word
            _hasShownPopup = true;
          }
        }
        for (var controller in _controllers!) {
          controller.clear();
        }
        setState(() {
          _currentLineIndex = 0;
          gm.updateWordToBeGuessed();
          origintileColors = colorBack();
          wordToGuess = gm.wordToBeGuessed;
          hint = gm.hint;
        });
        _focusNodes![0].requestFocus();

        _resetGameState();
      }
    } else {
      // If input length is not equal to number of tiles, clear the input of the current line
      currentController.clear();
      _focusNodes![_currentLineIndex].requestFocus();
    }
  }

  List<Color> colorBack() {
    // Access the state of the ScrabbleStack using the GlobalKey and reset the colors
    for (var key in _scrabbleStackKeys) {
      key.currentState?.getColorsBackToNormal();
    }
    return origintileColors; // Return the original colors after resetting
  }

  // Function to reset the game state to the first line and change the word to guess
  void _resetGameState() {
    setState(() {
      _hasShownPopup = false; // Reset the flag for the next game
      _currentLineIndex = 0; // Reset to the first line
      for (var controller in _controllers!) {
        controller.clear(); // Clear all text controllers
      }
      // Reset tile colors to original gray color (or any default color)
      origintileColors = List.generate(
          numberOfTiles, (_) => const Color.fromARGB(255, 156, 199, 235));

      // Update the word to guess
      gm.updateWordToBeGuessed();
      wordToGuess = gm.wordToBeGuessed; // Set the new word
      hint = gm.hint; // Set the new hint
    });
    _focusNodes![0].requestFocus(); // Focus on the first line
   
  }

/////////////////////////
////////////////////////////
////////////////////////////
////////////////////////////
////////////////////////////////// THE GAME PAGE /////////////////////////
////////////////////////////
////////////////////////////
////////////////////////////

  @override
  Widget build(BuildContext context) {
    return BackgroundWrapper(
      child:SafeArea(
      child: Stack(
        children: [
          Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(60.0),
              child: Stack(
                children: [
                  AppBar(
                    backgroundColor: Colors.transparent,
                    leading: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        size: 30,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        _resetGameState();
                        Navigator.pop(context);
                      },
                    ),
                    actions: [
                      IconButton(
                        icon: const Icon(
                          Icons.help_outline,
                          color: Colors.white,
                          size: 30.0,
                        ),
                        onPressed: _ShowHint,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Generate ScrabbleStack widgets with unique GlobalKeys
                for (int index = 0; index < _controllers!.length; index++)
                  Column(
                    children: [
                      ScrabbleStack(
                        key:
                            _scrabbleStackKeys[index], // Assign unique key here
                        numberOfTiles: numberOfTiles,
                        tileColor: origintileColors[index],
                        stat: 0,
                        autoFocus: index == _currentLineIndex,
                        focusNode: _focusNodes![index],
                        controller: _controllers![index],
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ElevatedButton(
                  onPressed: () {
                    _focusNextLine(); // Color and focus control on button press
                    print('Word to guess: $wordToGuess');
                    print('Hint: $hint');
                  },
                  style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 20),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    backgroundColor: Colors.green[700],
                  ),
                  child: Text(
                    'Check Word',
                    style: GoogleFonts.inknutAntiqua(
                        fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),]
      ),
      )
    );
  }
}
