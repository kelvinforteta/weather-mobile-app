import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final icon;
  final label;
  final description;

  CardWidget({@required this.label, this.icon, @required this.description});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        // width: 110.0,
        child: Card(
          margin: EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 8.0,
          ),
          elevation: 6,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Image.asset(
                  icon,
                  height: 40,
                ),
                Text(
                  '$label',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black45,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  '$description',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
