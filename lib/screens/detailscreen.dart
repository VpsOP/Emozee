import 'package:Emozee/Emoji.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DetailPage extends StatelessWidget {
  final double expandedHeight = 400;
  final double roundedCornerHeight = 50;

  final Emoji emozee;

  DetailPage(this.emozee);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          CustomScrollView(
            slivers: [
              buildSliverHead(emozee),
              SliverToBoxAdapter(child: buildDetailPage(emozee))
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: SizedBox(
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Icon(Icons.arrow_back, color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: IconButton(
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: emozee.emoji));
                          Fluttertoast.showToast(
                              msg: "Copied ${emozee.name} to Clipboard");
                        },
                        icon: Icon(Icons.copy),
                        color: Colors.white),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  buildSliverHead(Emoji emozee) {
    return SliverPersistentHeader(
        delegate:
            DetailSliverDelegate(expandedHeight, roundedCornerHeight, emozee));
  }

  buildDetailPage(Emoji emozee) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Text(
            emozee.description,
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
        ),
      ),
    );
  }
}

class DetailSliverDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final double roundedContainerHeight;

  final Emoji emozee;

  DetailSliverDelegate(
      this.expandedHeight, this.roundedContainerHeight, this.emozee);

  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ),
      child: Hero(
        tag: 1,
        child: Container(
          color: Color(0xff707070),
          child: Stack(
            children: <Widget>[
              Center(
                  child: Text(
                emozee.emoji,
                style: TextStyle(fontSize: 250),
              )),
              Positioned(
                top: expandedHeight - roundedContainerHeight - shrinkOffset,
                left: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: roundedContainerHeight,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: expandedHeight - 110 - shrinkOffset,
                left: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      emozee.name,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                          shadows: [Shadow(color: Colors.black, blurRadius: 5)],
                          fontFamily: 'AgencyFB',
                          letterSpacing: 1.3,
                          fontWeight: FontWeight.w800),
                    ),
                    // Text(
                    //   'owl',
                    //   style: TextStyle(
                    //     color: Colors.white,
                    //     fontSize: 15,
                    //   ),
                    // ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => 0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
