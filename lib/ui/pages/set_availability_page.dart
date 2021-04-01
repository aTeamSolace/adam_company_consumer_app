// import 'package:adam_company_consumer_app/common/import_clases.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// class AvailabilityClass extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     return _selectionScreen();
//   }
// }
// //class _selectionScreen extends State<AvailabilityClass>{
// //
// //  bool _value = false;
// //  @override
// //  Widget build(BuildContext context) {
// //    // TODO: implement build
// //    return Scaffold(
// //      body: SafeArea(child: Column(
// //        children: [
// //          InkWell(
// //            onTap: () {
// //              setState(() {
// //                print("_value:${_value}");
// //                _value = !_value;
// //              });
// //            },
// //            child: Container(
// //              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
// //              child: Padding(
// //                padding: const EdgeInsets.all(10.0),
// //                child: _value
// //                    ? Icon(
// //                  Icons.check,
// //                  size: 30.0,
// //                  color: Colors.white,
// //                )
// //                    : Icon(
// //                  Icons.check_box_outline_blank,
// //                  size: 30.0,
// //                  color: Colors.blue,
// //                ),
// //              ),
// //            ),
// //          )
// //        ],
// //      ),)
// //    );
// //  }
// //}
//
// class _selectionScreen extends State<AvailabilityClass> {
//   bool selectingmode = false;
//   List<Language> paints = <Language>[
//     Language(1, 'Monday', Colors.red),
//     Language(2, 'Tuesday', Colors.blue),
//     Language(3, 'Wednesday', Colors.green),
//     Language(4, 'Thursday', Colors.lime),
//     Language(5, 'Friday', Colors.indigo),
//     Language(6, 'Saturday', Colors.yellow),
//     Language(7, 'Sunday', Colors.yellow)
//   ];
//
//   var mydata = [];
//
//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;
//     return Scaffold(
//         appBar: AppBar(
//           automaticallyImplyLeading: false,
//           backgroundColor: WidgetColors.blackColor,
// //            leading: IconButton(
// //              icon: const Icon(Icons.arrow_back),
// //              onPressed: () {
// //                print("==============${mydata}");
// ////              setState(() {
// ////                selectingmode = false;
// ////                paints.forEach((p) => p.selected = false);
// ////              });
// //              },
// //            ),
//           title: Text(
//             availability,
//             style: GoogleFonts.montserrat(fontSize: 17),
//           ),
//         ),
//         body: SafeArea(
//             child: Column(
//           children: [
//             Container(
// //                  color: Colors.black,
//               child: Padding(
//                   padding: EdgeInsets.only(left: 10, right: 10),
//                   child: Center(
//                     child: GridView(
//                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 3,
//                         crossAxisSpacing: 10.0,
//                         mainAxisSpacing: 15.0,
//                         childAspectRatio: 2.6,
//                       ),
//                       children: List.generate(paints.length, (index) {
//                         return InkWell(
//                           onTap: () {
//                             setState(() {
//                               if (!selectingmode) {
//                                 paints[index].selected =
//                                     !paints[index].selected;
//                                 if (paints[index].selected == true) {
//                                   mydata.add(paints[index].title.toString());
//                                 } else if (paints[index].selected == false) {
//                                   mydata.remove(paints[index].title.toString());
//                                 }
//                               }
//                             });
//                           },
//                           child: Container(
//                             decoration: BoxDecoration(
//                                 color: paints[index].selected == true
//                                     ? WidgetColors.buttonColor
//                                     : Colors.white,
//                                 borderRadius: BorderRadius.circular(40),
//                                 border: Border.all(
//                                     color: WidgetColors.buttonColor)),
//                             height: 10,
//                             child: Center(
//                               child: Text(paints[index].title),
//                             ),
//                           ),
//                         );
// //              ListTile(
// //              onTap: () {
// //                setState(() {
// //                  if (!selectingmode) {
// //                    paints[index].selected = !paints[index].selected;
// //                    if(paints[index].selected == true){
// //                      mydata.add(paints[index].title.toString());
// //                    }else if(paints[index].selected == false){
// //                      mydata.remove(paints[index].title.toString());
// //                    }
// //                  }
// //                });
// //              },
// //              selected: paints[index].selected,
// //              title: Text(paints[index].title),
// //            );
//                       }),
//                     ),
//                   )),
//               height: height / 3,
//             )
//           ],
//         )));
//   }
// }
//
// class Language {
//   final int id;
//   final String title;
//   final Color colorpicture;
//   bool selected = false;
//
//   Language(this.id, this.title, this.colorpicture);
// }
