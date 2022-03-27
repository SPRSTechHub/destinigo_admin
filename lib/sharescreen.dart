import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:share_plus/share_plus.dart';

import 'ad_helper.dart';
import 'api.dart';
import 'package:lottie/lottie.dart';

class ShareScreenWP extends StatefulWidget {
  const ShareScreenWP({Key? key}) : super(key: key);

  @override
  _ShareScreenWPState createState() => _ShareScreenWPState();
}

class _ShareScreenWPState extends State<ShareScreenWP> {
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
      request: const AdRequest(),
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

  final _formKey = GlobalKey<FormState>();
  final mobilenoController = TextEditingController();
  String message = '';
  String url = 'https://play.liveipl.online/?uri=';

  @override
  void dispose() {
    mobilenoController.dispose();
    _bannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Share')),
      body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Lottie.asset('assets/images/tools_testing.json'),
              ),
              Expanded(
                flex: 2,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Card(
                              elevation: 8,
                              shadowColor: Colors.green,
                              margin: const EdgeInsets.all(20),
                              shape: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: Colors.white)),
                              child: Column(
                                children: [
                                  TextFormField(
                                    decoration: const InputDecoration(
                                      icon: Icon(Icons.phone),
                                      hintText: 'Enter a phone number',
                                      labelText: 'Enter Mobile No',
                                    ),
                                    controller: mobilenoController,
                                    // The validator receives the text that the user has entered.
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter 10 digit number';
                                      }
                                      return null;
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16.0),
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        // Validate returns true if the form is valid, or false otherwise.
                                        if (_formKey.currentState!.validate()) {
                                          // If the form is valid, display a snackbar. In the real world,
                                          // you'd often call a server or save the information in a database.
                                          var mobileno =
                                              mobilenoController.text;
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content:
                                                    Text('Processing Data')),
                                          );
                                          var rsp = await loginUser(mobileno);
                                          //  print(rsp);
                                          if (rsp.containsKey('errorcode')) {
                                            setState(() {
                                              var sharemsg = rsp['msg'] +
                                                  ' ' +
                                                  url +
                                                  rsp['linky'];
                                              Share.share(sharemsg,
                                                  subject: 'Look what I made!');
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                    content: Text(
                                                        'Link generated!')),
                                              );
                                            });
                                          } else {
                                            setState(() {
                                              message = 'Login Failed';
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
                          ]),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
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
            ],
          )),
    );
  }
}
