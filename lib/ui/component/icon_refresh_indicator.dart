// ignore_for_file: non_constant_identifier_names, avoid_unnecessary_containers

import 'package:buma/ui/style/constants.dart';
import 'package:flutter/material.dart';


class IconRefreshIndicator extends StatefulWidget {
  IconRefreshIndicator({
    Key? key,
  }) : super(key: key);

  @override
  State<IconRefreshIndicator> createState() => _IconRefreshIndicatorState();
}

class _IconRefreshIndicatorState extends State<IconRefreshIndicator> {
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Constants.spacing2),
      child: CircularProgressIndicator(
        strokeWidth: 4,
      ),
    );
  }
}
