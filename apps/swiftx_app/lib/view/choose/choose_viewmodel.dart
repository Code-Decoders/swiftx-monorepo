import 'dart:async';

import 'package:swiftx_app/core/app_locator.dart';
import 'package:swiftx_app/core/base_viewmodel.dart';
import 'package:swiftx_app/core/model/user_model.dart';
import 'package:swiftx_app/core/service/recipient_service.dart';

class ChooseViewModel extends BaseViewModel {
  String _query = '';
  String get query => _query;

  List<UserModel> _recipients = [];
  List<UserModel> get recipients => _recipients;

  Timer? _debounce;

  final recipientService = locator<RecipientService>();

  void setQuery(String newQuery) {
    _query = newQuery;
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      search(_query);
      notifyListeners();
    });
  }

  Future search(String query) async {
    setBusyAndNotify(true);
    final result = await recipientService.searchRecipients(query);
    _recipients = result;
    setBusyAndNotify(false);
  }
}
