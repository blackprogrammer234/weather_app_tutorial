part of 'weather_bloc_bloc.dart';
//WeatherBlocState ia a state class extended by each State
@immutable
sealed class WeatherBlocState extends Equatable {
  const WeatherBlocState();

   @override
  List<Object?> get props => [];
}

//States are the different situations in which the application can be found at any given time.
//THE ui will be rebuild based on the state of the bloc

final class WeatherBlocInitial extends WeatherBlocState {}
final class WeatherBlocLoading extends WeatherBlocState {}
final class WeatherBlocSuccess extends WeatherBlocState {
  final Weather weather;

  const WeatherBlocSuccess(this.weather);

  @override
  List<Object?> get props => [weather];
}
final class WeatherBlocFailure extends WeatherBlocState {}


