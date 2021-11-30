import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template/data/project_dao.dart';
import 'package:template/ui/components/components.dart';
import 'package:template/ui/models/app_state_manager.dart';
import 'package:template/ui/models/green_project.dart';

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
    final projectDao = Provider.of<ProjectDao>(context, listen: false);
    final appStateManager =
        Provider.of<AppStateManager>(context, listen: false);
    return Padding(
        padding: EdgeInsets.all(8.0),
        child: Form(
            key: _formKey,
            child: Column(
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
                // WebViewGember(
                //     title: 'Promotion', selectedUrl: 'http://www.bing.com'),
                Row(
                  children: [
                    const SizedBox(height: 20),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // 1
                          print('Dummy button pressed');

                          if (_checkValidName() &&
                              _checkValidSponsorName() &&
                              _checkValidDescription() &&
                              _checkValidShortDescription() &&
                              _checkValidMediaUrl()) {
                            projectDao.saveProject(GreenProject.create(
                                _nameController.text,
                                company_name: _sponsorController.text,
                                image_url: _mediaUrlController.text,
                                description: _descController.text,
                                short_description: _shortDescController.text));
                            appStateManager.goToProfile();
                          }
                        },
                        child: const Text('Submit'),
                      ),
                    )
                  ],
                ),
              ],
            )));
  }

  bool _checkValidName() {
    return _nameController.text != null && _nameController.text.isNotEmpty;
  }

  bool _checkValidSponsorName() {
    return _sponsorController.text != null &&
        _sponsorController.text.isNotEmpty;
  }

  bool _checkValidDescription() {
    return _descController.text != null && _descController.text.isNotEmpty;
  }

  bool _checkValidShortDescription() {
    return _shortDescController.text != null &&
        _shortDescController.text.isNotEmpty;
  }

  bool _checkValidMediaUrl() {
    return true;
  }
}
