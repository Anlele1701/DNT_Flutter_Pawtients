import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class ImageHelper {
  final ImagePicker _imagePicker;
  final ImageCropper _imageCropper;

  ImageHelper({ImagePicker? imagePicker, ImageCropper? imageCropper})
      : _imagePicker = imagePicker ?? ImagePicker(),
        _imageCropper = imageCropper ?? ImageCropper();

  Future<List<XFile>> pickImage(
      {ImageSource source = ImageSource.gallery,
      int imageQuality = 50,
      bool isMultiple = false}) async {
    if (isMultiple) {
      return await _imagePicker.pickMultiImage(imageQuality: imageQuality);
    }
    final file = await _imagePicker.pickImage(
        source: source, imageQuality: imageQuality);

    if (file != null) return [file];
    return [];
  }

  Future<CroppedFile?> cropImage(
          {required XFile file,
          CropAspectRatio? aspectRatio,
          CropStyle cropStyle = CropStyle.circle}) async =>
      await _imageCropper.cropImage(
          aspectRatio: aspectRatio, sourcePath: file.path);
}
