
import 'package:petfinder_app_demo/features/home/domain/entities/pet_image.dart';

class ImageModel {
  final String? id;
  final String? url;
  final int? width;
  final int? height;

  ImageModel({this.id, this.url, this.width, this.height});

  factory ImageModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return ImageModel();
    }
    return ImageModel(
      id: json['id'] as String?,
      url: json['url'] as String?,
      width: json['width'] as int?,
      height: json['height'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'url': url, 'width': width, 'height': height};
  }

  PetImage toEntity() {
    return PetImage(
      id: id ?? '',
      url: url ?? '',
      width: width ?? 0,
      height: height ?? 0,
    );
  }
}
