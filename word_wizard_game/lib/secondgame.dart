import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:word_wizard_game/ad_mob_service.dart';
import 'dart:ui'; // For BackdropFilter
import 'package:word_wizard_game/background.dart';
import 'gameprovider.dart';
import 'second.dart'; // Ensure correct import path

class Secondgame extends StatefulWidget {
  const Secondgame({super.key});

  @override
  State<Secondgame> createState() => _SecondgameState();
}

class _SecondgameState extends State<Secondgame> {
  final GameProvider gm = GameProvider();
   
  RewardedAd? _rewardedAd;
  List<TextEditingController>? _controllers;
  List<FocusNode>? _focusNodes;
  int _currentLineIndex = 0;
  int countForAds = 0;
  bool _hasShownPopup = false;
  late int numberOfTiles; // Late initialization
  late String wordToGuess;
  late String hint;
  late List<Color> origintileColors;
  late List<GlobalKey<ScrabbleStackState>> _scrabbleStackKeys;

 @override
  void initState() {
    super.initState();

    // Access the selectedLang value from the GameProvider
    final gameProvider = Provider.of<GameProvider>(context, listen: false);

    numberOfTiles = 5; // Initialize numberOfTiles
    origintileColors = List.generate(numberOfTiles, (_) => Colors.grey);
    _scrabbleStackKeys =
        List.generate(numberOfTiles, (_) => GlobalKey<ScrabbleStackState>());
    _focusNodes = List.generate(numberOfTiles, (_) => FocusNode());
    _controllers = List.generate(numberOfTiles, (_) => TextEditingController());

    gameProvider.updateWordToBeGuessed();
    _createRewardedAd();

    wordToGuess = gameProvider.wordToBeGuessed;
    hint = gameProvider.hint;
  }

  @override
  void dispose() {
    _controllers?.forEach((controller) => controller.dispose());
    _focusNodes?.forEach((focusNode) => focusNode.dispose());
    super.dispose();
  }

// HINT POPUP managing state



  // rewrded Ads Manager func for Hints <<<<<<<<<<<<<<<<<<<<<<<<<<<<
Future<void> _createRewardedAd() async {
    // Fetch the AdRequest based on user consent
    final AdRequest adRequest = await AdMobService.getAdRequest();

    // Load the rewarded ad
    RewardedAd.load(
      adUnitId: AdMobService.rewardAdUnitId!,
      request: adRequest,
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          setState(() => _rewardedAd = ad); // Ad successfully loaded
          
        },
        onAdFailedToLoad: (error) {
          setState(() => _rewardedAd = null); // Ad failed to load
          
        },
      ),
    );
  }

  void _showRewardedAd() {
    if (_rewardedAd != null) {
      // Configure callbacks for ad events
      _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          _createRewardedAd(); // Reload ad after it’s dismissed
          
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
          _createRewardedAd(); // Reload ad if it fails to show
      
        },
      );

      // Show the rewarded ad
      _rewardedAd!.show(
        onUserEarnedReward: (ad, reward) {
          setState(() => countForAds++); // Reward the user
         
        },
      );

      _rewardedAd = null; // Reset the ad reference after showing
    } else {
      
    }
  }

