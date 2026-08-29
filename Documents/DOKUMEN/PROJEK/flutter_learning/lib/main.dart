import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Mahasiswa Pintar',
    theme: ThemeData(
      useMaterial3: true,
      fontFamily: 'Quicksand',
      scaffoldBackgroundColor:
          Color.fromARGB(255, 250, 245, 210),
      colorScheme: ColorScheme.fromSeed(
        seedColor: Color(0xFF6E61E9),
      ),
    ),
    home: const HalamanBeranda(),
  ));
}

class HalamanBeranda extends StatefulWidget {
  const HalamanBeranda({super.key});

  @override
  State<HalamanBeranda> createState() => _HalamanBerandaState();
}

class _HalamanBerandaState extends State<HalamanBeranda> {
  int selectedNav= 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final compact = constraints.maxWidth < 760;

            return Row(
              children: [
                if (!compact)
                _SideNavigation(
                  selected: selectedNav,
                  onSelect: (i)=> setState(() => selectedNav = i),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(
                      compact ? 18 : 34,
                      26,
                      compact ? 18 : 34,
                      34
                    ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _TopBar(compact: compact),

                      const SizedBox(height: 28),

                      Text(
                        'Selamat Pagi Akmal',
                        style: TextStyle(
                          fontSize: compact ? 26 : 34,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xff242230),
                        ),
                      ),
                      const SizedBox(height: 7),

                      Text(
                        'Pantau Progres Kuliahmu dan Tugasmu Setiap Hari.',
                        style: TextStyle(
                          color: Colors.black.withOpacity(.5),
                            fontSize: 15,
                        ),
                      ),
                      
                      const SizedBox(height: 25),

                      _HeroProgress(compact: compact),

                      const SizedBox(height: 24),

                      _SectionTitle(
                        Title: 'Tugas dan Target',
                        Action: 'Lihat Semua',
                      ),

                      const SizedBox(height: 14,),

                      _PlanGrid(compact: compact),

                      const SizedBox(height: 28),

                        _SectionTitle(
                          title: 'Tugas Terbaru',
                          action: 'See all',
                        ),

                        const SizedBox(height: 14),

                        _CourseRow(compact: compact),
                      ],
                    ),
                  ),
                ),
                if (!compact) const SizedBox(width: 28),

                if (!compact) const _RightPanel(),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar:
      MediaQuery.sizeOf(context).width < 760
      ? NavigationBar(
        selectedIndex: selectedNav,
        backgroundColor: Colors.white,
        indicatorColor: const Color(0xFFE7E2FF),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Beranda',
          ),
          NavigationDestination(
            icon: Icon(Icons.assignment_outlined),
            selectedIcon: Icon(Icons.assignment),
            label: 'Tugas',
          ),
          NavigationDestination(
            icon: Icon(Icons.bar_chart_outlined),
            selectedIcon: Icon(Icons.bar_chart),
            label: 'Progres',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      )
      : null,
    );
  }
}
