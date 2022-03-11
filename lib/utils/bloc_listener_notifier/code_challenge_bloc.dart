import 'package:flutter/material.dart';

class CodeChallengeBloc with ChangeNotifier {
  /// Sample Start
  int _stateManagementTime = 0;

  int get stateManagementTime => _stateManagementTime;

  set stateManagementTime(int newvalue) {
    _stateManagementTime = newvalue + 1;
    print(_stateManagementTime);
    notifyListeners();
  }

  /// sample end

  /// employee state
  bool sslType = false;
  String domainssl = "http://";
  String fulldomain = "";
  String fullport = "";
  String domainUrl = "";
  String userName = "";
  String userEmail = "";
  String userProfile = "";

  bool get stateManagementsslType => sslType;

  String get stateManagementdomainssl => domainssl;

  set stateManagementsslType(bool _sslType) {
    sslType = !_sslType;
    if (sslType == false) {
      domainssl = "http://";
    } else {
      domainssl = "https://";
    }
    print(_sslType);
    notifyListeners();
  }

  String get stateManagementfulldomain => fulldomain;

  set stateManagementfulldomain(String _fulldomain) {
    fulldomain = _fulldomain;

    print(_fulldomain);
    notifyListeners();
  }

  String get stateManagementfullport => fullport;

  set stateManagementfullport(String _fullport) {
    fullport = ":" + _fullport;
    print(_fullport);
    notifyListeners();
  }

  String get stateManagementdomainUrl => domainUrl;

  set stateManagementdomainUrl(String _domainUrl) {
    domainUrl = _domainUrl;
    print(_domainUrl);
    notifyListeners();
  }

  String get stateManagementUserName => userName;

  set stateManagementUserName(String _userName) {
    userName = _userName;
    print(userName);
    notifyListeners();
  }

  String get stateManagementEmail => userEmail;

  set stateManagementEmail(String _userEmail) {
    userEmail = _userEmail;
    print(_userEmail);
    notifyListeners();
  }

  String get stateManagementprofile => userProfile;

  set stateManagementprofile(String _userProfile) {
    userProfile = _userProfile;
    print(_userProfile);
    notifyListeners();
  }
}
