import 'package:flutter/material.dart';

class AddProjectScreen extends StatefulWidget {
  const AddProjectScreen({Key? key}) : super(key: key);

  @override
  _AddProjectScreenState createState() => _AddProjectScreenState();
}

class _AddProjectScreenState extends State<AddProjectScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _sponsorController = TextEditingController();
  final _shortDescController = TextEditingController();
  final _descController = TextEditingController();
  final _mediaUrlController = TextEditingController();
  final _sponsorUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Promote Project',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                Flex(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    direction: Axis.vertical,
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Project Name',
                        ),
                        autocorrect: false,
                        autofocus: false,
                        textCapitalization: TextCapitalization.none,
                        keyboardType: TextInputType.name,
                        controller: _nameController,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Project Name Required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Sponsor Name',
                        ),
                        autocorrect: false,
                        autofocus: false,
                        textCapitalization: TextCapitalization.none,
                        keyboardType: TextInputType.name,
                        controller: _sponsorController,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Sponsor Name Required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Description',
                        ),
                        autocorrect: false,
                        autofocus: false,
                        textCapitalization: TextCapitalization.none,
                        keyboardType: TextInputType.name,
                        controller: _descController,
                        validator: (String? value) {
                          // if (value == null || value.isEmpty) {
                          //   return 'Sponsor Name Required';
                          // }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Short Description',
                        ),
                        autocorrect: false,
                        autofocus: false,
                        textCapitalization: TextCapitalization.none,
                        keyboardType: TextInputType.name,
                        controller: _shortDescController,
                        validator: (String? value) {
                          if ((value == null || value.isEmpty) &&
                              (_descController.text == null ||
                                  _descController.text.isEmpty)) {
                            return 'A short description is required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Media Url',
                        ),
                        autocorrect: false,
                        autofocus: false,
                        textCapitalization: TextCapitalization.none,
                        keyboardType: TextInputType.url,
                        controller: _mediaUrlController,
                        validator: (String? value) {
                          //Todo: Check that url is to some sort of media file.
                          return null;
                        },
                      ),
                    ]),
              ],
            )),
      ),
    );
  }
}
