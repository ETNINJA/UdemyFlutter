import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';

import '../providers/orders.dart' as ord; //due to name clash

class OrderItem extends StatefulWidget {
  final ord.OrderItem order;

  const OrderItem(this.order);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('\$${widget.order.amount}'),
            subtitle: Text(
              DateFormat('dd/MM/yyyy  hh:mm').format(widget.order.dateTime),
            ),
            trailing: IconButton(
                icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                }),
          ),
          //if (_expanded)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              height: min(widget.order.products.length * 20.0 + 40, 200),
              child: ListView(
                children: widget.order.products
                    .map((prod) => Column(
                      children: <Widget>[
                        Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  prod.title,
                                  style: TextStyle(
                                      fontSize: 14, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '${prod.quantity} x \$${prod.price}',
                                  style:
                                      TextStyle(fontSize: 14, color: Colors.grey),
                                  textAlign: TextAlign.right,
                                ),                            
                                //draw a line here for estetics                            
                              ],
                            ),
                            Divider(),
                      ],
                    ),
                    )                        
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }
}
