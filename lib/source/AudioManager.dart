import 'package:audioplayers/audioplayers.dart';

class AudioManager {
  static final AudioManager _instance = AudioManager._internal();
  factory AudioManager() => _instance;
  AudioManager._internal();

  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;

  // Cargar y reproducir música de fondo
  Future<void> playBackgroundMusic(String assetPath) async {
    try {
      await _audioPlayer.stop();
      await _audioPlayer.setSource(AssetSource(assetPath));
      await _audioPlayer.setReleaseMode(ReleaseMode.loop); // Repetir en bucle
      await _audioPlayer.resume();
      _isPlaying = true;
    } catch (e) {
      print("Error reproduciendo música: $e");
    }
  }

  // Reproducir efecto de sonido (sin loop)
  Future<void> playSoundEffect(String assetPath) async {
    try {
      final audioPlayer = AudioPlayer();
      await audioPlayer.setSource(AssetSource(assetPath));
      await audioPlayer.resume();
    } catch (e) {
      print("Error reproduciendo efecto: $e");
    }
  }

  // Pausar música
  Future<void> pauseMusic() async {
    await _audioPlayer.pause();
    _isPlaying = false;
  }

  // Reanudar música
  Future<void> resumeMusic() async {
    await _audioPlayer.resume();
    _isPlaying = true;
  }

  // Detener música
  Future<void> stopMusic() async {
    await _audioPlayer.stop();
    _isPlaying = false;
  }

  // Control de volumen (0.0 a 1.0)
  Future<void> setVolume(double volume) async {
    await _audioPlayer.setVolume(volume);
  }

  bool get isPlaying => _isPlaying;
}