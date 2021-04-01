import 'package:adam_company_consumer_app/common/import_clases.dart';
import 'package:adam_company_consumer_app/ui/pages/bottom_bar_pages/bottom_bar_page.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:location/location.dart';

class GetLocation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _selectionScreen();
  }
}

class _selectionScreen extends State<GetLocation> {
  @override
  void initState() {
    // TODO: implement initState
//    getCurrentLocation();
    super.initState();
  }

//  Location location = new Location();
  var currentAddress;
  LatLng latLng;

  getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    BackFunction.commonNavigator(
        context,
        BottomNavBarPage(
          initialIndex: 0,
          initialIndexJob: 0,
        ));
  }

  // PickResult selectedPlace;
  LocationResult _pickedLocation;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: Container(
        height: height,
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              around,
              style: GoogleFonts.poppins(
                color: WidgetColors.blackColor,
                fontSize: 16,
              ),
            ),
            Container(
              height: height * .03,
            ),
            Container(
              height: height * .07,
              width: width / 1.2,
              child: MaterialButtonClassPage(
                height: height * .07,
                radius: BorderRadius.circular(02),
                buttonName: current,
                onPress: () {
                  getCurrentLocation();
                },
                color: WidgetColors.buttonColor,
                minwidth: width / 1.2,
                fontSize: 16,
              ),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade400,
                      blurRadius: 2,
                      spreadRadius: 0.5,
                      offset: Offset(4, 4))
                ],
                color: WidgetColors.buttonColor,
              ),
            ),
            Container(
              height: height * .04,
            ),
            InkWell(
              splashColor: WidgetColors.buttonColor,
              onTap: () async {
                LocationResult result = await showLocationPicker(
                    context, "AIzaSyAO8dCr_tSOIoRgnSjil-ajIgbIjJqBlZo",
                    // "AIzaSyDZJEqajaFhUOZCZhh3irBvGsa5p9WHF7o",
                    initialCenter: latLng,
                    myLocationButtonEnabled: true,
                    layersButtonEnabled: true,
                    desiredAccuracy: LocationAccuracy.best,
                    resultCardDecoration: BoxDecoration(
                        color: Colors.black,
                        border: Border.all(
                            color: WidgetColors.buttonColor, width: 2)));
                setState(() => _pickedLocation = result);
                SharedPreferences setLocation =
                    await SharedPreferences.getInstance();
                setLocation.setString("fullAddress", result.address.toString());
                setLocation.setString(
                    "addressLatitude", result.latLng.latitude.toString());
                setLocation.setString(
                    "addressLongitude", result.latLng.longitude.toString());
                Navigator.of(context).pop();
                BackFunction.commonNavigator(
                    context,
                    BottomNavBarPage(
                      initialIndexJob: 0,
                      initialIndex: 0,
                      location: result.address.toString(),
                    ));
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) {
//                       return PlacePicker(
//                         apiKey: "AIzaSyBIzJdSxuK1chdYOdrz2f1VYGqb3glCCqo",
//                         initialPosition: latLng,
//                         useCurrentLocation: true,
// //                          selectInitialPosition: true,
//                         onPlacePicked: (result) {
//                           Navigator.of(context).pop();
//                           setState(() {
//                             selectedPlace = result;
//                           });
//                         },
//                         selectedPlaceWidgetBuilder:
//                             (_, selectedPlace, state, isSearchBarFocused) {
//                           print(
//                               "state: $state, isSearchBarFocused: $isSearchBarFocused");
//                           return isSearchBarFocused
//                               ? Container()
//                               : FloatingCard(
//                                   bottomPosition: 0.0,
//                                   leftPosition: 0.0,
//                                   rightPosition: 0.0,
//                                   width: 500,
//                                   borderRadius: BorderRadius.circular(12.0),
//                                   child: state == SearchingState.Searching
//                                       ? Center(
//                                           child: CircularProgressIndicator())
//                                       : Container(
//                                           width: width / 2,
//                                           child: MaterialButtonClassPage(
//                                             height: height * .07,
//                                             radius: BorderRadius.circular(02),
//                                             buttonName: "Pick Your Location",
//                                             onPress: () async {
//                                               SharedPreferences setLocation =
//                                                   await SharedPreferences
//                                                       .getInstance();
//                                               setLocation.setString(
//                                                   "fullAddress",
//                                                   selectedPlace.formattedAddress
//                                                       .toString());
//                                               setLocation.setString(
//                                                   "addressLatitude",
//                                                   selectedPlace
//                                                       .geometry.location.lat
//                                                       .toString());
//                                               setLocation.setString(
//                                                   "addressLongitude",
//                                                   selectedPlace
//                                                       .geometry.location.lng
//                                                       .toString());
//                                               Navigator.of(context).pop();
//                                               BackFunction.commonNavigator(
//                                                   context,
//                                                   BottomNavBarPage(
//                                                     initialIndexJob: 0,
//                                                     initialIndex: 0,
//                                                     location: selectedPlace
//                                                         .formattedAddress
//                                                         .toString(),
//                                                   ));
//                                               Navigator.of(context).pop();
//                                               BackFunction.commonNavigator(
//                                                   context,
//                                                   BottomNavBarPage(
//                                                     initialIndexJob: 0,
//                                                     initialIndex: 0,
//                                                     location: selectedPlace
//                                                         .formattedAddress
//                                                         .toString(),
//                                                   ));
//                                             },
//                                             color: WidgetColors.buttonColor,
//                                             minwidth: width / 1.2,
//                                             fontSize: 16,
//                                           ),
//                                           decoration: BoxDecoration(boxShadow: [
//                                             BoxShadow(
//                                                 color: Colors.grey.shade400,
//                                                 blurRadius: 2,
//                                                 spreadRadius: 0.5,
//                                                 offset: Offset(4, 4))
//                                           ]),
//                                         ),
//
// //                            RaisedButton(
// //
// //                              child: Text(
// //                                "Pick Your Location",
// //                                style:
// //                                GoogleFonts.montserrat(color: WidgetColors.buttonColor,fontSize: 16,),
// //                              ),
// //                              onPressed: () {
// //                                print("do something with  ${selectedPlace.formattedAddress} data");
// //
// //                                Navigator.of(context).pop();
// //                              },
// //                            ),
//                                 );
//                         },
//                       );
//                     },
//                   ),
//                 );
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(2),
                    border: Border.all(color: WidgetColors.buttonColor)),
                height: height * .07,
                width: width / 1.2,
                child: Center(
                  child: Text(
                    other,
                    style: GoogleFonts.poppins(
                      color: WidgetColors.buttonColor,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
