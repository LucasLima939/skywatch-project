import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skywatch_application/data/models/models.dart';
import 'package:skywatch_application/presentation/bloc/videos/videos.dart';
import 'package:skywatch_application/presentation/ui/components/components.dart';

import '../../../domain/interfaces/entities/entities.dart';

class UploadVideoForm extends StatefulWidget {
  final VideosBloc videosBloc;
  final AddressEntity? currentAddress;
  final FocusNode focus;
  final VoidCallback onGetLocation;
  const UploadVideoForm(
    this.videosBloc, {
    required this.currentAddress,
    required this.focus,
    required this.onGetLocation,
    super.key,
  });

  @override
  State<UploadVideoForm> createState() => _UploadVideoFormState();
}

class _UploadVideoFormState extends State<UploadVideoForm> {
  late TextEditingController fileNameController = TextEditingController();
  late TextEditingController descriptionController = TextEditingController();
  late TextEditingController weatherController = TextEditingController(text: 'Unknown');
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  String? downloadUrl;
  String? get currentLocation => widget.currentAddress?.stateAbbreviation;
  String? get description => descriptionController.text.isEmpty ? null : descriptionController.text;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideosBloc, VideosStates>(
        bloc: widget.videosBloc,
        builder: (context, state) {
          if (state is VideoLoadingState) {
            isLoading = true;
          }

          return Padding(
            padding: const EdgeInsets.all(30),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: fileNameController,
                    readOnly: true,
                    decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.upload, color: Colors.white),
                      hintText: 'Click to upload your video',
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                    validator: (value) {
                      if (value?.isNotEmpty == true) return null;
                      return 'Please select a file';
                    },
                    onTap: isLoading ? () {} : _openSelectFileBottomSheet,
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    focusNode: widget.focus,
                    controller: descriptionController,
                    maxLength: 40,
                    readOnly: isLoading,
                    decoration: const InputDecoration(
                        hintText: 'Type your description...',
                        hintStyle: TextStyle(color: Colors.white),
                        counterStyle: TextStyle(color: Colors.white)),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _buildLocationTag(),
                      const Spacer(),
                      WeatherTag(weatherController),
                    ],
                  ),
                  _buildButton(),
                ],
              ),
            ),
          );
        });
  }

  Widget _buildLocationTag() => GestureDetector(
        onTap: isLoading ? () {} : _getLocation,
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          const Icon(Icons.location_on, color: Colors.white),
          const SizedBox(width: 3),
          Text(currentLocation ?? 'Unknown',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                decoration: TextDecoration.underline,
                decorationColor: Colors.white,
              ))
        ]),
      );

  Widget _buildButton() => Align(
        alignment: Alignment.center,
        child: Container(
          padding: const EdgeInsets.only(top: 40),
          height: 80,
          width: MediaQuery.of(context).size.width * .5,
          child: FilledButton(
              onPressed: isLoading ? () {} : _uploadVideo,
              child: isLoading ? const CircularProgressIndicator() : const Text('Publish')),
        ),
      );

  void _uploadVideo() {
    _hideKeyboard();
    if (_formKey.currentState!.validate() && downloadUrl != null) {
      final model = SkyVideoModel(
        downloadUrl: downloadUrl!,
        likes: const [],
        locationAbbreviation: currentLocation ?? 'Unknown',
        weatherTag: weatherController.text,
        date: DateTime.now(),
        description: description,
      );
      widget.videosBloc.add(UploadVideoEvent(model));
    }
  }

  void _getLocation() {
    if (currentLocation == null && !isLoading) {
      widget.onGetLocation();
    }
  }

  void _openSelectFileBottomSheet() => showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) => SelectFileBottomSheet(onSelectOption: _onTapSelectFile),
      );

  void _onTapSelectFile(bool shouldRecord) => widget.videosBloc.add(GetVideoFileEvent(shouldRecord));

  void _hideKeyboard() => widget.focus.unfocus();

  @override
  void dispose() {
    fileNameController.dispose();
    descriptionController.dispose();
    weatherController.dispose();
    super.dispose();
  }
}
