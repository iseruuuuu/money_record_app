// Dart imports:
import 'dart:io';

// Package imports:
import 'package:google_mobile_ads/google_mobile_ads.dart';

// Project imports:
import 'package:money_records_app/constants/admob_constant.dart';

class AdmobInterstitial {
  InterstitialAd? _interstitialAd;
  int numOfAttemptLoad = 0;
  bool? ready;

  void createAd() {
    InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          numOfAttemptLoad = 0;
          ready = true;
        },
        onAdFailedToLoad: (LoadAdError error) {
          numOfAttemptLoad++;
          _interstitialAd = null;
          if (numOfAttemptLoad <= 2) {
            createAd();
          }
        },
      ),
    );
  }

  Future<void> showAd() async {
    ready = false;
    if (_interstitialAd == null) {
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) {},
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        ad.dispose();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError aderror) {
        ad.dispose();
        createAd();
      },
    );
    await _interstitialAd!.show();
    _interstitialAd = null;
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return AdmobConstant.interstitialAndroid;
    } else if (Platform.isIOS) {
      return AdmobConstant.interstitialIOS;
    } else {
      return BannerAd.testAdUnitId;
    }
  }
}
