import 'package:hive/hive.dart';

part 'image_metadata.g.dart';

@HiveType(typeId: 0)
class ImageMetadata {
  @HiveField(0)
  final String imageUrl;

  @HiveField(1)
  final String localFilePath;

  ImageMetadata({required this.imageUrl, required this.localFilePath});
}
