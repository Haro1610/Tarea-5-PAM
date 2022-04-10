part of 'content_bloc.dart';

abstract class ContentState extends Equatable {
  const ContentState();

  @override
  List<Object> get props => [];
}

class ContentInitial extends ContentState {}

class ContentFotosSuccessState extends ContentState {
  // lista de elementos de firebase fshare collection
  final List<Map<String, dynamic>> myData;

  ContentFotosSuccessState({required this.myData});
  @override
  List<Object> get props => [myData];
}

class ContentFotosErrorState extends ContentState {}

class ContentFotosEmptyState extends ContentState {}

class ContentFotosLoadingState extends ContentState {}

class ContentFotosEditState extends ContentState {}

class UpdateLoadingState extends ContentState {}

class UpdateSuccessState extends ContentState {}

class UpdateErrorState extends ContentState {}
