import 'dart:io';
import 'package:equatable/equatable.dart';
import '../data/medication.dart';

abstract class ScanState extends Equatable {
  const ScanState();

  @override
  List<Object?> get props => [];
}

class ScanInitial extends ScanState {}

class ScanLoading extends ScanState {}

class ScanImagePicked extends ScanState {
  final File image;

  const ScanImagePicked(this.image);

  @override
  List<Object?> get props => [image];
}

class ScanSuccess extends ScanState {
  final List<Medication> medications;
  final File image;

  const ScanSuccess(this.medications, this.image);

  @override
  List<Object?> get props => [medications, image];
}

class ScanError extends ScanState {
  final String message;

  const ScanError(this.message);

  @override
  List<Object?> get props => [message];
}
