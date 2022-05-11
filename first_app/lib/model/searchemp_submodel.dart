class SubAPIEmp {
 final String? empcode;
  final String? firstname;
  final String? lastname;
   final String? email;
  final  String? empcodemanager;
  final String? firstnamemanager;
  final String? lastnamemanager;
   final String? emailmanager;
  
  SubAPIEmp( this.empcode, this.firstname, this.lastname, this.email, this.empcodemanager
  , this.firstnamemanager, this.lastnamemanager, this.emailmanager);

  factory SubAPIEmp.fromJson(Map<String, dynamic> json) {
    return SubAPIEmp(
      json['emP_CODE'] == null ? null : json["emP_CODE"] as String,
      json['fnamE_T'] == null ? null : json["fnamE_T"] as String,
      json['lnamE_T'] == null ? null : json["lnamE_T"] as String,
      json['email'] == null ? null : json["email"] as String,
      json['msS_EMPCODE'] == null ? null : json["msS_EMPCODE"] as  String,
      json['msS_FIRSTNAME'] == null ? null : json["msS_FIRSTNAME"] as String,
      json['msS_LASTNAME'] == null ? null : json["msS_LASTNAME"] as String,
      json['msS_EMAIL'] == null ? null : json["msS_EMAIL"] as String,
      
    );
  }
}
  //{"data":{"status":true,"message":"พบข้อมูล","data":{"emP_CODE":"50872","fnamE_T":"ปณิตา","lnamE_T":"ธาราภูมิ","email":"PANITA.T@GHB.CO.TH","msS_EMPCODE":null,"msS_FIRSTNAME":null,"msS_LASTNAME":null,"msS_EMAIL":null}}}
  