import 'dart:async';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLaunchDemo extends StatefulWidget {
  static const String routeName = '/url_launch';

  UrlLaunchDemo({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _UrlLaunchDemoState createState() => new _UrlLaunchDemoState();
}

class _UrlLaunchDemoState extends State<UrlLaunchDemo> {
  Future<Null> _launched;

  Future<Null> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false, forceWebView: false);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<Null> _launchInWebViewOrVC(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: true, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _launchStatus(BuildContext context, AsyncSnapshot<Null> snapshot) {
    if (snapshot.hasError) {
      return new Text('Error: ${snapshot.error}');
    } else {
      return const Text('');
    }
  }

  @override
  Widget build(BuildContext context) {
    const String toLaunch = 'https://flutter.io';
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("URL Launch Demo"),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: const EdgeInsets.all(16.0),
              child: const Text(toLaunch),
            ),
            new RaisedButton(
              onPressed: () => setState(() {
                    _launched = _launchInBrowser(toLaunch);
                  }),
              child: const Text('Launch in browser'),
            ),
            const Padding(padding: const EdgeInsets.all(16.0)),
            new RaisedButton(
              onPressed: () => setState(() {
                    _launched = _launchInWebViewOrVC(toLaunch);
                  }),
              child: const Text('Launch in app'),
            ),
            const Padding(padding: const EdgeInsets.all(16.0)),
            new FutureBuilder<Null>(future: _launched, builder: _launchStatus),
          ],
        ),
      ),
    );
  }
}
