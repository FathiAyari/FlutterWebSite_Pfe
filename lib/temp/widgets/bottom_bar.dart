import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:showroom_backend/temp/widgets/custom_icon_button.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Align(
            alignment: Alignment.center,
            child: Container(
              height: 2,
              width: screenWidth * 0.9,
              color: Colors.white,
            )),
        Container(
          height: screenHeight * 0.05,
          child: Padding(
            padding: EdgeInsets.only(
                left: screenWidth * 0.05, right: screenWidth * 0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CustomIconButton(
                      iconData: FontAwesomeIcons.youtube,


                      color: Colors.red,
                    ),
                    SizedBox(width: screenWidth * 0.021),
                    CustomIconButton(
                      iconData: FontAwesomeIcons.github,
                      url: 'https://github.com/mounaboukhriss',
                      color: Colors.blueAccent,
                    ),
                    SizedBox(width: screenWidth * 0.02),
                    CustomIconButton(
                      iconData: FontAwesomeIcons.linkedin,
                      url: '  ',
                      color: Colors.blue,
                    )
                  ],
                ),
                Text('Made with Flutter Web \u00a9 2021',
                    style: TextStyle(color: Colors.blueAccent, fontFamily: 'Barlow'))
              ],
            ),
          ),
        )
      ],
    );
  }
}
