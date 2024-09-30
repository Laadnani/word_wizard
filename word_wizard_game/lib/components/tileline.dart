import 'package:flutter/material.dart';
//import 'package:word_wizard_game/rules/rules.dart';

class WordTiles extends StatefulWidget {
   WordTiles({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WordTilesState createState() => _WordTilesState();
}

class _WordTilesState extends State<WordTiles> {
  final TextEditingController _controller = TextEditingController();
  String enteredText = '';
  final int maxTiles = 5; // Define the number of tiles
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        enteredText = _controller.text;
      });
    });
    // Automatically request focus when the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Request focus on the hidden TextField when tapping anywhere on the screen
        FocusScope.of(context).requestFocus(_focusNode);
      },
      child: Padding(
       padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // HIDDEN TextField - capturing input without showing it
            TextField(
              controller: _controller,
              maxLength: maxTiles, // Optional: restrict input length
              focusNode: _focusNode,
              decoration: const InputDecoration(
                border: InputBorder.none, // Hide the border
                counterText: '', // Remove counter
                label: Text(''),
                enabled: true, // Make it inactive
              ),
              style: const TextStyle(
                  color: Colors.transparent), // Make text invisible
              showCursor: false, // Hide the cursor
              enableInteractiveSelection: false, // Disable selection
              autofocus: true, // Automatically focus
            ),
    
            // Display the tiles
            Wrap(
              spacing: 8.0, // space between the tiles
              children: List.generate(
                maxTiles, // Always generate maxTiles number of tiles
                (index) => Container(
                  width: 40,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.blueAccent),
                    color: Colors.grey.shade200,
                  ),
                  child: Text(
                    index < enteredText.length ? enteredText[index] : '',
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
