import 'package:flutter/material.dart';
import 'package:self_remedy/globals.dart';

class AlertAppDialog extends StatefulWidget {
  final String title;

  const AlertAppDialog({
    Key? key,
    this.title = 'Are you sure?',
  }) : super(key: key);

  @override
  State<AlertAppDialog> createState() => _AlertAppDialogState();

  static Future<bool> show(BuildContext context, {String? text}) async {
    bool res = await showDialog<bool>(
          context: context,
          builder: (context) => text != null
              ? AlertAppDialog(
                  title: text,
                )
              : const AlertAppDialog(),
        ) ??
        false;
    return res;
  }
}

class _AlertAppDialogState extends State<AlertAppDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(
        widget.title,
        style: Theme.of(context).textTheme.bodyText2,
      ),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            primary: accentColor,
          ),
          onPressed: () {
            Navigator.pop(context, false);
          },
          child: const Text(
            'CANCEL',
          ),
        ),
        ElevatedButton(
          style: TextButton.styleFrom(
            primary: accentColor,
            backgroundColor: accentColor,
          ),
          onPressed: () {
            Navigator.pop(context, true);
          },
          child: const Text(
            'Yes',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
