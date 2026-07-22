import '../models/exercise.dart';

class ExerciseService {
  static List<Exercise> getExercises() {
    return [

      Exercise(
        title: "Chin Tucks",
        description: "Corrects forward head posture.",
        image: "assets/exercises/chin_tuck.png",
        duration: "5 min",
        repetitions: "3 × 10",
        steps: [
          "Stand straight.",
          "Keep shoulders relaxed.",
          "Pull your chin backward.",
          "Hold for 5 seconds.",
          "Relax slowly.",
        ],
      ),

      Exercise(
        title: "Wall Angels",
        description: "Improves shoulder alignment.",
        image: "assets/exercises/wall_angel.png",
        duration: "5 min",
        repetitions: "3 × 12",
        steps: [
          "Stand against a wall.",
          "Raise your arms.",
          "Slide them upward.",
          "Return slowly.",
        ],
      ),

      Exercise(
        title: "Shoulder Rolls",
        description: "Relieves shoulder stiffness.",
        image: "assets/exercises/shoulder_roll.png",
        duration: "3 min",
        repetitions: "20 Rolls",
        steps: [
          "Lift shoulders.",
          "Roll backwards.",
          "Repeat smoothly.",
        ],
      ),

      Exercise(
        title: "Doorway Stretch",
        description: "Opens tight chest muscles.",
        image: "assets/exercises/stretch.png",
        duration: "5 min",
        repetitions: "3 Sets",
        steps: [
          "Stand in doorway.",
          "Place hands on frame.",
          "Lean forward.",
          "Hold 30 seconds.",
        ],
      ),

      Exercise(
        title: "Upper Trap Stretch",
        description: "Reduces neck tension.",
        image: "assets/exercises/trap.png",
        duration: "5 min",
        repetitions: "3 × 30 sec",
        steps: [
          "Sit straight.",
          "Tilt head sideways.",
          "Use hand gently.",
          "Hold.",
        ],
      ),

    ];
  }
}