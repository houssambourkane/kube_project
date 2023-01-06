SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


CREATE TABLE `langue` (
  `id` int(11) NOT NULL,
  `langue` varchar(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `langue` (`id`, `langue`) VALUES
(1, 'french');

ALTER TABLE `langue`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `langue`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;
