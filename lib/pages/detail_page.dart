import 'package:flutter/material.dart';
import 'package:self_remedy/globals.dart';
import 'package:self_remedy/helpers/api.dart';
import 'package:self_remedy/helpers/static_data.dart';
import 'package:self_remedy/models/disease.dart';
import 'package:self_remedy/pages/edit_page.dart';
import 'package:self_remedy/widgets/alert_dialog.dart';
import 'package:self_remedy/widgets/bullet_list.dart';

class DetailPage extends StatefulWidget {
  final Disease disease;
  const DetailPage({Key? key, required this.disease}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  ScrollController scrollController = ScrollController();
  late double height, width;
  @override
  Widget build(BuildContext context) {
    height = getSize(context).height;
    width = getSize(context).width;
    return Scaffold(
      body: _getSliverList(),
    );
  }

  _getSliverList() {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverAppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.error_outline,
                color: Colors.white,
              ),
              onPressed: () async {
                bool success = await AlertAppDialog.show(
                  context,
                  text:
                      "Do you find the data is invalid or the data is false? Do you want to report it?",
                );
                if (success) showToast("Reported successfully");
              },
            ),
          ],
          forceElevated: true,
          expandedHeight: 0.4 * height,
          backgroundColor: darkColor,
          pinned: true,
          flexibleSpace: LayoutBuilder(
            builder: (context, constraints) {
              return FlexibleSpaceBar(
                title: Text(
                  getDisease().name,
                  style: const TextStyle(color: Colors.white),
                ),
                // titlePadding: const EdgeInsets.only(left: 30.0, bottom: 8.0),
                centerTitle: true,
                collapseMode: CollapseMode.parallax,
                stretchModes: const [
                  StretchMode.blurBackground,
                  StretchMode.fadeTitle,
                ],
                background: Hero(
                  tag: getDisease().id,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.asset(
                          getImageFromName(getDisease().name),
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned.fill(
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.black87,
                                Colors.transparent,
                                Colors.transparent
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(<Widget>[
            Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _getHeading("About 🙋‍♂️", 0,
                      isListType: false, toEditText: getDisease().about),
                  Text(getDisease().about),
                  _getHeading("Symptoms 🤒", 1,
                      isListType: true, toEditList: getDisease().symptoms),
                  BulletList(items: getDisease().symptoms),
                  _getHeading("Home Remedies 🏡", 2,
                      isListType: true, toEditList: getDisease().homeRemedies),
                  BulletList(items: getDisease().homeRemedies),
                  _getHeading("Medications 🩺💊🏥", 3,
                      isListType: true, toEditList: getDisease().medications),
                  BulletList(items: getDisease().medications),
                  SizedBox(height: 0.025 * height),
                  if (getDisease().note.isNotEmpty)
                    Container(
                      decoration: BoxDecoration(
                          color: lightColor.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(5.0)),
                      // height: 0.1 * getSize(context).height,
                      padding: const EdgeInsets.all(10.0),
                      child: Wrap(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Note:",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Text(getDisease().note),
                        ],
                      ),
                    ),
                  SizedBox(height: 0.025 * height),
                ],
              ),
            ),
          ]),
        ),
      ],
    );
  }

  Padding _getHeading(
    String text,
    int sectionIndex, {
    bool isListType = false,
    List<dynamic> toEditList = const [],
    String toEditText = "",
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              goToPage(
                context,
                EditPage(
                  editIndex: sectionIndex,
                  disease: getDisease(),
                ),
              ).then((data) {
                if (data == null) return;
                apiHelper.modifyDisease(data.id, data);
              });
            },
            icon: const Icon(
              Icons.post_add,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Disease getDisease() => widget.disease;
}
