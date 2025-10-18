import 'package:equatable/equatable.dart';
import 'package:petfinder_app_demo/core/errors/failure.dart';
import '../../../domain/entities/pet.dart';

abstract class PetState extends Equatable {
  const PetState();

  @override
  List<Object> get props => [];
}

class PetInitial extends PetState {}

class PetLoading extends PetState {}

class PetsLoadingMore extends PetState {
  final List<Pet> currentPets;

  const PetsLoadingMore(this.currentPets);

  @override
  List<Object> get props => [currentPets];
}

class PetsLoaded extends PetState {
  final List<Pet> pets;
  final bool hasReachedMax;

  const PetsLoaded({
    required this.pets,
    required this.hasReachedMax,
  });

  @override
  List<Object> get props => [pets, hasReachedMax];
}

class PetsError extends PetState {
  final Failure message;

  const PetsError(this.message);

  @override
  List<Object> get props => [message];
}