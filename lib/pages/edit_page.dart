import 'package:flutter/material.dart';
import 'package:self_remedy/globals.dart';
import 'package:self_remedy/models/disease.dart';
import 'package:self_remedy/widgets/alert_dialog.dart';

class EditPage extends StatefulWidget {
  final Disease disease;
  final int editIndex;

  const EditPage({Key? key, required this.disease, required this.editIndex})
      : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  late Disease disease;
  List list = [];
  String text = "";
  bool editList = false;
  String sectionName = "";

  @override
  void initState() {
    disease = widget.disease;
    bloatValues();
    super.initState();
  }

  bloatValues() {
    switch (widget.editIndex) {
      case 0:
        {
          sectionName = "About";
          editList = false;
          text = disease.about;
          return;
        }
      case 1:
        {
          list = disease.symptoms;
          sectionName = "Symptoms";
          break;
        }
      case 2:
        {
          list = disease.homeRemedies;
          sectionName = "Home Remedies";
          break;
        }
      case 3:
        {
          list = disease.medications;
          sectionName = "Medications";
          break;
        }
    }

    editList = true;
  }

  saveValues() {
    switch (widget.editIndex) {
      case 0:
        {
          //TODO: Save about
          disease.about = text;
          break;
        }
      case 1:
        {
          disease.symptoms = list;
          break;
        }
      case 2:
        {
          disease.homeRemedies = list;
          break;
        }
      case 3:
        {
          disease.medications = list;
          break;
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkColor,
        titleSpacing: 0,
        title: Text("Edit ${disease.name}"),
        actions: [
          TextButton(
            onPressed: () {
              saveValues();
              Navigator.pop(context, disease);
            },
            child: const Text(
              "Save",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _getChildren(),
          ),
        ),
      ),
    );
  }

  _getChildren() {
    List<Widget> children = [];
    children.add(
      Container(
        padding: const EdgeInsets.only(top: 15.0),
        child: Text(
          sectionName,
          style: const TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
        ),
      ),
    );

    if (editList) {
      for (int i = 0; i < list.length; i++) {
        children.add(_getTextField(list[i], i));
      }
      children.add(const SizedBox(height: 20));

      if (editList) children.add(_getAddButton());
      children.add(const SizedBox(height: kToolbarHeight));

      return children;
    }
    children.add(_getTextField(text, 0));
    if (editList) children.add(_getAddButton());
    return children;
  }

  _getAddButton() {
    return GestureDetector(
      onTap: () {},
      child: Row(
        children: [
          const Spacer(),
          GestureDetector(
            onTap: () {
              list.add("");
              setState(() {});
            },
            child: Container(
                width: 0.4 * getSize(context).width,
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                margin: const EdgeInsets.only(right: 15.0),
                decoration: BoxDecoration(
                    color: accentColor,
                    borderRadius: BorderRadius.circular(10.0)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.add),
                    Text(
                      "Add Field",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }

  Widget _getTextField(String initialValue, int index) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20),
          padding:
              const EdgeInsets.only(top: 15, left: 10, right: 10, bottom: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: Colors.grey.withOpacity(0.2)),
          child: TextField(
            onChanged: (value) => editList ? list[index] = value : text = value,
            controller: TextEditingController(text: initialValue),
            maxLines: null,
            decoration: InputDecoration(
              hintText: initialValue.isEmpty ? "Type Here..." : "",
              border: InputBorder.none,
            ),
          ),
        ),
        if (editList)
          Positioned(
            right: 10,
            top: 10,
            child: GestureDetector(
              onTap: () async {
                bool delete = await AlertAppDialog.show(context,
                    text: "Are you sure you want to delete this item?");
                if (!delete) {
                  if (mounted) FocusScope.of(context).requestFocus(FocusNode());
                  return;
                }
                list.removeAt(index);
                setState(() {});
                showToast("Removed successfully.");
              },
              child: Container(
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5.0,
                      offset: const Offset(3.0, 3.0),
                      color: Colors.black.withOpacity(0.05),
                      spreadRadius: 4.0,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
