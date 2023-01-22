import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:self_remedy/globals.dart';

class TermsOfUsePage extends StatelessWidget {
  const TermsOfUsePage({Key? key}) : super(key: key);

  Future<String> readFile() async {
    final String fileString =
        await rootBundle.loadString('assets/terms-of-use.txt');
    return fileString;
  }

  @override
  Widget build(BuildContext context) {
    readFile();
    return Theme(
      data: Theme.of(context).copyWith(brightness: Brightness.dark),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          titleSpacing: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.close,
              color: Colors.white,
            ),
          ),
          title: const Text(
            "Terms of Use",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.black,
        ),
        body: FutureBuilder(
          future: readFile(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data != null) {
                return Stack(
                  children: [
                    Positioned.fill(
                      child: Opacity(
                        opacity: 0.5,
                        child: Center(
                          child: Image.asset("assets/loading.gif"),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 10.0),
                        child: Column(
                          children: [
                            SizedBox(height: 0.025 * getSize(context).height),
                            Text(
                              snapshot.data.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
            }
            return Center(
              child: Image.asset(
                "assets/loading.gif",
                height: 150,
                width: 150,
              ),
            );
          },
        ),
      ),
    );
  }
}
