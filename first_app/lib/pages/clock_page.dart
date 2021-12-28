
import 'package:first_app/Screen/components/body.dart';
import 'package:first_app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class clock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // we have to call this on our starting page
    SizeConfig().init(context);
    return Scaffold(
       appBar: AppBar(
          title: Text(
        "บันทึกเวลาปฏิบัติงาน",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      )),
      
      body: Body(),
    );
  }

  // AppBar buildAppBar(BuildContext context) {
  //   return AppBar(title: Text("บันทึกเวลาทำงาน"),
  //     leading: IconButton(
  //       icon: SvgPicture.asset(
  //         "assets/icons/Settings.svg",
  //         color: Theme.of(context).iconTheme.color,
  //       ),
  //       onPressed: () {



          
  //       },
  //     ),
  //     actions: [buildAddButton(context)],
  //   );
  // }

  Padding buildAddButton(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
      child: InkWell(
        onTap: () {},
        child: Container(
          width: getProportionateScreenWidth(32),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}