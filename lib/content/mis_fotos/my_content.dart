import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:foto_share/content/mis_fotos/item_my_content.dart';
import 'package:foto_share/content/mis_fotos/bloc/content_bloc.dart';

class MyContent extends StatelessWidget {
  const MyContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ContentBloc, ContentState>(
      listener: (context, state) {
        if (state is ContentFotosErrorState) {}

        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is ContentFotosLoadingState) {
          return ListView.builder(
            itemCount: 25,
            itemBuilder: (BuildContext context, int index) {
              return YoutubeShimmer();
            },
          );
        } else if (state is ContentFotosEmptyState) {
          return Center(
            child: Text("No hay datos por mostrar"),
          );
        } else if (state is ContentFotosSuccessState) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              itemCount: state.myData.length,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return ItemContent(publicFData: state.myData[index]);
              },
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
