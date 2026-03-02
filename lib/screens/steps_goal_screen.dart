import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StepsGoalScreen extends StatefulWidget {
  const StepsGoalScreen({super.key});

  @override
  State<StepsGoalScreen> createState() => _StepsGoalScreenState();
}

class _StepsGoalScreenState extends State<StepsGoalScreen> {
  double goal = 8000;

  @override
  void initState() {
    super.initState();
    _loadGoal();
  }

  Future<void> _loadGoal() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      goal = (prefs.getInt('steps_goal') ?? 8000).toDouble();
    });
  }

  Future<void> _saveGoal() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('steps_goal', goal.toInt());
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Цель шагов')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ТЕКУЩАЯ ЦЕЛЬ
            Text(
              '${goal.toInt()} шагов',
              style: Theme.of(
                context,
              ).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Минимум для поддержания серии',
              style: Theme.of(context).textTheme.bodyMedium,
            ),

            const SizedBox(height: 32),

            /// SLIDER
            Slider(
              min: 3000,
              max: 20000,
              divisions: 17,
              label: goal.toInt().toString(),
              value: goal,
              onChanged: (v) => setState(() => goal = v),
            ),

            const Spacer(),

            /// SAVE BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveGoal,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text('Сохранить', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
