import 'package:flutter/material.dart';

import '../models/exercise.dart';

class ExerciseCard extends StatelessWidget {
  final Exercise exercise;
  final VoidCallback onTap;

  const ExerciseCard({
    super.key,
    required this.exercise,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return Card(

      elevation: 4,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),

      child: InkWell(

        borderRadius: BorderRadius.circular(18),

        onTap: onTap,

        child: Padding(

          padding: const EdgeInsets.all(16),

          child: Row(

            children: [

              Container(

                width: 70,
                height: 70,

                decoration: BoxDecoration(

                  color: Colors.blue.shade100,

                  borderRadius:
                      BorderRadius.circular(15),

                ),

                child: const Icon(
                  Icons.fitness_center,
                  size: 35,
                  color: Colors.blue,
                ),

              ),

              const SizedBox(width: 18),

              Expanded(

                child: Column(

                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    Text(

                      exercise.title,

                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),

                    ),

                    const SizedBox(height: 5),

                    Text(
                      exercise.description,
                    ),

                    const SizedBox(height: 8),

                    Text(
                      "${exercise.duration} • ${exercise.repetitions}",
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),

                  ],

                ),

              ),

              const Icon(Icons.arrow_forward_ios),

            ],

          ),

        ),

      ),

    );

  }

}