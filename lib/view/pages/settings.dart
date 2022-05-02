import 'package:companera/view/widgets/settings_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
                        children: [
                          ListTile(title: Text('name'),)
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