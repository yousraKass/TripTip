import 'dart:io';
import 'package:bloc/bloc.dart';
import 'image_state.dart';
import 'package:triptip/data/imageUpload/imageUpload.dart';


class ImageCubit extends Cubit<ImageState> {
  final SupabaseImageUpload supabaseImageUpload;

  ImageCubit({required this.supabaseImageUpload}) : super(ImageInitial());

  Future<void> uploadImage(File imageFile) async {
    emit(ImageUploading());

    try {
      final imageUrl = await supabaseImageUpload.uploadImage(
        imageFile: imageFile,
        bucketName: 'images',
      );

      if (imageUrl != null) {
        emit(ImageUploaded(imageUrl));
      } else {
        emit(ImageError("Image upload failed."));
      }
    } catch (e) {
      emit(ImageError("Error uploading image: $e"));
    }
  }

  Future<void> downloadImage(String imageUrl, {String? customFileName}) async {
    emit(ImageDownloading());

    try {
      final File? file = await supabaseImageUpload.downloadImage(
        imageUrl: imageUrl,
        customFileName: customFileName,
      );

      if (file != null) {
        emit(ImageDownloaded(file));
      } else {
        emit(ImageError("Image download failed."));
      }
    } catch (e) {
      emit(ImageError("Error downloading image: $e"));
    }
  }
}