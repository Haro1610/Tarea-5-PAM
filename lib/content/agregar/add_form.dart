import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foto_share/content/agregar/bloc/create_bloc.dart';

class AddForm extends StatefulWidget {
  AddForm({Key? key}) : super(key: key);

  @override
  State<AddForm> createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {
  var _titleC = TextEditingController();
  bool _defaultSwichValue = false;
  File? image;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateBloc, CreateState>(
      listener: (context, state) {
        if (state is CreatePictureErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error al eleigr imagen valida...")),
          );
        } else if (state is CreateFshareErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error al guarda la Fshare...")),
          );
        } else if (state is CreateSuccesState) {
          _titleC.clear();
          _defaultSwichValue = false;
          image = null;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Guardado exitosamente")),
          );
        } else if (state is CreatePictureChangedState) {
          image = state.picture;
        }
        // TODO: implement listener
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: ListView(
            children: [
              image != null
                  ? Image.file(
                      image!,
                      height: 120,
                    )
                  : Container(),
              MaterialButton(
                child: Text("foto"),
                onPressed: () {
                  BlocProvider.of<CreateBloc>(context)
                      .add(OnCreateTakePictureEvent());
                  // bloc para guardar los datos en firebase
                },
              ),
              SizedBox(height: 24),
              TextField(
                controller: _titleC,
                decoration: InputDecoration(
                  label: Text("Title"),
                  border: OutlineInputBorder(),
                ),
              ),
              SwitchListTile(
                title: Text("Publicar"),
                value: _defaultSwichValue,
                onChanged: (newValue) {
                  _defaultSwichValue = newValue;
                  setState(() {});
                },
              ),
              MaterialButton(
                child: Text("Guardar"),
                onPressed: () {
                  Map<String, dynamic> fshareData = {
                    "title": _titleC.value.text,
                    "public": _defaultSwichValue,
                  };
                  BlocProvider.of<CreateBloc>(context)
                      .add(OnCreateSaveEvent(dataToSave: fshareData));
                  // bloc para guardar los datos en firebase
                },
              )
            ],
          ),
        );
      },
    );
  }
}
