import 'package:WeatherApp/view/weatherInfopage.dart';
import 'package:flutter/material.dart';


class AboutUsPage extends StatelessWidget {

  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        
        body:Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors:[
                  Colors.blue[300],
                  Colors.blue[600],
                  Colors.blue[300]
                ]
              ),
            ),
            child: Column(
               crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Text('About Us',
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
          Icons.wb_sunny,
          color: Colors.white,
          size: 45.0,
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(2.0),
        child: Text(
          "Weather",
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
                      context,MaterialPageRoute(builder: (context) => WeatherInfoPage()));
  },
)

              ),
                  ],
                ),

               
                     Container(
                        padding: EdgeInsets.all(30.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
        width: 0, color: Colors.white),
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60),)   
                        ),
                       
              ),

                    Expanded(
                      
                        child: Container( 
                          padding: EdgeInsets.zero,
                          color: Colors.white,
                          child: SingleChildScrollView(
                            child: Column(
             // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                                   Padding(
                                    padding: EdgeInsets.all(30),
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                       
    Card(
      
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)) ),
      shadowColor:Colors.blue,
        elevation: 10,
        color: Colors.white,   
                                
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                                   crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    mainAxisSize: MainAxisSize.max,
      
                                              children: [
                                                Center(
                                                  child: Image.network(  "https://www.bigcountryhomepage.com/wp-content/uploads/sites/56/2020/02/Weather-v2.jpg"
,fit: BoxFit.fill,),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text("Weather App",style:  TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),),
                                                ),
                                              Text('In weather app i have used bloc pattern to sepreate Bussiness logic with view.'
                                              'I have not used navigation drawer as task asked me 2 have only screens.'
                                              'I have use Button for togging between 2 screens instead Navigation Drawer.'
                                              'As I am allowes only to use 2 screen.' 
                                              '1)Current Weather Screen.'
                                              'That will be showing only current weather info using openweather api.'
                                              '2)About us Screen.'
                                              'As task have not defined any information regarding it ,So Ihave used for decribing Screen.'
                                              'I have made third page for setting as task had specified only to make 2 screen specific.'
                                             ,softWrap: true,
                                              )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                      
                ]  ),
                          ),
                        ),
                      ),
                    
         

//
               ] ), 
        
    

      )
       )   );
  }
}