import 'dart:io';
import 'dart:typed_data';

class VideoFile {
  final File? file;
  final Uint8List? bytes;

  VideoFile({this.file, this.bytes});

  bool get isWebFile => file == null;
}
