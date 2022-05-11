import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class EmailHelper {
  Future SendEmailLeave(String _recipient,String _firstname,String _lastname) async {
    String username = 'panita.tharaphom@gmail.com';
    String password = 'panita02';
    final smtpServer = gmail(username, password);
    String? msg;

    

    final message = Message()
      ..from = Address(username, 'GHB Time Management')
      ..recipients.add(username) // _recipient บังคับให้ส่งแค่อีเมล์นี้
      ..subject = 'แจ้งเตือนการอนุมัติการลาของ'+ '${_firstname}'+'  '+'${_lastname}'
      ..text = msg;

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }

   Future SendEmailDelegate(String _recipientdelagate,String _firstname,String _lastname,DateTime fromDate,
                                                         DateTime toDate,String leavetype,String delegatename) async {
    String username = 'panita.tharaphom@gmail.com';
    String password = 'panita02';
    final smtpServer = gmail(username, password);
    String? msg;

    
            
    final message = Message()
      ..from = Address(username, 'GHB Time Management')
      ..recipients.add(username) // _recipient บังคับให้ส่งแค่อีเมล์นี้
      ..subject = 'แจ้งเตือนการมอบหมายปฏิบัติหน้าที่แทนของ'+ '${_firstname}'+'  '+'${_lastname}'
      ..text = 'ประเภทลา '+'${leavetype}'+' วันที่ลา '+ '${fromDate.day}'+'/'+ '${fromDate.month}'+ '/'+'${fromDate.year} ถึงวันที่ '+
       '${toDate.day}'+'/'+ '${toDate.month}'+ '/'+'${toDate.year} โดยระหว่างการลามอบหมายให้คุณ' +'${delegatename} ปฏิบัติหน้าที่แทน';

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }





  
}
