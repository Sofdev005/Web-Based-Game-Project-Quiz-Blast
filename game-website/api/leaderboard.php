<?php
require_once __DIR__ . '/../classes/Game.php';

$response = ['status' => 'error', 'message' => 'Invalid request'];

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    $game = new Game();
    $limit = $_GET['limit'] ?? 10;
    $leaderboard = $game->getLeaderboard((int)$limit);

    if ($leaderboard) {
        $response = ['status' => 'success', 'leaderboard' => $leaderboard];
    } else {
        $response['message'] = 'Leaderboard is empty.';
    }
}

header('Content-Type: application/json');
echo json_encode($response);
?>