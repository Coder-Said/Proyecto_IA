import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const AutoDiagApp());
}

class AutoDiagApp extends StatelessWidget {
  const AutoDiagApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AutoDiag AI',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[50],
        cardColor: Colors.white,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFF121212),
        cardColor: const Color(0xFF1E1E1E),
      ),
      themeMode: ThemeMode.system, // Uses system theme
      home: const MainScreen(),
    );
  }
}

// -----------------------------------------------------------------
// MAIN NAVIGATION WRAPPER
// -----------------------------------------------------------------
class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const Center(child: Text("Historial")), // Placeholder
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Historial'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------
// 1. HOME / MAIN MENU SCREEN
// -----------------------------------------------------------------
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Inicio", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                  Text("Bienvenido a AutoDiag", style: TextStyle(color: Colors.grey)),
                ],
              ),
              const CircleAvatar(
                backgroundColor: Colors.grey,
                child: Icon(Icons.person, color: Colors.white),
              )
            ],
          ),
          const SizedBox(height: 24),

          // Current Vehicle Card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.blueAccent, Colors.blue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("VEHÍCULO ACTUAL", style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Text("Toyota Corolla", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                Row(
                  children: const [
                    Icon(Icons.calendar_today, color: Colors.white70, size: 16),
                    SizedBox(width: 4),
                    Text("2018", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                    SizedBox(width: 16),
                    Icon(Icons.speed, color: Colors.white70, size: 16),
                    SizedBox(width: 4),
                    Text("65,000 km", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                  ],
                )
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Main Action
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const DiagnosticStartScreen()));
            },
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                border: Border.all(color: Colors.blueAccent.withOpacity(0.5), width: 2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: Colors.blueAccent, borderRadius: BorderRadius.circular(50)),
                    child: const Icon(Icons.mic, color: Colors.white, size: 32),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("Escanear Motor", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text("Realizar diagnóstico acústico", style: TextStyle(color: Colors.grey, fontSize: 12)),
                    ],
                  )
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Grid Options
          Row(
            children: [
              Expanded(child: _buildGridButton(context, Icons.build, "Talleres Cercanos", Colors.orange, () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const WorkshopsScreen()));
              })),
              const SizedBox(width: 16),
              Expanded(child: _buildGridButton(context, Icons.help_outline, "Guía y Ayuda", Colors.green, () {})),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildGridButton(BuildContext context, IconData icon, String title, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.withOpacity(0.2)),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle),
              child: Icon(icon, color: color),
            ),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------
// 2. DIAGNOSTIC START SCREEN
// -----------------------------------------------------------------
class DiagnosticStartScreen extends StatelessWidget {
  const DiagnosticStartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).textTheme.bodyLarge?.color),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Listo para escanear", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              const Text(
                "Acerque el dispositivo al motor encendido en un entorno lo más silencioso posible.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 48),
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ListeningScreen()));
                },
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: const BoxDecoration(
                    color: Colors.blueAccent,
                    shape: BoxShape.circle,
                    boxShadow: [BoxShadow(color: Colors.blueAccent, blurRadius: 20, spreadRadius: 5)],
                  ),
                  child: const Icon(Icons.mic, color: Colors.white, size: 64),
                ),
              ),
              const SizedBox(height: 32),
              const Text("Tocar para escanear", style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------
// 3. LISTENING SCREEN (Simulated Analysis)
// -----------------------------------------------------------------
class ListeningScreen extends StatefulWidget {
  const ListeningScreen({Key? key}) : super(key: key);

  @override
  _ListeningScreenState createState() => _ListeningScreenState();
}

class _ListeningScreenState extends State<ListeningScreen> {
  @override
  void initState() {
    super.initState();
    // Simulate audio processing delay
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ResultScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text("Analizando acústica...", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blueAccent)),
            SizedBox(height: 16),
            Text("Mantenga el dispositivo estable y no apague el motor", style: TextStyle(color: Colors.grey)),
            SizedBox(height: 64),
            CircularProgressIndicator(strokeWidth: 6),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------
// 4. RESULT SCREEN
// -----------------------------------------------------------------
class ResultScreen extends StatelessWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Resultados", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).textTheme.bodyLarge?.color),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          // Result Card
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.redAccent.withOpacity(0.5), width: 2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(color: Colors.red.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
                  child: const Text("ANOMALÍA DETECTADA", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 10)),
                ),
                const SizedBox(height: 16),
                const Text("Holgura en correa", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                const Text(
                  "Se detectó un patrón acústico irregular en altas frecuencias comúnmente asociado al desgaste o falta de tensión en las correas.",
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Certeza del modelo AI", style: TextStyle(fontWeight: FontWeight.bold)),
                    const Text("87%", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.red)),
                  ],
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(value: 0.87, color: Colors.red, backgroundColor: Colors.grey[300], minHeight: 8),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Recommendation
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.orange.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Icon(Icons.warning_amber_rounded, color: Colors.orange),
                    SizedBox(width: 8),
                    Text("Recomendación", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange)),
                  ],
                ),
                const SizedBox(height: 8),
                const Text("Se sugiere revisión visual de la banda de accesorios y posible reemplazo para evitar ruptura mientras conduce.", style: TextStyle(color: Colors.orange)),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Schedule Action
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ScheduleScreen()));
            },
            icon: const Icon(Icons.build),
            label: const Text("Agendar Revisión Mecánica"),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Escanear nuevamente"),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            ),
          )
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------
// 5. PROFILE SCREEN
// -----------------------------------------------------------------
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          const Text("Perfil del Vehículo", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          _buildTextField("Marca", "Toyota"),
          const SizedBox(height: 16),
          _buildTextField("Modelo", "Corolla"),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _buildTextField("Año", "2018")),
              const SizedBox(width: 16),
              Expanded(child: _buildTextField("Cilindraje (L)", "1.8")),
            ],
          ),
          const SizedBox(height: 16),
          _buildTextField("Kilometraje (Opcional)", "65000", suffix: "km"),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {},
            child: const Text("Guardar Perfil"),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, String value, {String? suffix}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
        const SizedBox(height: 8),
        TextField(
          controller: TextEditingController(text: value),
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
            suffixText: suffix,
          ),
        ),
      ],
    );
  }
}

