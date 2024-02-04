class Review {
  final String id; // New field for review ID
  final String userName;
  final String userProfilePhoto;
  final String reviewText;
  final int starRating;
  final List<String> photos;
  final DateTime createdAt; // New field for creation time
  final bool hasPhotos; // New field for indicating if the review has photos

  Review({
    required this.id,
    required this.userName,
    required this.userProfilePhoto,
    required this.reviewText,
    required this.starRating,
    required this.photos,
    required this.createdAt,
  }) : hasPhotos = photos.isNotEmpty;

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      id: map['id'],
      userName: map['userName'],
      userProfilePhoto: map['userProfilePhoto'],
      reviewText: map['reviewText'],
      starRating: map['starRating'],
      photos: (map['photos'] as List<dynamic>).cast<String>(),
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userName': userName,
      'userProfilePhoto': userProfilePhoto,
      'reviewText': reviewText,
      'starRating': starRating,
      'photos': photos,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
