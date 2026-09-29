import 'package:flutter/material.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 245, 210),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Tasks',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Color(0xFF282533),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            const Text(
              'Keep your tasks organized.',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black54,
              ),
            ),

            const SizedBox(height: 24),

            _TaskCard(
              title: 'Revisi BAB 1',
              category: 'Skripsi',
              deadline: '2 hari lagi',
              progress: 0.8,
              color: const Color(0xFFFFB16E),
            ),

            const SizedBox(height: 14),

            _TaskCard(
              title: 'Tugas Flutter',
              category: 'Pemrograman',
              deadline: '5 hari lagi',
              progress: 0.6,
              color: const Color(0xFF99A4F5),
            ),

            const SizedBox(height: 14),

            _TaskCard(
              title: 'Presentasi Proyek',
              category: 'Perkuliahan',
              deadline: '8 hari lagi',
              progress: 0.35,
              color: const Color(0xFFF6D56A),
            ),
          ],
        ),
      ),
    );
  }
}

class _TaskCard extends StatelessWidget {
  final String title;
  final String category;
  final String deadline;
  final double progress;
  final Color color;

  const _TaskCard({
    required this.title,
    required this.category,
    required this.deadline,
    required this.progress,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.assignment_rounded,
                size: 20,
              ),

              const SizedBox(width: 8),

              Text(
                category.toUpperCase(),
                style: TextStyle(
                  fontSize: 10,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w700,
                  color: Colors.black.withOpacity(.55),
                ),
              ),

              const Spacer(),

              Text(
                deadline,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          Text(
            title,
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w800,
            ),
          ),

          const SizedBox(height: 14),

          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 7,
              backgroundColor: Colors.white38,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            '${(progress * 100).toInt()}% selesai',
            style: TextStyle(
              fontSize: 11,
              color: Colors.black.withOpacity(.55),
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}