// -----------------------------------------------------------------
// 6. WORKSHOPS SCREEN
// -----------------------------------------------------------------
class WorkshopsScreen extends StatelessWidget {
  const WorkshopsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Talleres Cercanos", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).textTheme.bodyLarge?.color),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          const Text("Estimaciones basadas en diagnóstico de Holgura en correa.", style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 24),
          _buildWorkshopCard(context, "Mecánica Los Andes", "4.8", "1.2 km", "\$35.00 - \$50.00", "Mejor Precio"),
          _buildWorkshopCard(context, "Taller Automotriz Express", "4.5", "0.5 km", "\$45.00 - \$60.00", "Más Cercano"),
          _buildWorkshopCard(context, "Servicios Central Motor", "4.9", "3.0 km", "\$55.00 - \$75.00", null),
        ],
      ),
    );
  }

  Widget _buildWorkshopCard(BuildContext context, String name, String rating, String distance, String price, String? badge) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (badge != null)
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(color: Colors.green.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
              child: Text(badge, style: const TextStyle(color: Colors.green, fontSize: 10, fontWeight: FontWeight.bold)),
            ),
          Text(name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 16),
              const SizedBox(width: 4),
              Text(rating, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(width: 8),
              Text("• $distance", style: const TextStyle(color: Colors.grey)),
            ],
          ),
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Costo estimado", style: TextStyle(color: Colors.grey, fontSize: 12)),
                  Text(price, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ScheduleScreen()));
                },
                child: const Text("Agendar"),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------
// 7. SCHEDULE SCREEN
// -----------------------------------------------------------------
class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Agendar Cita", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).textTheme.bodyLarge?.color),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          // Technical Sheet
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.05),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey.withOpacity(0.3), style: BorderStyle.solid),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Ficha Técnica", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(color: Colors.blueAccent.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                      child: const Text("#AD-84920", style: TextStyle(color: Colors.blueAccent, fontSize: 10, fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
                const SizedBox(height: 16),
                _buildTechRow("Vehículo", "Toyota Corolla (2018)"),
                _buildTechRow("Motor", "1.8L Gasolina"),
                _buildTechRow("Kilometraje", "65,000 km"),
                const Divider(height: 24),
                _buildTechRow("Falla Detectada", "Holgura en correa", isAlert: true),
                _buildTechRow("Certeza AI", "87%"),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          
          const Text("Taller Seleccionado", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.grey.withOpacity(0.2)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Mecánica Los Andes", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("Cambiar", style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold, fontSize: 12)),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          
          const Text("Fecha y Hora (Simulado)", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.grey.withOpacity(0.2)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("10 Oct 2026 - 10:00 AM"),
                Icon(Icons.calendar_today, size: 16, color: Colors.grey),
              ],
            ),
          ),
          
          const SizedBox(height: 32),
          
          ElevatedButton(
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            child: const Text("Confirmar Cita"),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTechRow(String label, String value, {bool isAlert = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: TextStyle(fontWeight: isAlert ? FontWeight.bold : FontWeight.normal, color: isAlert ? Colors.red : null)),
        ],
      ),
    );
  }
}
