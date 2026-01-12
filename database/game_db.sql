-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 12, 2026 at 08:17 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cinematic_game_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `game_sessions`
--

CREATE TABLE `game_sessions` (
  `session_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `start_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `end_time` timestamp NULL DEFAULT NULL,
  `total_questions` int(11) DEFAULT 0,
  `correct_answers` int(11) DEFAULT 0,
  `final_score` int(11) DEFAULT 0,
  `highest_difficulty_reached` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `game_sessions`
--

INSERT INTO `game_sessions` (`session_id`, `user_id`, `start_time`, `end_time`, `total_questions`, `correct_answers`, `final_score`, `highest_difficulty_reached`) VALUES
(1, 1, '2025-12-09 12:31:59', NULL, 25, 22, 19, 5),
(2, 2, '2025-12-10 07:49:52', NULL, 25, 20, 15, 5),
(3, 1, '2025-12-10 07:53:29', NULL, 25, 25, 25, 5),
(4, 1, '2025-12-10 10:18:59', NULL, 7, 5, 3, 2),
(5, 1, '2025-12-10 11:25:12', NULL, 2, 1, 0, 1),
(6, 1, '2025-12-16 21:49:16', NULL, 0, 0, 0, 1),
(7, 3, '2025-12-17 09:10:14', NULL, 3, 1, -1, 1),
(8, 1, '2025-12-17 09:12:23', NULL, 2, 1, 0, 1),
(9, 1, '2026-01-12 18:49:48', NULL, 6, 3, 0, 2);

-- --------------------------------------------------------

--
-- Stand-in structure for view `leaderboard`
-- (See below for the actual view)
--
CREATE TABLE `leaderboard` (
`user_id` int(11)
,`username` varchar(50)
,`profile_pic` varchar(255)
,`total_score` decimal(32,0)
,`total_games` bigint(21)
,`max_difficulty` int(11)
,`rank_position` bigint(21)
);

-- --------------------------------------------------------

--
-- Table structure for table `questions`
--

CREATE TABLE `questions` (
  `question_id` int(11) NOT NULL,
  `question_text` text NOT NULL,
  `option_a` varchar(255) NOT NULL,
  `option_b` varchar(255) NOT NULL,
  `option_c` varchar(255) NOT NULL,
  `option_d` varchar(255) NOT NULL,
  `correct_answer` char(1) NOT NULL,
  `difficulty_level` int(11) DEFAULT 1,
  `category` varchar(50) DEFAULT NULL,
  `explanation` text DEFAULT NULL,
  `time_added` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_active` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `questions`
--

INSERT INTO `questions` (`question_id`, `question_text`, `option_a`, `option_b`, `option_c`, `option_d`, `correct_answer`, `difficulty_level`, `category`, `explanation`, `time_added`, `is_active`) VALUES
(15, 'What year was the original Super Mario Bros. released?', '1983', '1985', '1987', '1989', 'B', 1, 'Games', 'Super Mario Bros. was released in 1985 for the Nintendo Entertainment System (NES).', '2025-12-10 10:17:51', 1),
(16, 'Which company developed the game \"The Legend of Zelda\"?', 'Sega', 'Nintendo', 'Square Enix', 'Capcom', 'B', 1, 'Games', 'The Legend of Zelda was developed and published by Nintendo.', '2025-12-10 10:17:51', 1),
(17, 'What is the best-selling video game of all time?', 'Tetris', 'Minecraft', 'Grand Theft Auto V', 'Wii Sports', 'B', 2, 'Games', 'Minecraft has sold over 238 million copies as of 2021, making it the best-selling game.', '2025-12-10 10:17:51', 1),
(18, 'In \"Pokémon Red/Blue\", what type is Pikachu?', 'Normal', 'Electric', 'Psychic', 'Flying', 'B', 1, 'Games', 'Pikachu is an Electric-type Pokémon.', '2025-12-10 10:17:51', 1),
(19, 'Which game features the character \"Master Chief\"?', 'Halo', 'Call of Duty', 'Destiny', 'Gears of War', 'A', 2, 'Games', 'Master Chief is the protagonist of the Halo series.', '2025-12-10 10:17:51', 1),
(20, 'What is the name of the main character in \"The Witcher 3: Wild Hunt\"?', 'Geralt of Rivia', 'Ezio Auditore', 'Solid Snake', 'Kratos', 'A', 3, 'Games', 'Geralt of Rivia is the protagonist of The Witcher series.', '2025-12-10 10:17:51', 1),
(21, 'Which game introduced the \"Battle Royale\" genre to mainstream popularity?', 'Fortnite', 'PUBG', 'Apex Legends', 'Call of Duty: Warzone', 'B', 3, 'Games', 'PlayerUnknown\'s Battlegrounds (PUBG) popularized the battle royale genre in 2017.', '2025-12-10 10:17:51', 1),
(22, 'What is the highest possible score in a game of Tetris?', '999,999', '999,999,999', 'No maximum', '1,000,000', 'B', 4, 'Games', 'The maximum score in Tetris is 999,999,999 points, though it requires special conditions.', '2025-12-10 10:17:51', 1),
(23, 'In \"World of Warcraft\", what is the name of the Lich King\'s sword?', 'Ashbringer', 'Frostmourne', 'Doomhammer', 'Shadowmourne', 'B', 4, 'Games', 'Frostmourne is the runeblade wielded by the Lich King in World of Warcraft.', '2025-12-10 10:17:51', 1),
(24, 'Which game engine is used to develop \"Fortnite\"?', 'Unity', 'Unreal Engine', 'CryEngine', 'Frostbite', 'B', 5, 'Games', 'Fortnite is developed using Unreal Engine, specifically created by Epic Games.', '2025-12-10 10:17:51', 1),
(25, 'Which actor played Iron Man in the Marvel Cinematic Universe?', 'Chris Evans', 'Robert Downey Jr.', 'Chris Hemsworth', 'Mark Ruffalo', 'B', 1, 'Movies', 'Robert Downey Jr. portrayed Tony Stark/Iron Man in the MCU.', '2025-12-10 10:17:51', 1),
(26, 'What is the highest-grossing film of all time?', 'Titanic', 'Avatar', 'Avengers: Endgame', 'Star Wars: The Force Awakens', 'C', 2, 'Movies', 'Avengers: Endgame grossed over $2.79 billion worldwide.', '2025-12-10 10:17:51', 1),
(27, 'Which movie won the Academy Award for Best Picture in 2020?', 'Parasite', '1917', 'Joker', 'Once Upon a Time in Hollywood', 'A', 3, 'Movies', 'Parasite, directed by Bong Joon-ho, won Best Picture in 2020.', '2025-12-10 10:17:51', 1),
(28, 'Who directed \"The Shawshank Redemption\"?', 'Steven Spielberg', 'Frank Darabont', 'Martin Scorsese', 'Quentin Tarantino', 'B', 2, 'Movies', 'Frank Darabont directed The Shawshank Redemption.', '2025-12-10 10:17:51', 1),
(29, 'What is the name of the fictional continent where \"Game of Thrones\" takes place?', 'Middle-earth', 'Westeros', 'Narnia', 'Azeroth', 'B', 1, 'Movies', 'Westeros is the main continent in Game of Thrones.', '2025-12-10 10:17:51', 1),
(30, 'Which film features the quote: \"Here\'s looking at you, kid\"?', 'Gone with the Wind', 'Casablanca', 'The Godfather', 'Citizen Kane', 'B', 3, 'Movies', 'This famous line is spoken by Rick (Humphrey Bogart) in Casablanca.', '2025-12-10 10:17:51', 1),
(31, 'How many Oscars did \"Titanic\" win?', '11', '10', '9', '8', 'A', 4, 'Movies', 'Titanic won 11 Academy Awards, including Best Picture.', '2025-12-10 10:17:51', 1),
(32, 'Who played the Joker in \"The Dark Knight\"?', 'Jack Nicholson', 'Jared Leto', 'Heath Ledger', 'Joaquin Phoenix', 'C', 3, 'Movies', 'Heath Ledger played the Joker in The Dark Knight, winning a posthumous Oscar.', '2025-12-10 10:17:51', 1),
(33, 'Which movie is the first in the Marvel Cinematic Universe?', 'Iron Man', 'The Incredible Hulk', 'Thor', 'Captain America: The First Avenger', 'A', 2, 'Movies', 'Iron Man (2008) was the first film in the MCU.', '2025-12-10 10:17:51', 1),
(34, 'What year was \"Star Wars: A New Hope\" released?', '1975', '1977', '1979', '1981', 'B', 4, 'Movies', 'The original Star Wars film was released in 1977.', '2025-12-10 10:17:51', 1),
(35, 'What is 7 × 8?', '54', '56', '58', '60', 'B', 1, 'Math', '7 multiplied by 8 equals 56.', '2025-12-10 10:17:51', 1),
(36, 'What is the value of π (pi) to two decimal places?', '3.12', '3.14', '3.16', '3.18', 'B', 1, 'Math', 'π is approximately 3.14159, so 3.14 to two decimal places.', '2025-12-10 10:17:51', 1),
(37, 'What is 15% of 200?', '15', '20', '30', '45', 'C', 2, 'Math', '15% of 200 = 0.15 × 200 = 30.', '2025-12-10 10:17:51', 1),
(38, 'Solve for x: 2x + 5 = 17', '4', '5', '6', '7', 'C', 2, 'Math', '2x + 5 = 17 → 2x = 12 → x = 6.', '2025-12-10 10:17:51', 1),
(39, 'What is the square root of 169?', '11', '12', '13', '14', 'C', 3, 'Math', '13 × 13 = 169, so √169 = 13.', '2025-12-10 10:17:51', 1),
(40, 'What is the area of a circle with radius 7? (π = 22/7)', '154', '154.5', '155', '155.5', 'A', 3, 'Math', 'Area = πr² = (22/7) × 7² = (22/7) × 49 = 22 × 7 = 154.', '2025-12-10 10:17:51', 1),
(41, 'What is the derivative of x³?', '2x²', '3x²', '3x', 'x²', 'B', 4, 'Math', 'd/dx(x³) = 3x².', '2025-12-10 10:17:51', 1),
(42, 'What is the value of 5! (5 factorial)?', '100', '110', '120', '130', 'C', 4, 'Math', '5! = 5 × 4 × 3 × 2 × 1 = 120.', '2025-12-10 10:17:51', 1),
(43, 'What is the sum of the interior angles of a triangle?', '90°', '180°', '270°', '360°', 'B', 1, 'Math', 'The sum of interior angles of any triangle is always 180°.', '2025-12-10 10:17:51', 1),
(44, 'If a = 3 and b = 4 in a right triangle, what is c (hypotenuse)?', '5', '6', '7', '8', 'A', 5, 'Math', 'Using Pythagorean theorem: c² = a² + b² = 9 + 16 = 25 → c = 5.', '2025-12-10 10:17:51', 1);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `last_login` timestamp NULL DEFAULT NULL,
  `total_score` int(11) DEFAULT 0,
  `games_played` int(11) DEFAULT 0,
  `highest_streak` int(11) DEFAULT 0,
  `profile_pic` varchar(255) DEFAULT 'default.png',
  `is_active` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `username`, `email`, `password_hash`, `created_at`, `last_login`, `total_score`, `games_played`, `highest_streak`, `profile_pic`, `is_active`) VALUES
(1, 'soufiane', 'soufianetajri@gmail.com', '$2y$10$PzI.1cLw0VrQuDF4v11S2uMlss8N47fnB.62ocqz0ZoZfnfmW8S2.', '2025-12-09 12:31:34', NULL, 47, 0, 0, 'default.png', 1),
(2, 'nabil', 'nabil@gmail.com', '$2y$10$F/aknYnyDytBiUYGO11YNu/U6fVJduP.1q98jo4Zlhhj/YVwEeB5i', '2025-12-10 07:49:24', NULL, 15, 0, 0, 'default.png', 1),
(3, 'fjaiki', 'flaiki@gmail.com', '$2y$10$JTYQkyxgAiZ0PLv59vlEp.EIWMX1I2fNiJ9viql1w/0cnIcrv/vNm', '2025-12-17 09:10:00', NULL, -1, 0, 0, 'default.png', 1);

-- --------------------------------------------------------

--
-- Table structure for table `user_answers`
--

CREATE TABLE `user_answers` (
  `answer_id` int(11) NOT NULL,
  `session_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `question_id` int(11) NOT NULL,
  `selected_answer` char(1) DEFAULT NULL,
  `is_correct` tinyint(1) DEFAULT NULL,
  `difficulty_at_time` int(11) DEFAULT NULL,
  `time_taken` int(11) DEFAULT 0,
  `answered_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_answers`
--

INSERT INTO `user_answers` (`answer_id`, `session_id`, `user_id`, `question_id`, `selected_answer`, `is_correct`, `difficulty_at_time`, `time_taken`, `answered_at`) VALUES
(1, 4, 1, 16, 'B', 1, 1, 0, '2025-12-10 10:19:06'),
(2, 4, 1, 15, 'A', 0, 1, 0, '2025-12-10 10:19:13'),
(3, 4, 1, 43, 'A', 0, 1, 0, '2025-12-10 10:19:22'),
(4, 4, 1, 25, 'B', 1, 1, 0, '2025-12-10 10:19:32'),
(5, 4, 1, 25, 'B', 1, 1, 0, '2025-12-10 10:19:39'),
(6, 4, 1, 35, 'B', 1, 2, 0, '2025-12-10 10:19:43'),
(7, 4, 1, 29, 'B', 1, 2, 0, '2025-12-10 10:19:51'),
(8, 5, 1, 29, 'A', 0, 1, 0, '2025-12-10 11:25:21'),
(9, 5, 1, 43, 'B', 1, 1, 0, '2025-12-10 11:25:28'),
(10, 7, 3, 43, 'D', 0, 1, 0, '2025-12-17 09:10:28'),
(11, 7, 3, 16, 'B', 1, 1, 0, '2025-12-17 09:10:36'),
(12, 7, 3, 15, 'D', 0, 1, 0, '2025-12-17 09:10:44'),
(13, 8, 1, 35, 'B', 1, 1, 0, '2025-12-17 09:12:38'),
(14, 8, 1, 15, 'A', 0, 1, 0, '2025-12-17 09:12:43'),
(15, 9, 1, 16, 'A', 0, 1, 0, '2026-01-12 18:50:20'),
(16, 9, 1, 43, 'A', 0, 1, 0, '2026-01-12 18:50:40'),
(17, 9, 1, 15, 'B', 1, 1, 0, '2026-01-12 18:50:46'),
(18, 9, 1, 18, 'B', 1, 1, 0, '2026-01-12 18:50:51'),
(19, 9, 1, 35, 'B', 1, 1, 0, '2026-01-12 18:50:56'),
(20, 9, 1, 36, 'D', 0, 2, 0, '2026-01-12 18:51:01');

-- --------------------------------------------------------

--
-- Structure for view `leaderboard`
--
DROP TABLE IF EXISTS `leaderboard`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `leaderboard`  AS SELECT `u`.`user_id` AS `user_id`, `u`.`username` AS `username`, `u`.`profile_pic` AS `profile_pic`, coalesce(sum(`gs`.`final_score`),0) AS `total_score`, count(distinct `gs`.`session_id`) AS `total_games`, max(`gs`.`highest_difficulty_reached`) AS `max_difficulty`, rank() over ( order by coalesce(sum(`gs`.`final_score`),0) desc) AS `rank_position` FROM (`users` `u` left join `game_sessions` `gs` on(`u`.`user_id` = `gs`.`user_id`)) WHERE `u`.`is_active` = 1 GROUP BY `u`.`user_id`, `u`.`username`, `u`.`profile_pic` ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `game_sessions`
--
ALTER TABLE `game_sessions`
  ADD PRIMARY KEY (`session_id`),
  ADD KEY `idx_user_time` (`user_id`,`start_time`);

--
-- Indexes for table `questions`
--
ALTER TABLE `questions`
  ADD PRIMARY KEY (`question_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `user_answers`
--
ALTER TABLE `user_answers`
  ADD PRIMARY KEY (`answer_id`),
  ADD KEY `session_id` (`session_id`),
  ADD KEY `question_id` (`question_id`),
  ADD KEY `idx_user_session` (`user_id`,`session_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `game_sessions`
--
ALTER TABLE `game_sessions`
  MODIFY `session_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `questions`
--
ALTER TABLE `questions`
  MODIFY `question_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `user_answers`
--
ALTER TABLE `user_answers`
  MODIFY `answer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `game_sessions`
--
ALTER TABLE `game_sessions`
  ADD CONSTRAINT `game_sessions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `user_answers`
--
ALTER TABLE `user_answers`
  ADD CONSTRAINT `user_answers_ibfk_1` FOREIGN KEY (`session_id`) REFERENCES `game_sessions` (`session_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_answers_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_answers_ibfk_3` FOREIGN KEY (`question_id`) REFERENCES `questions` (`question_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
