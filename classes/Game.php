<?php
require_once 'Database.php';

class Game {
    private $db;

    public function __construct() {
        $this->db = Database::getInstance()->getConnection();
    }

    public function createGameSession($user_id) {
        $sql = "INSERT INTO game_sessions (user_id) VALUES (?)";
        $stmt = $this->db->prepare($sql);
        $stmt->bind_param("i", $user_id);
        $stmt->execute();
        return $stmt->insert_id;
    }

    public function saveAnswer($session_id, $user_id, $question_id, $selected_answer, $is_correct, $difficulty) {
        $sql = "INSERT INTO user_answers (session_id, user_id, question_id, selected_answer, is_correct, difficulty_at_time) VALUES (?, ?, ?, ?, ?, ?)";
        $stmt = $this->db->prepare($sql);
        $stmt->bind_param("iiisii", $session_id, $user_id, $question_id, $selected_answer, $is_correct, $difficulty);
        return $stmt->execute();
    }

    public function updateGameSession($session_id, $score, $difficulty) {
        $sql = "UPDATE game_sessions SET final_score = final_score + ?, total_questions = total_questions + 1, correct_answers = correct_answers + (CASE WHEN ? > 0 THEN 1 ELSE 0 END), highest_difficulty_reached = ? WHERE session_id = ?";
        $stmt = $this->db->prepare($sql);
        $stmt->bind_param("iiii", $score, $score, $difficulty, $session_id);
        return $stmt->execute();
    }

    public function updateUserScore($user_id, $score) {
        $sql = "UPDATE users SET total_score = total_score + ? WHERE user_id = ?";
        $stmt = $this->db->prepare($sql);
        $stmt->bind_param("ii", $score, $user_id);
        return $stmt->execute();
    }

    public function getLeaderboard($limit = 10) {
        $sql = "SELECT username, total_score, profile_pic FROM users ORDER BY total_score DESC LIMIT ?";
        $stmt = $this->db->prepare($sql);
        $stmt->bind_param("i", $limit);
        $stmt->execute();
        return $stmt->get_result()->fetch_all(MYSQLI_ASSOC);
    }
}
?>