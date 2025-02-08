import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class SupabaseImageUpload {
  final SupabaseClient supabase;
  
  SupabaseImageUpload({required this.supabase});

  Future<String?> uploadImage({
    required File imageFile,
    required String bucketName,
    String? folder,
  }) async {
    try {
      // Generate unique file name using timestamp
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final extension = path.extension(imageFile.path);
      final fileName = '$timestamp$extension';
      
      // Create the full path including folder if provided
      final filePath = folder != null ? '$folder/$fileName' : fileName;

      // Upload the file to Supabase Storage
      final response = await supabase
          .storage
          .from(bucketName)
          .upload(filePath, imageFile);

      if (response.isEmpty) {
        throw Exception('Upload failed');
      }

      // Get the public URL
      final imageUrl = supabase
          .storage
          .from(bucketName)
          .getPublicUrl(filePath);

      return imageUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  
  // Download image from URL and save to local storage
  Future<File?> downloadImage({
    required String imageUrl,
    String? customFileName,
  }) async {
    try {
      // Get the temporary directory for storing the downloaded file
      final Directory tempDir = await getTemporaryDirectory();
      
      // Generate file name from URL if custom name not provided
      final String fileName = customFileName ?? 
          '${DateTime.now().millisecondsSinceEpoch}${path.extension(imageUrl)}';
      
      // Create the full path for saving the file
      final String filePath = path.join(tempDir.path, fileName);

      // Download the file
      final response = await http.get(Uri.parse(imageUrl));
      
      if (response.statusCode != 200) {
        throw Exception('Failed to download image');
      }

      // Save the file
      final File file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
      
      return file;
    } catch (e) {
      print('Error downloading image: $e');
      return null;
    }
  }
}