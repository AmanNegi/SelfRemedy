import 'package:flutter/material.dart';
import 'package:self_remedy/helpers/api.dart';
import 'package:self_remedy/models/disease.dart';

//TODO: Do Caching as well, so that app can work offline as well
class DataManager {
  List<Disease> _dataList = [];

  void setData(List<Disease> data) {
    _dataList = data;
  }

  void refreshData() async {
    _dataList = await apiHelper.getAllDiseases();
  }

  List<Disease> getData() {
    return [..._dataList];
  }
}

// Singleton instance
DataManager dataManager = DataManager();
