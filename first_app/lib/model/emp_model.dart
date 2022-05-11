class APIEmployee {
   final String? emp_code;
   final String? fname;
   final String? lname;
   final String? position_name;
   final String? email;
   final String? tel;
   final String? group_code;
   final String? group_name;
   final String? field_code;
   final String? field_name;
   final String? dept_code;
   final String? dept_name;
   final String? center_code;
   final String? center_name;
   final String? zone_code;
   final String? zone_name;
   final String? division_code;
   final String? division_name;
   final String? sol_code;
   final String? sol_name;
   final String? stop_date;
  final String? grade;

  APIEmployee(
    this.emp_code,
    this.fname,
    this.lname,
    this.position_name,
    this.email,
    this.tel,
    this.group_code,
    this.group_name,
    this.field_code,
    this.field_name,
    this.dept_code,
    this.dept_name,
    this.center_code,
    this.center_name,
    this.zone_code,
    this.zone_name,
    this.division_code,
    this.division_name,
    this.sol_code,
    this.sol_name,
   this.stop_date,
    this.grade,
    );

  factory APIEmployee.fromJson(Map<String, dynamic> json) {
    return APIEmployee(
      json['emp_code'] == null ? null : json["emp_code"] as String,
      json['fname'] == null ? null : json["fname"] as String,
      json['lname'] == null ? null : json["lname"] as String,
      json['position_name'] == null ? null : json["position_name"] as String,
      json['email'] == null ? null : json["email"] as String,
      json['tel'] == null ? null : json["tel"] as String,
      json['group_code'] == null ? null : json["group_code"] as String,
      json['group_name'] == null ? null : json["group_name"] as String,
      json['field_code'] == null ? null : json["field_code"] as String,
      json['field_name'] == null ? null : json["field_name"] as String,
      json['dept_code'] == null ? null : json["dept_code"] as String,
      json['dept_name'] == null ? null : json["dept_name"] as String,
      json['center_code'] == null ? null : json["center_code"] as String,
      json['center_name'] == null ? null : json["center_name"] as String,
      json['zone_code'] == null ? null : json["zone_code"] as String,
      json['zone_name'] == null ? null : json["zone_name"] as String,
      json['division_code'] == null ? null : json["division_code"] as String,
      json['division_name'] == null ? null : json["division_name"]! as String,
      json['sol_code'] == null ? null : json["sol_code"] as String,
      json['sol_name'] == null ? null : json["sol_name"] as String,
      json['stop_date'] == null ? null : json["stop_date"]! as String,
       json['grade'] == null ? null : json["grade"] as String,
      // emp_code: json["emp_code"],
      // fname: json['fname'],
      // lname : json['lname'],
      // position_name: json['position_name'],
      // email: json['email'],
      // tel: json['tel'],
      // group_code: json['group_code'],
      // group_name : json['group_name'],
      // field_code: json['field_code'],
      // field_name: json['field_name'],
      // dept_code: json['dept_code'],
      // dept_name: json['dept_name'],
      // center_code : json['center_code'],
      // center_name: json['center_name'],
      // zone_code: json['zone_code'],
      // zone_name: json['zone_name'],
      // division_code: json['division_code'],
      // division_name : json['division_name'],
      // sol_code: json['sol_code'],
      // sol_name: json['sol_name'],
      // stop_date: json['stop_date'],
    );
  }
}
