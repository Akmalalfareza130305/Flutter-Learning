import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'pages/tasks_page.dart';

void main() => runApp(const LearningDashboardApp());

class LearningDashboardApp extends StatelessWidget {
  const LearningDashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mahasiswa Pintar',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Quicksand',
        scaffoldBackgroundColor:
            const Color.fromARGB(255, 250, 245, 210),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6E61E9),
        ),
      ),
      home: const DashboardPage(),
    );
  }
}

// ============================================================
// DASHBOARD PAGE
// ============================================================

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int selectedNav = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final compact = constraints.maxWidth < 760;

            return Row(
              children: [
                // ==================================================
                // NAVIGASI DESKTOP
                // ==================================================

                if (!compact)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: SizedBox(
                        width: 72,
                        height:
                            (constraints.maxHeight - 36).clamp(360.0, 560.0),
                        child: _PencilNavBar(
                          vertical: true,
                          selected: selectedNav,
                          onSelect: (i) {
                            setState(() {
                              selectedNav = i;
                            });
                            if (i == 1) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const TasksPage(),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ),

                // ==================================================
                // KONTEN UTAMA
                // ==================================================

                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(
                      compact ? 18 : 34,
                      26,
                      compact ? 18 : 34,
                      34,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const _TopBar(compact: false),

                        const SizedBox(height: 28),

                        // SAPAAN
                        Text(
                          'Good morning, Akmal 👋',
                          style: TextStyle(
                            fontSize: compact ? 26 : 34,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF242230),
                          ),
                        ),

                        const SizedBox(height: 7),

                        Text(
                          'Keep learning and make progress every day.',
                          style: TextStyle(
                            color: Colors.black.withOpacity(.5),
                            fontSize: 15,
                          ),
                        ),

                        const SizedBox(height: 25),

                        // ==================================================
                        // PROGRESS PERKULIAHAN
                        // ==================================================

                        _HeroProgress(compact: compact),

                        const SizedBox(height: 24),

                        // ==================================================
                        // TUGAS & TARGET
                        // ==================================================

                        const _SectionTitle(
                          title: 'Tugas & Target',
                          action: 'View all',
                        ),

                        const SizedBox(height: 14),

                        _PlanGrid(compact: compact),

                        const SizedBox(height: 28),

                        // ==================================================
                        // TUGAS TERBARU
                        // ==================================================

                        const _SectionTitle(
                          title: 'Tugas Terbaru',
                          action: 'See all',
                        ),

                        const SizedBox(height: 14),

                        _CourseRow(compact: compact),

                        const SizedBox(height: 28),

                        // ==================================================
                        // TARGET HARI INI
                        // ==================================================

                        const _SectionTitle(
                          title: 'Target Hari Ini',
                          action: 'View all',
                        ),

                        const SizedBox(height: 14),

                        _TodayTarget(),

                        const SizedBox(height: 20),

                        // ==================================================
                        // MOTIVASI
                        // ==================================================

                        _MotivationCard(),
                      ],
                    ),
                  ),
                ),

                // ==================================================
                // PANEL KANAN
                // ==================================================

                if (!compact) const SizedBox(width: 28),

                if (!compact) const _RightPanel(),
              ],
            );
          },
        ),
      ),

      // ============================================================
      // NAVIGASI MOBILE
      // ============================================================

      bottomNavigationBar:
          MediaQuery.sizeOf(context).width < 760
              ? _PencilNavBar(
                selected: selectedNav,
                onSelect: (i) {
                  setState(() {
                    selectedNav = i;
                  });
                  if (i == 1) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TasksPage(),
                      ),
                    );
                  }
                },
              )
              : null,
    );
  }
}

// ============================================================
// PENCIL NAVIGATION BAR
// ============================================================

class _PencilNavBar extends StatelessWidget {
  final int selected;
  final ValueChanged<int> onSelect;
  final bool vertical;

  const _PencilNavBar({
    required this.selected,
    required this.onSelect,
    this.vertical = false,
  });

