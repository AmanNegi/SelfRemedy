import 'package:flutter/material.dart';
import 'package:self_remedy/helpers/api.dart';
import 'package:self_remedy/helpers/scroll_behaviour.dart';
import 'package:self_remedy/widgets/grid_item.dart';

import '../globals.dart';
import '../helpers/data_manager.dart';

class DiseaseBottomSheet extends StatefulWidget {
  const DiseaseBottomSheet({Key? key}) : super(key: key);

  @override
  State<DiseaseBottomSheet> createState() => _DiseaseBottomSheetState();
}

class _DiseaseBottomSheetState extends State<DiseaseBottomSheet> {
  void fetchData() async {
    if (dataManager.getData().isNotEmpty) return;
    // We don't want to fetch data on ui reloads if it preexists
    dataManager.setData(await apiHelper.getAllDiseases());
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DraggableScrollableSheet(
        minChildSize: 0.45,
        maxChildSize: 1,
        initialChildSize: 0.45,
        builder: (BuildContext context, ScrollController scrollController) {
          return ScrollConfiguration(
            behavior: HideGlowScrollBehaviour(),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Container(
                margin: EdgeInsets.only(
                  top: 0.05 * getSize(context).height,
                ),
                height: getSize(context).height,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    topLeft: Radius.circular(30.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5.0,
                      spreadRadius: 10.0,
                      offset: const Offset(0.0, 5.0),
                      color: Colors.black.withOpacity(0.1),
                    )
                  ],
                  color: Theme.of(context).cardColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 0.025 * getSize(context).height),
                    Row(
                      children: [
                        const Spacer(),
                        Container(
                          height: 4,
                          width: 0.2 * getSize(context).width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: Colors.grey,
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                    SizedBox(height: 0.025 * getSize(context).height),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, top: 8.0, bottom: 8.0),
                      child: Text("Common Diseases",
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(fontWeight: FontWeight.w600)),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: GridView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          itemCount: dataManager.getData().length,
                          controller: scrollController,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                            crossAxisCount: 2,
                          ),
                          itemBuilder: (context, index) {
                            return GridItem(
                                disease: dataManager.getData()[index]);
                          }),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
