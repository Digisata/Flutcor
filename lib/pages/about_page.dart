import 'package:cached_network_image/cached_network_image.dart';
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
            padding: EdgeInsets.fromLTRB(
              16.0,
              16.0,
              16.0,
              0,
            ),
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
                        height: 27.0,
                        width: 27.0,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.0,
                ),
                _greetingText(context, 'Made with \u2665 by'),
                SizedBox(
                  height: 30.0,
                ),
                _photoProfile(
                    'https://avatars0.githubusercontent.com/u/30319634?s=400&u=0351d283b9e76d31e8bbd80e088b2c12618948c8&v=4'),
                SizedBox(
                  height: 10.0,
                ),
                _nameText(context, 'Hanif Naufal'),
                _aboutText(context,
                    'UI UX enthusiast, frontend developer (flutter), and lifelong learner'),
                SizedBox(
                  height: 10.0,
                ),
                _socialMedia(
                    'https://www.linkedin.com/in/khairunnaufal-hanif-375371134/',
                    'https://github.com/Digisata',
                    'twitter',
                    'twitter_logo.png',
                    'https://twitter.com/Digisata'),
                SizedBox(
                  height: 30.0,
                ),
                _photoProfile(
                    'https://media-exp1.licdn.com/dms/image/C5603AQGXyQrPxDn1mQ/profile-displayphoto-shrink_800_800/0?e=1599091200&v=beta&t=M6stdynGlZdN-Vs0chTmTOsjGAGXPoVoV3D7SOTKv3M'),
                SizedBox(
                  height: 10.0,
                ),
                _nameText(context, 'Dzakwan Diego'),
                _aboutText(context,
                    'UI UX enthusiast, Network Engineer. Learning how to be a Developer'),
                SizedBox(
                  height: 10.0,
                ),
                _socialMedia(
                    'https://www.linkedin.com/in/dzakwandp/',
                    'https://github.com/dzakwandp',
                    'instagram',
                    'instagram_logo.png',
                    'https://www.instagram.com/dzakwandp/'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  CircleAvatar _photoProfile(String url) {
    return CircleAvatar(
      radius: 75.0,
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        imageUrl: url,
        progressIndicatorBuilder: (context, url, download) =>
            CircularProgressIndicator(
          value: download.progress,
        ),
        errorWidget: (context, url, error) => Icon(Icons.error),
        imageBuilder: (context, imageProvider) => Container(
          width: 150.0,
          height: 150.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
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
      text: TextSpan(
        text: greeting,
        style: Theme.of(context).textTheme.headline2.copyWith(fontSize: 30.0),
      ),
    );
  }

  Text _nameText(BuildContext context, String name) {
    return Text(
      name,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
      style: Theme.of(context).textTheme.headline1,
    );
  }

  Text _aboutText(BuildContext context, String about) {
    return Text(
      about,
      textAlign: TextAlign.center,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      textDirection: TextDirection.ltr,
      style: Theme.of(context).textTheme.headline2,
    );
  }

  Row _socialMedia(String linkedin, String github,
      [String social, String logo, String url]) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _icon('linkedin', 'linkedin_logo.png', linkedin),
        _icon('github', 'github_logo.png', github),
        _icon(social, logo, url),
      ],
    );
  }

  IconButton _icon(String social, String logo, String url) {
    return IconButton(
      tooltip: 'Go to $social',
      icon: Container(
        height: 30.0,
        width: 30.0,
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
