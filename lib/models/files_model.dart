import 'package:json_annotation/json_annotation.dart';

part 'files_model.g.dart';

@JsonSerializable()
class FilesModel {
  final List<FileModel> files;

  FilesModel(this.files);

  factory FilesModel.fromJson(Map<String, dynamic> json) =>
      _$FilesModelFromJson(json);

  Map<String, dynamic> toJson() => _$FilesModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class FileModel {
  final String filename;

  FileModel(this.filename);

  factory FileModel.fromJson(Map<String, dynamic> json) =>
      _$FileModelFromJson(json);

  Map<String, dynamic> toJson() => _$FileModelToJson(this);
}
