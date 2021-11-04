import 'package:flutter/material.dart';

class RecentChats extends StatelessWidget {
  Widget _headerRow() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
      child: Row(children: const <Widget>[
        Text(
          'Wiadomości',
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
        ),
      ]),
    );
  }

  Widget _chatItem(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              CircleAvatar(radius: 35.0, backgroundColor: Colors.grey),
              SizedBox(width: 10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Natalia",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 5.0),
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Text(
                      "Tylko dlatego, że słuchamy tej samej muzyki",
                      style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      _headerRow(),
      ListView.builder(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemCount: 8,
          itemBuilder: (context, index) {
            return GestureDetector(onTap: () => {}, child: _chatItem(context));
          })
    ]);
  }
}
