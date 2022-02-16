/// Base class containing the configurable strings of the app.
class StringManager {
  /// Basic const constructor
  const StringManager();

  /// Text to display on top of the page
  String get appBarTitle => "BuddyBet Coding Challege";

  /// The name of the app.
  String get appName => 'Buddy Bet Challenge';

  /// Hint of the name input field
  String get nameInputHint => "Enter the name";

  String get yourNationalityText => "Your nationality is";

  String get greetingText => "Welcome to";

  String get codingChallengeTitle => "Coding Challenge";

  String get iGuessDescription => "Let's bet, i guess your country\nby just using your name";

  String get letsTryText => "Let's try";

  String get findOutNowText => "Find out now";

  String get guessingText => "Guessing...";

  String get somethingWentWrongText => "Sorry, something went wrong";
}
