// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'files_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilesModel _$FilesModelFromJson(Map<String, dynamic> json) {
  return FilesModel(
    (json['files'] as List)
        ?.map((e) =>
            e == null ? null : FileModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$FilesModelToJson(FilesModel instance) =>
    <String, dynamic>{
      'files': instance.files,
    };

FileModel _$FileModelFromJson(Map<String, dynamic> json) {
  return FileModel(
    json['filename'] as String,
  );
}

Map<String, dynamic> _$FileModelToJson(FileModel instance) => <String, dynamic>{
      'filename': instance.filename,
    };
