// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

// Project imports:
import 'package:money_records_app/constants/admob_constant.dart';

class GoogleAdInfo {
  GoogleAdInfo() {
    createMmyInterstitialAd();
  }

  static String get appId {
    //static修飾子：インスタンスごとでなくクラス共通で取得できる変数
    if (Platform.isAndroid) {
      return AdmobConstant.android; //アプリID
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

//<---------------InterstitialAd - インタースティシャル広告----------------->
  /* ポップアップとして全画面を占有し、閉じるボタンを押さない限り表示され続ける広告 */

  InterstitialAd? myInterstitialAd;
  int numInterstitialLoadAttempts = 0;
  int maxFailedLoadAttempts = 3;

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/7049598008";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/3964253750";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  createMmyInterstitialAd() {
    /* インタースティシャル広告を作成 */
    var interstitialAd = InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          myInterstitialAd = ad;
          numInterstitialLoadAttempts = 0;
        },
        onAdFailedToLoad: (LoadAdError error) {
          numInterstitialLoadAttempts += 1;
          myInterstitialAd = null;
          if (numInterstitialLoadAttempts <= maxFailedLoadAttempts) {
            createMmyInterstitialAd();
          }
        },
      ),
    );
  }

  showLoadingAdDialog() async {
    /* インタースティシャル広告を表示する前に飛び出す1秒間のローディングダイアログ */
    /* Googleの推奨として、ユーザーの誤操作防止のためにあえて広告前にローディング画面出す */
    Get.defaultDialog(
      title: "",
      content: Column(
        children: const [
          CircularProgressIndicator(),
          SizedBox(height: 15),
          Text("Loading"),
        ],
      ),
    );
    await Future.delayed(const Duration(seconds: 1)); //ダイアログを1秒間表示
    if (Get.isDialogOpen!) Get.back(); //ダイアログを閉じる
  }

  showMyInterstitialAd() async {
    /* インタースティシャル広告を表示する関数 */
    if (myInterstitialAd == null) {
      return;
    }
    await showLoadingAdDialog();
    myInterstitialAd!.show();
    myInterstitialAd = null;
  }
}
