import 'package:flutcor/commons/commons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      tooltip: 'Back to home page',
                      icon: Image.asset(
                        'assets/buttons/back_button.png',
                        height: ContentSize.height(context) * 0.03,
                        width: ContentSize.height(context) * 0.03,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: ContentSize.height(context) * 0.03,
                ),
                _greetingText(context, 'Made with \u2665 by'),
                SizedBox(
                  height: ContentSize.height(context) * 0.03,
                ),
                _photoProfile(context,
                    'https://avatars0.githubusercontent.com/u/30319634?s=400&u=0351d283b9e76d31e8bbd80e088b2c12618948c8&v=4'),
                SizedBox(
                  height: ContentSize.height(context) * 0.02,
                ),
                _nameText(context, 'Hanif Naufal'),
                _aboutText(context,
                    'UI UX enthusiast, frontend developer (flutter), and lifelong learner'),
                SizedBox(
                  height: ContentSize.height(context) * 0.02,
                ),
                _socialMedia(
                  context,
                  'https://www.linkedin.com/in/khairunnaufal-hanif-375371134/',
                  'https://github.com/Digisata',
                  'twitter',
                  'twitter_logo.png',
                  'https://twitter.com/Digisata',
                ),
                SizedBox(
                  height: ContentSize.height(context) * 0.03,
                ),
                _photoProfile(context,
                    'https://media-exp1.licdn.com/dms/image/C5603AQGXyQrPxDn1mQ/profile-displayphoto-shrink_800_800/0?e=1599091200&v=beta&t=M6stdynGlZdN-Vs0chTmTOsjGAGXPoVoV3D7SOTKv3M'),
                SizedBox(
                  height: ContentSize.height(context) * 0.02,
                ),
                _nameText(context, 'Dzakwan Diego'),
                _aboutText(context,
                    'UI UX enthusiast, Network Engineer. Learning how to be a Developer'),
                SizedBox(
                  height: ContentSize.height(context) * 0.02,
                ),
                _socialMedia(
                  context,
                  'https://www.linkedin.com/in/dzakwandp/',
                  'https://github.com/dzakwandp',
                  'instagram',
                  'instagram_logo.png',
                  'https://www.instagram.com/dzakwandp/',
                ),
                SizedBox(
                  height: ContentSize.height(context) * 0.03,
                ),
                RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.headline2.copyWith(
                          fontSize: ContentSize.dp14(context),
                        ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Thanks to ',
                      ),
                      TextSpan(
                        text: 'Muhammad Sulthan Al Ihsan',
                        style: TextStyle(
                          color: Colors.blue[700],
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            _launchURL('https://github.com/sulthanalihsan');
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  CircleAvatar _photoProfile(BuildContext context, String url) {
    return CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: ContentSize.height(context) * 0.08,
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        imageUrl: url,
        progressIndicatorBuilder: (context, url, download) =>
            CircularProgressIndicator(
          value: download.progress,
        ),
        errorWidget: (context, url, error) => Icon(Icons.error),
        imageBuilder: (context, imageProvider) => Container(
          width: ContentSize.height(context) * 0.16,
          height: ContentSize.height(context) * 0.16,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  RichText _greetingText(BuildContext context, String greeting) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        text: greeting,
        style: Theme.of(context).textTheme.headline2.copyWith(
              fontSize: ContentSize.dp30(context),
            ),
      ),
    );
  }

  Text _nameText(BuildContext context, String name) {
    return Text(
      name,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
      style: Theme.of(context).textTheme.headline1.copyWith(
            fontSize: ContentSize.dp24(context),
          ),
    );
  }

  Text _aboutText(BuildContext context, String about) {
    return Text(
      about,
      textAlign: TextAlign.center,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      textDirection: TextDirection.ltr,
      style: Theme.of(context).textTheme.headline2.copyWith(
            fontSize: ContentSize.dp20(context),
          ),
    );
  }

  Row _socialMedia(BuildContext context, String linkedin, String github,
      [String social, String logo, String url]) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _icon(context, 'linkedin', 'linkedin_logo.png', linkedin),
        _icon(context, 'github', 'github_logo.png', github),
        _icon(context, social, logo, url),
      ],
    );
  }

  IconButton _icon(
      BuildContext context, String social, String logo, String url) {
    return IconButton(
      tooltip: 'Go to $social',
      icon: Container(
        height: ContentSize.height(context) * 0.03,
        width: ContentSize.height(context) * 0.03,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent,
          image: DecorationImage(
            image: AssetImage(
              'assets/logos/$logo',
            ),
          ),
        ),
      ),
      onPressed: () {
        _launchURL(url);
      },
    );
  }
}
