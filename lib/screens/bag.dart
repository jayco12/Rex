class TemplateParams {
  final String fromName;
  final String fromEmail;
  final List<Map<String, dynamic>> cartData;

  TemplateParams({
    required this.fromName,
    required this.fromEmail,
    required this.cartData,
  });

  Map<String, dynamic> toMap() {
    return {
      'fromName': fromName,
      'fromEmail': fromEmail,
      'cartData': cartData,
    };
  }
}
