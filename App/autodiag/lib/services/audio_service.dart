import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';

class AudioRecordingService {
  final AudioRecorder _audioRecorder = AudioRecorder();

  /// Solicitar permiso de micrófono
  Future<bool> requestPermission() async {
    final status = await Permission.microphone.request();
    return status.isGranted;
  }

  /// Inicia la grabación de audio PCM 16kHz Mono
  Future<String?> startRecording() async {
    final hasPermission = await _audioRecorder.hasPermission();
    if (!hasPermission) {
      final granted = await requestPermission();
      if (!granted) return null;
    }

    final dir = await getTemporaryDirectory();
    final filePath = '${dir.path}/engine_recording.wav';

    // Eliminar archivo previo si existe
    final file = File(filePath);
    if (await file.exists()) {
      await file.delete();
    }

    await _audioRecorder.start(
      const RecordConfig(
        encoder: AudioEncoder.pcm16bits,
        sampleRate: 16000,
        numChannels: 1,
      ),
      path: filePath,
    );

    return filePath;
  }

  /// Detiene la grabación y devuelve la ruta del archivo grabado
  Future<String?> stopRecording() async {
    return await _audioRecorder.stop();
  }

  void dispose() {
    _audioRecorder.dispose();
  }
}