  static const _items = [
    (
      Icons.home_outlined,
      Icons.home,
      'Home',
    ),
    (
      Icons.assignment_outlined,
      Icons.assignment,
      'Tasks',
    ),
    (
      Icons.bar_chart_outlined,
      Icons.bar_chart,
      'Progress',
    ),
    (
      Icons.person_outline,
      Icons.person,
      'Profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final axis = vertical ? Axis.vertical : Axis.horizontal;

    final pencil = Container(
      height: vertical ? null : 66,
      width: vertical ? 72 : null,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .18),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Flex(
        direction: axis,
        children: [
          // ==================================================
          // 1. PENGHAPUS
          // ==================================================

          Container(
            width: vertical ? null : 28,
            height: vertical ? 28 : null,
            decoration: BoxDecoration(
              color: const Color(0xFFFF9B9C),
              borderRadius:
                  vertical
                      ? const BorderRadius.vertical(
                        top: Radius.circular(20),
                      )
                      : const BorderRadius.horizontal(
                        left: Radius.circular(20),
                      ),
            ),
          ),

          // ==================================================
          // 2. RING LOGAM
          // ==================================================

          Container(
            width: vertical ? null : 16,
            height: vertical ? 16 : null,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin:
                    vertical
                        ? Alignment.centerLeft
                        : Alignment.topCenter,
                end:
                    vertical
                        ? Alignment.centerRight
                        : Alignment.bottomCenter,
                colors: const [
                  Color(0xFF9E9EA8),
                  Color(0xFFE4E4EA),
                  Color(0xFF9E9EA8),
                ],
              ),
            ),
            child: Flex(
              direction: axis,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                3,
                (_) => Container(
                  width: vertical ? null : 1.5,
                  height: vertical ? 1.5 : null,
                  color: Colors.black.withValues(alpha: .18),
                ),
              ),
            ),
          ),

          // ==================================================
          // 3. BADAN PENSIL
          // ==================================================

          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin:
                      vertical
                          ? Alignment.centerLeft
                          : Alignment.topCenter,
                  end:
                      vertical
                          ? Alignment.centerRight
                          : Alignment.bottomCenter,
                  stops: const [0, .18, .5, .82, 1],
                  colors: const [
                    Color(0xFFE2AE3C),
                    Color(0xFFF6D56A),
                    Color(0xFFFBE58C),
                    Color(0xFFF6D56A),
                    Color(0xFFE2AE3C),
                  ],
                ),
              ),
              child: Flex(
                direction: axis,
                children: List.generate(_items.length, (i) {
                  final item = _items[i];
                  final active = selected == i;

                  return Expanded(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => onSelect(i),
                      child: Center(
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color:
                                active
                                    ? const Color(0xFF6E61E9)
                                    : Colors.transparent,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                active ? item.$2 : item.$1,
                                size: 22,
                                color:
                                    active
                                        ? Colors.white
                                        : const Color(0xFF5A4A1A),
                              ),

                              const SizedBox(height: 2),

                              Text(
                                item.$3,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800,
                                  color:
                                      active
                                          ? Colors.white
                                          : const Color(0xFF5A4A1A),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),

          // ==================================================
          // 4. UJUNG PENSIL
          // ==================================================

          SizedBox(
            width: vertical ? 72 : 50,
            height: vertical ? 50 : 66,
            child: CustomPaint(
              painter: _PencilTipPainter(
                vertical: vertical,
              ),
            ),
          ),
        ],
      ),
    );

    if (vertical) {
      return pencil;
    }

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 10),
        child: pencil,
      ),
    );
  }
}

// ============================================================
// PENCIL TIP
// ============================================================

class _PencilTipPainter extends CustomPainter {
  final bool vertical;

