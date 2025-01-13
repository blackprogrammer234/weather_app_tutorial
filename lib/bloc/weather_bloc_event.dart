part of 'weather_bloc_bloc.dart';

//WeatherBlocEvent is an event class extended by each State
@immutable
sealed class WeatherBlocEvent extends Equatable{
  const WeatherBlocEvent();

   @override
  List<Object?> get props => [];
}
//Events are occurrences or interactions in the application that trigger a state change.
class FetchWeather extends WeatherBlocEvent{
  final Position position;

  const FetchWeather(this.position);

  @override
  List<Object?> get props => [position];
}
