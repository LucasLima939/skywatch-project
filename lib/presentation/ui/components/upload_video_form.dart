import 'dart:io';

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
  late TextEditingController descriptionController = TextEditingController();
  late TextEditingController weatherController = TextEditingController(text: 'Unknown');
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  File? selectedFile;
  String? downloadUrl;
  String? get fileName => selectedFile?.path.split('/').last;
  String? get currentLocation => widget.currentAddress?.stateAbbreviation;
  String? get description => descriptionController.text.isEmpty ? null : descriptionController.text;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideosBloc, VideosStates>(
        bloc: widget.videosBloc,
        builder: (context, state) {
          isLoading = false;
          if (state is VideoLoadingState) {
            isLoading = true;
          } else if (state is VideoFileResponseState) {
            selectedFile = state.file;
            _formKey.currentState!.validate();
          } else if (state is DownloadVideoSuccessState) {
            isLoading = true;
            downloadUrl = state.downloadUrl;
            widget.videosBloc.add(SubmitVideoEvent(_buildVideoModel()));
          } else if (state is SubmitVideoSuccessState) {
            Navigator.of(context).pop(true);
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
                    readOnly: true,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                          icon: Icon(selectedFile == null ? Icons.upload : Icons.close),
                          color: Colors.white,
                          onPressed: () {
                            if (isLoading) return;
                            if (selectedFile == null) {
                              _openSelectFileBottomSheet();
                            } else {
                              widget.videosBloc.add(const ClearVideoFileEvent());
                            }
                          }),
                      hintText: fileName ?? 'Click to upload your video',
                      hintStyle: const TextStyle(color: Colors.white),
                    ),
                    validator: (value) => selectedFile == null ? 'Please select a file' : null,
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    focusNode: widget.focus,
                    controller: descriptionController,
                    maxLength: 40,
                    readOnly: isLoading,
                    style: const TextStyle(color: Colors.white),
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
              onPressed: _uploadVideo,
              child: isLoading
                  ? const SizedBox(height: 15, width: 15, child: CircularProgressIndicator(color: Colors.white))
                  : const Text('Publish')),
        ),
      );

  void _uploadVideo() {
    _hideKeyboard();
    if (_formKey.currentState!.validate() && selectedFile != null && !isLoading) {
      widget.videosBloc.add(UploadVideoEvent(selectedFile!, fileName!));
    }
  }

  SkyVideoEntity _buildVideoModel() => SkyVideoModel(
        downloadUrl: downloadUrl!,
        likes: const [],
        locationAbbreviation: currentLocation ?? 'Unknown',
        weatherTag: weatherController.text,
        date: DateTime.now(),
        description: description,
      );

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
    descriptionController.dispose();
    weatherController.dispose();
    super.dispose();
  }
}
