import 'package:flutter/material.dart';
import 'package:self_remedy/globals.dart';
import 'package:self_remedy/models/disease.dart';

import '../helpers/api.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  Disease data = Disease.empty();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        title: const Text("List Disease"),
        backgroundColor: darkColor,
        actions: [
          GestureDetector(
            onTap: () async {
              if (validateInput()) {
                bool success = await apiHelper.addData(data: data);
                if (success) {
                  showToast("Added data successfully");
                  Navigator.pop(context);
                }
              }
            },
            child: const Center(
                child: Text(
              "Create",
            )),
          ),
          const SizedBox(width: 15)
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _getTextField("Name", (val) => data.name = val),
            _getTextField("About", (val) => data.about = val),
            _getTextField("Symptoms", (val) => data.symptoms = [val]),
            _getTextField("Home Remedies", (val) => data.homeRemedies = [val]),
            _getTextField("Medications", (val) => data.medications = [val]),
            _getTextField("Note", (val) => data.note = val),
            Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
              decoration: BoxDecoration(
                  color: lightColor.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(5.0)),
              // height: 0.1 * getSize(context).height,
              padding: const EdgeInsets.all(10.0),
              child: Wrap(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Note:",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                      "The listed item can be removed by admin if it is reported by mutliple people."),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _getTextField(String hintText, Function onChange) {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 15.0, right: 15.0),
      padding: const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.grey.withOpacity(0.2)),
      child: TextField(
        onChanged: (value) => onChange(value),
        // controller: TextEditingController(text: initialValue),
        maxLines: null,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }

  bool validateInput() {
    if (data.name.isEmpty) {
      showToast("Enter a name to continue");
      return false;
    }
    if (data.about.isEmpty) {
      showToast("Enter about to continue");
      return false;
    }
    if (data.symptoms[0].toString().isEmpty) {
      showToast("Enter a symptom to continue");
      return false;
    }
    return true;
  }
}
