import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsGroupItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool? value;
  final ValueChanged<bool>? onChanged;

  const SettingsGroupItem({Key? key, required this.icon, required this.title, this.onChanged, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        children: [
          Icon(icon),
          SizedBox(width: 10,),
          Expanded(child: Text(title, style: TextStyle(fontSize: 18),)),
          onChanged != null ? CupertinoSwitch(value: value!, onChanged: onChanged, activeColor: Theme.of(context).primaryColor,) : Container()
        ],
      ),
    );
  }
}
