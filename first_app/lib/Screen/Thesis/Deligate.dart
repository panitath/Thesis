
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class deligate extends StatefulWidget {
  const deligate({Key? key}) : super(key: key);

  @override
  _deligateState createState() => _deligateState();
}

class _deligateState extends State<deligate> {
  String startdate = DateTime.now().toString();
  String enddate = DateTime.now().toString();
  List leavelist = ['ลากิจ', 'ลาพักผ่อน', 'ลาคลอด'];
  String leavetype = 'ลากิจ';
  Future<void> _openDatepicker(BuildContext context) async {
    final DateTime? d = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: new DateTime(2017),
        lastDate: new DateTime(2030));

    if (d != null) {
      setState(() {
        startdate = d.toLocal().toString();
      });
    }

    if (d != null) {
      setState(() {
        enddate = d.toLocal().toString();
      });
    }
  }

  int currentIndex = 0;
  final screens = [deligate(), leave()];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      
      body:  SingleChildScrollView(
      child : Stack(
        children: <Widget>[
          Container(
            height: size.height * .40,
            decoration: BoxDecoration(
                color: Colors.cyan,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(36),
                    bottomRight: Radius.circular(36))),
          ),
          SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(children: <Widget>[
              // Align(
              //   alignment: Alignment.topRight,
              //   child: Container(alignment: Alignment.center,
              //   height: 52,
              //   width: 52,
              //   decoration: BoxDecoration(color: Colors.amber),
                
              //   ),
              // ),
              Text("\nHi Panita\nแจ้งมอบหมายปฏิบัติหน้าที่แทน\n\n",style: Theme.of(context).textTheme.headline5!.copyWith(
             color: Colors.black,fontWeight: FontWeight.bold)),
              Row(
                children: [
                  Text("ค้นหารหัสพนักงาน\n"),
                ],
              ),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 30,vertical: 5),
              decoration: BoxDecoration(color: Colors.white,
              borderRadius: BorderRadius.circular(29.5),),
              
               child: TextField(decoration: InputDecoration(hintText: "Search",
               
               border: InputBorder.none),
               )
              
            ),
             Container(
                // decoration: BoxDecoration(
                //     color: Colors.yellow[600],
                //     borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text("ประเภทลา", style: TextStyle(fontSize: 20)),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            DropdownButton<String>(
                              value: leavetype,
                              onChanged: (String? newValue) {
                                setState(() {
                                  leavetype = newValue!;
                                });
                              },
                              items: <String>[
                                'ลากิจ',
                                'ลาพักผ่อน',
                                'ลาคลอด'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ]),
                ),
              ),
            Container(
                  // color: Colors.cyan,
                  child: Padding(
                padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            "วันที่เริ่มต้น",
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Row(children: <Widget>[
                            Text(enddate),
                            IconButton(
                              icon: Icon(Icons.calendar_today),
                              onPressed: () {
                                _openDatepicker(context);
                              },
                            ),
                          ])
                        ],
                      ),
                    ]),
              )),
              Container(
                  // color: Colors.cyan,
                  child: Padding(
                padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            "วันที่สิ้นสุด",
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Row(children: <Widget>[
                            Text(enddate),
                            IconButton(
                              icon: Icon(Icons.calendar_today),
                              onPressed: () {
                                _openDatepicker(context);
                              },
                            ),
                          ])
                        ],
                      ),
                    ]),
              )),
               SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  child: Text("Send"),
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return leave();
                    }));
                  },
                ),
            )]),
          ))
        ],
      )),
    );
  }
}

// Column(children: <Widget>[
//   Container(
//     height: size.height*0.4,
//     child: Stack(children: <Widget>[
//       Container(
//         padding: EdgeInsets.only(
    
//         ),
//         height: size.height*0.4-27,
//         decoration: BoxDecoration(color: Colors.cyan,
//         borderRadius: BorderRadius.only(
//           bottomLeft: Radius.circular(36),
//           bottomRight: Radius.circular(36)
//         )
//         ),
//        child: Row(
//          children: <Widget>[
//            Text('Hi Panita',
//            style: Theme.of(context).textTheme.headline5!.copyWith(
//              color: Colors.white,fontWeight: FontWeight.bold),
//            ),
//          ],
//        ), )
//     ],),
//   ),

//     return Scaffold(
//       //backgroundColor: Colors.amber,

