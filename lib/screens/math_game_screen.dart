import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/game_provider.dart';
import '../providers/game_sound_provider.dart';

class MathGameScreen extends StatefulWidget {
  const MathGameScreen({super.key});

  @override
  State<MathGameScreen> createState() => _MathGameScreenState();
}

class _MathGameScreenState extends State<MathGameScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _messageController;
  late Animation<double> _messageAnimation;
  String? _message;
  Color? _messageColor;

  @override
  void initState() {
    super.initState();
    _messageController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _messageAnimation = CurvedAnimation(
      parent: _messageController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _showMessage(String message, Color color) {
    setState(() {
      _message = message;
      _messageColor = color;
    });
    _messageController.forward(from: 0.0).then((_) {
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          _messageController.reverse();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Math Game'), centerTitle: true),
      body: Consumer2<GameProvider, GameSoundProvider>(
        builder: (context, gameProvider, soundProvider, child) {
          return Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.blue.shade100, Colors.white],
                  ),
                ),
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight:
                            MediaQuery.of(context).size.height -
                            AppBar().preferredSize.height -
                            MediaQuery.of(context).padding.top,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _buildScoreBoard(gameProvider),
                            const SizedBox(height: 32),
                            _buildQuestion(gameProvider, soundProvider),
                            const SizedBox(height: 32),
                            _buildAnswerOptions(
                              context,
                              gameProvider,
                              soundProvider,
                            ),
                            const SizedBox(height: 32),
                            _buildGameControls(
                              context,
                              gameProvider,
                              soundProvider,
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              if (_message != null)
                Positioned(
                  top: 100,
                  left: 0,
                  right: 0,
                  child: FadeTransition(
                    opacity: _messageAnimation,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, -0.5),
                        end: Offset.zero,
                      ).animate(_messageAnimation),
                      child: Center(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 32),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: _messageColor?.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    _messageColor?.withOpacity(0.3) ??
                                    Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: Text(
                            _message!,
                            style: const TextStyle(
                              fontSize: 24,

                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildScoreBoard(GameProvider gameProvider) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Score: ${gameProvider.score}',
              style: const TextStyle(fontSize: 24, color: Colors.blue),
            ),
            Text(
              'Level: ${gameProvider.level}',
              style: const TextStyle(fontSize: 24, color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestion(
    GameProvider gameProvider,
    GameSoundProvider soundProvider,
  ) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Text(
              gameProvider.currentQuestion,
              style: const TextStyle(fontSize: 32, color: Colors.blue),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            IconButton(
              icon: Icon(
                soundProvider.isSpeaking
                    ? Icons.volume_up
                    : Icons.volume_up_outlined,
                size: 32,
                color: Colors.blue,
              ),
              onPressed:
                  () => soundProvider.playNewQuestion(
                    gameProvider.currentQuestion,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnswerOptions(
    BuildContext context,
    GameProvider gameProvider,
    GameSoundProvider soundProvider,
  ) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: gameProvider.options.length,
      itemBuilder: (context, index) {
        final option = gameProvider.options[index];
        final isSelected = gameProvider.selectedAnswer == option;
        final isCorrect = gameProvider.isAnswerCorrect(option);

        return Card(
          elevation: isSelected ? 8 : 4,
          color:
              isSelected
                  ? (isCorrect ? Colors.green.shade100 : Colors.red.shade100)
                  : Colors.white,
          child: InkWell(
            onTap: () async {
              if (gameProvider.checkAnswer(option)) {
                await soundProvider.playCorrectAnswer();
                _showMessage('Great job! +10 points! 🎉', Colors.green);
                gameProvider.nextQuestion();
              } else {
                await soundProvider.playWrongAnswer();
                _showMessage('Try again! 💪', Colors.orange);
              }
            },
            child: Center(
              child: Text(
                option.toString(),
                style: TextStyle(
                  fontSize: 32,

                  color:
                      isSelected
                          ? (isCorrect
                              ? Colors.green.shade700
                              : Colors.red.shade700)
                          : Colors.blue,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildGameControls(
    BuildContext context,
    GameProvider gameProvider,
    GameSoundProvider soundProvider,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton.icon(
          onPressed: () {
            gameProvider.resetGame();
            soundProvider.playNewQuestion(gameProvider.currentQuestion);
            _showMessage('New game started! 🎮', Colors.blue);
          },
          icon: const Icon(Icons.refresh),
          label: const Text('New Game'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        ),
        ElevatedButton.icon(
          onPressed: () async {
            await soundProvider.playGameOver(gameProvider.score);
            _showMessage('Game over! 👋', Colors.purple);
            if (context.mounted) {
              Future.delayed(const Duration(seconds: 1), () {
                if (context.mounted) {
                  Navigator.pop(context);
                }
              });
            }
          },
          icon: const Icon(Icons.exit_to_app),
          label: const Text('Exit'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        ),
      ],
    );
  }
}
