import 'package:collection/collection.dart';

class Rules {
// create a rule for the entred strings

// create a rule for verifying the entred word vs. the word chosen by the computer
  static List<int> checkStringEquality(String string1, String string2) {
    // If the strings are equal, return an empty list.
    if (string1 == string2) {
      print("The strings are equal.");
      return [0, 1, 2, 3, 4];
    }

    // Initialize an empty list to hold the matching indices.
    List<int> matchingIndices = [];

    // Get the minimum length to avoid index out of range issues.
    int minLength =
        string1.length < string2.length ? string1.length : string2.length;

    // check if the letters are in the list

    // Iterate through both strings and compare characters.
    for (int i = 0; i < minLength; i++) {
      if (string1[i] == string2[i]) {
        matchingIndices.add(i); // Add the index where characters are the same.
      }
    }

    return matchingIndices;
  }

 static List<List<String>> compareLists(List<String> givenWord, List<String> input) {
    List<List<String>> result = [];

    for (int i = 0; i < input.length; i++) {
      String letter = input[i];
      String status;

      if (givenWord.contains(letter)) {
        if (letter == givenWord[i]) {
          status = "is correct";
        } else {
          status = "is in wrong index";
        }
      } else {
        status = "is incorrect";
      }

      result.add([letter, status]);
    }

    return result;
  }




}
