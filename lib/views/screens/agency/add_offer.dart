import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:triptip/views/themes/colors.dart';
import 'package:triptip/views/themes/fonts.dart';

// Screen Util class to manage responsive dimensions
class ScreenUtil {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double defaultSize;
  static late Orientation orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
    
    defaultSize = orientation == Orientation.landscape 
        ? screenHeight * 0.024
        : screenWidth * 0.024;
  }

  static double get scaleFactor {
    if (screenWidth > 600) {  // Tablet breakpoint
      return 1.2;  // Larger scale for tablets
    }
    return 1.0;  // Normal scale for phones
  }

  static double scaledHeight(double height) {
    return (height / 812.0) * screenHeight * scaleFactor;
  }

  static double scaledWidth(double width) {
    return (width / 375.0) * screenWidth;
  }

  static double fontSize(double size) {
    return (size / 375.0) * screenWidth;
  }
}

class AddOfferPage extends StatefulWidget {
  const AddOfferPage({super.key});

  @override
  State<AddOfferPage> createState() => _AddOfferPageState();
}

class _AddOfferPageState extends State<AddOfferPage> {
  DateTime? fromDate = DateTime(2024, 2, 8);
  DateTime? toDate = DateTime(2024, 2, 22);
  File? mainImage;
  List<File> additionalImages = [];
  final ImagePicker _picker = ImagePicker();
  bool isHovering = false;

