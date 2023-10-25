import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skywatch_application/presentation/bloc/videos/videos.dart';
import 'package:skywatch_application/presentation/bloc/weather/weather.dart';
import 'package:skywatch_application/presentation/ui/components/components.dart';

import '../../../domain/interfaces/interfaces.dart';

class UploadVideoBottomSheet extends StatefulWidget {
  final VideosBloc videosBloc;
  final WeatherBloc weatherBloc;
  const UploadVideoBottomSheet(this.videosBloc, this.weatherBloc, {super.key});

  @override
  State<UploadVideoBottomSheet> createState() => _UploadVideoBottomSheetState();
}

class _UploadVideoBottomSheetState extends State<UploadVideoBottomSheet> {
  final focus = FocusNode();
  AddressEntity? currentAddress;

  @override
  void dispose() {
    focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _hideKeyboard();
        Navigator.pop(context);
      },
      child: Material(
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: _hideKeyboard,
              child: AnimatedContainer(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                    color: Theme.of(context).appBarTheme.backgroundColor,
                    borderRadius: const BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20))),
                child: BlocBuilder<WeatherBloc, WeatherState>(
                    bloc: widget.weatherBloc,
                    builder: (context, state) {
                      if (state is WeatherAddressState) {
                        currentAddress = state.entity;
                      } else if (state is WeatherLocationState) {
                        widget.weatherBloc.add(GetCurrentAddressEvent(state.entity));
                        widget.weatherBloc.add(GetWeeklyForecastEvent(state.entity));
                      }

                      return SingleChildScrollView(
                        physics: const NeverScrollableScrollPhysics(),
                        child: Column(mainAxisSize: MainAxisSize.min, children: [
                          const BottomSheetHeader(),
                          UploadVideoForm(
                            widget.videosBloc,
                            currentAddress: currentAddress,
                            focus: focus,
                            onGetLocation: onGetLocation,
                          ),
                        ]),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onGetLocation() => widget.weatherBloc.add(const GetCurrentLocationEvent());

  void _hideKeyboard() => focus.unfocus();
}
