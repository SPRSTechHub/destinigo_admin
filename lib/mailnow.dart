import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'ad_helper.dart';
import 'api.dart';

class Mailnow extends StatefulWidget {
  const Mailnow({Key? key}) : super(key: key);

  @override
  _MailnowState createState() => _MailnowState();
}

class _MailnowState extends State<Mailnow> {
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
          // print('Failed to load a banner ad: ${err.message}');
          _isBannerAdReady = false;
          ad.dispose();
        },
      ),
    );
    _bannerAd.load();
  }

  // Set up Global Form Keys //
  final _formKey = GlobalKey<FormState>();

  // Set up Form inputs //
  final emailController = TextEditingController();
  final fullnameController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    fullnameController.dispose();
    _bannerAd.dispose();
    super.dispose();
  }

  // Set up Output //
  String message = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Emails')),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment(.15, .045),
                end: Alignment(-1, -1),
                colors: [
                  Color.fromRGBO(0, 0, 9, 1),
                  Color.fromRGBO(91, 0, 60, 1)
                ],
              )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: Image.asset(
                        'assets/images/mail_top_banner.png',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 82,
                    child: Align(
                        child: Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: <Widget>[
                          Positioned(
                              top: 0,
                              right: 0,
                              child: SizedBox(
                                  width: 88,
                                  height: 82,
                                  child: Stack(children: <Widget>[
                                    Positioned(
                                        top: 0,
                                        left: 0,
                                        child: Container(
                                            width: 88,
                                            height: 82,
                                            decoration: const BoxDecoration(
                                              gradient: RadialGradient(
                                                center: Alignment.center,
                                                colors: [
                                                  Color.fromARGB(
                                                      255, 88, 0, 75),
                                                  Color.fromRGBO(19, 0, 18, 1)
                                                ],
                                                radius: 1.0,
                                              ),
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                                bottomLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10),
                                              ),
                                            ))),
                                    const Positioned(
                                        top: 17,
                                        left: 21,
                                        child: Text(
                                          '99',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  255, 255, 255, 1),
                                              fontFamily: 'Roboto',
                                              fontSize: 40,
                                              letterSpacing:
                                                  0 /*percentages not used in flutter. defaulting to zero*/,
                                              fontWeight: FontWeight.normal,
                                              height: 1),
                                        )),
                                    const Positioned(
                                        top: 60,
                                        left: 16,
                                        child: Text(
                                          'TARGET',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  255, 255, 255, 1),
                                              fontFamily: 'Roboto',
                                              fontSize: 16,
                                              letterSpacing:
                                                  0 /*percentages not used in flutter. defaulting to zero*/,
                                              fontWeight: FontWeight.normal,
                                              height: 1),
                                        )),
                                  ]))),
                          Positioned(
                              top: 0,
                              right: 96,
                              child: Container(
                                  width: 88,
                                  height: 82,
                                  decoration: const BoxDecoration(
                                    gradient: RadialGradient(
                                      center: Alignment.center,
                                      colors: [
                                        Color.fromARGB(255, 88, 0, 75),
                                        Color.fromRGBO(19, 0, 18, 1)
                                      ],
                                      radius: 1.0,
                                    ),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                  ),
                                  child: Stack(children: <Widget>[
                                    Positioned(
                                        top: 0,
                                        left: 0,
                                        child: Container(
                                            width: 88,
                                            height: 82,
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                                bottomLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10),
                                              ),
                                            ))),
                                    const Positioned(
                                        top: 60,
                                        left: 25,
                                        child: Text(
                                          'SEND',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  255, 255, 255, 1),
                                              fontFamily: 'Roboto',
                                              fontSize: 16,
                                              letterSpacing:
                                                  0 /*percentages not used in flutter. defaulting to zero*/,
                                              fontWeight: FontWeight.normal,
                                              height: 1),
                                        )),
                                    const Positioned(
                                        top: 18,
                                        left: 19,
                                        child: Text(
                                          '99',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  255, 255, 255, 1),
                                              fontFamily: 'Roboto',
                                              fontSize: 40,
                                              letterSpacing:
                                                  0 /*percentages not used in flutter. defaulting to zero*/,
                                              fontWeight: FontWeight.normal,
                                              height: 1),
                                        )),
                                  ]))),
                          Positioned(
                              top: 0,
                              right: 192,
                              child: Container(
                                  width: 88,
                                  height: 82,
                                  decoration: const BoxDecoration(
                                    gradient: RadialGradient(
                                      center: Alignment.center,
                                      colors: [
                                        Color.fromARGB(255, 88, 0, 75),
                                        Color.fromRGBO(19, 0, 18, 1)
                                      ],
                                      radius: 1.0,
                                    ),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                  ),
                                  child: Stack(children: <Widget>[
                                    Positioned(
                                        top: 0,
                                        left: 0,
                                        child: Container(
                                            width: 88,
                                            height: 82,
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                                bottomLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10),
                                              ),
                                            ))),
                                    const Positioned(
                                        top: 17,
                                        left: 22,
                                        child: Text(
                                          '99',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  255, 255, 255, 1),
                                              fontFamily: 'Roboto',
                                              fontSize: 40,
                                              letterSpacing:
                                                  0 /*percentages not used in flutter. defaulting to zero*/,
                                              fontWeight: FontWeight.normal,
                                              height: 1),
                                        )),
                                    const Positioned(
                                        top: 60,
                                        left: 25,
                                        child: Text(
                                          'ACHV',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  255, 255, 255, 1),
                                              fontFamily: 'Roboto',
                                              fontSize: 16,
                                              letterSpacing:
                                                  0 /*percentages not used in flutter. defaulting to zero*/,
                                              fontWeight: FontWeight.normal,
                                              height: 1),
                                        )),
                                  ]))),
                        ])),
                  ),
                  SizedBox(
                      child: Form(
                          key: _formKey,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Card(
                                  elevation: 8,
                                  shadowColor: Colors.green,
                                  margin: const EdgeInsets.all(20),
                                  shape: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: Colors.white)),
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        decoration: const InputDecoration(
                                          icon: Icon(Icons.person),
                                          hintText: 'Enter Fullname',
                                          labelText: 'Full Name',
                                        ),
                                        controller: fullnameController,
                                        // The validator receives the text that the user has entered.
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter valid email id';
                                          }
                                          return null;
                                        },
                                      ),
                                      TextFormField(
                                        decoration: const InputDecoration(
                                          icon: Icon(Icons.mail),
                                          hintText: 'Enter email id',
                                          labelText: 'Email Id',
                                        ),
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        controller: emailController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'This field is required';
                                          }
                                          if (!RegExp(r'\S+@\S+\.\S+')
                                              .hasMatch(value)) {
                                            return "Please enter a valid email address";
                                          }
                                          return null;
                                        },
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16.0),
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              var fullname =
                                                  fullnameController.text;
                                              var email = emailController.text;
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                    content: Text(
                                                        'Processing Data')),
                                              );
                                              var rsp = await sendEmail(
                                                  fullname, email);
                                              print(rsp);
                                              if (rsp.containsKey(
                                                      'errorcode') ==
                                                  100) {
                                                setState(() {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                        content: Text(
                                                            'Link generated!')),
                                                  );
                                                });
                                              } else {
                                                setState(() {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                        content: Text(
                                                            'Server Error!')),
                                                  );
                                                });
                                              }
                                            }
                                          },
                                          child: const Text('Submit'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ]))),
                  Positioned(
                    top: 690,
                    left: 23,
                    child: Stack(
                      children: [
                        const Center(
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
                ], //<Widget>[]
              ) //Padding
              ),
        ),
      ),
    );
  }
}