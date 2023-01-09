import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class GraphEmptyScreen extends StatelessWidget {
  const GraphEmptyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BannerAd myBanner = BannerAd(
      adUnitId: Platform.isAndroid
          //android
          ? 'ca-app-pub-3940256099942544/6300978111'
          //ios
          : 'ca-app-pub-3471170179614589/7242925577',
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
        },
      ),
    );
    myBanner.load();
    final AdWidget adWidget = AdWidget(ad: myBanner);
    final Container adContainer = Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      height: myBanner.size.height.toDouble(),
      child: adWidget,
    );
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          const Text(
            '入力画面で追加をしてください',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 23,
            ),
          ),
          const SizedBox(height: 15),
          const Icon(
            Icons.maps_ugc_outlined,
            size: 90,
          ),
          const Spacer(),
          adContainer,
        ],
      ),
    );
  }
}
