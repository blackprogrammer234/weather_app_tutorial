import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:weather/weather.dart';

part 'weather_bloc_event.dart';
part 'weather_bloc_state.dart';

//=======How the Bloc works==========
//The ui first trigger the event by performing some action
//The bloc then listen that event to be called and process it. 
//Emit the state based on business requirement
//State is consume by UI which from there the screen is either rebuild or unique action is perform

//***
// The WeatherBlocBloc is responsible for managing the state and event of the weather data
// */
class WeatherBlocBloc extends Bloc<WeatherBlocEvent, WeatherBlocState> {
  //Initial state of the bloc by calling the WeatherBlocInitial
  WeatherBlocBloc() : super(WeatherBlocInitial()) {
    //When the FetchWeather event is trigger, the bloc will listen to the event and process it. If 
    //the event is successful, the bloc will emit the WeatherBlocSuccess state that contain the weather data
    on<FetchWeather>((event, emit) async {
      emit(WeatherBlocLoading());
      try {
        //WeatherFactory is apart of the weather package that is responsible for fetching the weather data afther passing the API Key
        //which is stored in the environment file and the language of the weather data.
        // From there we can call the currentWeatherByLocation to fetch the weather data based on the current location of the user which was  provided
        //by the geolocator plugin
        WeatherFactory wf =
            WeatherFactory(dotenv.env['API_KEY']!, language: Language.ENGLISH);
        Position position = await Geolocator.getCurrentPosition();
        Weather weather = await wf.currentWeatherByLocation(
            event.position.latitude, event.position.longitude);
        print(weather);
        emit(WeatherBlocSuccess(weather));
      } catch (e) {
        //If the bloc failed for any reason then send back weatherBlocFailure state back to the UI
        emit(WeatherBlocFailure());
      }
    });
  }
}
