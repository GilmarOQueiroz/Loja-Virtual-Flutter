import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Widget _buildBodyBack() => Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 211, 118, 130),
            Color.fromARGB(255, 253, 181, 168)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight
        )
      ),
    );

    return Stack(
      children: <Widget>[
        _buildBodyBack(),
        CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
              snap: true,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text('Novidades'),
                centerTitle: true,
              ),
            ),
            FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance
              .collection('home')
              .orderBy('pos')
              .get(),
              builder: (context, snapshot) {
                if(!snapshot.hasData)
                  return SliverToBoxAdapter(
                    child: Container(
                      height: 200.0,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  );
                else
                  return SliverToBoxAdapter(
                    child: GridView.custom(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverQuiltedGridDelegate(
                          crossAxisCount:2,
                          mainAxisSpacing: 1,
                          crossAxisSpacing: 1,
                          repeatPattern: QuiltedGridRepeatPattern.inverted,
                          pattern: const [
                            QuiltedGridTile(2, 2),
                            QuiltedGridTile(1, 2),
                            QuiltedGridTile(2, 1),
                            QuiltedGridTile(1, 1),
                            QuiltedGridTile(1, 1),
                          ],
                        ),
                      childrenDelegate: SliverChildBuilderDelegate(
                          (context, index) => FadeInImage.memoryNetwork(
                              placeholder: kTransparentImage,
                              image: snapshot.data.docs[index]['image'],
                              fit: BoxFit.cover,
                          ),
                        childCount: snapshot.data.docs.length,
                      ),
                    ),
                  );
              },
            )
          ],
        )
      ],
    );
  }
}