// Show a congratulations popup when the word is correct

  void _showCongratulationsPopup(int won, String guessedWord) {
    const String wonString = 'Congratulations!';
    const String lostString = 'Oops! You lost.';
    late String PopUptitle;

    if (won == 1) {
      PopUptitle = wonString;
    } else {
      PopUptitle = lostString;
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent, // Set background transparent
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15), // Rounded corners
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Glass Effect Background
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(
                    color: Colors.black.withOpacity(0.2), // Slight transparency
                    width: 300, // Set the width of the dialog
                    height: 200, // Set the height of the dialog
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Title
                        Text(
                          PopUptitle,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Content
                        Text(
                          'The word was $guessedWord',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white.withOpacity(0.8),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        // Action Button
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green[700],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 24,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                            for (var controller in _controllers!) {
                              controller.clear();
                            }
                            setState(() {
                              _currentLineIndex = 0;
                              gm.updateWordToBeGuessed();
                              origintileColors = colorBack();
                              wordToGuess = gm.wordToBeGuessed;
                              hint = gm.hint;
                              _hasShownPopup =
                                  false; // Reset the flag for the next game
                            });
                            _focusNodes![0].requestFocus();
                          },
                          child: const Text(
                            'Guess another word',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showHint() {
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent, // Set background transparent
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15), // Rounded corners
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Glass Effect Background
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(
                    color: Colors.black.withOpacity(0.2), // Slight transparency
                    width: 300, // Set the width of the dialog
                    height: 200, // Set the height of the dialog
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Title
                        const Text(
                          'Hint !',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Content
                        Text(
                          hint,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white.withOpacity(0.8),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        // Action Button
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green[700],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 24),
                          ),
                          onPressed: () {
                            // Close the popup and reset the game state
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'Hide Hint',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

 void _focusNextLine() {
    TextEditingController currentController = _controllers![_currentLineIndex];

    if (currentController.text.length == numberOfTiles) {
      // Color tiles based on comparison for the current line
      final currentScrabbleStackKey = _scrabbleStackKeys[_currentLineIndex];
      currentScrabbleStackKey.currentState
          ?.colorTilesBasedOnComparison(wordToGuess);

      // Check if the entered word matches the word to guess
      if (currentController.text.toUpperCase() == wordToGuess.toUpperCase()) {
        // Show winning card if the word matches
        if (!_hasShownPopup) {
          _showCongratulationsPopup(1, wordToGuess);
          _hasShownPopup = true;
        }
      }

      // Check if it's not the last line
      if (_currentLineIndex < _focusNodes!.length - 1) {
        setState(() {
          _currentLineIndex++;
        });
        _focusNodes![_currentLineIndex].requestFocus();
      } else {
        // If it's the last line
        if (currentController.text.toUpperCase() == wordToGuess.toUpperCase()) {
          // Correct input on the last line
          if (!_hasShownPopup) {
            _showCongratulationsPopup(1, wordToGuess);
            _hasShownPopup = true;
          }
        } else {
          // Incorrect input on the last line
          if (!_hasShownPopup) {
            _showCongratulationsPopup(2, wordToGuess);
            _hasShownPopup = true;
          }
        }

        // Reset game state
        for (var controller in _controllers!) {
          controller.clear();
        }
        setState(() {
          _currentLineIndex = 0;
          gm.updateWordToBeGuessed();
          origintileColors = colorBack();
          wordToGuess = gm.wordToBeGuessed;
          hint = gm.hint;
        });
        _focusNodes![0].requestFocus();

        _resetGameState();
      }
    } else {
      // If input length is not equal to number of tiles, clear the input of the current line
      currentController.clear();
      _focusNodes![_currentLineIndex].requestFocus();
    }
  }

  List<Color> colorBack() {
    // Access the state of the ScrabbleStack using the GlobalKey and reset the colors
    for (var key in _scrabbleStackKeys) {
      key.currentState?.getColorsBackToNormal();
    }
    return origintileColors; // Return the original colors after resetting
  }

  // Function to reset the game state to the first line and change the word to guess
  void _resetGameState() {
    setState(() {
      _hasShownPopup = false; // Reset the flag for the next game
      _currentLineIndex = 0; // Reset to the first line
      numberOfTiles = gm.wordLength; // Reset the number of tiles
      for (var controller in _controllers!) {
        controller.clear(); // Clear all text controllers
      }
      // Reset tile colors to original gray color (or any default color)
      origintileColors = List.generate(
          numberOfTiles, (_) => const Color.fromARGB(255, 156, 199, 235));

      // Update the word to guess
      gm.updateWordToBeGuessed();
      wordToGuess = gm.wordToBeGuessed; // Set the new word
      hint = gm.hint; // Set the new hint
    });
    _focusNodes![0].requestFocus(); // Focus on the first line
    countForAds = 0;
  }

/////////////////////////
////////////////////////////
////////////////////////////
////////////////////////////
////////////////////////////////// THE GAME PAGE /////////////////////////
////////////////////////////
////////////////////////////
////////////////////////////

  @override
  Widget build(BuildContext context) {
    return BackgroundWrapper(
        child: SafeArea(
      child: Stack(children: [
        Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60.0),
            child: Stack(
              children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  leading: IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 30,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      _resetGameState();
                      Navigator.pop(context);
                    },
                  ),
                  actions: [
                    IconButton(
                      icon: const Icon(
                        Icons.help_outline,
                        color: Colors.white,
                        size: 30.0,
                      ),
                      onPressed: () {
                        countForAds ++;
                        _showHint();
                        if (countForAds == 1 || countForAds == 5 || countForAds == 8) {
                        _showRewardedAd();
                        }
                        
                        }
                    ),
                  ],
                ),
              ],
            ),
          ),
          body: Center(
            child: Consumer(
              builder: (context,gameProvider,child) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Generate ScrabbleStack widgets with unique GlobalKeys
                    for (int index = 0; index < _controllers!.length; index++)
                      Column(
                        children: [
                          ScrabbleStack(
                            key:
                                _scrabbleStackKeys[index], // Assign unique key here
                            numberOfTiles: 5,
                            tileColor: origintileColors[index],
                            stat: 0,
                            autoFocus: index == _currentLineIndex,
                            focusNode: _focusNodes![index],
                            controller: _controllers![index],
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ElevatedButton(
                      onPressed: () {
                        _focusNextLine(); // Color and focus control on button press
                      },
                      style: ElevatedButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 20),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                        backgroundColor: Colors.green[700],
                      ),
                      child: Text(
                        'Check Word',
                        style: GoogleFonts.inknutAntiqua(
                            fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ],
                );
              }
            ),
          ),
        ),
      ]),
    ));
  }
}
