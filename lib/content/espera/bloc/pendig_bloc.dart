import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'pendig_event.dart';
part 'pendig_state.dart';

class PendigBloc extends Bloc<PendigEvent, PendigState> {
  PendigBloc() : super(PendigInitial()) {
    on<GetAllMyDisabledFotosEvent>(_getMyDisabledContent);
    // TODO: implement event handler
  }

  FutureOr<void> _getMyDisabledContent(event, emit) async {
    emit(PendigFotosLoadingState());
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

      // query de Dart filtrando la info utilizando como referencia la lista de ids de docs del usuario actual
      var myDisabledContentList = queryFotos.docs
          .where((doc) =>
              listIds.contains(doc.id) && doc.data()["public"] == false)
          .map((doc) => doc.data().cast<String, dynamic>())
          .toList();

      // lista de documentos filtrados del usuario con sus datos de fotos en espera
      emit(PendigFotosSuccessState(myDisabledData: myDisabledContentList));
    } catch (e) {
      print("Error al obtener items en espera: $e");
      emit(PendigFotosErrorState());
      emit(PendigFotosEmptyState());
    }
  }
}
