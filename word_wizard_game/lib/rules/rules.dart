class Rules {
// create a rule for the entred strings



// create a rule for verifying the entred word vs. the word chosen by the computer
 static List<int> checkStringEquality(String string1, String string2) {
    // If the strings are equal, return an empty list.
    if (string1 == string2) {
      print("The strings are equal.");
      return [1,2,3,4,5];
    }

    // Initialize an empty list to hold the matching indices.
    List<int> matchingIndices = [];

    // Get the minimum length to avoid index out of range issues.
    int minLength =
        string1.length < string2.length ? string1.length : string2.length;

    // Iterate through both strings and compare characters.
    for (int i = 0; i < minLength; i++) {
      if (string1[i] == string2[i]) {
        matchingIndices.add(i); // Add the index where characters are the same.
      }
    }

    return matchingIndices;
  }



}
