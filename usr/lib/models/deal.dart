class Deal {
  final String id;
  final String productName;
  final double originalPrice;
  final double discountedPrice;
  final int discountPercentage;
  final String image;
  final String description;
  final DateTime endDate;

  Deal({
    required this.id,
    required this.productName,
    required this.originalPrice,
    required this.discountedPrice,
    required this.discountPercentage,
    required this.image,
    required this.description,
    required this.endDate,
  });

  String get savings {
    return (originalPrice - discountedPrice).toStringAsFixed(2);
  }

  String get daysRemaining {
    final difference = endDate.difference(DateTime.now());
    if (difference.inDays > 0) {
      return '${difference.inDays} days left';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours left';
    } else {
      return 'Ending soon!';
    }
  }
}
