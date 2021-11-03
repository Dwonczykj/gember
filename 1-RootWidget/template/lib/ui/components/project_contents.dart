import 'package:flutter/material.dart';
import '../models/green_project.dart';

class ProjectContents extends StatelessWidget {
  final GreenProject project;

  const ProjectContents({Key? key, required this.project}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double _projectContentsHeight = 250.0;

    final theme = Theme.of(context);
    final titleStyle = theme.textTheme.headline5?.copyWith(
        color: Colors.white,
        backgroundColor: Colors.grey[800]!.withOpacity(0.66));
    final subHeadingStyle = theme.textTheme.headline4?.copyWith(fontSize: 14.0);
    final cardDescriptionStyle = theme.textTheme.bodyText2;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: _projectContentsHeight,
          child: Stack(children: [
            Positioned.fill(
              // In order to have the ink splash appear above the image, you
              // must use Ink.image. This allows the image to be painted as
              // part of the Material and display ink effects above it. Using
              // a standard Image will obscure the ink splash.
              child: Ink.image(
                image: AssetImage(
                  'assets/mock_data/images/insulate_britain.jpeg',
                ),
                fit: BoxFit.cover,
                child: Container(),
              ),
            ),
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                clipBehavior: Clip.antiAlias,
                child: Text(
                  project.name,
                  style: titleStyle,
                ),
              ),
            ),
          ]),
        ),
        Padding(
            padding: EdgeInsets.fromLTRB(8, 8, 8, 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Text(project.company_name, style: subHeadingStyle)),
                Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Text(project.short_description,
                        style: cardDescriptionStyle)),
              ],
            ))
      ],
    );
  }
}
