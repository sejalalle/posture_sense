import 'package:flutter/material.dart';

import '../../models/exercise.dart';
import '../../services/exercise_service.dart';
import '../../widgets/exercise_card.dart';
import 'exercise_detail_screen.dart';

class ExercisesScreen extends StatelessWidget {
  ExercisesScreen({super.key});

  final List<Exercise> exercises =
      ExerciseService.getExercises();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Posture Exercises"),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: exercises.length,
        itemBuilder: (_, index) {
          final exercise = exercises[index];

          return Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: ExerciseCard(
              exercise: exercise,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ExerciseDetailScreen(
                      exercise: exercise,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}