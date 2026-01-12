const Game = {
    state: {
        score: 0,
        difficulty: 1,
        questionCount: 0,
        currentQuestions: [],
        currentQuestionIndex: 0,
        sessionId: null,
    },

    elements: {
        gameScreen: document.getElementById('game-screen'),
        questionText: document.getElementById('question-text'),
        optionsContainer: document.getElementById('options-container'),
        scoreDisplay: document.querySelector('#score-display span'),
        difficultyDisplay: document.querySelector('#difficulty-display span'),
        feedbackContainer: document.getElementById('feedback-container'),
    },

    async start() {
        console.log('Starting game...');
        this.resetState();
        const response = await Api.startGame();
        if (response.status === 'success') {
            this.state.sessionId = response.session_id;
            this.updateHUD();
            await this.fetchQuestions();
            Animations.fadeIn(this.elements.gameScreen);
        } else {
            alert('Error starting game. Please try again.');
        }
    },

    resetState() {
        this.state.score = 0;
        this.state.difficulty = 1;
        this.state.questionCount = 0;
        this.state.currentQuestions = [];
        this.state.currentQuestionIndex = 0;
    },

    async fetchQuestions() {
        this.elements.optionsContainer.innerHTML = '';
        this.elements.feedbackContainer.innerHTML = '';

        const response = await Api.getQuestions(this.state.difficulty);
        if (response.status === 'success' && response.questions.length > 0) {
            this.state.currentQuestions = response.questions;
            this.state.currentQuestionIndex = 0;
            this.displayQuestion();
        } else {
            // No more questions, end game or show message
            this.endGame('Congratulations! You have completed all available questions.');
        }
    },

    displayQuestion() {
        const question = this.state.currentQuestions[this.state.currentQuestionIndex];
        Animations.typewriter(this.elements.questionText, question.question_text, () => {
            this.renderOptions(question);
        });
    },

    renderOptions(question) {
        this.elements.optionsContainer.innerHTML = '';
        const options = ['a', 'b', 'c', 'd'];
        options.forEach(opt => {
            const optionEl = document.createElement('button');
            optionEl.classList.add('option-btn');
            optionEl.dataset.answer = opt.toUpperCase();
            optionEl.innerHTML = `${opt.toUpperCase()}. ${question['option_' + opt]}`;
            optionEl.onclick = () => this.selectAnswer(optionEl);
            this.elements.optionsContainer.appendChild(optionEl);
        });
    },

    async selectAnswer(selectedOption) {
        this.disableOptions();
        const question = this.state.currentQuestions[this.state.currentQuestionIndex];
        const answer = selectedOption.dataset.answer;

        const response = await Api.submitAnswer(question.question_id, answer, this.state.difficulty);

        if (response.status === 'success') {
            if (response.correct) {
                selectedOption.classList.add('correct');
                Animations.pulse(selectedOption, 'correct');
                this.elements.feedbackContainer.innerHTML = `<span style="color:var(--correct-color)">CORRECT!</span>`;
                this.updateScore(1);
            } else {
                selectedOption.classList.add('incorrect');
                Animations.shake(selectedOption, 'incorrect');
                this.elements.feedbackContainer.innerHTML = `<span style="color:var(--incorrect-color)">INCORRECT!</span>`;
                // Highlight the correct answer
                const correctOption = this.elements.optionsContainer.querySelector(`[data-answer="${response.correct_answer}"]`);
                if(correctOption) correctOption.classList.add('correct');
                this.updateScore(-1);
            }

            setTimeout(() => this.nextQuestion(), 1500);

        } else {
            alert('Error submitting answer.');
            this.enableOptions();
        }
    },

    nextQuestion() {
        this.state.questionCount++;
        this.state.currentQuestionIndex++;

        // Increase difficulty every 5 questions
        if (this.state.questionCount % 5 === 0) {
            this.state.difficulty++;
        }

        if (this.state.currentQuestionIndex >= this.state.currentQuestions.length) {
            this.fetchQuestions(); // Fetch next batch of questions
        } else {
            this.displayQuestion();
        }
        
        this.updateHUD();
        this.elements.feedbackContainer.innerHTML = '';
    },
    
    updateScore(change) {
        this.state.score += change;
        this.updateHUD();
        Animations.updateScore(this.elements.scoreDisplay.parentElement, change > 0);
    },

    updateHUD() {
        this.elements.scoreDisplay.textContent = this.state.score;
        this.elements.difficultyDisplay.textContent = this.state.difficulty;
    },
    
    disableOptions() {
        document.querySelectorAll('.option-btn').forEach(btn => btn.classList.add('disabled'));
    },
    
    enableOptions() {
        document.querySelectorAll('.option-btn').forEach(btn => btn.classList.remove('disabled'));
    },

    endGame(message) {
        alert(message);
        Main.showScreen('main-menu-screen'); // Return to main menu
        Main.loadLeaderboard(); // Refresh leaderboard
    }
};
