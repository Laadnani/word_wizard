import 'dart:math';
import 'package:flutter/material.dart';
import 'package:word_wizard_game/words.dart/words_en.dart';

class GameProvider extends ChangeNotifier {
  static int maxTiles = 5;

// random index

  final _randomIndex = Random();

  // Word to be guessed
  static String _wordToBeGuessed = '';

  // Getter for the word to be guessed
  String get wordToBeGuessed => _wordToBeGuessed;

  // Setter for the word to be guessed
  set wordToBeGuessed(String getRandomWord) {
    _wordToBeGuessed = getRandomWord;
    notifyListeners();
  }

  

  // Generate a random word
  String getRandomWord() {
    final randomIndex = _randomIndex.nextInt(WordsEn.fiveLetters.length);
    final selectedPair = WordsEn.fiveLetters[randomIndex];
    return selectedPair[0]; // Return only the word
  }

  // get Hint for the user

String getRandomHint(){
  final randomIndex = _randomIndex.nextInt(WordsEn.fiveLetters.length);
  final selectedPair = WordsEn.fiveLetters[randomIndex];
  return selectedPair[1]; // Return only the hint
}
  // Hint for the user
  String _hint = '';

  // Getter for the hint
  String get hint => _hint;

  // Setter for the hint
  set hint(String getRandomHint) {
    _hint = getRandomHint;
    notifyListeners();
  }

  // Update the word to be guessed and notify listeners
  void updateWordToBeGuessed() {
    _wordToBeGuessed = getRandomWord();
    // Find the corresponding hint in the list based on the word
    for (var pair in WordsEn.fiveLetters) {
      if (pair[0] == _wordToBeGuessed) {
        _hint = pair[1];
        break;
      }
    }
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

  List<String> splitword2(String word, int index) {
    List<String> letters = [];

    for (int i = 0; i < index; i++) {
      letters.add(word[i]);
    }
    return letters;
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

  // icons tries function

  List<IconData> iconTries({required int tries, required int triesUsed}) {
    assert(tries >= 0);
    assert(triesUsed >= 0);
    // Improved function with clear variable names and concise logic
    final usedIcons = List.generate(triesUsed, (_) => Icons.abc);
    final remainingIcons =
        List.generate(tries - triesUsed, (_) => Icons.abc_rounded);
    final iconsRendered = [...usedIcons, ...remainingIcons];
    return iconsRendered;
  }

  static String _TextToOUput = '';

  String get TextToOUput => _TextToOUput;

  void updateTextToOUput(String value) {
    _TextToOUput = value;
    notifyListeners();
  }

  static List<int> _hints = [];

  List<int> get hints => _hints;

  void updateHints(List<int> value) {
    _hints = value;
    notifyListeners();
  }
}
