class BrandResponse {
  final bool success;
  final String message;
  final List<Brand> data;

  BrandResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory BrandResponse.fromJson(Map<String, dynamic> json) {
    return BrandResponse(
      success: json['success'],
      message: json['message'],
      data: (json['data'] as List<dynamic>).map((item) => Brand.fromJson(item as Map<String, dynamic>)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data.map((brand) => brand.toJson()).toList(),
    };
  }
}

class Brand {
  final int? brandId;
  final String? brandName;
  final String? brandDescription;
  final String? websiteUrl;
  final String? logo;
  final String? region;
  final String? area;
  final String? ownerPhoneNumber;
  final String? wineryPhoneNumber;
  final String? ownerName;
  final String? commercialName;
  final String? instagram;
  final String? facebook;

  Brand({
    this.brandId,
    this.brandName,
    this.brandDescription,
    this.websiteUrl,
    this.logo,
    this.region,
    this.area,
    this.ownerPhoneNumber,
    this.wineryPhoneNumber,
    this.ownerName,
    this.commercialName,
    this.instagram,
    this.facebook,
  });

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      brandId: json['brandId'] as int?,
      brandName: json['brandName'] as String?,
      brandDescription: json['brandDescription'] as String?,
      websiteUrl: json['websiteUrl'] as String?,
      logo: json['logo'] as String?,
      region: json['region'] as String?,
      area: json['area'] as String?,
      ownerPhoneNumber: json['ownerPhoneNumber'] as String?,
      wineryPhoneNumber: json['wineryPhoneNumber'] as String?,
      ownerName: json['ownerName'] as String?,
      commercialName: json['commercialName'] as String?,
      instagram: json['instagram'] as String?,
      facebook: json['facebook'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'brandId': brandId,
      'brandName': brandName,
      'brandDescription': brandDescription,
      'websiteUrl': websiteUrl,
      'logo': logo,
      'region': region,
      'area': area,
      'ownerPhoneNumber': ownerPhoneNumber,
      'wineryPhoneNumber': wineryPhoneNumber,
      'ownerName': ownerName,
      'commercialName': commercialName,
      'instagram': instagram,
      'facebook': facebook,
    };
  }
}
