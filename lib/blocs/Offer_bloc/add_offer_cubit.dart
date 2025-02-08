// offer_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:triptip/data/models/OfferModel.dart';
import 'dart:io';
import 'package:flutter/material.dart';
class OfferCubit extends Cubit<OfferState> {
  OfferCubit() : super(OfferInitial());

  final _formKey = GlobalKey<FormState>();
  String? _title;
  String? _destination;
  String? _description;
  double? _price;
  DateTime? _fromDate;
  DateTime? _toDate;
  File? _mainImage;
  List<File> _additionalImages = [];
  String _transport = 'Available';
  String _meals = 'Available';
  String _guide = 'Available';
  String _hotel = 'Available';

  // Getters for form state
  GlobalKey<FormState> get formKey => _formKey;
  String? get title => _title;
  String? get destination => _destination;
  String? get description => _description;
  double? get price => _price;
  DateTime? get fromDate => _fromDate;
  DateTime? get toDate => _toDate;
  File? get mainImage => _mainImage;
  List<File> get additionalImages => _additionalImages;
  String get transport => _transport;
  String get meals => _meals;
  String get guide => _guide;
  String get hotel => _hotel;

  // Setters for form state
  void setTitle(String value) {
    _title = value;
    emit(OfferFormUpdated());
  }

  void setDestination(String value) {
    _destination = value;
    emit(OfferFormUpdated());
  }

  void setDescription(String value) {
    _description = value;
    emit(OfferFormUpdated());
  }

  void setPrice(String value) {
    _price = double.tryParse(value);
    emit(OfferFormUpdated());
  }

  void setFromDate(DateTime? value) {
    _fromDate = value;
    emit(OfferFormUpdated());
  }

  void setToDate(DateTime? value) {
    _toDate = value;
    emit(OfferFormUpdated());
  }

  void setMainImage(File? value) {
    _mainImage = value;
    emit(OfferFormUpdated());
  }

  void addAdditionalImage(File value) {
    _additionalImages.add(value);
    emit(OfferFormUpdated());
  }

  void removeAdditionalImage(int index) {
    _additionalImages.removeAt(index);
    emit(OfferFormUpdated());
  }

  void setTransport(String value) {
    _transport = value;
    emit(OfferFormUpdated());
  }

  void setMeals(String value) {
    _meals = value;
    emit(OfferFormUpdated());
  }

  void setGuide(String value) {
    _guide = value;
    emit(OfferFormUpdated());
  }

  void setHotel(String value) {
    _hotel = value;
    emit(OfferFormUpdated());
  }

  // Form validation
  bool validateForm() {
    if (_formKey.currentState!.validate()) {
      if (_mainImage == null) {
        emit(OfferError('Main image is required'));
        return false;
      }
      if (_fromDate == null || _toDate == null) {
        emit(OfferError('Both dates are required'));
        return false;
      }
      if (_toDate!.isBefore(_fromDate!)) {
        emit(OfferError('End date must be after start date'));
        return false;
      }
      return true;
    }
    return false;
  }

  // Submit form
  void submitForm(int agencyId) async {
    if (!validateForm()) return;

    emit(OfferLoading());

    try {
      final newOffer = OfferModel(
        id: DateTime.now().millisecondsSinceEpoch,
        image: _mainImage!.path,
        cityName: _title!,
        countryName: _destination!,
        price: _price!,
        startDate: _fromDate!.toIso8601String(),
        endDate: _toDate!.toIso8601String(),
        descriptionText: _description!,
        category: 'Default',
        thumbnails: _additionalImages.map((file) => file.path).toList(),
        days: _toDate!.difference(_fromDate!).inDays,
        transport: _transport,
        meals: _meals,
        guide: _guide,
        hotel: _hotel,
      );

      // Simulate a network call or database operation
      await Future.delayed(Duration(seconds: 2));
      emit(OfferAdded(newOffer));
    } catch (e) {
      emit(OfferError(e.toString()));
    }

  }
  
}

abstract class OfferState {}

class OfferInitial extends OfferState {}

class OfferLoading extends OfferState {}

class OfferFormUpdated extends OfferState {}

class OfferAdded extends OfferState {
  final OfferModel offer;

  OfferAdded(this.offer);
}

class OfferError extends OfferState {
  final String message;

  OfferError(this.message);
}