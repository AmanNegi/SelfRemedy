import 'dart:convert';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:flutter/services.dart';
import 'package:self_remedy/globals.dart';
import 'package:self_remedy/helpers/consts.dart';
import 'package:flutter/material.dart';
import 'package:self_remedy/helpers/shared_prefs.dart';
import 'package:self_remedy/models/appdata.dart';
import 'package:self_remedy/models/disease.dart';

class APIHelper {
  Client client = Client();
  late Databases databases;
  models.Session? session;
  models.Account? user;
  late Account account;

  Future<models.Account?> getUser() async {
    account = Account(client);
    user = await account.get();
    sharedPrefsHelper.updateUser(AppData(
        name: user!.name,
        isLoggedIn: true,
        isFirstTime: false,
        email: user!.email));
    return user;
  }

  Future<bool> login(String email, String password) async {
    try {
      account = Account(client);
      session =
          await account.createEmailSession(email: email, password: password);
      user = await account.get();
      sharedPrefsHelper.updateUser(AppData(
        name: user!.name,
        email: user!.email,
        isLoggedIn: true,
        isFirstTime: false,
      ));
      return true;
    } on AppwriteException catch (_) {
      debugPrint("An Error occured while login ${_.message}  ");
      showToast(_.message ?? "Login failed");
      return false;
    }
  }

  Future<bool> signOut() async {
    account = Account(client);
    if (session != null) {
      account.deleteSession(sessionId: session!.$id);
    }

    sharedPrefsHelper.updateUser(AppData.empty());
    return true;
  }

  Future<bool> signup(String username, String email, String password) async {
    try {
      account = Account(client);
      await account.create(
        userId: ID.unique(),
        email: email,
        password: password,
        name: username,
      );
      session =
          await account.createEmailSession(email: email, password: password);
      user = await account.get();
      sharedPrefsHelper.updateUser(AppData(
        name: user!.name,
        email: user!.email,
        isLoggedIn: true,
        isFirstTime: false,
      ));

      return true;
    } on AppwriteException catch (_) {
      debugPrint("An Error occured while signup ${_.message} $_ ");
      showToast(_.message ?? "Signup failed");
      return false;
    }
  }

  Future<bool> updateUsername(String username) async {
    try {
      account = Account(client);
      await account.updateName(
        name: username,
      );
      user = await account.get();
      sharedPrefsHelper.updateUser(AppData(
        name: user!.name,
        email: user!.email,
        isLoggedIn: true,
        isFirstTime: false,
      ));

      return true;
    } on AppwriteException catch (_) {
      debugPrint("An Error occured while updating username ${_.message} $_ ");
      showToast(_.message ?? "Update Username failed");
      return false;
    }
  }

// TODO: Login using username only
  Future<void> createAnonmyousUser() async {
    if (session != null) return;
    final account = Account(client);
    session = await account.createAnonymousSession();
    debugPrint("Login Complete");
  }

  void initConnection() async {
    client
        .setEndpoint('https://cloud.appwrite.io/v1')
        .setProject(projectId)
        .setSelfSigned(status: true);
    databases = Databases(client);
  }

  Future<List<Disease>> getAllDiseases() async {
    debugPrint("Getting Diseases...");
    List<Disease> data = [];
    try {
      // await createAnonmyousUser();
      var result = await databases.listDocuments(
        databaseId: databaseId,
        collectionId: databaseCollectionId,
      );
      for (models.Document document in result.documents) {
        data.add(Disease.fromJson(document.toMap()));
      }
    } catch (e) {
      // handle error
      debugPrint("Some Error occured $e");
    }
    return data;
  }

  Future<bool> addData({dynamic map, Disease? data}) async {
    try {
      if (data != null) {
        map = {
          'name': data.name,
          'imageURL': '',
          'about': data.about,
          'symptoms': data.symptoms,
          'home_remedies': data.homeRemedies,
          'medications': data.medications,
          "note": data.note,
        };
      }
      await databases.createDocument(
        databaseId: databaseId,
        collectionId: databaseCollectionId,
        documentId: ID.unique(),
        data: map as Map,
      );
      return true;
    } on AppwriteException catch (_) {
      debugPrint("An Error occured while Adding Data ${_.message} $_ ");
      showToast(_.message ?? "Failed to Add Data");
      return false;
    }
  }

  Future<bool> deleteData(String id) async {
    try {
      await databases.deleteDocument(
        databaseId: databaseId,
        collectionId: databaseCollectionId,
        documentId: id,
      );
      return true;
    } on AppwriteException catch (_) {
      debugPrint("An Error occured while Deleting ${_.message}  ");
      showToast(_.message ?? "Delete failed");
      return false;
    }
  }

  Future<Disease> modifyDisease(String id, Disease data) async {
    try {
      models.Document result = await databases.updateDocument(
        databaseId: databaseId,
        collectionId: databaseCollectionId,
        documentId: id,
        data: data.toJson(),
      );
      Disease modifiedDisease = Disease.fromJson(result.toMap());
      return modifiedDisease;
    } on AppwriteException catch (_, e) {
      debugPrint(e.toString());
      debugPrint("An Error occured while updating ${_.message}  ");
      showToast(_.message ?? "Update failed");
      return data;
    }
  }

  void getHeathFact() async {
    // try{
    //   var result = await
    // }
  }

  // ! NOTE: Don't use following functions
  // ! Functions used to push mock data to the database from data.json
  void addMockData() async {
    // addAllData(await getMockData());
  }

  void addAllData(List<dynamic> data) async {
    try {
      for (dynamic e in data) {
        addData(map: e);
      }

      debugPrint("All Items added successfully");
    } catch (e) {
      debugPrint("Error:  $e");
    }
  }

  Future<List<dynamic>> getMockData() async {
    List<dynamic> data = [];
    try {
      final String jsonString = await rootBundle.loadString('assets/data.json');
      Map? response = json.decode(jsonString);

      if (response != null && response.isNotEmpty) {
        var map = response['data'];
        data = map;
      }
    } catch (e) {
      debugPrint("An Error Occurred $e");
    }
    return data;
  }

  void deleteAll() async {
    var diseases = await getAllDiseases();
    for (Disease disease in diseases) {
      await deleteData(disease.id);
    }
  }
}

APIHelper apiHelper = APIHelper();
// singleton instance
