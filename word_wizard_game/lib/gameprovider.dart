import 'dart:math';
import 'package:flutter/material.dart';
import 'package:word_wizard_game/words.dart/words_en.dart';

class GameProvider extends ChangeNotifier {
  static int maxTiles = 5;

  // Word to be guessed
  static String _wordToBeGuessed = _generateWord();

  // Generate a random word
  static String _generateWord() {
    int index = Random().nextInt(WordsEn.fiveLetters.length);
    return WordsEn.fiveLetters[index];
  }

  String get wordToBeGuessed => _wordToBeGuessed;

  set wordToBeGuessed(String value) {
    _wordToBeGuessed = value;
    notifyListeners();
  }

  // Update the word to be guessed and notify listeners
  void updateWordToBeGuessed() {
    _wordToBeGuessed = _generateWord();
    notifyListeners();
  }

  // Store tiles entered by the user
  static String _inputText = '';

  // Getter for input text
  String get inputText => _inputText;

  // Update input text and notify listeners
  void updateInputText(String value) {
    _inputText = value;
    notifyListeners();
  }

  // Clear input text
  void clearInput() {
    _inputText = '';
    notifyListeners();
  }

  // String helpers

  List<String> splitword(String word, int index) {
    List<String> letters = [];
    if (index > word.length) {
      return ['Please enter $index letters.'];
    } else {
      for (int i = 0; i < index; i++) {
        letters.add(word[i]);
      }
      return letters;
    }
  }

// TILES HANDELING GESTURES AND STATES

// input count anch checks

  static int _inputCount = 0;

  int get inputCount => _inputCount;

  void updateInputCount(int value) {
    _inputCount = value;
    notifyListeners();
  }

  // hqndling which tileline is on focus

  static int _pagetileIndex = 1;

  get pagetileIndex => _pagetileIndex;

  void updatePagetileIndex(int value) {
    _pagetileIndex = value + 1;
    notifyListeners();
  }

// number of tries per game
  static int _tries = 5;

  int get triesLeft => _tries;

  set triesLeft(int value) {
    _tries = value;
    notifyListeners();
  }

  void resetTriesLeft(int value) {
    _tries = value;
    notifyListeners();
  }

  void updateTriesLeft(int value) {
    _tries = value - 1;
    notifyListeners();
  }

// number of tries used

  static int _triesUsed = 0;

  int get triesUsed => _triesUsed;

  void resetUsedTries(int value) {
    _triesUsed = value;
    notifyListeners();
  }

  void updateTriesUsed(int value) {
    _triesUsed = value + 1;
    notifyListeners();
  }

   

}
