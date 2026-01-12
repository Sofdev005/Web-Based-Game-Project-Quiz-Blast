<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quiz Blast Game</title>
    <link rel="stylesheet" href="assets/css/main.css">
    <link rel="stylesheet" href="assets/css/animations.css">
    <link rel="stylesheet" href="assets/css/game.css">
</head>
<body>

    <div id="app-container">

        <!-- Header -->
        <header id="main-header">
            <h1 class="game-title"><span>QUIZ</span> BLAST</h1>
            <div id="user-info">
                <!-- User info will be dynamically inserted here -->
            </div>
        </header>

        <!-- Main Content -->
        <main id="main-content">

            <!-- Auth Screen -->
            <section id="auth-screen" class="screen">
                <div id="auth-forms">
                    <!-- Login Form -->
                    <form id="login-form" class="auth-form">
                        <h2>Login</h2>
                        <input type="email" id="login-email" placeholder="Email" required>
                        <input type="password" id="login-password" placeholder="Password" required>
                        <button type="submit">Enter</button>
                        <p>Don't have an account? <a href="#" id="show-register">Register</a></p>
                    </form>
                    <!-- Register Form -->
                    <form id="register-form" class="auth-form" style="display: none;">
                        <h2>Register</h2>
                        <input type="text" id="register-username" placeholder="Username" required>
                        <input type="email" id="register-email" placeholder="Email" required>
                        <input type="password" id="register-password" placeholder="Password" required>
                        <button type="submit">Create Account</button>
                        <p>Already have an account? <a href="#" id="show-login">Login</a></p>
                    </form>
                </div>
            </section>

            <!-- Main Menu / Leaderboard Screen -->
            <section id="main-menu-screen" class="screen" style="display: none;">
                <div id="leaderboard-container">
                    <h2>LEADERBOARD</h2>
                    <table id="leaderboard-table">
                        <thead>
                            <tr>
                                <th>Rank</th>
                                <th>Player</th>
                                <th>Score</th>
                            </tr>
                        </thead>
                        <tbody id="leaderboard-body">
                            <!-- Leaderboard data will be dynamically inserted here -->
                        </tbody>
                    </table>
                </div>
                <button id="start-game-btn">Start New Game</button>
            </section>

            <!-- Game Screen -->
            <section id="game-screen" class="screen" style="display: none;">
                <div id="game-hud">
                    <div id="score-display">Score: <span>0</span></div>
                    <div id="difficulty-display">Difficulty: <span>1</span></div>
                </div>
                <div id="question-container">
                    <p id="question-text"></p>
                </div>
                <div id="options-container">
                    <!-- Options will be dynamically inserted here -->
                </div>
                <div id="feedback-container"></div>
            </section>

        </main>

    </div>

    <script src="assets/js/api.js"></script>
    <script src="assets/js/animations.js"></script>
    <script src="assets/js/game.js"></script>
    <script src="assets/js/main.js"></script>
</body>
</html>