import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScrabbleStack extends StatefulWidget {
  final int numberOfTiles;
  final Color tileColor;
  final bool autoFocus;
  final int stat;
  final String initialText;
  final FocusNode? focusNode;
  final TextEditingController controller;

  ScrabbleStack({
    Key? key, // Ensure the key is included
    required this.numberOfTiles,
    this.tileColor = Colors.blue,
    this.autoFocus = false,
    required this.stat,
    this.initialText = '',
    this.focusNode,
    required this.controller,
  }) : super(key: key);

  @override
  ScrabbleStackState createState() => ScrabbleStackState();
}

// Make the state class public by removing the underscore
class ScrabbleStackState extends State<ScrabbleStack> {
  late String _enteredText;
  late List<Color> tileColors;

  @override
  void initState() {
    super.initState();
    _enteredText = widget.controller.text;
    tileColors = List<Color>.filled(widget.numberOfTiles, widget.tileColor);

    if (widget.autoFocus) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.focusNode?.requestFocus();
      });
    }

    widget.controller.addListener(() {
      setState(() {
        _enteredText = widget.controller.text;
      });
    });
  }

  /// Function to color tiles based on comparison with a given character
 void colorTilesBasedOnComparison(String wordToGuess) {
    setState(() {
      for (int i = 0; i < widget.numberOfTiles; i++) {
        if (i < _enteredText.length) {
          String enteredChar = _enteredText[i].toUpperCase();
          String targetChar = wordToGuess[i].toUpperCase();

          if (enteredChar == targetChar) {
            // Character is correct and at the correct index
            tileColors[i] = Colors.greenAccent;
          } else if (wordToGuess.toUpperCase().contains(enteredChar)) {
            // Character exists in word but at a different index
            tileColors[i] = Colors.yellowAccent;
          } else {
            // Character does not exist in word
            tileColors[i] = Colors.redAccent;
          }
        } else {
          // Reset color for empty or extra tiles
          tileColors[i] = widget.tileColor;
        }
      }
    });

    // Debugging: Print the updated colors
    print("Tile colors updated for line: ${tileColors.toString()}");
  }

  List<Color> getColorsBackToNormal() {

    return

    tileColors = List<Color>.filled(widget.numberOfTiles, const Color.fromARGB(255, 156, 199, 235));
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Tiles layout
        Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(widget.numberOfTiles, (index) {
            String displayChar =
                index < _enteredText.length ? _enteredText[index] : '';
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: GestureDetector(
                onTap: () {
                  widget.focusNode?.requestFocus();
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: tileColors[index],
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[500]!,
                        blurRadius: 5,
                        offset: const Offset(3, 3),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    displayChar.toUpperCase(),
                    style: GoogleFonts.inknutAntiqua(
                        fontSize: 24, color: Colors.black),
                  ),
                ),
              ),
            );
          }),
        ),
        // Invisible input field
        Positioned.fill(
          child: TextField(
            controller: widget.controller,
            focusNode: widget.focusNode,
            showCursor: false,
            autofocus: widget.autoFocus,
            maxLength: widget.numberOfTiles,
            style: const TextStyle(color: Colors.transparent),
            decoration: const InputDecoration(
              counterText: '',
              border: InputBorder.none,
              isCollapsed: true,
            ),
          ),
        ),
      ],
    );
  }
}
