// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_metadata.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ImageMetadataAdapter extends TypeAdapter<ImageMetadata> {
  @override
  final int typeId = 0;

  @override
  ImageMetadata read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ImageMetadata(
      imageUrl: fields[0] as String,
      localFilePath: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ImageMetadata obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.imageUrl)
      ..writeByte(1)
      ..write(obj.localFilePath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImageMetadataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
