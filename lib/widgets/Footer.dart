import 'package:flutter/material.dart';

import '../constants.dart';

class footer extends StatelessWidget {
  const footer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: theme_color,
      ),
    );
  }
}