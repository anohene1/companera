import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsGroupItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool? value;
  final ValueChanged<bool>? onChanged;
  final VoidCallback? onTap;
  final Color? color;

  const SettingsGroupItem({Key? key, required this.icon, required this.title, this.onChanged, this.value, this.onTap, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        highlightColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: 60,
          child: Row(
            children: [
              Icon(icon, color: color,),
              const SizedBox(width: 10,),
              Expanded(child: Text(title, style: TextStyle(fontSize: 18, color: color),)),
              onChanged != null ? CupertinoSwitch(value: value!, onChanged: onChanged, activeColor: Theme.of(context).primaryColor,) : Container()
            ],
          ),
        ),
      ),
    );
  }
}
