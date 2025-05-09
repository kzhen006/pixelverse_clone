import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pixelverse_clone/constants/constants.dart';
import 'package:pixelverse_clone/features/tweet/widgets/tweet_list.dart';
import 'package:pixelverse_clone/theme/theme.dart';
import 'package:pixelverse_clone/theme/pallete.dart';

class UIConstants {
  static AppBar appBar() {
    return AppBar(
      title: SvgPicture.asset(
        AssetsConstants.twitterLogo,
        //colorFilter: Pallete.blueColorFilter,
        color: Pallete.blueColor,
        height: 30.0,
      ),
      centerTitle: true,
    );
  }

  static const List<Widget> bottomTabBarPages = [
    TweetList(),
    Text('Feature In Progress'),
    Text('Feature Not Enabled'),
    Text('Notification Screen'),
    
    // ExploreView(),
    // NotificationView(),
  ];
}