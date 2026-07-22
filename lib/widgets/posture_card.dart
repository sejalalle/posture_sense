import 'package:flutter/material.dart';

class PostureCard extends StatelessWidget {

  final double angle;

  final String status;

  const PostureCard({

    super.key,

    required this.angle,
    required this.status,

  });

  @override
  Widget build(BuildContext context) {

    Color color;

    if(status=="Good"){

      color = Colors.green;

    }else if(status=="Moderate"){

      color = Colors.orange;

    }else{

      color = Colors.red;

    }

    return Card(

      elevation: 8,

      margin: const EdgeInsets.all(20),

      child: Padding(

        padding: const EdgeInsets.all(20),

        child: Column(

          mainAxisSize: MainAxisSize.min,

          children: [

            Text(

              "Neck Angle",

              style: TextStyle(
                fontSize: 18,
              ),

            ),

            const SizedBox(height:10),

            Text(

              "${angle.toStringAsFixed(1)}°",

              style: const TextStyle(

                fontSize: 36,
                fontWeight: FontWeight.bold,

              ),

            ),

            const SizedBox(height:20),

            Chip(

              label: Text(status),

              backgroundColor: color,

            ),

          ],

        ),

      ),

    );

  }

}