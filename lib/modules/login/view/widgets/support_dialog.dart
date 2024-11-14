import 'package:flutter/material.dart';

supportDialog(context) => showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      title: Text('Support'),
      contentPadding: EdgeInsets.all(10),
      content:   Column(
        mainAxisSize: MainAxisSize.min,
    
            children: [
      ListTile(
        title: Text('Contact Over Call'),
        subtitle: Text('Call our customer support'),
        leading: Icon(Icons.call),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () {},
      ),
      ListTile(
        title: Text('Contact Over WhatsApp'),
        subtitle: Text('Message our customer support'),
        leading: Icon(Icons.wechat),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () {},
      )
            ],
          ),
    ));
