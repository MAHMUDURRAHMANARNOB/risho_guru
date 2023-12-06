import 'package:flutter/material.dart';
import 'dart:convert';

import '../api/api_service.dart';
import '../api/responses/substiptionStatus_response.dart';
import '../models/tools.dart';

class SubscriptionStatusProvider extends ChangeNotifier {
  int userId;
  late SubscriptionStatusResponse _subscriptionStatus;

  SubscriptionStatusProvider({required this.userId})
      : _subscriptionStatus = SubscriptionStatusResponse.initial();

  SubscriptionStatusResponse get subscriptionStatus => _subscriptionStatus;

  Future<void> fetchData() async {
    print('Fetching subscriptionData for userId: $userId');

    try {
      final newSubscriptionStatus =
          await ApiService.fetchSubscriptionStatus(userId);

      // Check if the response has an error code of 200 (or any other success condition)
      if (newSubscriptionStatus.errorcode == 200) {
        // Update the subscription status and notify listeners
        _subscriptionStatus = newSubscriptionStatus;
        notifyListeners();
      } else {
        // Handle the case when the response has an error code other than 200
        print(
            'Failed to fetch subscription data. Error code: ${newSubscriptionStatus.errorcode}');
      }
    } catch (e) {
      // Handle the case when there is an exception during the API call
      print('Error fetching subscription data: $e');
    }
  }
}