  const _PencilTipPainter({
    this.vertical = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double w = size.width;
    double h = size.height;

    if (vertical) {
      canvas.translate(size.width, 0);
      canvas.rotate(math.pi / 2);

      w = size.height;
      h = size.width;
    }

    // Kayu
    final wood =
        Path()
          ..moveTo(0, 0)
          ..lineTo(w, h / 2)
          ..lineTo(0, h)
          ..close();

    canvas.drawPath(
      wood,
      Paint()..color = const Color(0xFFF3D3A2),
    );

    // Bayangan kayu
    final shade =
        Path()
          ..moveTo(0, h / 2)
          ..lineTo(w, h / 2)
          ..lineTo(0, h)
          ..close();

    canvas.drawPath(
      shade,
      Paint()
        ..color = const Color(0xFFE2B87F).withValues(alpha: .6),
    );

    // Grafit
    final gx = w * .68;
    final gh = h * .5 * (1 - .68);

    final lead =
        Path()
          ..moveTo(gx, h / 2 - gh)
          ..lineTo(w, h / 2)
          ..lineTo(gx, h / 2 + gh)
          ..close();

    canvas.drawPath(
      lead,
      Paint()..color = const Color(0xFF25242D),
    );
  }

  @override
  bool shouldRepaint(
    covariant _PencilTipPainter old,
  ) {
    return old.vertical != vertical;
  }
}

// ============================================================
// TOP BAR
// ============================================================

class _TopBar extends StatelessWidget {
  final bool compact;

  const _TopBar({
    required this.compact,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (compact)
          const Icon(
            Icons.grid_view_rounded,
            color: Color(0xFF403C52),
          ),

        if (compact)
          const SizedBox(width: 14),

        const Spacer(),

        // Notifikasi
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.notifications_none_rounded,
            color: Color(0xFF403C52),
          ),
        ),

        const SizedBox(width: 6),

        // Foto/profile
        const CircleAvatar(
          radius: 20,
          backgroundColor: Color(0xFFFFC3AD),
          child: Icon(
            Icons.person,
            color: Colors.white,
          ),
        ),

        if (!compact) ...[
          const SizedBox(width: 10),

          const Text(
            'Akmal',
            style: TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(width: 5),

          const Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 18,
          ),
        ],
      ],
    );
  }
}

// ============================================================
// HERO PROGRESS
// ============================================================

class _HeroProgress extends StatelessWidget {
  final bool compact;

  const _HeroProgress({
    required this.compact,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF6F64E7),
            Color(0xFF8C75EE),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(27),
      ),
      child:
          compact
              ? _heroContent()
              : Row(
                children: [
                  _heroContent(),
                  const Spacer(),
                  const SizedBox(
                    width: 230,
                    height: 135,
                    child: CustomPaint(
                      painter: _ChartPainter(),
                    ),
                  ),
                ],
              ),
    );
  }

  Widget _heroContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Your progress',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),

        const SizedBox(height: 9),

        const Text(
          '78%',
          style: TextStyle(
            color: Colors.white,
            fontSize: 48,
            fontWeight: FontWeight.w800,
          ),
        ),

        const SizedBox(height: 8),

        const Text(
          'Average progress this month',
          style: TextStyle(
            color: Colors.white70,
          ),
        ),

        const SizedBox(height: 18),

        SizedBox(
          width: 190,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: const LinearProgressIndicator(
              value: .78,
              minHeight: 9,
              backgroundColor: Colors.white24,
              color: Color(0xFFFFCE72),
            ),
          ),
        ),
      ],
    );
  }
}

// ============================================================
// CHART
// ============================================================

class _ChartPainter extends CustomPainter {
  const _ChartPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.white.withOpacity(.7)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 4;

    final path =
        Path()
          ..moveTo(0, 104)
          ..cubicTo(
            30,
            45,
            54,
            126,
            82,
            72,
          )
          ..cubicTo(
            112,
            15,
            137,
            94,
            166,
            47,
          )
          ..cubicTo(
            187,
            16,
            212,
            35,
            size.width,
            10,
          );

    canvas.drawPath(path, paint);

    for (var x = 0; x < 6; x++) {
      canvas.drawLine(
        Offset(x * 45, 0),
        Offset(x * 45, size.height),
        Paint()
          ..color = Colors.white.withOpacity(.08),
      );
    }
  }

  @override
  bool shouldRepaint(
    covariant CustomPainter oldDelegate,
  ) {
    return false;
  }
}

