import 'package:WeatherApp/bloc/weatherinfoBloc/weatherinfo_page_event.dart';
import 'package:WeatherApp/bloc/weatherinfoBloc/weatherinfo_page_state.dart';
import 'package:WeatherApp/repo/weatherrepo.dart';
import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

class WeatherInfoPageBloc extends Bloc<WeatherInfoPageEvent,WeatherInfoPageState>
{
WeatherRepo weatherRepo;

WeatherInfoPageBloc() : super(WeatherInfoLoadingState()){
weatherRepo= WeatherRepo();
}

  @override
  Stream<WeatherInfoPageState> mapEventToState(WeatherInfoPageEvent event)async* {
    if(event is InitEvent)
   {
     yield WeatherInfoLoadingState();
     DateTime now = DateTime.now();
    var newFormat = DateFormat("yy-MM-dd");
     String formattedDate = DateFormat(' EEE d MMM   kk:mm:ss \n').format(now);
     try{
      final position=await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      var weatherInfoMain=await weatherRepo.getWeatherInfo((position.latitude).toString(),(position.longitude).toString());
      yield WeatherInfoInitialState(weatherInfoMain,formattedDate);
     }catch(ex){
      yield WeatherInfoFailureState();
       final position=await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      var weatherInfoMain=await weatherRepo.getWeatherInfo((position.latitude).toString(),(position.longitude).toString());
      yield WeatherInfoInitialState(weatherInfoMain,formattedDate);
     }
     
   }
  } 
}