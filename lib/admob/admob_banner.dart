// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:google_mobile_ads/google_mobile_ads.dart';

// Project imports:
import 'package:money_records_app/constants/admob_constant.dart';

class AdmobBanner {
  static String get appId {
    if (Platform.isAndroid) {
      return AdmobConstant.android;
    } else if (Platform.isIOS) {
      return AdmobConstant.iOS;
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return AdmobConstant.bannerAndroid;
    } else if (Platform.isIOS) {
      return AdmobConstant.bannerIOS;
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  get myBannerAd {
    var bannerAd = BannerAd(
      adUnitId: bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: bannerAdListener,
    )..load();
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      alignment: Alignment.center,
      width: bannerAd.size.width.toDouble(),
      height: bannerAd.size.height.toDouble(),
      child: AdWidget(ad: bannerAd),
    );
  }

  BannerAdListener get bannerAdListener {
    return BannerAdListener(
      onAdLoaded: (Ad ad) => print('Ad loaded.'),
      onAdFailedToLoad: (Ad ad, LoadAdError error) {
        ad.dispose();
      },
      onAdOpened: (Ad ad) => print('Ad opened.'),
      onAdClosed: (Ad ad) => print('Ad closed.'),
      onAdImpression: (Ad ad) => print('Ad impression.'),
    );
  }
}
