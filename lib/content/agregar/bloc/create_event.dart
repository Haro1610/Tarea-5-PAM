part of 'create_bloc.dart';

abstract class CreateEvent extends Equatable {
  const CreateEvent();

  @override
  List<Object> get props => [];
}

// click al booton de foto

class OnCreateTakePictureEvent extends CreateEvent {}

// click al booton guardar

class OnCreateSaveEvent extends CreateEvent {
  final Map<String, dynamic> dataToSave;

  OnCreateSaveEvent({required this.dataToSave});
  @override
  // TODO: implement props
  List<Object> get props => [dataToSave];
}
