// import 'dart:io';
//
// import 'package:adam_company_consumer_app/common/import_clases.dart';
// import 'package:adam_company_consumer_app/network/api_provider/api_provider.dart';
// import 'package:adam_company_consumer_app/network/model/get_technician_contact.dart';
// import 'package:adam_company_consumer_app/ui/page_data/job_in_progress_card.dart';
// import 'package:adam_company_consumer_app/ui/pages/select_technician_contact.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class JobInProgress extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     return _selectionScreen();
//   }
// }
//
// class _selectionScreen extends State<JobInProgress> {
//   @override
//   initState() {
//     checkSessionValue();
//     loadingMethod();
//     loading = false;
//     super.initState();
//   }
//
//   onWillPop() {
//     return BackFunction.slideLeftNavigator(
//         context,
//         BottomNavBarPage(
//           initialIndex: 1,
//           initialIndexJob: 1,
//         ));
//   }
//
//   var user_id;
//
//   checkSessionValue() async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     setState(() {
//       user_id = preferences.getString("user_id");
//       // getOngoingTechnicianProfile(user_id.toString());
//     });
//   }
//
//   // Widget customText(
//   //     var title, double height, Color color, FontWeight fontWeight) {
//   //   return Text(
//   //     title.toString(),
//   //     style: GoogleFonts.montserrat(
//   //       fontSize: height,
//   //       color: color,
//   //       fontWeight: fontWeight,
//   //     ),
//   //   );
//   // }
//
//   // Future getOngoingTechnicianProfile(var user_id) async {
//   //   final response = await http.post(
//   //       "http://socialenginespecialist.com/PuneDC/adamcompanies/api/customermanagement/techniciandetailsongoingconsumerservices",
//   //       body: {"consumer_id": user_id.toString()});
//   //
//   //   print("getOngoingTechnicianProfile:${response.body}");
//   //   print("getOngoingTechnicianProfile:${user_id}");
//   //   // if (response.statusCode == 200) {
//   //   //   List<TechnicianModelResult> technicianResult;
//   //   //   if (this.mounted) {
//   //   //     setState(() {
//   //   //       final responseJson = json.decode(response.body);
//   //   //       print("Select Technician :$responseJson");
//   //   //       technicianResult = TechnicianModel.fromJson(responseJson).data;
//   //   //     });
//   //   //   }
//   //   //   return technicianResult;
//   //   // } else {
//   //   //   throw Exception('Failed to load technisian data');
//   //   // }
//   // }
//
//   bool loading;
//   loadingMethod() {
//     Future.delayed(Duration(seconds: 1), () {
//       if (this.mounted) {
//         setState(() {
//           loading = true;
//         });
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;
//     return WillPopScope(
//         child: Scaffold(
//           backgroundColor: Color(0xffE2E2E2),
//           appBar: AppBar(
//             leading: IconButton(
//                 icon: Platform.isIOS
//                     ? Icon(
//                         Icons.arrow_back_ios,
//                         color: Colors.white,
//                       )
//                     : Icon(
//                         Icons.arrow_back,
//                         color: Colors.white,
//                       ),
//                 onPressed: () {
//                   onWillPop();
//                 }),
//             iconTheme: IconThemeData(color: Colors.white),
//             backgroundColor: Colors.black,
//             centerTitle: true,
//             title: customText(
//                 cnt_tech, 18, Colors.white, FontWeight.w400),
//           ),
//           body: SafeArea(
//               child: Center(
//                   child: PlatformScrollbar(
//             child: Container(
//                 width: width,
//                 height: height,
//                 margin: EdgeInsets.only(top: 20, left: 10, right: 10),
//                 child: loading ?  FutureBuilder(
//                   future:
//                   Provider.of<GetApiDataProvider>(context, listen: false)
//                       .getContactTechnicianData(user_id.toString()),
//                   builder: (BuildContext context,
//                       AsyncSnapshot<GetContactTechnicianModel> snapshot) {
//                     if (snapshot.hasData) {
//                       if (snapshot.data.data.length > 0) {
//                         return GridView.builder(
//                           itemCount: snapshot.data.data.length,
//                           padding: EdgeInsets.only(
//                               bottom: kFloatingActionButtonMargin + 48),
//                           gridDelegate:
//                           SliverGridDelegateWithFixedCrossAxisCount(
//                             crossAxisCount: 2,
//                             crossAxisSpacing: 5.0,
//                             mainAxisSpacing: 5.0,
//                           ),
//                           physics: BouncingScrollPhysics(),
//                           itemBuilder: (BuildContext context, int index) {
//                             return InkWell(
//                               child: JobInProgressCard(
//                                 userImage: snapshot.data.data[index].profilePic,
//                                 userName: snapshot.data.data[index].name,
//                                 userId: snapshot.data.data[index].userId,
//                               ),
//                               onTap: () {
//                                 BackFunction.sizeNavigator(
//                                     context,
//                                     ContactTechnician(
//                                       technician_id: snapshot.data.data[index].userId,
//                                       service_id: snapshot.data.data[index].id,
//                                     ));
//                               },
//                             );
//                           },
//                         );
//                       } else {
//                         return Center(
//                           child: Text(
//                             no_jb_in_progress,
//                             style: GoogleFonts.poppins(
//                                 fontSize: 16, fontWeight: FontWeight.w500),
//                           ),
//                         );
//                       }
//                     } else if (snapshot.hasError) {
//                       return Text(snapshot.error.toString());
//                     }
//                     return Center(
//                       child: PlatformLoader(
//                         color: WidgetColors.buttonColor,
//                         radius: 15,
//                       ),
//                     );
//                   },
//                 ) : Center(
//                   child: PlatformLoader(
//                     color: WidgetColors.buttonColor,radius: 15,
//                   ),
//                 )
//                 // GridView(
//                 //   padding:
//                 //       EdgeInsets.only(bottom: kFloatingActionButtonMargin + 48),
//                 //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 //     crossAxisCount: 2,
//                 //     crossAxisSpacing: 5.0,
//                 //     mainAxisSpacing: 5.0,
//                 //   ),
//                 //   physics: BouncingScrollPhysics(),
//                 //   children: [
//                 //     InkWell(
//                 //       child: JobInProgressCard(),
//                 //       onTap: () {
//                 //         BackFunction.slideLeftNavigator(
//                 //             context, ContactTechnician());
//                 //       },
//                 //     ),
//                 //     JobInProgressCard(),
//                 //     JobInProgressCard(),
//                 //     JobInProgressCard(),
//                 //     JobInProgressCard(),
//                 //   ],
//                 // ),
//                 ),
//           ))),
//         ),
//         onWillPop: () {
//           return onWillPop();
//         });
//   }
// }