// ============================================================
// SECTION TITLE
// ============================================================

class _SectionTitle extends StatelessWidget {
  final String title;
  final String action;

  const _SectionTitle({
    required this.title,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w800,
            color: Color(0xFF282533),
          ),
        ),

        const Spacer(),

        Text(
          action,
          style: const TextStyle(
            color: Color(0xFF7165DF),
            fontWeight: FontWeight.w700,
          ),
        ),

        const Icon(
          Icons.chevron_right_rounded,
          color: Color(0xFF7165DF),
        ),
      ],
    );
  }
}

// ============================================================
// TUGAS & TARGET GRID
// ============================================================

class _PlanGrid extends StatelessWidget {
  final bool compact;

  const _PlanGrid({
    required this.compact,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      (
        'Tugas Kuliah',
        '3 tugas aktif',
        Icons.assignment_outlined,
        const Color(0xFFFFC8B9),
      ),
      (
        'Skripsi',
        '2 target aktif',
        Icons.menu_book_outlined,
        const Color(0xFFBFE6DD),
      ),
      (
        'Target Mingguan',
        '4 target',
        Icons.flag_outlined,
        const Color(0xFFF8D779),
      ),
    ];

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: compact ? 1 : 3,
      crossAxisSpacing: 14,
      mainAxisSpacing: 14,
      childAspectRatio: compact ? 3.2 : 1.35,
      children:
          items
              .map(
                (item) => _PlanCard(
                  title: item.$1,
                  lessons: item.$2,
                  icon: item.$3,
                  color: item.$4,
                ),
              )
              .toList(),
    );
  }
}

// ============================================================
// PLAN CARD
// ============================================================

class _PlanCard extends StatelessWidget {
  final String title;
  final String lessons;
  final IconData icon;
  final Color color;

  const _PlanCard({
    required this.title,
    required this.lessons,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(23),
      ),
      child: Row(
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: .65),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF302D3B),
            ),
          ),

          const SizedBox(width: 13),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  lessons,
                  style: TextStyle(
                    color: Colors.black.withValues(alpha: .55),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          const Icon(
            Icons.arrow_outward_rounded,
            size: 18,
          ),
        ],
      ),
    );
  }
}

// ============================================================
// TUGAS TERBARU
// ============================================================

class _CourseRow extends StatelessWidget {
  final bool compact;

  const _CourseRow({
    required this.compact,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 205,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: const [
          _CourseCard(
            color: Color(0xFFFFB16E),
            title: 'Revisi BAB 1\nSkripsi',
            category: 'SKRIPSI',
            progress: '80%',
          ),

          SizedBox(width: 14),

          _CourseCard(
            color: Color(0xFF99A4F5),
            title: 'Tugas Flutter\nProject',
            category: 'PEMROGRAMAN',
            progress: '60%',
          ),

          SizedBox(width: 14),

          _CourseCard(
            color: Color(0xFFF6D56A),
            title: 'Presentasi\nProyek',
            category: 'PERKULIAHAN',
            progress: '35%',
          ),
        ],
      ),
    );
  }
}

// ============================================================
// COURSE / TASK CARD
// ============================================================

class _CourseCard extends StatelessWidget {
  final Color color;
  final String title;
  final String category;
  final String progress;

  const _CourseCard({
    required this.color,
    required this.title,
    required this.category,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 245,
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
                Icons.school_rounded,
                size: 19,
              ),

              const Spacer(),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 9,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.55),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  progress,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),

          const Spacer(),

          Text(
            category,
            style: TextStyle(
              fontSize: 9,
              letterSpacing: 1,
              color: Colors.black.withOpacity(.55),
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 17,
              height: 1.08,
            ),
          ),

          const SizedBox(height: 13),

          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: LinearProgressIndicator(
              value:
                  double.parse(
                    progress.replaceAll('%', ''),
                  ) /
                  100,
              minHeight: 6,
              backgroundColor: Colors.white38,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// TARGET HARI INI
// ============================================================

class _TodayTarget extends StatelessWidget {
  const _TodayTarget();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.72),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          _TargetItem(
            title: 'Membaca materi Flutter',
            completed: true,
          ),

          const SizedBox(height: 10),

          _TargetItem(
            title: 'Menyelesaikan revisi BAB 1',
            completed: false,
          ),

          const SizedBox(height: 10),

          _TargetItem(
            title: 'Membuat tugas pemrograman',
            completed: false,
          ),
        ],
      ),
    );
  }
}

