import 'package:freezed_annotation/freezed_annotation.dart';

part 'photo_dto.freezed.dart';
part 'photo_dto.g.dart';

@freezed
class PhotoDto with _$PhotoDto {
  const factory PhotoDto({
    required String id,
    required String title,
    required String imageUrl,
    required DateTime createdAt,
    required double price,
  }) = _PhotoDto;

  factory PhotoDto.fromJson(Map<String, dynamic> json) =>
      _$PhotoDtoFromJson(json);
}
