import 'package:companera/services/authentication.dart';
import 'package:companera/view/widgets/settings_group.dart';
import 'package:companera/view/widgets/settings_group_item.dart';
import 'package:companera/view/widgets/settings_group_slider_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';
import 'package:line_icons/line_icons.dart';

import '../../constants/app-colors.dart';
import '../widgets/dark_radial_background.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        title: Text('Settings'),
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: Stack(
            children: [
              Container(
                // height: double.infinity,
                // width: double.infinity,
                child: DarkRadialBackground(
                  color: HexColor.fromHex("#181a1f"),
                  position: "topLeft",
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 140, left: 20, right: 20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SettingsGroup(
                        heading: 'Fall Detection',
                        children: [
                          SettingsGroupItem(icon: LineIcons.running, title: 'Detect Falls', value: true, onChanged: (value){},),
                          Divider(),
                          SettingsGroupItem(icon: LineIcons.users, title: 'Emergency Contacts', onTap: (){},),
                        ],
                      ),
                      SettingsGroup(
                        heading: 'Reading',
                        children: [
                          SettingsGroupSliderItem(value: 0.5, onChanged: (value){}, title: 'Speech Rate'),
                          Divider(),
                          SettingsGroupSliderItem(value: 1, onChanged: (value){}, title: 'Speech Volume'),
                          Divider(),
                          SettingsGroupSliderItem(value: 1, onChanged: (value){}, title: 'Speech Pitch'),
                        ],
                      ),
                      SettingsGroup(
                          heading: 'Account',
                        children: [
                          SettingsGroupItem(icon: Icons.logout, title: 'Log out', onTap: (){
                            AuthService.signOut(context);
                          },),
                          Divider(),
                          SettingsGroupItem(icon: LineIcons.trash, title: 'Delete Account', color: Colors.red, onTap: (){
                            AuthService.deleteAccount(context);
                          },)
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          )
      ),
    );
  }
}