//           appBar: AppBar(
//           leading: Icon(Icons.menu),
//           title: Text("Deligate"),
//         ),
//         body: SingleChildScrollView(
//           child: Card(
//               child: Column(
//             children: [
//               Container(
//                   // color: Colors.cyan,
//                   child: Padding(
//                 padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
//                 child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: <Widget>[
//                       // Column(
//                       //   children: <Widget>[
//                       //     Padding(
//                       //       padding: const EdgeInsets.all(8.0),
//                       //       child: Image.asset("assets/images/leaverequest.png"),
//                       //     ),
//                       //   ],
//                       // ),
//                     ]),
//               )),
//               Container(
//                   // color: Colors.cyan,
//                   // decoration: BoxDecoration(
//                   //     color: Colors.green[400],
//                   //     borderRadius: BorderRadius.circular(20)),
//                   child: Padding(
//                     //padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
//                     padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
//                     child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: <Widget>[
//                           Column(
//                             children: <Widget>[
//                               Text(
//                                 "แจ้งมอบหมายปฏิบัติหน้าที่แทน",
//                                 style: TextStyle(fontSize: 20),
//                               ),
//                             ],
//                           ),
//                         ]),
//                   )),

//               Container(
//                   child: Padding(
//                 padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
//                 child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: <Widget>[
//                       Column(
//                         children: <Widget>[
//                           Text(
//                             "ค้นหาพนักงาน",
//                             style: TextStyle(fontSize: 20),
//                           ),
//                         ],
//                       ),
//                       Column(
//                         children: <Widget>[
//                           Row(children: <Widget>[
//                             SizedBox(
//                               height: 50,
//                               width: 250,
//                               child: CupertinoSearchTextField(),
//                             )
//                           ])
//                         ],
//                       ),
//                     ]),
//               )),
//               Container(
//                 // decoration: BoxDecoration(
//                 //     color: Colors.yellow[600],
//                 //     borderRadius: BorderRadius.circular(20)),
//                 child: Padding(
//                   padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
//                   child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: <Widget>[
//                         Column(
//                           children: <Widget>[
//                             Text("ประเภทลา", style: TextStyle(fontSize: 20)),
//                           ],
//                         ),
//                         Column(
//                           children: <Widget>[
//                             DropdownButton<String>(
//                               value: leavetype,
//                               onChanged: (String? newValue) {
//                                 setState(() {
//                                   leavetype = newValue!;
//                                 });
//                               },
//                               items: <String>[
//                                 'ลากิจ',
//                                 'ลาพักผ่อน',
//                                 'ลาคลอด'
//                               ].map<DropdownMenuItem<String>>((String value) {
//                                 return DropdownMenuItem<String>(
//                                   value: value,
//                                   child: Text(value),
//                                 );
//                               }).toList(),
//                             ),
//                           ],
//                         ),
//                       ]),
//                 ),
//               ),
//               Container(
//                   // color: Colors.cyan,
//                   child: Padding(
//                 padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
//                 child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: <Widget>[
//                       Column(
//                         children: <Widget>[
//                           Text(
//                             "วันที่เริ่มต้น",
//                             style: TextStyle(fontSize: 20),
//                           ),
//                         ],
//                       ),
//                       Column(
//                         children: <Widget>[
//                           Row(children: <Widget>[
//                             Text(enddate),
//                             IconButton(
//                               icon: Icon(Icons.calendar_today),
//                               onPressed: () {
//                                 _openDatepicker(context);
//                               },
//                             ),
//                           ])
//                         ],
//                       ),
//                     ]),
//               )),
//               Container(
//                   // color: Colors.cyan,
//                   child: Padding(
//                 padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
//                 child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: <Widget>[
//                       Column(
//                         children: <Widget>[
//                           Text(
//                             "วันที่สิ้นสุด",
//                             style: TextStyle(fontSize: 20),
//                           ),
//                         ],
//                       ),
//                       Column(
//                         children: <Widget>[
//                           Row(children: <Widget>[
//                             Text(enddate),
//                             IconButton(
//                               icon: Icon(Icons.calendar_today),
//                               onPressed: () {
//                                 _openDatepicker(context);
//                               },
//                             ),
//                           ])
//                         ],
//                       ),
//                     ]),
//               )),
             
//               SizedBox(
//                 width: double.infinity,
//                 height: 50,
//                 child: ElevatedButton(
//                   child: Text("Send"),
//                   onPressed: () {
//                     Navigator.pushReplacement(context,
//                         MaterialPageRoute(builder: (context) {
//                       return leave();
//                     }));
//                   },
//                 ),
//               ),
//             ],
//           )),
          
//         ));
//   }
// }

    
    