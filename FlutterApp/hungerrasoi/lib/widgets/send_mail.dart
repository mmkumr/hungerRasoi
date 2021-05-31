//Email: tmcare@gmail.com
//Password: uynuggaxgbnehjyg
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:flutter/material.dart';

class Mail{

    Future<bool>sendMail(String subject, String recipient, String text, String html)async{
        String username = 'titanicmarketcare@gmail.com';
        String password = 'uynuggaxgbnehjyg';
        final smtpServer = gmail(username, password);

        final message = Message()
            ..from = Address(username, 'TitanicMarket')
            ..recipients.add(recipient)
            //..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
            ..bccRecipients.add(Address(username))
            ..subject = subject
            ..text = text
            ..html = html;
        try {
            final sendReport = await send(message, smtpServer);
            print('Message sent: ' + sendReport.toString());
            return true;
        } on MailerException catch (e) {
            print('Message not sent.');
            for (var p in e.problems) {
                print('Problem: ${p.code}: ${p.msg}');
            }
            return false;
        }

    }
}