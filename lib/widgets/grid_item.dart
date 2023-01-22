import 'package:flutter/material.dart';
import 'package:self_remedy/helpers/static_data.dart';
import 'package:self_remedy/models/disease.dart';

import '../globals.dart';
import '../pages/detail_page.dart';

class GridItem extends StatelessWidget {
  const GridItem({Key? key, required this.disease}) : super(key: key);
  final Disease disease;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        goToPage(context, DetailPage(disease: disease));
      },
      child: Ink(
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(color: accentColor.withOpacity(0.2)),
          ),
          child: Column(
            children: [
              Expanded(
                child: Hero(
                  tag: disease.id,
                  child: Image.asset(
                    getImageFromName(disease.name),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Center(
                child: Text(disease.name.toString()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
