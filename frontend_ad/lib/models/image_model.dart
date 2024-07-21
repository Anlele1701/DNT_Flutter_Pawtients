import 'dart:convert';
import 'dart:typed_data';
import 'package:json_annotation/json_annotation.dart';
@JsonSerializable()
class ImagePet{
  late String filename;
  late Uint8List data;
  late String mimetype;
  ImagePet({required this.filename, required this.data, required this.mimetype});
  ImagePet.fromjson(Map<String, dynamic> json){
    filename=json['filename'];
    mimetype=json['mimetype'];
    if (json['data'] is Map<String, dynamic> &&
        json['data']['type'] == 'Buffer' &&
        json['data']['data'] is List<dynamic>) {
      List<int> bytes = List<int>.from(json['data']['data']);
      data = Uint8List.fromList(bytes);
    } else {
      Uint8List bytes = base64Decode(json['data']);
      data=bytes;
    }
  }
  Map<String, dynamic> toJson(){
    return {
      'filename': filename,
      'data': data != null ? data!.toList() : null,
      'mimetype': mimetype,
    };
  }
}