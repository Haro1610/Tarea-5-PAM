import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:image_picker/image_picker.dart';

part 'create_event.dart';
part 'create_state.dart';

class CreateBloc extends Bloc<CreateEvent, CreateState> {
  File? _selectedPicture;
  CreateBloc() : super(CreateInitial()) {
    on<OnCreateTakePictureEvent>(_takePicture);
    on<OnCreateSaveEvent>(_saveData);
    // TODO: implement event handler
  }

  FutureOr<void> _saveData(OnCreateSaveEvent event, emit) async {
    emit(CreateLoadingState());
    bool saved = await _saveFshare(event.dataToSave);
    emit(saved ? CreateSuccesState() : CreateFshareErrorState());
  }

  Future<bool> _saveFshare(Map<String, dynamic> dataToSave) async {
    try {
      String _imageUrl = await _uploadPictureToStorage();
      if (_imageUrl != "") {
        dataToSave["picture"] = _imageUrl;
        dataToSave["publishedAt"] = Timestamp.fromDate(DateTime.now());
        dataToSave["stars"] = 0;
        dataToSave["username"] = FirebaseAuth.instance.currentUser!.displayName;
      } else {
        return false;
      }
      var docRef =
          await FirebaseFirestore.instance.collection("fshare").add(dataToSave);
      return await _updateUserDocumentReference(docRef.id);
    } catch (e) {
      print("Error al crear el Fshare: $e");
      return false;
    }
  }

  Future<String> _uploadPictureToStorage() async {
    try {
      var stamp = DateTime.now();
      if (_selectedPicture == null) {
        return "";
      }
      UploadTask task = FirebaseStorage.instance
          .ref("fshare/image_${stamp}.png")
          .putFile(_selectedPicture!);
      await task;

      return await task.storage
          .ref("fshare/image_${stamp}.png")
          .getDownloadURL();
    } catch (e) {
      return "";
    }
  }

  Future<bool> _updateUserDocumentReference(String fshareId) async {
    try {
      var queryUser = await FirebaseFirestore.instance
          .collection("users")
          .doc("${FirebaseAuth.instance.currentUser!.uid}");
      var docsRef = await queryUser.get();
      List<dynamic> listIds = docsRef.data()?["fotolistId"];

      listIds.add(fshareId);

      await queryUser.update({"fotolistId": listIds});
      return true;
    } catch (e) {
      print("Error al actulizar users collection: $e");
      return false;
    }
  }

  Future<void> _takePicture(event, emit) async {
    emit(CreateLoadingState());
    await _getImage();

    if (_selectedPicture != null)
      emit(CreatePictureChangedState(picture: _selectedPicture!));
    else
      emit(CreatePictureErrorState());
  }

  Future<void> _getImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxHeight: 720,
      maxWidth: 720,
      imageQuality: 85,
    );
    if (pickedFile != null) {
      _selectedPicture = File(pickedFile.path);
    } else {
      print('No image selected.');
      _selectedPicture = null;
    }
  }
}
