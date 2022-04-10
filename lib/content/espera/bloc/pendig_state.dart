part of 'pendig_bloc.dart';

abstract class PendigState extends Equatable {
  const PendigState();

  @override
  List<Object> get props => [];
}

class PendigInitial extends PendigState {}

class PendigFotosSuccessState extends PendigState {
  // lista de elementos de firebase fshare collection
  final List<Map<String, dynamic>> myDisabledData;

  PendigFotosSuccessState({required this.myDisabledData});
  @override
  List<Object> get props => [myDisabledData];
}

class PendigFotosErrorState extends PendigState {}

class PendigFotosEmptyState extends PendigState {}

class PendigFotosLoadingState extends PendigState {}
