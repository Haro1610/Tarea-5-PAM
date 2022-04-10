import 'package:flutter/material.dart';

class ItemEspera extends StatefulWidget {
  final Map<String, dynamic> nonPublicFData;
  ItemEspera({Key? key, required this.nonPublicFData}) : super(key: key);

  @override
  State<ItemEspera> createState() => _ItemEsperaState();
}

class _ItemEsperaState extends State<ItemEspera> {
  bool _swithcValue = false;
  @override
  void initState() {
    _swithcValue = widget.nonPublicFData["public"];
    super.initState();
  }

  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(25),
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                "${widget.nonPublicFData["picture"]}",
                fit: BoxFit.cover,
              ),
            ),
            SwitchListTile(
              title: Text("${widget.nonPublicFData["title"]}"),
              subtitle: Text("${widget.nonPublicFData["published"].toDate()}"),
              value: _swithcValue,
              onChanged: (newVal) {
                setState(() {
                  _swithcValue = newVal;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
