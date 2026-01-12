const Main = {
    elements: {
        authScreen: document.getElementById('auth-screen'),
        mainMenuScreen: document.getElementById('main-menu-screen'),
        gameScreen: document.getElementById('game-screen'),
        
        loginForm: document.getElementById('login-form'),
        registerForm: document.getElementById('register-form'),
        showRegisterLink: document.getElementById('show-register'),
        showLoginLink: document.getElementById('show-login'),
        
        startGameBtn: document.getElementById('start-game-btn'),
        leaderboardBody: document.getElementById('leaderboard-body'),
        userInfo: document.getElementById('user-info'),
    },

    init() {
        this.addEventListeners();
        // Check for existing session on load in a real app
        // For now, we start at the auth screen
        this.showScreen('auth-screen');
    },

    addEventListeners() {
        this.elements.loginForm.addEventListener('submit', this.handleLogin.bind(this));
        this.elements.registerForm.addEventListener('submit', this.handleRegister.bind(this));
        this.elements.showRegisterLink.addEventListener('click', (e) => {
            e.preventDefault();
            this.elements.loginForm.style.display = 'none';
            this.elements.registerForm.style.display = 'block';
        });
        this.elements.showLoginLink.addEventListener('click', (e) => {
            e.preventDefault();
            this.elements.registerForm.style.display = 'none';
            this.elements.loginForm.style.display = 'block';
        });

        this.elements.startGameBtn.addEventListener('click', this.handleStartGame.bind(this));
    },

    async handleLogin(e) {
        e.preventDefault();
        const email = this.elements.loginForm.querySelector('#login-email').value;
        const password = this.elements.loginForm.querySelector('#login-password').value;
        const response = await Api.login(email, password);
        if (response.status === 'success') {
            this.setupUser(response.user);
        } else {
            alert(response.message || 'Login failed.');
        }
    },

    async handleRegister(e) {
        e.preventDefault();
        const username = this.elements.registerForm.querySelector('#register-username').value;
        const email = this.elements.registerForm.querySelector('#register-email').value;
        const password = this.elements.registerForm.querySelector('#register-password').value;
        const response = await Api.register(username, email, password);
        if (response.status === 'success') {
            alert('Registration successful! Please log in.');
            this.elements.registerForm.style.display = 'none';
            this.elements.loginForm.style.display = 'block';
            this.elements.loginForm.querySelector('#login-email').value = email;
        } else {
            alert(response.message || 'Registration failed.');
        }
    },
    
    async handleStartGame() {
        this.showScreen('game-screen');
        await Game.start();
    },

    setupUser(user) {
        this.elements.userInfo.innerHTML = `<span>Welcome, ${user.username}</span> | <a href="#" id="logout-btn">Logout</a>`;
        document.getElementById('logout-btn').addEventListener('click', async (e) => {
            e.preventDefault();
            await Api.logout();
            window.location.reload();
        });
        this.loadLeaderboard();
        this.showScreen('main-menu-screen');
    },

    async loadLeaderboard() {
        const response = await Api.getLeaderboard();
        this.elements.leaderboardBody.innerHTML = ''; // Clear existing
        if (response.status === 'success') {
            response.leaderboard.forEach((player, index) => {
                const row = `
                    <tr>
                        <td>${index + 1}</td>
                        <td>${player.username}</td>
                        <td>${player.total_score}</td>
                    </tr>
                `;
                this.elements.leaderboardBody.innerHTML += row;
            });
        }
    },

    showScreen(screenId) {
        const screens = [this.elements.authScreen, this.elements.mainMenuScreen, this.elements.gameScreen];
        screens.forEach(screen => {
            if (screen.id === screenId) {
                Animations.fadeIn(screen);
            } else {
                screen.style.display = 'none';
            }
        });
    }
};

// Initialize the application
document.addEventListener('DOMContentLoaded', () => Main.init());
