
import 'package:flutter/material.dart';
import 'package:word_wizard_game/components/tileline.dart';




class HintTiles extends StatefulWidget {
  final List<List<String>> letterStatuses;
  final int maxPresses;

  const HintTiles({
    super.key,
    required this.letterStatuses,
    required this.maxPresses,
  });

 

  @override
  State<HintTiles> createState() => _HintTilesState();
}

class _HintTilesState extends State<HintTiles> {
final  int _pressCount = 1;



  @override
  Widget build(BuildContext context) {
    return _pressCount < widget.maxPresses
        ? Padding(
            padding: const EdgeInsets.all(1),
            child: Padding(
             padding: const EdgeInsets.all(2.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.letterStatuses.map((hint) {
                  final letter = hint[0];
                  final status = hint[1];
                  return Tiles(textEntered: letter, tileCount: 5, onTileTap: onTapTile, tileIndex: _pressCount, color: getColorByStatus(status));
                }).toList(),
              ),
            ),
          )
        : const Text('Nothing Yet');
  }

  Color getColorByStatus(String status) {
    switch (status) {
      case "is correct":
        return Colors.green;
      case "is in wrong index":
        return const Color.fromARGB(255, 127, 129, 7);
      default:
        return const Color.fromARGB(255, 177, 7, 7);
    }
  }

  void onTapTile(String letter) {
    // Implement a default behavior or logging here
    print("Default tap: $letter");
  }
}
