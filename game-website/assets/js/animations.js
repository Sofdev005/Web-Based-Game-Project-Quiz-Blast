const Animations = {
    fadeIn: (element) => {
        element.style.display = 'block';
        element.classList.remove('fade-out');
        element.classList.add('fadeIn');
    },

    fadeOut: (element) => {
        element.classList.remove('fadeIn');
        element.classList.add('fade-out');
        setTimeout(() => {
            element.style.display = 'none';
        }, 500); // Match animation duration
    },

    typewriter: (element, text, callback) => {
        element.innerHTML = '';
        element.style.opacity = 1;
        element.classList.add('typing');
        let i = 0;
        const speed = 50; // milliseconds

        function type() {
            if (i < text.length) {
                element.innerHTML += text.charAt(i);
                i++;
                setTimeout(type, speed);
            } else {
                element.classList.remove('typing');
                if (callback) callback();
            }
        }
        type();
    },

    pulse: (element, effect) => {
        element.classList.add(effect);
        setTimeout(() => element.classList.remove(effect), 600);
    },

    shake: (element, effect) => {
        element.classList.add(effect);
        setTimeout(() => element.classList.remove(effect), 600);
    },
    
    updateScore: (element, increase = true) => {
        const animationClass = increase ? 'score-increase' : 'score-decrease';
        element.classList.add(animationClass);
        setTimeout(() => element.classList.remove(animationClass), 500);
    }
};
