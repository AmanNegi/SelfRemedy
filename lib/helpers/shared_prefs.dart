import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:self_remedy/models/appdata.dart';
import 'package:shared_preferences/shared_preferences.dart';

ValueNotifier<AppData> appdata = ValueNotifier<AppData>(AppData.empty());

class SharedPrefsHelper {
  SharedPreferences? _instance;
  init() async {
    _instance ??= await SharedPreferences.getInstance();
  }
  // For now simply store the user session

  updateUser(AppData data) async {
    await init();
    await _instance!.setString('appData', json.encode(data.toJson()));
    appdata.value = data;
  }

  getUser() async {
    await init();
    if (_instance!.containsKey('appData')) {
      String? data = _instance!.getString('appData');
      debugPrint("Got User Data From Device $data");
      if (data != null && data.isNotEmpty) {
        Map session = json.decode(data);
        appdata.value = AppData.fromJSON(session);
      }
    } else {
      updateUser(AppData.empty());
    }
  }
}

// Singleton instance
SharedPrefsHelper sharedPrefsHelper = SharedPrefsHelper();
