<?php
require_once __DIR__ . '/../classes/Question.php';

$response = ['status' => 'error', 'message' => 'Invalid request'];

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    $difficulty = $_GET['difficulty'] ?? 1;
    $question = new Question();
    $questions = $question->getQuestions((int)$difficulty);

    if ($questions) {
        $response = ['status' => 'success', 'questions' => $questions];
    } else {
        $response['message'] = 'No questions found for this difficulty level.';
    }
}

header('Content-Type: application/json');
echo json_encode($response);
?>