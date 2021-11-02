import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NewPairs extends StatelessWidget {

  Widget _headerRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
      child: Row(children: const <Widget>[
        Text(
          'Nowe pary',
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
        ),
      ]),
    );
  }

  Widget _pairItem() {
    return Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(children: <Widget>[
          CircleAvatar(radius: 35.0, backgroundColor: Colors.grey),
          SizedBox(height: 6.0),
          Text(
            "Natalia",
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _headerRow(),
        SizedBox(
          height: 120.0,
          child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              scrollDirection: Axis.horizontal,
              itemCount: 8,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(onTap: () => {}, child: _pairItem());
              }),
        )
      ],
    );
  }
}
