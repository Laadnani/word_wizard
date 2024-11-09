// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:word_wizard_game/components/tile.dart';


class Tiles extends StatefulWidget {
  final String textEntered;
  final int tileCount;  final int tileIndex; // Index of the current tile
  final Function(String)  onTileTap;
  
   const Tiles({
    super.key,
    required this.textEntered,
    required this.tileCount,
    required this.onTileTap, // Accept the onTileTap function
    required this.tileIndex, // Accept the tileIndex
    color,
    //required this.isActive, // Accept the isActive
    //requires this.activeindex // activate the tile at index activeindex
  });

  @override
  State<Tiles> createState() => _TilesState();
}

class _TilesState extends State<Tiles> {
 // Fixed number of tiles
  late Color color;


  @override
  Widget build(BuildContext context) {

   

    return Padding(
      padding: const EdgeInsets.all(16.0),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          widget.tileCount, // Generate a fixed number of tiles
          (i) => Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 4.0), // Space between tiles
            child: GestureDetector( // Use GestureDetector to detect taps
              onTap: () {
                if (i < widget.textEntered.length) {
                  // Only tap existing tiles
                  widget.onTileTap(widget.textEntered[i]); // Call the onTileTap function with the tapped letter
                } else {
                  
                }
              },
              
              child: Tile(
                textEntered: i < widget.textEntered.length && widget.textEntered.isNotEmpty
                    ? widget.textEntered[i]
                    : '', // Handle empty tiles
                   index: i,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
