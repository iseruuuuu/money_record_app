// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:google_mobile_ads/google_mobile_ads.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({
    Key? key,
    required this.id,
    required this.discountPrice,
    required this.buyPrice,
    required this.category,
    required this.createdDate,
  }) : super(key: key);

  final String id;
  final int discountPrice;
  final int buyPrice;
  final String category;
  final DateTime createdDate;

  //TODO デザインを修正する
  @override
  Widget build(BuildContext context) {
    final myBanner = BannerAd(
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
    final adWidget = AdWidget(ad: myBanner);
    final adContainer = Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      height: myBanner.size.height.toDouble(),
      child: adWidget,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF4A67AD),
        elevation: 0,
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text('節約できた金額'),
            trailing: Text('$discountPrice円'),
          ),
          ListTile(
            title: const Text('支払った金額'),
            trailing: Text('$buyPrice円'),
          ),
          ListTile(
            title: const Text('種類'),
            trailing: Text(category),
          ),
          ListTile(
            title: const Text('日付'),
            trailing: Text(
              '${createdDate.year}/${createdDate.month}/${createdDate.day}',
            ),
          ),
          const Spacer(),
          adContainer,
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
