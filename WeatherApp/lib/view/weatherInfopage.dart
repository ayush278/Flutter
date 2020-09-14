import 'package:WeatherApp/bloc/weatherinfoBloc/weatherinfo_page_bloc.dart';
import 'package:WeatherApp/bloc/weatherinfoBloc/weatherinfo_page_event.dart';
import 'package:WeatherApp/bloc/weatherinfoBloc/weatherinfo_page_state.dart';
import 'package:WeatherApp/model/Weather.dart';
import 'package:WeatherApp/repo/weatherrepo.dart';
import 'package:WeatherApp/view/aboutuspage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';

class WeatherInfoPage extends StatelessWidget {

String temp,mintemp,maxtemp,humidity,pressure,feelslike,formattedDate;

  @override
  Widget build(BuildContext context) {

 
    return SafeArea(
      child: Scaffold( 
        body:BlocProvider<WeatherInfoPageBloc>(
          create: (context)=>WeatherInfoPageBloc()..add(InitEvent()),
      
        child:BlocBuilder<WeatherInfoPageBloc,WeatherInfoPageState>(
          builder: (context,state){
            if(state is WeatherInfoInitialState)
            {
              WeatherInfoMain weatherInfoMain =state.weather;
              temp=(weatherInfoMain.temp).toString();
              mintemp=(weatherInfoMain.temp_min).toString();
              maxtemp=(weatherInfoMain.temp_max).toString();
              humidity=(weatherInfoMain.humidity).toString();
              pressure=(weatherInfoMain.pressure).toString();
              feelslike=(weatherInfoMain.feels_like).toString();
              formattedDate=state.formattedDate;
              return Container(
           width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.blue[300],
              Colors.blue[600],
              Colors.blue[300]
            ]
          )
        ),
        
          child: Column(
             crossAxisAlignment: CrossAxisAlignment.stretch,
  mainAxisAlignment: MainAxisAlignment.start,
            children: [
               
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Text('Weather',
               style: TextStyle(
                      color: Colors.white,
                       fontSize: 34,
               ),
               ),
                    ),
                    Align(
                alignment: Alignment.topRight,
                child:FlatButton(
  color: Colors.transparent,
  splashColor: Colors.transparent,
  padding: EdgeInsets.all(8.0),
  child: Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(4.0),
        child: Icon(
          Icons.person_outline,
          color: Colors.white,
          size: 45.0,
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(2.0),
        child: Text(
          "About Us",
          style: TextStyle(
            color: Colors.white,
          fontWeight: FontWeight.bold,
            fontSize: 15.0
          ),
        ),
      ),
    ],
  ),
  onPressed: () {
     Navigator.pushReplacement(
                      context,MaterialPageRoute(builder: (context) => AboutUsPage()));
  },
)

              ),
                  ],
                ),
               
               Expanded(
                child: Container( 
                  alignment: Alignment.center,
                          padding: EdgeInsets.zero,
                          color: Colors.transparent,
                          child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                       Text("${formattedDate}",style: TextStyle(color:Colors.white,fontSize: 25.0,)),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children:[
                           
                         Text("${temp}\u2103",style: TextStyle(color:Colors.white,fontSize:90.0 ),)
                         ]
                       ),
                        Text("Max. Temp: ${maxtemp}\u2103  Min. Temp: ${mintemp}\u2103",style: TextStyle(color:Colors.white,fontSize: 18.0),),
                        Text("feels like : ${feelslike}\u2103",style: TextStyle(color:Colors.white,fontSize: 18.0),),
                       
                       
                      ],
                    ),
                  ),
                ),
              ), 
            ],
          ),
        );
            }
        else if(state is WeatherInfoLoadingState )
        {
          return Center(child: CircularProgressIndicator(),);
        }else if(state is WeatherInfoFailureState )
        {
          return Center(child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Location Access is required for fetching Weather information",
                style: TextStyle(color: Colors.red,fontSize: 20,),),
                Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton(
                        child: Text("Allow",style: TextStyle(fontSize: 20)),
                        onPressed: () async{
                          Navigator.pushReplacement(
                        context,MaterialPageRoute(builder: (context) => WeatherInfoPage()));
                        }),
                    ),
                    
                  ],
                )
            ],
          ),);
        }
          }
          )
      ),
    )
    );
  }
}
