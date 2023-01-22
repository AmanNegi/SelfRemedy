import 'package:flutter/material.dart';
import 'package:self_remedy/globals.dart';
import 'package:self_remedy/helpers/api.dart';
import 'package:self_remedy/pages/add_page.dart';
import 'package:self_remedy/pages/edit_profile.dart';
import 'package:self_remedy/pages/terms_of_use.dart';
import 'package:self_remedy/pages/welcome_page.dart';
import 'package:self_remedy/widgets/about_us_dialog.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.transparent,
      child: Column(
        children: [
          Center(
            child: Image.asset(
              "assets/loading.gif",
              height: 150,
              width: 150,
            ),
          ),
          SizedBox(height: 0.05 * getSize(context).height),
          _getListTile("List Disease", Icons.post_add,
              () => goToPage(context, const AddPage())),
          _getListTile("Edit Profile", Icons.person_outline,
              () => goToPage(context, const EditProfilePage())),
          _getListTile("Terms of use", Icons.gavel_outlined,
              () => goToPage(context, const TermsOfUsePage())),
          _getListTile("Logout", Icons.logout_outlined, () async {
            await apiHelper.signOut();
            goToPage(context, const WelcomePage(), clearStack: true);
          }),
          _getListTile("About", Icons.info_outline, () {
            showDialog(
                context: context, builder: (context) => const AboutUsDialog());
          })
        ],
      ),
    );
  }

  ListTile _getListTile(String text, IconData icon, Function onTap) {
    return ListTile(
      onTap: () => onTap(),
      leading: Icon(
        icon,
        color: Colors.white70,
      ),
      minLeadingWidth: 20,
      title: Text(
        text,
        style: const TextStyle(color: Colors.white70),
      ),
    );
  }
}
