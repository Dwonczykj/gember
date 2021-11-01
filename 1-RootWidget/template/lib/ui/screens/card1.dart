import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:template/ui/models/green_project.dart';

class Card1 extends StatelessWidget {
  GreenProject project;

  Card1({Key? key, required this.project}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          padding: EdgeInsets.all(12),
          constraints: BoxConstraints.expand(
            width: 350,
            height: 350,
          ),
          child: Stack(children: <Widget>[
            ClipRRect(
              child: Container(
                color: Theme.of(context).backgroundColor,
              ),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            Container(
              // child: Stack(
              //   children: <Widget>[

              //   ],
              // ),
              padding: EdgeInsets.all(16),
              constraints: BoxConstraints.expand(
                width: 350,
                height: 250,
              ),
              // decoration: BoxDecoration(
              //     image: DecorationImage(
              //       image: AssetImage(
              //           'assets/mock_data/images/insulate_britain.jpeg'),
              //       fit: BoxFit.cover,
              //     ),
              //     borderRadius: BorderRadius.all(Radius.circular(10.0))
              // ),
              child: CachedNetworkImage(
                imageUrl: project.image_url,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
                child: Text(
                  project.name,
                  style: Theme.of(context).textTheme.headline6,
                ),
                left: 8.0,
                top: 260.0),
            Positioned(
                child: Text(
                  project.company_name,
                  style: Theme.of(context).textTheme.headline3,
                ),
                left: 8.0,
                bottom: 8.0),
            Positioned(
                child: Text(
                  '<Followers: 500K>',
                  style: Theme.of(context).textTheme.headline6,
                ),
                right: 8.0,
                top: 280.0),
          ])),
    );
  }
}
