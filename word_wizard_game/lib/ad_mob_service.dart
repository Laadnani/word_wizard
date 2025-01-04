import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:user_messaging_platform/user_messaging_platform.dart' as ump;

class AdMobService {
  /// Banner Ad Unit ID
  static String? get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-2174102362628384/3469998451';
    } else {
      return null;
    }
  }

  /// Rewarded Ad Unit ID
  static String? get rewardAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-2174102362628384/1849896654';
    } else {
      return null;
    }
  }

  /// Generate AdRequest based on user consent
  static Future<AdRequest> getAdRequest() async {
    // Fetch the consent status using UMP
    ump.ConsentInformation consentInfo =
        await ump.UserMessagingPlatform.instance.requestConsentInfoUpdate();

    // Check consent status and set personalizedAds flag accordingly
    bool personalizedAds =
        consentInfo.consentStatus == ump.ConsentStatus.obtained;

    return AdRequest(
      nonPersonalizedAds:
          !personalizedAds, // If consent is not obtained, use non-personalized ads
    );
  }

  void updateConsent() async {
    // Make sure to continue with the latest consent info.
    var info =
        await ump.UserMessagingPlatform.instance.requestConsentInfoUpdate();

    // Show the consent form if consent is required.
    if (info.consentStatus == ump.ConsentStatus.required) {
      // `showConsentForm` returns the latest consent info, after the consent from has been closed.
      info = await ump.UserMessagingPlatform.instance.showConsentForm();
    }
  }
}
