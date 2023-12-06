class SubscriptionStatusResponse {
  final int errorcode;
  final String message;
  final String validitydate;
  final String isValid;
  final int commentsavailable;
  final int ticketsavailable;

  SubscriptionStatusResponse({
    required this.errorcode,
    required this.message,
    required this.validitydate,
    required this.isValid,
    required this.commentsavailable,
    required this.ticketsavailable,
  });
  SubscriptionStatusResponse.initial()
      : errorcode = 0,
        message = '',
        validitydate = '',
        isValid = '',
        commentsavailable = 0,
        ticketsavailable = 0;

  factory SubscriptionStatusResponse.fromJson(Map<String, dynamic> json) {
    return SubscriptionStatusResponse(
      errorcode: json['errorcode'],
      message: json['message'],
      validitydate: json['validitydate'],
      isValid: json['isValid'],
      commentsavailable: json['commentsavailable'],
      ticketsavailable: json['ticketsavailable'],
    );
  }
}
