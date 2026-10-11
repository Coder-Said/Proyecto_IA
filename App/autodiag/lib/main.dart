import 'package:flutter/material.dart';
import 'dart:async';
import 'services/audio_service.dart';
import 'services/model_service.dart';

void main() {
  runApp(const AutoDiagApp());
}

class AutoDiagApp extends StatelessWidget {
  const AutoDiagApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AutoDiag AI',
      debugShowCheckedModeBanner: false,
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
      themeMode: ThemeMode.system,
      home: const MainScreen(),
    );
  }
}

// -----------------------------------------------------------------
// MAIN NAVIGATION WRAPPER
// -----------------------------------------------------------------
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const Center(child: Text("Historial de Diagnósticos")),
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
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  Text("Bienvenido a AutoDiag AI", style: TextStyle(color: Colors.grey)),
                ],
              ),
              const CircleAvatar(
                backgroundColor: Colors.blueAccent,
                child: Icon(Icons.person, color: Colors.white),
              )
            ],
          ),
          const SizedBox(height: 24),

          // Tarjeta de Vehículo Actual
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

          // Botón Principal de Escaneo
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const DiagnosticStartScreen()));
            },
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                border: Border.all(color: Colors.blueAccent.withValues(alpha: 0.5), width: 2),
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
                      Text("Realizar diagnóstico acústico con IA", style: TextStyle(color: Colors.grey, fontSize: 12)),
                    ],
                  )
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Opciones
          Row(
            children: [
              Expanded(
                child: _buildGridButton(context, Icons.build, "Talleres Cercanos", Colors.orange, () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const WorkshopsScreen()));
                }),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildGridButton(context, Icons.help_outline, "Guía y Ayuda", Colors.green, () {}),
              ),
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
          border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: color.withValues(alpha: 0.1), shape: BoxShape.circle),
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
  const DiagnosticStartScreen({super.key});

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
                "Acerque el micrófono del dispositivo al motor encendido en un entorno lo más silencioso posible.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 48),
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const ListeningScreen()),
                  );
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
              const Text("Tocar para iniciar grabación (5s)", style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------
// 3. LISTENING & RECORDING SCREEN (Grabación Real + Inferencia IA ONNX)
// -----------------------------------------------------------------
enum ScanState {
  inicializando,
  grabando,
  analizando,
  error,
}

class ListeningScreen extends StatefulWidget {
  const ListeningScreen({super.key});

  @override
  State<ListeningScreen> createState() => _ListeningScreenState();
}

class _ListeningScreenState extends State<ListeningScreen> {
  final AudioRecordingService _audioService = AudioRecordingService();
  final OnnxModelService _onnxService = OnnxModelService();

  ScanState _scanState = ScanState.inicializando;
  int _secondsRemaining = 5;
  String _errorMessage = "";
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _iniciarProceso();
  }

  Future<void> _iniciarProceso() async {
    setState(() {
      _scanState = ScanState.inicializando;
      _secondsRemaining = 5;
      _errorMessage = "";
    });

    try {
      await _onnxService.initModels();

      final path = await _audioService.startRecording();
      if (path == null) {
        if (mounted) {
          setState(() {
            _scanState = ScanState.error;
            _errorMessage = "No se pudo acceder al micrófono. Por favor concede el permiso e intentalo de nuevo.";
          });
        }
        return;
      }

      if (!mounted) return;

      setState(() {
        _scanState = ScanState.grabando;
        _secondsRemaining = 5;
      });

      _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
        if (_secondsRemaining > 1) {
          if (mounted) {
            setState(() {
              _secondsRemaining--;
            });
          }
        } else {
          _timer?.cancel();
          await _detenerYProcesar();
        }
      });
    } catch (e) {
      if (mounted) {
        setState(() {
          _scanState = ScanState.error;
          _errorMessage = "Error al iniciar el escaneo: $e";
        });
      }
    }
  }

  Future<void> _detenerYProcesar() async {
    if (mounted) {
      setState(() {
        _scanState = ScanState.analizando;
      });
    }

    try {
      final recordedPath = await _audioService.stopRecording();
      final String pathAProcesar = recordedPath ?? '';

      final DiagnosticResult result = await _onnxService.procesarAudioYDiagnosticar(pathAProcesar);

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ResultScreen(result: result)),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _scanState = ScanState.error;
          _errorMessage = "Error al analizar el audio: $e";
        });
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _audioService.dispose();
    _onnxService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: _buildStateContent(),
        ),
      ),
    );
  }

  Widget _buildStateContent() {
    switch (_scanState) {
      case ScanState.inicializando:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircularProgressIndicator(strokeWidth: 5, color: Colors.blueAccent),
            SizedBox(height: 28),
            Text(
              "Preparando micrófono e IA...",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              "Cargando componentes de captura...",
              style: TextStyle(color: Colors.grey),
            ),
          ],
        );

      case ScanState.grabando:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Grabando acústica del motor...",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blueAccent),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            const Text(
              "Mantenga el teléfono cerca del motor encendido",
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 150,
                  height: 150,
                  child: CircularProgressIndicator(
                    value: (5 - _secondsRemaining) / 5.0,
                    strokeWidth: 8,
                    color: Colors.redAccent,
                    backgroundColor: Colors.blueAccent.withValues(alpha: 0.2),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "$_secondsRemaining",
                      style: const TextStyle(fontSize: 52, fontWeight: FontWeight.bold, color: Colors.redAccent),
                    ),
                    const Text("segundos", style: TextStyle(color: Colors.grey, fontSize: 13)),
                  ],
                ),
              ],
            ),
          ],
        );

      case ScanState.analizando:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircularProgressIndicator(strokeWidth: 6, color: Colors.blueAccent),
            SizedBox(height: 28),
            Text(
              "Analizando con IA ONNX...",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blueAccent),
            ),
            SizedBox(height: 12),
            Text(
              "Procesando patrón de frecuencia y diagnóstico...",
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        );

      case ScanState.error:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.redAccent, size: 64),
            const SizedBox(height: 16),
            const Text(
              "Ocurrió un inconveniente",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              _errorMessage,
              style: const TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: _iniciarProceso,
              icon: const Icon(Icons.refresh),
              label: const Text("Reintentar Grabación"),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Regresar"),
            ),
          ],
        );
    }
  }
}

