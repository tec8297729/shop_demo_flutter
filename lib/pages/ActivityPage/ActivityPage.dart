import 'package:baixing/utils/image_utils.dart';
import 'package:flutter/material.dart';

class ActivityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: ImageUtils.getAssetImage('asset/ad/recruitment.png'),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
