<?php
require_once 'Database.php';

class Question {
    private $db;

    public function __construct() {
        $this->db = Database::getInstance()->getConnection();
    }

    public function getQuestions($difficulty = 1, $limit = 4) {
        $sql = "SELECT question_id, question_text, option_a, option_b, option_c, option_d, difficulty_level, category FROM questions WHERE difficulty_level = ? AND is_active = TRUE ORDER BY RAND() LIMIT ?";
        $stmt = $this->db->prepare($sql);
        $stmt->bind_param("ii", $difficulty, $limit);
        $stmt->execute();
        return $stmt->get_result()->fetch_all(MYSQLI_ASSOC);
    }

    public function getCorrectAnswer($question_id) {
        $sql = "SELECT correct_answer FROM questions WHERE question_id = ?";
        $stmt = $this->db->prepare($sql);
        $stmt->bind_param("i", $question_id);
        $stmt->execute();
        $result = $stmt->get_result()->fetch_assoc();
        return $result ? $result['correct_answer'] : null;
    }
}
?>