// ============================================================
// TARGET ITEM
// ============================================================

class _TargetItem extends StatelessWidget {
  final String title;
  final bool completed;

  const _TargetItem({
    required this.title,
    required this.completed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 13,
        vertical: 11,
      ),
      decoration: BoxDecoration(
        color:
            completed
                ? const Color(0xFFE6F4ED)
                : const Color(0xFFF5F2E8),
        borderRadius: BorderRadius.circular(17),
      ),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color:
                  completed
                      ? const Color(0xFF6E61E9)
                      : Colors.white,
              shape: BoxShape.circle,
            ),
            child:
                completed
                    ? const Icon(
                      Icons.check,
                      size: 17,
                      color: Colors.white,
                    )
                    : null,
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color:
                    completed
                        ? Colors.black54
                        : const Color(0xFF302D3B),
                decoration:
                    completed
                        ? TextDecoration.lineThrough
                        : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// MOTIVATION CARD
// ============================================================

class _MotivationCard extends StatelessWidget {
  const _MotivationCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFE6F4ED),
        borderRadius: BorderRadius.circular(23),
      ),
      child: const Row(
        children: [
          Icon(
            Icons.auto_awesome_rounded,
            size: 25,
          ),

          SizedBox(width: 12),

          Expanded(
            child: Text(
              'Sedikit demi sedikit, yang penting selesai.',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// RIGHT PANEL - DEADLINE
// ============================================================

class _RightPanel extends StatelessWidget {
  const _RightPanel();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 290,
      margin: const EdgeInsets.only(
        top: 96,
        right: 26,
        bottom: 25,
      ),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.72),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Deadline Terdekat',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            'Jangan sampai lupa targetmu',
            style: TextStyle(
              color: Colors.black.withOpacity(.5),
            ),
          ),

          const SizedBox(height: 20),

          // ==================================================
          // DEADLINE 1
          // ==================================================

          const _DeadlineTile(
            deadline: '2 hari',
            name: 'Revisi BAB 1',
            progress: '80%',
            color: Color(0xFFFF9B9C),
          ),

          const SizedBox(height: 10),

          // ==================================================
          // DEADLINE 2
          // ==================================================

          const _DeadlineTile(
            deadline: '5 hari',
            name: 'Tugas Flutter',
            progress: '60%',
            color: Color(0xFFB9B5F3),
          ),

          const SizedBox(height: 10),

          // ==================================================
          // DEADLINE 3
          // ==================================================

          const _DeadlineTile(
            deadline: '8 hari',
            name: 'Presentasi Proyek',
            progress: '35%',
            color: Color(0xFFF4D268),
          ),

          const Spacer(),

          // ==================================================
          // TOTAL TARGET
          // ==================================================

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFE6F4ED),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.task_alt_rounded,
                ),

                SizedBox(width: 10),

                Expanded(
                  child: Text(
                    '3 tugas sedang dikerjakan\nTetap semangat!',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// DEADLINE TILE
// ============================================================

class _DeadlineTile extends StatelessWidget {
  final String deadline;
  final String name;
  final String progress;
  final Color color;

  const _DeadlineTile({
    required this.deadline,
    required this.name,
    required this.progress,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(17),
      ),
      child: Row(
        children: [
          // WAKTU DEADLINE
          Container(
            width: 52,
            padding: const EdgeInsets.symmetric(
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.55),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Text(
                  deadline,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                  ),
                ),

                const Text(
                  'lagi',
                  style: TextStyle(
                    fontSize: 9,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 11),

          // NAMA TUGAS
          Expanded(
            child: Text(
              name,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ),

          // PROGRESS
          Text(
            progress,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}