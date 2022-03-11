import 'package:flutter/material.dart';
import '../../../core/constants/entity_factory.dart';
import '../../../core/model/common.dart';

class BaseListProvider<T> extends ChangeNotifier {
  StateType _stateType = StateType.loading;
  bool _hasMore = true;
  String _message = '';
  bool _enableEdit = false;
  bool _isDarkTheme = false;

  StateType get stateType => _stateType;
  bool get hasMore => _hasMore;
  String get message => _message;
  bool get enableEdit => _enableEdit;
  bool get isDarkTheme => _isDarkTheme;

  final List<T> _list = [];

  List<T> get list => _list;

  bool _disposed = false;

  void setStateType(StateType stateType) {
    _stateType = stateType;
    if (_disposed) return;
    notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  void setHasMore(bool hasMore) {
    _hasMore = hasMore;
    notifyListeners();
  }

  void setEnableEdit(bool edit) {
    _enableEdit = edit;
    notifyListeners();
  }

  void setMessage(String msg) {
    _message = msg;
    notifyListeners();
  }

  void setThemeStatus(bool status) {
    _isDarkTheme = status;
    notifyListeners();
  }

  String? _language;
  String? get language => _language;

  void setLanguage(String data) {
    _language = data;
    notifyListeners();
  }

  late NationalizeResponse _nationalizeResponse;
  NationalizeResponse get nationalizeResponse => _nationalizeResponse;

  void setNationalizeResponse(NationalizeResponse data) {
    _nationalizeResponse = data;
    notifyListeners();
  }

  void add(T data) {
    _list.add(data);
    notifyListeners();
  }

  void addAll(List<T> data) {
    _list.addAll(data);
    notifyListeners();
  }

  void insert(int i, T data) {
    _list.insert(i, data);
    notifyListeners();
  }

  void insertAll(int i, List<T> data) {
    _list.insertAll(i, data);
    notifyListeners();
  }

  void remove(T data) {
    _list.remove(data);
    notifyListeners();
  }

  void removeAt(int i) {
    _list.removeAt(i);
    notifyListeners();
  }

  void clear() {
    _list.clear();
    notifyListeners();
  }
}
