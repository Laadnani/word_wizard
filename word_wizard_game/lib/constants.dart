class Cts {


  static String homeScreen = '/homeScreen';

  static String settingScreen ='/settingScreen';


  // game settings 

// num of tiles

  final int _numOfTiles = 5 ;
  int get numOfTiles => _numOfTiles;
  set numOfTiles(int value) => _numOfTiles;


// chosen word to play on

  final String _chosenWord = '';
    set chosenWord(String value) => _chosenWord;
    String get chosenWord => _chosenWord;


}