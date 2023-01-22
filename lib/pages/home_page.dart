import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:self_remedy/globals.dart';
import 'package:self_remedy/helpers/shared_prefs.dart';
import 'package:self_remedy/pages/add_page.dart';
import 'package:self_remedy/pages/search_page.dart';
import 'package:self_remedy/widgets/disease_bottom_sheet.dart';
import 'package:self_remedy/widgets/drawer.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

import '../models/appdata.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

final GlobalKey<SideMenuState> _sideMenuKey = GlobalKey<SideMenuState>();

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SideMenu(
      key: _sideMenuKey,
      background: Colors.black,
      closeIcon: const Icon(Icons.close, color: Colors.grey),
      menu: const DrawerWidget(),
      type: SideMenuType.slideNRotate,
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: Container(
                color: accentColor,
              ),
            ),
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
            Positioned(
              top: 0.2 * getSize(context).height,
              right: -40,
              child: Transform.rotate(
                angle: 180,
                child: SvgPicture.asset(
                  "assets/leaf.svg",
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
            ),
            Positioned.fill(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).padding.top,
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          final state = _sideMenuKey.currentState;
                          if (state!.isOpened) {
                            state.closeSideMenu();
                          } else {
                            state.openSideMenu();
                          } // open side menu
                        },
                        icon: const Icon(
                          Icons.menu,
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15.0),
                    width: double.infinity,
                    height: 0.175 * getSize(context).height,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Hello, ",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        ValueListenableBuilder<AppData>(
                          valueListenable: appdata,
                          builder: (context, value, child) {
                            return Text(
                              value.name,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: GoogleFonts.prata().fontFamily,
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          },
                        ),
                        Text(
                          "What can we help you with today?",
                          style:
                              TextStyle(color: Colors.white.withOpacity(0.7)),
                        ),
                        SizedBox(height: 0.025 * getSize(context).height),
                      ],
                    ),
                  ),
                  Container(
                    height: 0.25 * getSize(context).height,
                    margin: const EdgeInsets.symmetric(horizontal: 15.0),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSearchBar(),
                        const Spacer(),
                        _buildDidYouKnowSection(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Positioned.fill(
              child: DiseaseBottomSheet(),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildDidYouKnowSection() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          borderRadius: BorderRadius.circular(5.0)),
      // height: 0.1 * getSize(context).height,
      padding: const EdgeInsets.all(10.0),
      child: Wrap(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "Health Fact",
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
          ),
          Text(
            "Honey is a natural antioxidant that contains flavonoids and phenolic acids which protect cells from damage, reduce inflammation and lower risk of chronic diseases.",
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }

  _buildSearchBar() {
    return GestureDetector(
      onTap: () => goToPage(context, const SearchPage()),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30.0),
            boxShadow: [
              BoxShadow(
                blurRadius: 5.0,
                offset: const Offset(3.0, 3.0),
                color: Colors.black.withOpacity(0.05),
                spreadRadius: 4.0,
              ),
            ]),
        child: Material(
          color: Colors.transparent,
          child: TextField(
            enabled: false,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Search",
              prefixIcon: Hero(
                tag: "Search",
                child: Icon(
                  Icons.search,
                  color: Colors.grey.withOpacity(0.8),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
