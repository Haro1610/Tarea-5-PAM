import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foto_share/content/mis_fotos/bloc/content_bloc.dart';

class ItemContent extends StatefulWidget {
  final Map<String, dynamic> publicFData;
  ItemContent({Key? key, required this.publicFData}) : super(key: key);

  @override
  State<ItemContent> createState() => _ItemContentState();
}

class _ItemContentState extends State<ItemContent> {
  bool _swithcValue = false;
  var controllerTitle = TextEditingController();
  var controllerPicture = TextEditingController();
  var controllerStars = TextEditingController();

  @override
  void initState() {
    _swithcValue = widget.publicFData["public"];
    super.initState();
  }

  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .7,
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                "${widget.publicFData["picture"]}",
                fit: BoxFit.cover,
              ),
            ),
            SwitchListTile(
              title: Text("${widget.publicFData["title"]}"),
              subtitle: Text("${widget.publicFData["publishedAt"]}"),
              value: _swithcValue,
              onChanged: (newVal) {
                setState(() {
                  _swithcValue = newVal;
                });
              },
            ),
            Wrap(
              spacing: 10.0,
              children: [
                MaterialButton(
                    color: Color.fromARGB(255, 92, 185, 169),
                    child: Text("Editar"),
                    onPressed: () {
                      showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (_) => AlertDialog(
                          title: Text("${widget.publicFData["title"]}"),
                          content: Wrap(
                            runSpacing: 18,
                            spacing: 18,
                            children: [
                              TextField(
                                controller: controllerTitle,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Titulo",
                                ),
                              ),
                              TextField(
                                controller: controllerPicture,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Link Imagen",
                                ),
                              ),
                              TextField(
                                controller: controllerStars,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Estrellas",
                                ),
                              )
                            ],
                          ),
                          actions: [
                            Wrap(
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Map<String, dynamic> fshareUpdate =
                                        widget.publicFData;
                                    fshareUpdate["picture"] =
                                        controllerPicture.text;
                                    fshareUpdate["public"] = _swithcValue;
                                    fshareUpdate["stars"] =
                                        controllerStars.text;
                                    fshareUpdate["title"] =
                                        controllerTitle.text;
                                    BlocProvider.of<ContentBloc>(context).add(
                                        UpdateFotoEvent(
                                            dataToUpdate: fshareUpdate));

                                    Navigator.pop(context, 'Aceptar');
                                    BlocProvider.of<ContentBloc>(context)
                                        .add(GetAllMyFotosEvent());
                                  },
                                  child: Text(
                                    "Aceptar",
                                    style: TextStyle(color: Colors.green),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context, 'Cancelar');
                                  },
                                  child: Text(
                                    "Cancelar",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
                IconButton(
                  icon: Icon(Icons.star_outlined, color: Colors.green),
                  tooltip: "Likes: ${widget.publicFData["stars"]}",
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
