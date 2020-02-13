import 'package:flutter/material.dart';
import '../SkeletonScreen.dart';

class DefualtItemSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
      height: 80.0,
      child: Row(
        children: <Widget>[
          SkeletonScreen.skeQuare(100),
          SizedBox(width: 10.0),
          Expanded(
            child: Container(
              child: Column(
                children: <Widget>[
                  SkeletonScreen.skeRect(height: 10.0),
                  SizedBox(height: 10),
                  SkeletonScreen.skeRect(height: 10.0),
                  SizedBox(height: 10),
                  SkeletonScreen.skeRect(height: 10.0),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SkeletonScreen.skeRect(width: 50.0, height: 10.0),
                      SkeletonScreen.skeRect(width: 50.0, height: 10.0),
                      SkeletonScreen.skeRect(width: 50.0, height: 10.0),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
