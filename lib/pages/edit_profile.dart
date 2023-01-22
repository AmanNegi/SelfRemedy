import 'package:flutter/material.dart';
import 'package:self_remedy/globals.dart';
import 'package:self_remedy/helpers/api.dart';
import 'package:self_remedy/helpers/shared_prefs.dart';
import 'package:self_remedy/models/appdata.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  String name = "";

  @override
  void initState() {
    try {
      name = apiHelper.user!.name;
    } catch (e) {
      debugPrint(e.toString());
    }

    if (name.isEmpty) {
      apiHelper.getUser();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit profile"),
        backgroundColor: darkColor,
        actions: [
          TextButton(
            onPressed: () async {
              if (validateInput()) {
                bool success = await apiHelper.updateUsername(name);
                if (success) {
                  showToast("Updated username successfully!");
                  Navigator.pop(context);
                }
              }
            },
            child: const Text(
              "Save",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: ValueListenableBuilder<AppData>(
          valueListenable: appdata,
          builder: (context, data, child) {
            return Column(
              children: [
                _getTextField("Username", data.name, (v) => name = v),
                _getTextField("Email", data.email, () {}, enabled: false),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 15.0),
                  decoration: BoxDecoration(
                      color: lightColor.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(5.0)),
                  // height: 0.1 * getSize(context).height,
                  padding: const EdgeInsets.all(10.0),
                  child: Wrap(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Note: ",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text("You can not change the email address"),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }

  Container _getTextField(
      String hintText, String initialValue, Function onChange,
      {bool enabled = true}) {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 15.0, right: 15.0),
      padding: const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.grey.withOpacity(0.2)),
      child: TextField(
        enabled: enabled,
        onChanged: (value) => onChange(value),
        controller: TextEditingController(text: initialValue),
        maxLines: 1,
        decoration: InputDecoration(
          hintText: hintText,
          label: Text(hintText),
          border: InputBorder.none,
        ),
      ),
    );
  }

  bool validateInput() {
    if (name.isEmpty) {
      showToast("Enter name to continue");
      return false;
    }
    return true;
  }
}