// -----------------------------------------------------------------
// 4. RESULT SCREEN (Muestra el diagnóstico real obtenido de la IA)
// -----------------------------------------------------------------
class ResultScreen extends StatelessWidget {
  final DiagnosticResult result;

  const ResultScreen({super.key, required this.result});

  Color _getColor(String colorName) {
    switch (colorName) {
      case 'red':
        return Colors.redAccent;
      case 'orange':
        return Colors.orange;
      case 'green':
      default:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getColor(result.colorHex);
    final int certezaPorcentaje = (result.certeza * 100).round();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Resultados IA", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).textTheme.bodyLarge?.color),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          if (result.isUnrecognized) ...[
            // Vista especial para cuando está en silencio o el audio no tiene volumen
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.orange.withValues(alpha: 0.5), width: 2),
              ),
              child: Column(
                children: [
                  const Icon(Icons.mic_off_rounded, size: 64, color: Colors.orange),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(color: Colors.orange.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(20)),
                    child: const Text("AUDIO NO RECONOCIDO", style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 11)),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    result.titulo,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    result.descripcion,
                    style: const TextStyle(color: Colors.grey, height: 1.4),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.orange.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.lightbulb_outline, color: Colors.orange),
                      SizedBox(width: 8),
                      Text("Sugerencia", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    result.recomendacion,
                    style: const TextStyle(color: Colors.orange, height: 1.3),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.refresh),
              label: const Text("Reintentar Escaneo"),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ] else ...[
            // Vista normal cuando la IA predice un diagnóstico válido
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: statusColor.withValues(alpha: 0.5), width: 2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(color: statusColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      result.categoria,
                      style: TextStyle(color: statusColor, fontWeight: FontWeight.bold, fontSize: 11),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    result.titulo,
                    style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    result.descripcion,
                    style: const TextStyle(color: Colors.grey, height: 1.4),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Certeza del modelo AI", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(
                        "$certezaPorcentaje%",
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: statusColor),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: result.certeza,
                    color: statusColor,
                    backgroundColor: Colors.grey[300],
                    minHeight: 8,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Recomendación
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.warning_amber_rounded, color: statusColor),
                      const SizedBox(width: 8),
                      Text(
                        "Recomendación",
                        style: TextStyle(fontWeight: FontWeight.bold, color: statusColor),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    result.recomendacion,
                    style: TextStyle(color: statusColor, height: 1.3),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Acciones
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ScheduleScreen(diagnosticTitle: result.titulo)),
                );
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
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
              child: const Text("Escanear nuevamente"),
            )
          ]
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------
// 5. PROFILE SCREEN
// -----------------------------------------------------------------
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
          _buildTextField("Kilometraje", "65000", suffix: "km"),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Perfil actualizado correctamente.")),
              );
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            ),
            child: const Text("Guardar Perfil"),
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
  const WorkshopsScreen({super.key});

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
          const Text("Talleres recomendados en tu zona para revisión preventiva.", style: TextStyle(color: Colors.grey)),
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
        border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (badge != null)
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(color: Colors.green.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ScheduleScreen(diagnosticTitle: "Revisión Preventiva")),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text("Agendar"),
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
  final String diagnosticTitle;

  const ScheduleScreen({super.key, this.diagnosticTitle = "Revisión Preventiva"});

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
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey.withValues(alpha: 0.3)),
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
                      decoration: BoxDecoration(color: Colors.blueAccent.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
                      child: const Text("#AD-84920", style: TextStyle(color: Colors.blueAccent, fontSize: 10, fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
                const SizedBox(height: 16),
                _buildTechRow("Vehículo", "Toyota Corolla (2018)"),
                _buildTechRow("Motor", "1.8L Gasolina"),
                _buildTechRow("Kilometraje", "65,000 km"),
                const Divider(height: 24),
                _buildTechRow("Falla Detectada", diagnosticTitle, isAlert: true),
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
              border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
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
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Cita agendada correctamente.")),
              );
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            child: const Text("Confirmar Cita"),
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
