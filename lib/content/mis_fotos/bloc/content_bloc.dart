import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'content_event.dart';
part 'content_state.dart';

class ContentBloc extends Bloc<ContentEvent, ContentState> {
  ContentBloc() : super(ContentInitial()) {
    on<GetAllMyFotosEvent>(_getMyContent);
    on<UpdateFotoEvent>(_editarFoto);
  }

  FutureOr<void> _getMyContent(event, emit) async {
    emit(ContentFotosLoadingState());
    try {
      // query para traer el documento con el id del usuario autenticado
      var queryUser = await FirebaseFirestore.instance
          .collection("users")
          .doc("${FirebaseAuth.instance.currentUser!.uid}");

      // query para sacar la data del documento
      var docsRef = await queryUser.get();

      var listIds = docsRef.data()?["fotolistId"];

      // query para sacar documentos de fshare
      var queryFotos =
          await FirebaseFirestore.instance.collection("fshare").get();
      var myContentList =
          queryFotos.docs.where((doc) => listIds.contains(doc.id)).map((doc) {
        var mp = doc.data().cast<String, dynamic>();
        mp["id"] = doc.id;
        return mp;
      }).toList();

      //myContentList.forEach((mapa) => print("${mapa["id"]}\n"));

      // lista de documentos filtrados del usuario con sus datos de fotos en espera
      emit(ContentFotosSuccessState(myData: myContentList));
    } catch (e) {
      print("Error al obtener items en espera: $e");
      emit(ContentFotosErrorState());
      emit(ContentFotosEmptyState());
    }
  }

  FutureOr<void> _editarFoto(event, emit) async {
    emit(UpdateLoadingState());
    bool updated = await _updateFshare(event.dataToUpdate);
    emit(updated ? UpdateSuccessState() : UpdateErrorState());
  }

  Future<bool> _updateFshare(Map<String, dynamic> dataToUpdate) async {
    var docRef = await FirebaseFirestore.instance.collection("fshare");

    try {
      docRef
          .doc(dataToUpdate['id'])
          .update(dataToUpdate)
          .then((value) => print("Fshare updated"))
          .catchError((error) => print("Update error: $error"));
      return true;
    } catch (e) {
      return false;
    }
  }
}
