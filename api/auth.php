<?php
require_once __DIR__ . '/../classes/User.php';

session_start();

$response = ['status' => 'error', 'message' => 'Invalid request'];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $data = json_decode(file_get_contents('php://input'), true);
    $action = $data['action'] ?? '';

    $user = new User();

    if ($action === 'register') {
        $username = $data['username'] ?? '';
        $email = $data['email'] ?? '';
        $password = $data['password'] ?? '';

        if (!empty($username) && !empty($email) && !empty($password)) {
            if ($user->findUserByEmail($email) || $user->findUserByUsername($username)) {
                $response['message'] = 'Username or email already exists.';
            } else {
                if ($user->createUser($username, $email, $password)) {
                    $response = ['status' => 'success', 'message' => 'Registration successful.'];
                } else {
                    $response['message'] = 'Registration failed.';
                }
            }
        } else {
            $response['message'] = 'All fields are required.';
        }
    } elseif ($action === 'login') {
        $email = $data['email'] ?? '';
        $password = $data['password'] ?? '';

        if (!empty($email) && !empty($password)) {
            $db_user = $user->findUserByEmail($email);
            if ($db_user && password_verify($password, $db_user['password_hash'])) {
                $_SESSION['user_id'] = $db_user['user_id'];
                $_SESSION['username'] = $db_user['username'];
                $response = ['status' => 'success', 'message' => 'Login successful.', 'user' => ['id' => $db_user['user_id'], 'username' => $db_user['username']]];
            } else {
                $response['message'] = 'Invalid email or password.';
            }
        } else {
            $response['message'] = 'Email and password are required.';
        }
    } elseif ($action === 'logout') {
        session_destroy();
        $response = ['status' => 'success', 'message' => 'Logout successful.'];
    }
}

header('Content-Type: application/json');
echo json_encode($response);
?>