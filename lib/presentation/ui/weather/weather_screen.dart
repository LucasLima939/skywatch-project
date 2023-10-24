import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skywatch_application/domain/interfaces/interfaces.dart';
import 'package:skywatch_application/presentation/bloc/weather/weather.dart';
import 'package:skywatch_application/presentation/ui/mixins/state_manager.dart';
import 'package:skywatch_application/presentation/ui/ui.dart';

class WeatherScreen extends StatefulWidget {
  final WeatherBloc bloc;
  const WeatherScreen(this.bloc, {super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> with StateManager {
  bool isLoading = false;
  LocationEntity? currentLocation;
  AddressEntity? currentAddress;
  ForecastEntity? forecast;
  WeatherEntity? get todayForecast => forecast?.entities.first;
  List<WeatherEntity>? get weeklyForecast => forecast?.entities.sublist(1);

  Widget _buildListener({required Widget child}) => BlocListener<WeatherBloc, WeatherState>(
        bloc: widget.bloc,
        listener: (context, state) {
          if (state is WeatherForecastState) {
            forecast = state.entity;
          } else if (state is WeatherFailureState) {
            final onRefresh = state.refreshEvent != null ? () => widget.bloc.add(state.refreshEvent) : null;
            showFailureDialog(state.failure, context, onRefresh);
          }
        },
        child: child,
      );

  @override
  Widget build(BuildContext context) {
    return _buildListener(
      child: Scaffold(
        body: BlocBuilder<WeatherBloc, WeatherState>(
            bloc: widget.bloc,
            builder: (context, state) {
              isLoading = true;
              if (state is WeatherLocationState) {
                currentLocation ??= state.entity;
                _initWeatherPage();
              } else if (state is WeatherAddressState) {
                currentAddress ??= state.entity;
                widget.bloc.add(GetWeeklyForecastEvent(currentLocation!));
              } else {
                isLoading = state is WeatherLoadingState;
              }
              return isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : todayForecast == null || weeklyForecast == null
                      ? _buildEmptyPlaceholder()
                      : RefreshIndicator(
                          onRefresh: _initWeatherPage,
                          color: Theme.of(context).primaryColor,
                          child: SingleChildScrollView(
                            child: Container(
                              constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
                              child: Column(
                                children: [
                                  const SizedBox(height: 40),
                                  CurrentWeatherCard(todayForecast!, currentAddress),
                                  const SizedBox(height: 40),
                                  WeeklyForecastTile(weeklyForecast!),
                                  const SizedBox(height: 40),
                                ],
                              ),
                            ),
                          ),
                        );
            }),
      ),
    );
  }

  Widget _buildEmptyPlaceholder() => Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
        const Text('No data found', style: TextStyle(color: Colors.white, fontSize: 16)),
        const SizedBox(height: 20),
        FilledButton(onPressed: _initWeatherPage, child: const Text('Refresh')),
      ]));

  Future<void> _initWeatherPage() async {
    if (currentLocation == null) {
      widget.bloc.add(const GetCurrentLocationEvent());
    } else if (currentAddress == null) {
      widget.bloc.add(GetCurrentAddressEvent(currentLocation!));
    } else {
      widget.bloc.add(GetWeeklyForecastEvent(currentLocation!));
    }
  }
}
