// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:google_mobile_ads/google_mobile_ads.dart';

// Project imports:
import 'package:money_records_app/components/app_bar_item.dart';
import 'package:money_records_app/screen/detail/children/detail_divider_item.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({
    Key? key,
    required this.discountPrice,
    required this.buyPrice,
    required this.category,
    required this.createdDate,
  }) : super(key: key);

  final int discountPrice;
  final int buyPrice;
  final String category;
  final DateTime createdDate;

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

    final deviceSize = MediaQuery.of(context).size.width;
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: const Color(0xFFF2F2F7),
        appBar: AppBarItem(
          appBar: AppBar(),
          title: '',
        ),
        body: Column(
          children: [
            ListTile(
              title: const Text(
                '支払った金額',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              trailing: SizedBox(
                width: deviceSize - 200,
                child: Text(
                  '$buyPrice円',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                  textAlign: TextAlign.end,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const DetailDividerItem(),
            ListTile(
              title: const Text(
                '節約できた金額',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              trailing: SizedBox(
                width: deviceSize - 200,
                child: Text(
                  '$discountPrice円',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                  textAlign: TextAlign.end,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const DetailDividerItem(),
            ListTile(
              title: const Text(
                '種類',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              trailing: SizedBox(
                width: deviceSize - 120,
                child: Text(
                  category,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                  textAlign: TextAlign.end,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const DetailDividerItem(),
            ListTile(
              title: const Text(
                '日付',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              trailing: Text(
                '${createdDate.year}年${createdDate.month}月${createdDate.day}日',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
            ),
            const DetailDividerItem(),
            const Spacer(),
            adContainer,
          ],
        ),
      ),
    );
  }
}
