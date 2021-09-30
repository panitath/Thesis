import 'package:first_app/Screen/Thesis/leavedetail.dart';
import 'package:first_app/model/emp_leave.dart';
import 'package:first_app/model/emp_leavelist.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class leave_list extends StatelessWidget {
  // Emp_leavelist leave = Emp_leavelist();
  // final List<Empleave> leavelist = List.generate(leave.);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        appBar: AppBar(
          title: Text("LeaveList"),
        ),
        body: Consumer(
          builder: (context, Emp_leavelist provider, child) {
            return ListView.builder(
              itemCount: provider.transactions.length,
              itemBuilder: (context, index) {
                Empleave data = provider.transactions[index];
                return Card(
                  child: ListTile(title: Text(data.leaveid.toString()),
                  subtitle: Text("วันที่ลา  "+ data.startdate.toString()), 
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LeaveDetail(leave : provider.transactions[index],)));
                  }, 
                ),
                )
                ;
              },
            );
          },
        ));
  }
}

   
  // ListView.builder(itemBuilder: (context,int index){
  //   return ListView.separated(
  //       padding: EdgeInsets.all(8.0),
  //       itemCount: enties.length,
  //       itemBuilder: (context, index) {
  //         return ProductTile(
  //           item: ProductItem(
  //             name: 'Product ${enties[index]}',
  //             price: '฿25',
  //             colorShade: colorCodes[index % 3],
  //           ),
  //         );
  //       },
  //       separatorBuilder: (context, index) => Divider(),
  //     );
  // }
//   )
// );
    
//   }
// }





    // final List<String> enties = <String>[
    //   'A',
    //   'B',
    //   'C',
    //   'D',
    //   'E',
    //   'F',
    //   'G',
    //   'H',
    //   'I',
    //   'J',
    //   'K',
    //   'L'
    // ];
    // final List<int> colorCodes = <int>[600, 500, 100];
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text("LeaveList"),
    //   ),
    //   body: ListView.separated(
    //     padding: EdgeInsets.all(8.0),
    //     itemCount: enties.length,
    //     itemBuilder: (context, index) {
    //       return ProductTile(
    //         item: ProductItem(
    //           name: 'Product ${enties[index]}',
    //           price: '฿25',
    //           colorShade: colorCodes[index % 3],
    //         ),
    //       );
    //     },
    //     separatorBuilder: (context, index) => Divider(),
    //   ),
    // );
//   }
// }

// class ProductItem {
//   final String name;
//   final String price;
//   final int colorShade;

//   const ProductItem(
//       {Key? key,
//       required this.name,
//       required this.price,
//       required this.colorShade});
// }

// class ProductTile extends StatelessWidget {
//   //กล่อง
//   final ProductItem item;
//   const ProductTile({Key? key, required this.item}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => ProductDetail(item: item),
//           ),
//         );
//       },
//       child: Container(
//         height: 100,
//         color: Colors.amber[item.colorShade],
//         child: Center(
//           child: Text('Entry ${item.name}'),
//         ),
//       ),
//     );
//   }
// }

// class ProductDetail extends StatelessWidget {
//   final ProductItem item;

//   const ProductDetail({Key? key, required this.item}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Product Detail'),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Text('Product Name: ${item.name}'),
//           Text('Price: ${item.price}'),
//         ],
//       ),
//     );
//   }
// }

