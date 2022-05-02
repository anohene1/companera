import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsGroupSliderItem extends StatelessWidget {
  final double value;
  final ValueChanged<double> onChanged;
  final int? divisions;
  final String title;
  const SettingsGroupSliderItem({Key? key, required this.value, required this.onChanged, this.divisions, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, top: 20, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(title, style: TextStyle(fontSize: 18),),
          ),
          SizedBox(height: 10, width: double.infinity,),
          SizedBox(
              width: double.infinity,
              child: CupertinoSlider(value: value, onChanged: onChanged, divisions: divisions,))
        ],
      ),
    );
  }
}
