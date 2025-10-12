import 'package:flutter_stripe/flutter_stripe.dart';

/// Call this in your main.dart before using Stripe features.
/// Example:
///   await initializeStripe('your-publishable-key');
Future<void> initializeStripe(String publishableKey) async {
  Stripe.publishableKey = publishableKey;
  // Optionally set the merchant identifier for Apple Pay
  // Stripe.merchantIdentifier = 'merchant.com.yourapp';
  await Stripe.instance.applySettings();
}

/// You can add more helper functions here for payment, etc.