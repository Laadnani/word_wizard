// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:word_wizard_game/components/tile.dart';
import 'package:word_wizard_game/gameprovider.dart';

class Tiles extends StatelessWidget {
  final String textEntered;
  final int tileCount; // Fixed number of tiles
  //final bool isActive;
  final int tileIndex; // Index of the current tile
  final Function(String) onTileTap; // Specify the type for clarity

  const Tiles({
    super.key,
    required this.textEntered,
    required this.tileCount,
    required this.onTileTap, // Accept the onTileTap function
    required this.tileIndex, // Accept the tileIndex
    //required this.isActive, // Accept the isActive
    //requires this.activeindex // activate the tile at index activeindex
  });

  @override
  Widget build(BuildContext context) {

   

    return Padding(
      padding: const EdgeInsets.all(16.0),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          tileCount, // Generate a fixed number of tiles
          (i) => Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 4.0), // Space between tiles
            child: GestureDetector( // Use GestureDetector to detect taps
              onTap: () {
                if (i < textEntered.length) {
                  // Only tap existing tiles
                  onTileTap(textEntered[i]); // Call the onTileTap function with the tapped letter
                } else {
                  
                }
              },
              
              child: Tile(
                textEntered: i < textEntered.length && textEntered.isNotEmpty
                    ? textEntered[i]
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
