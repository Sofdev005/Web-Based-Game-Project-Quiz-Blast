<?php
require_once __DIR__ . '/../classes/Game.php';
require_once __DIR__ . '/../classes/Question.php';

session_start();

$response = ['status' => 'error', 'message' => 'Invalid request'];

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_SESSION['user_id'])) {
    $data = json_decode(file_get_contents('php://input'), true);
    $action = $data['action'] ?? '';
    $user_id = $_SESSION['user_id'];

    $game = new Game();

    if ($action === 'start') {
        $session_id = $game->createGameSession($user_id);
        $_SESSION['game_session_id'] = $session_id;
        $response = ['status' => 'success', 'session_id' => $session_id];
    } elseif ($action === 'submit_answer' && isset($_SESSION['game_session_id'])) {
        $question_id = $data['question_id'] ?? 0;
        $selected_answer = $data['answer'] ?? '';
        $difficulty = $data['difficulty'] ?? 1;

        if ($question_id > 0 && !empty($selected_answer)) {
            $question = new Question();
            $correct_answer = $question->getCorrectAnswer($question_id);
            $is_correct = ($selected_answer === $correct_answer);
            $score = $is_correct ? 1 : -1;

            $session_id = $_SESSION['game_session_id'];

            $game->saveAnswer($session_id, $user_id, $question_id, $selected_answer, $is_correct, $difficulty);
            $game->updateGameSession($session_id, $score, $difficulty);
            $game->updateUserScore($user_id, $score);

            $response = ['status' => 'success', 'correct' => $is_correct, 'correct_answer' => $correct_answer, 'score' => $score];
        } else {
            $response['message'] = 'Question ID and answer are required.';
        }
    }
} else {
    $response['message'] = 'You must be logged in to play.';
}


header('Content-Type: application/json');
echo json_encode($response);
?>