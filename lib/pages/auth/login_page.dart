import 'package:flutter/material.dart';
import 'package:self_remedy/globals.dart';
import 'package:self_remedy/helpers/api.dart';
import 'package:self_remedy/pages/auth/signup_page.dart';
import 'package:self_remedy/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  static const String route = "/SignUpPage";

  const LoginPage({Key? key}) : super(key: key);
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  late double height, width;
  int currentPageIndex = 0;
  PageController pageController = PageController(initialPage: 0);

  List<String> data = ["", ""];
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    height = getSize(context).height;
    width = getSize(context).width;
    return Scaffold(
      // appBar: _buildAppBar(),
      body: PageView.builder(
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          currentPageIndex = index;
          setState(() {});
        },
        controller: pageController,
        itemBuilder: (context, index) {
          return AbsorbPointer(
            absorbing: isLoading,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 0.125 * height),
                  Center(
                    child: Text(
                      titleText[index],
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF101010),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 0.4 * height,
                    width: 0.75 * width,
                    child: listImage[index],
                  ),
                  SizedBox(height: 0.025 * height),
                  _buildTextField(hintText[index]),
                  SizedBox(height: 0.05 * height),
                  _buildIndicators(),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (currentPageIndex != 0) {
                              currentPageIndex--;
                              setState(() {});
                            }
                          },
                          child: Text(
                            "Back",
                            style: TextStyle(
                                color: currentPageIndex == 1
                                    ? Colors.transparent
                                    : Colors.black),
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () => _handleOnNext(),
                          child: Container(
                            decoration: BoxDecoration(
                              color: listColor[index],
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 25.0,
                                vertical: 10,
                              ),
                              child: isLoading
                                  ? const SizedBox(
                                      height: 25,
                                      width: 25,
                                      child: CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation(
                                            Colors.white),
                                      ),
                                    )
                                  : Text(
                                      currentPageIndex == 1
                                          ? "Continue"
                                          : "Next",
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      goToPage(context, const SignUpPage(), clearStack: true);
                    },
                    child: const Text(
                      "Don't have an account? Sign up",
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
        itemCount: 2,
      ),
    );
  }

  _handleOnNext() async {
    switch (currentPageIndex) {
      case 0:
        {
          if (data[0].isEmpty) {
            return showToast("Enter email address to proceed");
          }
          if (!data[0].isValidEmail()) {
            return showToast("Enter a valid email address");
          }

          pageController.nextPage(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut);
          break;
        }
      case 1:
        {
          if (data[1].isEmpty) {
            return showToast("Enter password to proceed");
          }
          if (data[1].length < 5) {
            return showToast("Enter password with more than 5 characters");
          }
          setState(() => isLoading = true);

          bool success = await apiHelper.login(data[0], data[1]);
          setState(() => isLoading = false);
          if (success) {
            showToast("Login successful");
            if (mounted) goToPage(context, const HomePage(), clearStack: true);
          }

          break;
        }
    }
  }

  _buildIndicators() {
    return SizedBox(
      height: 5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildCurrentPageIndicator(0),
          SizedBox(width: 0.0275 * width),
          _buildCurrentPageIndicator(1),
        ],
      ),
    );
  }

  _buildTextField(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 0.85 * width,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: TextField(
          controller: TextEditingController(text: data[currentPageIndex]),
          onChanged: (e) {
            data[currentPageIndex] = e.trim();
          },
          decoration: InputDecoration(
            hintText: text,
            hintStyle: const TextStyle(
              color: Colors.grey,
            ),
            border: InputBorder.none,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
          ),
        ),
      ),
    );
  }

  _buildCurrentPageIndicator(int index) {
    return Container(
      width: 0.045 * width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: index == currentPageIndex ? listColor[index] : Colors.grey[300],
      ),
    );
  }
}

List<Color> listColor = [
  const Color(0xFFf4b512),
  const Color(0xFFfa517a),
];
List<String> titleText = [
  "What is your\n email address?",
  "Remember your\npassword?"
];

List<String> hintText = ["Email Address", "Shh.. it's a secret"];

List<Image> listImage = [
  Image.asset("assets/music.png"),
  Image.asset("assets/birth.png")
];
