import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import '../../core/localization/local_keys.dart';
import '../../core/localization/local_setup.dart';

class AppLocalizations {
  final Locale locale;
  late Map<String, String> _sentences;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) =>
      Localizations.of<AppLocalizations>(context, AppLocalizations);

  Future<bool> load() async {
    final path = 'assets/lang/${locale.languageCode}.json';
    final data = await rootBundle.loadString(path);
    final Map<String, dynamic> _result = json.decode(data);

    _sentences = <String, String>{};
    _result.forEach((String key, dynamic value) {
      _sentences[key] = value.toString();
    });

    return true;
  }

  String? translate(String key) {
    return _sentences[key];
  }

  String? get userId => translate(LocalKeys.userId);

  String? get appTitle => translate(LocalKeys.appTitle);
  String? get signInWithGoogle => translate(LocalKeys.signInWithGoogle);
  String? get dashboard => translate(LocalKeys.dashboard);
  String? get customers => translate(LocalKeys.customers);
  String? get settings => translate(LocalKeys.settings);
  String? get signOut => translate(LocalKeys.signOut);
  String? get welcomeMessage => translate(LocalKeys.welcomeMessage);

  // MHI
  String? get pinVerification => translate(LocalKeys.pinVerification);
  String? get password => translate(LocalKeys.password);
  String? get iagreethe => translate(LocalKeys.iagreethe);
  String? get termsandconditions => translate(LocalKeys.termsandconditions);
  String? get signin => translate(LocalKeys.signin);
  String? get forgotpassword => translate(LocalKeys.forgotpassword);
  String? get enteryourmaindomain => translate(LocalKeys.enteryourmaindomain);
  String? get enterportnumber => translate(LocalKeys.enterportnumber);
  String? get cancel => translate(LocalKeys.cancel);
  String? get save => translate(LocalKeys.save);
  String? get http => translate(LocalKeys.http);
  String? get https => translate(LocalKeys.https);
  String? get pleasereadthetermsandcontitions =>
      translate(LocalKeys.pleasereadthetermsandcontitions);
  String? get pleaseconfigureyouredomainandportnumber =>
      translate(LocalKeys.pleaseconfigureyouredomainandportnumber);
  String? get enteryourefourdigit => translate(LocalKeys.enteryourefourdigit);
  String? get somethinkwentwrong => translate(LocalKeys.somethinkwentwrong);
  String? get calendar => translate(LocalKeys.calendar);
  String? get punchin => translate(LocalKeys.punchin);
  String? get punchout => translate(LocalKeys.punchout);
  String? get attendancereport => translate(LocalKeys.attendancereport);
  String? get changepin => translate(LocalKeys.changepin);
  String? get exit => translate(LocalKeys.exit);
  String? get logout => translate(LocalKeys.logout);
  String? get ratemhilite => translate(LocalKeys.ratemhilite);
  String? get version => translate(LocalKeys.version);
  String? get today => translate(LocalKeys.today);
  String? get ok => translate(LocalKeys.ok);
  String? get absent => translate(LocalKeys.absent);
  String? get missingpunch => translate(LocalKeys.missingpunch);
  String? get leaveapprovel => translate(LocalKeys.leaveapprovel);
  String? get userregistration => translate(LocalKeys.userregistration);
  String? get creategeofence => translate(LocalKeys.creategeofence);
  String? get reports => translate(LocalKeys.reports);
  String? get manualattendance => translate(LocalKeys.manualattendance);
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return supportedLocalCodes.contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    final localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}

class FallbackCupertinoLocalizationsDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return supportedLocalCodes.contains(locale.languageCode);
  }

  @override
  Future<CupertinoLocalizations> load(Locale locale) {
    return DefaultCupertinoLocalizations.load(locale);
  }

  @override
  bool shouldReload(FallbackCupertinoLocalizationsDelegate old) => false;
}
