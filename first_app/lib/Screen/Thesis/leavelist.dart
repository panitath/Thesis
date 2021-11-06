import 'package:first_app/Screen/Thesis/leave.dart';
import 'package:first_app/Screen/Thesis/leavedetail.dart';
import 'package:first_app/model/emp_leave.dart';
import 'package:first_app/model/Empleavelist_form_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class leave_list extends StatelessWidget {
  // Emp_leavelist leave = Emp_leavelist();
  // final List<Empleave> leavelist = List.generate(leave.);

 
    
  @override
  Widget build(BuildContext context) {
    List<Empleave> _empleaveList = [];
    if (context.read<EmpleavelistFormmodel>().empleaveList!= null) {
      _empleaveList = context.read<EmpleavelistFormmodel>().empleaveList;
    }
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'ภาพรวมการลาหยุด',
              style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              //color: Colors.white,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              iconSize: 28.0,
               onPressed: () {
              //   Navigator.push(context,
              //       MaterialPageRoute(builder: (context) => LogInScreen())
              //   );
              },
            ),
          ],
          //backgroundColor: Color(0xFF473F97),
        ),
        //
        body: ListView.builder(
        itemCount: _empleaveList.length,
        itemBuilder: (context, int index) {
          
          //User data = provider.users[index];
          return Card(
            
            child: ListTile(
              leading: CircleAvatar(
                radius: 20,
                child: FittedBox(
                  child: Text('${index+1}',
                    //style: TextStyle(color: iWhiteColor,fontSize: 20),
                  ),
                ),
              ),
              title: Text('${_empleaveList[index].leaveid}'),
              subtitle: Text('${_empleaveList[index].startdate}'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  EmpleaveDetail(Empleaves: _empleaveList[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
  }

class EmpleaveDetail extends StatefulWidget {
  
  final Empleave Empleaves;
  
  const EmpleaveDetail({Key? key, required this.Empleaves}) : super(key: key);

  @override
  _EmpleaveDetailState createState() => _EmpleaveDetailState();
}

class _EmpleaveDetailState extends State<EmpleaveDetail> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('รายละเอียดการลา'),
        //backgroundColor: iBlueColor,
        actions: [
          IconButton(
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => LogInScreen()),
              // );
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0), 
        
        child: Form(
            key: formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                enabled: false,
                labelText: 'ประเภทลา',
                labelStyle: TextStyle(
                    //color: iBlackColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
                enabledBorder: UnderlineInputBorder(
                  //borderSide: BorderSide(color: iBlueColor),
                ),
                focusedBorder: UnderlineInputBorder(
                  //borderSide: BorderSide(color: iBlueColor),
                ),
              ),
              initialValue: '${widget.Empleaves.leaveid}',
            ),
            TextFormField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                enabled: false,
                labelText: 'วันที่เริ่มต้นการลา',
                labelStyle: TextStyle(
                   // color: iBlackColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
                enabledBorder: UnderlineInputBorder(
                  //borderSide: BorderSide(color: iBlueColor),
                ),
                focusedBorder: UnderlineInputBorder(
                  //borderSide: BorderSide(color: iBlueColor),
                ),
              ),
              initialValue: '${widget.Empleaves.startdate}',
            ),
            TextFormField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                enabled: false,
                labelText: 'วันที่สิ้นสุดการลา',
                labelStyle: TextStyle(
                    //color: iBlackColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
                enabledBorder: UnderlineInputBorder(
                  //borderSide: BorderSide(color: iBlueColor),
                ),
                focusedBorder: UnderlineInputBorder(
                  //borderSide: BorderSide(color: iBlueColor),
                ),
              ),
              initialValue: '${widget.Empleaves.enddate}',
            ),
            
            Divider(),
            TextFormField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                enabled: false,
                labelText: 'หมายเหตุ',
                labelStyle: TextStyle(
                    //color: iBlackColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
                enabledBorder: UnderlineInputBorder(
                 // borderSide: BorderSide(color: iBlueColor),
                ),
                focusedBorder: UnderlineInputBorder(
                  //borderSide: BorderSide(color: iBlueColor),
                ),
              ),
              initialValue: '${widget.Empleaves.comment}',
            ),
            Container(
                    // margin: EdgeInsets.only(top: 280),
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      // BorderRadius: new BorderRadius.circular(30.0),

                      //height: 60,
                      // color: iBlueColor,
                      onPressed: () { 
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();                   
                      }
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => leave()));
                        }
                      ,
                      style: ElevatedButton.styleFrom(
                        //primary: iBlueColor,
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                      ),
                      child: Text('ลบ',
                          //style: TextStyle(fontSize: 20, color: iWhiteColor)),
                    ),
                  )
            )],
        ),
      ),
    ));
  }
}