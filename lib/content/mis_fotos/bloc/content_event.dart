part of 'content_bloc.dart';

abstract class ContentEvent extends Equatable {
  const ContentEvent();

  @override
  List<Object> get props => [];
}

class GetAllMyFotosEvent extends ContentEvent {}

class UpdateFotoEvent extends ContentEvent {
  final Map<String, dynamic> dataToUpdate;

  UpdateFotoEvent({required this.dataToUpdate});
  @override
  // TODO: implement props
  List<Object> get props => [dataToUpdate];
}
