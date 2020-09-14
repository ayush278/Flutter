import 'package:WeatherApp/model/Weather.dart';
import 'package:equatable/equatable.dart';

abstract class WeatherInfoPageState extends Equatable{}


class WeatherInfoInitialState extends WeatherInfoPageState{
   WeatherInfoMain weather;
   String formattedDate;
  WeatherInfoInitialState(this.weather, this.formattedDate);
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
class WeatherInfoSuccessState extends WeatherInfoPageState{

  @override
  // TODO: implement props
  List<Object> get props => null;
}
class WeatherInfoLoadingState extends WeatherInfoPageState{
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
class WeatherInfoFailureState extends WeatherInfoPageState{

  @override
  // TODO: implement props
  List<Object> get props => null;
}