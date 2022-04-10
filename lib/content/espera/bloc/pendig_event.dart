part of 'pendig_bloc.dart';

abstract class PendigEvent extends Equatable {
  const PendigEvent();

  @override
  List<Object> get props => [];
}

class GetAllMyDisabledFotosEvent extends PendigEvent {}
