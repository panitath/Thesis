import 'searchemp_submodel.dart';

class APIEmp {
//  final int? empcode;
//   final String? firstname;
//   final String? lastname;
//    final String? email;
//   final int? empcodemanager;
//   final String? firstnamemanager;
//   final String? lastnamemanager;
//    final String? emailmanager;
//{"data":{"status":true,"message":"พบข้อมูล","data":{"emP_CODE":"50872","fnamE_T":"ปณิตา","lnamE_T":"ธาราภูมิ","email":"PANITA.T@GHB.CO.TH","msS_EMPCODE":null,"msS_FIRSTNAME":null,"msS_LASTNAME":null,"msS_EMAIL":null}}}
  
     final bool? status;
  final String? message;
  final SubAPIEmp? employee;
  APIEmp( this.status, this.message, this.employee);

  factory APIEmp.fromJson(Map<String, dynamic> json) {
    return APIEmp(
      json['status'] == null ? false : json["status"] as bool,
      json['message'] == null ? null : json["message"] as String,
       json['data'] == null ? null : SubAPIEmp.fromJson(json['data']),
     
   
      
    );
  }
}
  //{"data":{"status":true,"message":"พบข้อมูล","data":{"emP_CODE":"50872","fnamE_T":"ปณิตา","lnamE_T":"ธาราภูมิ","email":"PANITA.T@GHB.CO.TH","msS_EMPCODE":null,"msS_FIRSTNAME":null,"msS_LASTNAME":null,"msS_EMAIL":null}}}
  