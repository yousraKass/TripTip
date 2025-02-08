import 'dart:io';
import 'package:equatable/equatable.dart';

abstract class ImageState extends Equatable {
  const ImageState(); // Ensures consistent object comparison

  @override
  List<Object?> get props => [];
}

class ImageInitial extends ImageState {
  const ImageInitial();
}

class ImageUploading extends ImageState {
  const ImageUploading();
}

class ImageUploaded extends ImageState {
  final String imageUrl;
  const ImageUploaded(this.imageUrl);

  @override
  List<Object?> get props => [imageUrl];
}

class ImageDownloading extends ImageState {
  const ImageDownloading();
}

class ImageDownloaded extends ImageState {
  final File imageFile;
  const ImageDownloaded(this.imageFile);

  @override
  List<Object?> get props => [imageFile];
}

class ImageError extends ImageState {
  final String message;
  const ImageError(this.message);

  @override
  List<Object?> get props => [message];
}
