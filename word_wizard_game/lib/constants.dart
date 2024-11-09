class Cts {
  static String homeScreen = '/homeScreen';

  static String settingScreen = '/settingScreen';
  static String gameScreen = '/gameScreen';
  static String second = '/second';
  static String third = '/third';

  // game settings

// num of tiles

  final int _numOfTiles = 5;
  int get numOfTiles => _numOfTiles;
  set numOfTiles(int value) => _numOfTiles;

// chosen word to play on

  static String _chosenWord = 'world';
  set chosenWord(String value) => _chosenWord;
  String get chosenWord => _chosenWord;

  //  setting an entred word variable

  static String _entredWord = '';
  set entredWord(String value) => _entredWord;
  String get entredWord => _entredWord;

  static String _iconTryused = 'X'; 
  set iconused(String value) => _iconTryused;
  String get iconused => _iconTryused;

  static String _iconnTryLeft = '0';
  set iconnTryLeft(String value) => _iconnTryLeft;
  String get iconnTryLeft => _iconnTryLeft;
}