  Future<void> _pickImage({bool isMainImage = true}) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        setState(() {
          if (isMainImage) {
            mainImage = File(pickedFile.path);
          } else {
            additionalImages.add(File(pickedFile.path));
          }
        });
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
      // You might want to show a snackbar or alert here
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e')),
      );
    }
  }

  Future<void> _pickMultipleImages() async {
    try {
      final List<XFile> pickedFiles = await _picker.pickMultiImage(
        imageQuality: 80,
      );

      if (pickedFiles.isNotEmpty) {
        setState(() {
          additionalImages.addAll(pickedFiles.map((file) => File(file.path)).toList());
        });
      }
    } catch (e) {
      debugPrint('Error picking multiple images: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking multiple images: $e')),
      );
    }
  }

  String getMainImageText() {
    return mainImage != null ? 'Change main Image' : 'Upload main Image';
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil().init(context);
    
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset('assets/icons/undo_icon.png'),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: AppColors.white,
        centerTitle: true,
        title: Text(
          'Add Offer',
          style: TextStyle(
            fontFamily: FontFamily.medium,
            color: AppColors.black,
            fontSize: ScreenUtil.fontSize(18),
          ),
        ),
      ),
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(ScreenUtil.scaledWidth(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MouseRegion(
              onEnter: (_) => setState(() => isHovering = true),
              onExit: (_) => setState(() => isHovering = false),
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: ScreenUtil.scaledHeight(200),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(ScreenUtil.scaledWidth(12)),
                      image: mainImage != null
                          ? DecorationImage(
                              image: FileImage(mainImage!),
                              fit: BoxFit.cover,
                              colorFilter: isHovering
                                  ? ColorFilter.mode(
                                      Colors.black.withOpacity(0.4),
                                      BlendMode.dstATop,
                                    )
                                  : null,
                            )
                          : const DecorationImage(
                              image: AssetImage('assets/img/offer_img.png'),
                              fit: BoxFit.cover,
                            ),
                    ),
                    child: mainImage == null
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () => _pickImage(isMainImage: true),
                                  child: Image.asset(
                                    'assets/icons/Upload_icon.png',
                                    height: ScreenUtil.scaledHeight(40),
                                    width: ScreenUtil.scaledWidth(40),
                                  ),
                                ),
                                SizedBox(height: ScreenUtil.scaledHeight(12)),
                                Text(
                                  getMainImageText(),
                                  style: TextStyle(
                                    color: AppColors.main,
                                    fontFamily: FontFamily.regular,
                                    fontSize: ScreenUtil.fontSize(14),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(), // Empty container to maintain structure
                  ),
                    if (mainImage != null && isHovering)
                      Center(
                        child: Container(
                          width: double.infinity,
                          height: ScreenUtil.scaledHeight(200),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(ScreenUtil.scaledWidth(12)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () => _pickImage(isMainImage: true),
                                child: Image.asset(
                                  'assets/icons/Upload_icon.png',
                                  height: ScreenUtil.scaledHeight(40),
                                  width: ScreenUtil.scaledWidth(40),
                                ),
                              ),
                              SizedBox(height: ScreenUtil.scaledHeight(12)),
                              Text(
                                getMainImageText(),
                                style: TextStyle(
                                  color: AppColors.main,
                                  fontFamily: FontFamily.regular,
                                  fontSize: ScreenUtil.fontSize(14),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                ],
              ),
            ),
            SizedBox(height: ScreenUtil.scaledHeight(24)),
            _buildTextField('Offer Title', 'Enter Offer title'),
            SizedBox(height: ScreenUtil.scaledHeight(16)),
            _buildTextField('Destination', 'enter destination'),
            SizedBox(height: ScreenUtil.scaledHeight(16)),
            
            Row(
              children: [
                Expanded(child: _buildDateField('From', fromDate)),
                SizedBox(width: ScreenUtil.scaledWidth(16)),
                Expanded(child: _buildDateField('To', toDate)),
              ],
            ),
            SizedBox(height: ScreenUtil.scaledHeight(16)),
            
            Row(
              children: [
                Expanded(child: _buildPriceField('Price', 0)),
                SizedBox(width: ScreenUtil.scaledWidth(16)),
                Expanded(child: _buildDropdownField('Transport', 'Available')),
              ],
            ),
            SizedBox(height: ScreenUtil.scaledHeight(16)),
            
            Row(
              children: [
                Expanded(child: _buildDropdownField('Guide', 'Available')),
                SizedBox(width: ScreenUtil.scaledWidth(16)),
                Expanded(child: _buildDropdownField('Meals', 'Available')),
              ],
            ),
            SizedBox(height: ScreenUtil.scaledHeight(16)),
            
            _buildDropdownField('Hotel', 'Available'),
            SizedBox(height: ScreenUtil.scaledHeight(16)),
            
            _buildTextField(
              'Description',
              'Write a detailed description about the offer...',
              maxLines: 5,
            ),
            SizedBox(height: ScreenUtil.scaledHeight(24)),
            
            // Additional Photos Section
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: ScreenUtil.scaledHeight(50),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () => _pickMultipleImages(),
                        child: Container(
                          width: ScreenUtil.scaledWidth(40),
                          height: ScreenUtil.scaledHeight(40),
                          margin: EdgeInsets.all(ScreenUtil.scaledWidth(2)),
                          decoration: BoxDecoration(
                            color: AppColors.customGrey,
                            borderRadius: BorderRadius.circular(ScreenUtil.scaledWidth(4)),
                          ),
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: Image.asset(
                              'assets/icons/Upload_icon.png',
                              height: ScreenUtil.scaledHeight(20),
                              width: ScreenUtil.scaledWidth(20),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: ScreenUtil.scaledWidth(8)),
                      Text(
                        'Upload all other photos',
                        style: TextStyle(
                          color: AppColors.main,
                          fontFamily: FontFamily.regular,
                          fontSize: ScreenUtil.fontSize(14),
                        ),
                      ),
                    ],
                  ),
                ),
                if (additionalImages.isNotEmpty)
                  Container(
                    height: ScreenUtil.scaledHeight(100),
                    margin: EdgeInsets.only(top: ScreenUtil.scaledHeight(8)),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: additionalImages.length,
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            Container(
                              width: ScreenUtil.scaledWidth(100),
                              margin: EdgeInsets.only(right: ScreenUtil.scaledWidth(8)),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(ScreenUtil.scaledWidth(8)),
                                image: DecorationImage(
                                  image: FileImage(additionalImages[index]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 4,
                              right: 12,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    additionalImages.removeAt(index);
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.close,
                                    size: 16,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
              ],
            ),
            SizedBox(height: ScreenUtil.scaledHeight(24)),
            
            SizedBox(
              width: double.infinity,
              height: ScreenUtil.scaledHeight(50),
              child: ElevatedButton(
                
                onPressed: () {
                 /*  Navigator.pushNamed(context, '/offers_page'); */
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.main,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(ScreenUtil.scaledWidth(12)),
                  ),
                ),
                child: Text(
                  'Add offer',
                  style: TextStyle(
                    color: AppColors.white,
                    fontFamily: FontFamily.medium,
                    fontSize: ScreenUtil.fontSize(16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String hint, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: FontFamily.medium,
            color: AppColors.black,
            fontSize: ScreenUtil.fontSize(14),
          ),
        ),
        SizedBox(height: ScreenUtil.scaledHeight(8)),
        TextField(
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: Colors.grey[400],
              fontFamily: FontFamily.regular,
              fontSize: ScreenUtil.fontSize(12),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(ScreenUtil.scaledWidth(12)),
              borderSide: BorderSide(color: AppColors.greyLight!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(ScreenUtil.scaledWidth(12)),
              borderSide: BorderSide(color: AppColors.greyLight!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(ScreenUtil.scaledWidth(12)),
              borderSide: const BorderSide(color: AppColors.main),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateField(String label, DateTime? date) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: FontFamily.regular,
            color: AppColors.black,
            fontSize: ScreenUtil.fontSize(14),
          ),
        ),
        SizedBox(height: ScreenUtil.scaledHeight(8)),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              showDatePicker(
                context: context,
                initialDate: date ?? DateTime.now(),
                firstDate: DateTime(2024),
                lastDate: DateTime(2025),
                builder: (context, child) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: const ColorScheme.light(
                        primary: AppColors.main,
                        onPrimary: AppColors.black,
                        surface: AppColors.white,
                        onSurface: AppColors.black,
                      ),
                    ),
                    child: child!,
                  );
                },
              ).then((pickedDate) {
                if (pickedDate != null) {
                  setState(() {
                    if (label == 'From') {
                      fromDate = pickedDate;
                    } else {
                      toDate = pickedDate;
                    }
                  });
                }
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil.scaledWidth(12),
                vertical: ScreenUtil.scaledHeight(14),
              ),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.greyLight!),
                borderRadius: BorderRadius.circular(ScreenUtil.scaledWidth(12)),
              ),
              child: Row(
                children: [
                    Image.asset(
                    'assets/icons/date.png',
                    width: ScreenUtil.scaledWidth(27),
                    height: ScreenUtil.scaledHeight(27),
                   
                    ),
                  SizedBox(width: ScreenUtil.scaledWidth(8)),
                  Text(
                    date != null
                        ? "${date.day} / ${date.month} / ${date.year}"
                        : 'Select date',
                    style: TextStyle(
                      fontFamily: FontFamily.regular,
                      color: AppColors.black,
                      fontSize: ScreenUtil.fontSize(14),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPriceField(String label, double initialValue) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: FontFamily.regular,
            color: AppColors.black,
            fontSize: ScreenUtil.fontSize(14),
          ),
        ),
        SizedBox(height: ScreenUtil.scaledHeight(8)),
        TextField(
          controller: TextEditingController(text: initialValue.toString()),
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            prefixIcon: Image.asset(
              'assets/icons/money.png',
              width: ScreenUtil.scaledWidth(26),
              height: ScreenUtil.scaledHeight(26),
            ),
            contentPadding: EdgeInsets.symmetric(
              vertical: ScreenUtil.scaledHeight(21),
              horizontal: ScreenUtil.scaledWidth(12),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(ScreenUtil.scaledWidth(12)),
              borderSide: BorderSide(color: AppColors.greyLight!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(ScreenUtil.scaledWidth(12)),
              borderSide: BorderSide(color: AppColors.greyLight!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(ScreenUtil.scaledWidth(12)),
              borderSide: const BorderSide(color: AppColors.main),
            ),
          ),
        ),
      ],
    );
  }
 String guideAvailability = 'Available';
  String mealsAvailability = 'Available';
  String hotelAvailability = 'Available';
  String transportAvailability = 'Available';

  Widget _buildDropdownField(String label, String initialValue) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: FontFamily.regular,
            color: AppColors.black,
            fontSize: ScreenUtil.fontSize(14),
          ),
        ),
        SizedBox(height: ScreenUtil.scaledHeight(8)),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil.scaledWidth(12),
            vertical: ScreenUtil.scaledHeight(4),
          ),
          height: label == 'Hotel' ? ScreenUtil.scaledHeight(60) : null,
          width: label == 'Hotel' ? ScreenUtil.scaledWidth(165) : null,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.greyLight!),
            borderRadius: BorderRadius.circular(ScreenUtil.scaledWidth(12)),
          ),
          child: Row(
            children: [
              Image.asset(
                label == 'Guide'
                    ? 'assets/icons/guide.png'
                    : label == 'Meals'
                        ? 'assets/icons/food.png'
                        : label == 'Hotel'
                            ? 'assets/icons/hotel.png'
                            : 'assets/icons/bus.png',
                width: ScreenUtil.scaledWidth(26),
                height: ScreenUtil.scaledHeight(26),
              ),
              SizedBox(width: ScreenUtil.scaledWidth(8)),
              Expanded(
                child: DropdownButton<String>(
                    value: label == 'Guide'
                      ? guideAvailability
                      : label == 'Meals'
                        ? mealsAvailability
                        : label == 'Hotel'
                          ? hotelAvailability
                          : label == 'Transport'
                            ? transportAvailability
                            : null,
                  isExpanded: true,
                  underline: const SizedBox(),
                  items: ['Available', 'Not Available'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                          fontFamily: FontFamily.regular,
                          color: value == 'Available'
                              ? AppColors.black
                              : Colors.red,
                          fontSize: ScreenUtil.fontSize(14),
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        // Update the appropriate state variable based on the label
                        switch (label) {
                          case 'Guide':
                            guideAvailability = newValue;
                            break;
                          case 'Meals':
                            mealsAvailability = newValue;
                            break;
                          case 'Hotel':
                            hotelAvailability = newValue;
                            break;
                          default: // Transport
                            transportAvailability = newValue;
                            break;
                        }
                      });
                    }
                  },
                  icon: Icon(
                    Icons.arrow_drop_down,
                    size: ScreenUtil.scaledWidth(24),
                  ),
                  dropdownColor: AppColors.white,
                  style: TextStyle(
                    fontFamily: FontFamily.regular,
                    color: AppColors.black,
                    fontSize: ScreenUtil.fontSize(14),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}