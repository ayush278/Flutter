     class WeatherInfoMain
    {
         double temp ;
         int pressure ;
         int humidity ;
         int temp_min ;
         double temp_max ;
         double feels_like ;


         WeatherInfoMain(this.temp,this.pressure,this.humidity,this.temp_max,this.temp_min,this.feels_like);
         factory WeatherInfoMain.fromJson(Map<String,dynamic> json){
           return WeatherInfoMain(
             json["temp"], 
             json["pressure"], 
             json["humidity"],
             json["temp_max"],
             json["temp_min"],
             json["feels_like"],
             );
         }
    }