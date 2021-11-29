abstract class IBarrage {
  void send(String message);
  void pause();
  void play();
}

enum BarrageStatus { play, pause }
