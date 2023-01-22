import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:self_remedy/globals.dart';
import 'package:self_remedy/helpers/data_manager.dart';
import 'package:self_remedy/widgets/grid_item.dart';

import '../models/disease.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String query = "";
  late double height, width;
  List<Disease> data = [];

  void searchForDisease(String query) {
    debugPrint("Searching for $query");
    data = [];
    query = query.trim().toLowerCase();
    List<Disease> result = [];
    for (Disease element in dataManager.getData()) {
      if (element.name.toLowerCase().contains(query.trim())) {
        result.add(element);
      } else if (element.about.toLowerCase().contains(query.trim())) {
        result.add(element);
      }
    }
    data = result;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    height = getSize(context).height;
    width = getSize(context).width;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top),
          _getSearchPart(),
          _getSearchView(),
        ],
      ),
    );
  }

  Expanded _getSearchView() {
    if (query.length < 3) {
      return Expanded(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                query.isEmpty ? "👆" : "🤖",
                style: const TextStyle(fontSize: 40),
              ),
              Text(
                query.isEmpty
                    ? "Enter some text to find it"
                    : "Enter atleast 3 characters to search it",
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    if (data.isEmpty) {
      return Expanded(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Text(
                "😟",
                style: TextStyle(fontSize: 40),
              ),
              Text(
                "No Items Found",
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return Expanded(
      child: GridView.builder(
          padding:
              EdgeInsets.symmetric(horizontal: 15.0, vertical: 0.025 * height),
          itemCount: data.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            crossAxisCount: 2,
          ),
          itemBuilder: (context, index) {
            return GridItem(disease: data[index]);
          }),
    );
  }

  _getSearchPart() {
    return Container(
      height: 0.2 * height,
      decoration: const BoxDecoration(
        color: accentColor,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Stack(
        children: [
          Positioned(
            top: -10,
            right: 0,
            child: Transform.rotate(
              angle: 90,
              child: SvgPicture.asset(
                "assets/leaf.svg",
                color: Colors.white.withOpacity(0.1),
              ),
            ),
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Hero(
                      tag: "Search",
                      child: Icon(
                        Icons.search,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                Theme(
                  data: Theme.of(context).copyWith(
                    textSelectionTheme: const TextSelectionThemeData(
                      cursorColor: Colors.white,
                      selectionHandleColor: Colors.white54,
                      selectionColor: Colors.white30,
                    ),
                  ),
                  child: TextField(
                    autofocus: true,
                    style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      hintText: "Type here",
                      hintStyle:
                          TextStyle(color: Colors.white.withOpacity(0.75)),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ),
                    onChanged: (e) {
                      if (e.length >= 3) {
                        query = e;
                        searchForDisease(e);
                        setState(() {});
                      } else {
                        query = e;
                        data = [];
                        setState(() {});
                      }
                    },
                  ),
                ),
                Text(
                  "Results: ${data.length}",
                  style: const TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
