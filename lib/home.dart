// ignore_for_file: prefer_const_constructors, must_call_super
import 'package:destinigo_admin/sharescreen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'adddata.dart';
import 'callscreen.dart';
import 'mailnow.dart';
import 'ad_helper.dart';
import 'package:destinigo_admin/services/local_notification_service.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title, string}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();
    LocalNotificationService.initialize(context);
/* Terminate app show notification */
    FirebaseMessaging.instance.getInitialMessage().then(
          (message) {
        print("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          print("New Notification");
          // if (message.data['_id'] != null) {
          //   Navigator.of(context).push(
          //     MaterialPageRoute(
          //       builder: (context) => DemoScreen(
          //         id: message.data['_id'],
          //       ),
          //     ),
          //   );
          // }
        }
      },
    );

    /* App opened show notification */
    FirebaseMessaging.onMessage.listen(
          (message) {
        print("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data11 ${message.data}");
        //  LocalNotificationService.createanddisplaynotification(message);
        }
      },
    );

    /* App is in Background show notoficaton */
    FirebaseMessaging.onMessageOpenedApp.listen(
          (message) {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data22 ${message.data['_id']}");
        }
      },
    );

  }
    // ignore: unused_element
  Future<InitializationStatus> _initGoogleMobileAds() {
    return MobileAds.instance.initialize();
  }

  late BannerAd _bannerAd;
  bool _isBannerAdReady = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          _isBannerAdReady = false;
          ad.dispose();
        },
      ),
    );
    _bannerAd.load();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment(.15, .045),
            end: Alignment(-1, -1),
            colors: const [
              Color.fromRGBO(0, 0, 9, 1),
              Color.fromRGBO(91, 0, 60, 1)
            ],
          )),
          child: Stack(children: <Widget>[
            Positioned(
                top: 50,
                left: 14,
                child: Text(
                  'Dashboard',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Color.fromRGBO(59, 102, 255, 1),
                      fontFamily: 'Roboto',
                      fontSize: 20,
                      letterSpacing:
                          0 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.normal,
                      height: 1),
                )),
            Positioned(
                top: 50,
                left: 242,
                child: Container(
                    width: 38,
                    height: 26,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/Computer_chat.png'),
                          fit: BoxFit.fitWidth),
                    ))),
            Positioned(
              top: 690,
              left: 23,
              child: Stack(
                children: [
                  Center(
                      //
                      ),
                  if (_isBannerAdReady)
                    Align(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                        width: _bannerAd.size.width.toDouble(),
                        height: _bannerAd.size.height.toDouble(),
                        child: AdWidget(ad: _bannerAd),
                      ),
                    ),
                ],
              ),
            ),
            Positioned(
                top: 50,
                left: 308,
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(196, 196, 196, 1),
                    image: DecorationImage(
                        image: AssetImage("assets/images/profile.png"),
                        fit: BoxFit.fitWidth),
                    borderRadius: BorderRadius.all(Radius.elliptical(28, 28)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1), //color of shadow
                        spreadRadius: 5, //spread radius
                        blurRadius: 7, // blur radius
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                )),
            Positioned(
                top: 86,
                left: 14,
                child: Text(
                  'Hello,',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      fontFamily: 'Roboto',
                      fontSize: 26,
                      letterSpacing:
                          0 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.normal,
                      height: 1),
                )),
            Positioned(
                top: 184,
                left: 24,
                child: Container(
                    width: 118,
                    height: 114,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.25),
                            offset: Offset(0, 6),
                            blurRadius: 4)
                      ],
                      gradient: LinearGradient(
                          begin:
                              Alignment(0.4546307623386383, 0.6700913906097412),
                          end: Alignment(
                              -0.6700913906097412, 0.4243307411670685),
                          colors: const [
                            Color.fromRGBO(70, 70, 70, 0.6299999952316284),
                            Color.fromRGBO(0, 0, 30, 1)
                          ]),
                    ))),
            Positioned(
                top: 195,
                left: 40,
                child: Container(
                    width: 118,
                    height: 114,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.25),
                            offset: Offset(0, 6),
                            blurRadius: 4)
                      ],
                      gradient: LinearGradient(
                          begin:
                              Alignment(0.4546307623386383, 0.6700913906097412),
                          end: Alignment(
                              -0.6700913906097412, 0.4243307411670685),
                          colors: const [
                            Color.fromRGBO(70, 70, 70, 0.6299999952316284),
                            Color.fromRGBO(0, 0, 30, 1)
                          ]),
                    ))),
            Positioned(
                top: 114,
                left: 18,
                child: SizedBox(
                    width: 338,
                    height: 48,
                    child: Stack(children: <Widget>[
                      Positioned(
                          top: 13,
                          left: 0,
                          child: Text(
                            'App user',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 1),
                                fontFamily: 'Roboto',
                                fontSize: 20,
                                letterSpacing:
                                    0 /*percentages not used in flutter. defaulting to zero*/,
                                fontWeight: FontWeight.normal,
                                height: 1),
                          )),
                      Positioned(
                          top: 5,
                          left: 124,
                          child: Container(
                              width: 42,
                              height: 39,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/Hitchhike.png'),
                                    fit: BoxFit.fitWidth),
                              ))),
                      Positioned(
                          top: 0,
                          left: 290,
                          child: Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/images/Lock.png'),
                                    fit: BoxFit.fitWidth),
                              ))),
                    ]))),
            Positioned(
              top: 209,
              left: 68,
              child: InkWell(
                child: Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/Adduser.png'),
                          fit: BoxFit.fitWidth),
                    )),
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => AddData()));
                },
              ),
            ),
            Positioned(
                top: 183,
                left: 223,
                child: Container(
                    width: 118,
                    height: 114,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromARGB(218, 0, 0, 0),
                            offset: Offset(0, 2),
                            blurRadius: 4)
                      ],
                      gradient: LinearGradient(
                          begin:
                              Alignment(0.4546307623386383, 0.6700913906097412),
                          end: Alignment(
                              -0.6700913906097412, 0.4243307411670685),
                          colors: const [
                            Color.fromRGBO(70, 70, 70, 0.6299999952316284),
                            Color.fromRGBO(0, 0, 30, 1)
                          ]),
                    ))),
            Positioned(
                top: 194,
                left: 208,
                child: Container(
                    width: 118,
                    height: 114,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.25),
                            offset: Offset(0, 6),
                            blurRadius: 4)
                      ],
                      gradient: LinearGradient(
                          begin:
                              Alignment(0.4546307623386383, 0.6700913906097412),
                          end: Alignment(
                              -0.6700913906097412, 0.4243307411670685),
                          colors: const [
                            Color.fromRGBO(70, 70, 70, 0.6299999952316284),
                            Color.fromRGBO(0, 0, 30, 1)
                          ]),
                    ))),
            Positioned(
                top: 209,
                left: 244,
                child: InkWell(
                  child: Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/Callback.png'),
                            fit: BoxFit.fitWidth),
                      )),
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => CallScreen()));
                  },
                )),
            Positioned(
                top: 355,
                left: 24,
                child: Container(
                    width: 118,
                    height: 114,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.25),
                            offset: Offset(0, 6),
                            blurRadius: 4)
                      ],
                      gradient: LinearGradient(
                          begin:
                              Alignment(0.4546307623386383, 0.6700913906097412),
                          end: Alignment(
                              -0.6700913906097412, 0.4243307411670685),
                          colors: const [
                            Color.fromRGBO(70, 70, 70, 0.6299999952316284),
                            Color.fromRGBO(0, 0, 30, 1)
                          ]),
                    ))),
            Positioned(
                top: 338,
                left: 40,
                child: Container(
                    width: 118,
                    height: 114,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.25),
                            offset: Offset(0, 6),
                            blurRadius: 4)
                      ],
                      gradient: LinearGradient(
                          begin:
                              Alignment(0.4546307623386383, 0.6700913906097412),
                          end: Alignment(
                              -0.6700913906097412, 0.4243307411670685),
                          colors: const [
                            Color.fromRGBO(70, 70, 70, 0.6299999952316284),
                            Color.fromRGBO(0, 0, 30, 1)
                          ]),
                    ))),
            Positioned(
                top: 355,
                left: 233,
                child: Container(
                    width: 118,
                    height: 114,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.25),
                            offset: Offset(0, 6),
                            blurRadius: 4)
                      ],
                      gradient: LinearGradient(
                          begin:
                              Alignment(0.4546307623386383, 0.6700913906097412),
                          end: Alignment(
                              -0.6700913906097412, 0.4243307411670685),
                          colors: const [
                            Color.fromRGBO(70, 70, 70, 0.6299999952316284),
                            Color.fromRGBO(0, 0, 30, 1)
                          ]),
                    ))),
            Positioned(
                top: 338,
                left: 217,
                child: Container(
                    width: 118,
                    height: 114,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.25),
                            offset: Offset(0, 6),
                            blurRadius: 4)
                      ],
                      gradient: LinearGradient(
                          begin:
                              Alignment(0.4546307623386383, 0.6700913906097412),
                          end: Alignment(
                              -0.6700913906097412, 0.4243307411670685),
                          colors: const [
                            Color.fromRGBO(70, 70, 70, 0.6299999952316284),
                            Color.fromRGBO(0, 0, 30, 1)
                          ]),
                    ))),
            Positioned(
                top: 368,
                left: 70,
                child: InkWell(
                  child: Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/Whatsapp.png'),
                            fit: BoxFit.fitWidth),
                      )),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ShareScreenWP()));
                  },
                )),
            Positioned(
                top: 368,
                left: 250,
                child: InkWell(
                  child: Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/Sendemail.png'),
                            fit: BoxFit.fitWidth),
                      )),
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Mailnow()));
                  },
                )),
            Positioned(
                top: 515,
                left: 24,
                child: Text(
                  'Text paragraph are here',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      fontFamily: 'Roboto',
                      fontSize: 26,
                      letterSpacing:
                          0 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.normal,
                      height: 1),
                )),
          ])),
    );
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }
}
