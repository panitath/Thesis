import 'leave_model.dart';
import 'searchemp_model.dart';

class EmpAPIModel {

  final APIEmp? employee;
 
  //{"data":{"status":true,"message":"พบข้อมูล","data":{"emP_CODE":"50872","fnamE_T":"ปณิตา","lnamE_T":"ธาราภูมิ","email":"PANITA.T@GHB.CO.TH","msS_EMPCODE":null,"msS_FIRSTNAME":null,"msS_LASTNAME":null,"msS_EMAIL":null}}}
  
  //  "emP_CODE": "55947",
  //           "fnamE_T": "รณชัย",
  //           "lnamE_T": "จำศิล",
  //           "email": "RONACHAI.J@GHB.CO.TH",
  //           "msS_EMPCODE": null,
  //           "msS_FIRSTNAME": null,
  //           "msS_LASTNAME": null,
  //           "msS_EMAIL": null

  EmpAPIModel(this.employee);

  factory EmpAPIModel.fromJson(Map<String, dynamic> json) {
    return EmpAPIModel(
       json['data'] == null ? null : APIEmp.fromJson(json['data']),
    

     
    );
  }


}

