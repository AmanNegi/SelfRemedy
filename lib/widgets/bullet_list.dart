import 'package:flutter/material.dart';

class BulletList extends StatelessWidget {
  const BulletList({
    Key? key,
    required this.items,
  }) : super(key: key);
  final List<dynamic> items;

  @override
  Widget build(BuildContext context) {
    var widgetList = <Widget>[];
    for (var text in items) {
      widgetList.add(BulletListItem(text: text.toString()));
      widgetList.add(const SizedBox(height: 5.0));
    }

    return Column(children: widgetList);
  }
}

class BulletListItem extends StatelessWidget {
  const BulletListItem({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text("• "),
        Expanded(
          child: Text(text),
        ),
      ],
    );
  }
}
