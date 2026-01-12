const API_URL = 'api/';

async function apiRequest(endpoint, method = 'GET', body = null) {
    const options = {
        method,
        headers: {
            'Content-Type': 'application/json'
        }
    };
    if (body) {
        options.body = JSON.stringify(body);
    }

    try {
        const response = await fetch(API_URL + endpoint, options);
        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }
        return await response.json();
    } catch (error) {
        console.error(`API request failed: ${error}`);
        return { status: 'error', message: 'A network error occurred.' };
    }
}

const Api = {
    // Auth
    login: (email, password) => apiRequest('auth.php', 'POST', { action: 'login', email, password }),
    register: (username, email, password) => apiRequest('auth.php', 'POST', { action: 'register', username, email, password }),
    logout: () => apiRequest('auth.php', 'POST', { action: 'logout' }),

    // Game
    startGame: () => apiRequest('game.php', 'POST', { action: 'start' }),
    submitAnswer: (question_id, answer, difficulty) => apiRequest('game.php', 'POST', { action: 'submit_answer', question_id, answer, difficulty }),
    
    // Questions
    getQuestions: (difficulty) => apiRequest(`questions.php?difficulty=${difficulty}`),

    // Leaderboard
    getLeaderboard: (limit = 10) => apiRequest(`leaderboard.php?limit=${limit}`),
};
