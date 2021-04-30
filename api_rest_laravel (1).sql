-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3306
-- Tiempo de generación: 30-04-2021 a las 00:39:59
-- Versión del servidor: 5.7.31
-- Versión de PHP: 7.3.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `api_rest_laravel`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categories`
--

DROP TABLE IF EXISTS `categories`;
CREATE TABLE IF NOT EXISTS `categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `categories`
--

INSERT INTO `categories` (`id`, `name`, `created_at`, `updated_at`) VALUES
(2, 'Tecnología', '2021-02-13 11:15:32', '2021-02-20 19:05:58'),
(3, 'VideoJuegos', '2021-02-20 00:20:57', '2021-02-20 00:20:57'),
(4, 'Motos', '2021-02-20 18:48:05', '2021-02-20 18:48:05'),
(5, 'Automoviles', '2021-02-20 18:53:11', '2021-02-20 19:03:31'),
(6, 'Peliculas', '2021-02-21 15:38:49', '2021-02-21 15:38:49'),
(7, 'Cocina', '2021-03-07 17:11:04', '2021-03-07 17:11:04'),
(15, 'Limpieza', '2021-03-07 17:23:37', '2021-03-07 17:23:37'),
(21, 'Ahre', '2021-03-07 17:49:12', '2021-03-07 17:49:12');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `posts`
--

DROP TABLE IF EXISTS `posts`;
CREATE TABLE IF NOT EXISTS `posts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_post_user` (`user_id`),
  KEY `fk_post_category` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `posts`
--

INSERT INTO `posts` (`id`, `user_id`, `category_id`, `title`, `content`, `image`, `created_at`, `updated_at`) VALUES
(24, 34, 2, 'University Of Languages', '<p><strong>¿Querés llevar tu enseñanza a otro nivel?</strong></p><hr><p><strong><em>Aprendé con nosotros - ONLINE</em></strong></p><p>Capacitaciones: Ingles</p>', '16156652671.png', '2021-03-11 20:56:34', '2021-03-13 17:59:42'),
(25, 26, 15, 'Entrada de Alejandro Chicala', '<p>al; text-decoration-color: initial; display: inline !important; float: none;\'>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis tincidunt posuere magna, nec consectetur arcu ultricies et. Maecenas efficitur mi eros, eget commodo dui ornare ac. Pellentesque condimentum dui diam. Sed elementum ipsum sed condimentum rutrum. Vestibulum et dolor nulla. Vivamus sit amet vehicula eros. Ut in efficitur erat, at posuere ligula.</span> </p>', NULL, '2021-03-11 20:57:19', '2021-03-11 20:57:19'),
(26, 26, 4, 'Hola ahre', '<p>que <strong><em>dices</em></strong></p>', '1615497907default-placeholder.png', '2021-03-11 21:25:07', '2021-03-11 21:25:07'),
(58, 34, 15, 'Catálogo xd', '<p style=\'margin: 0px 0px 15px; padding: 0px; text-align: justify; color: rgb(0, 0, 0); font-family: \"Open Sans\", Arial, sans-serif; font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\'><strong><em>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur a luctus magna, quis faucibus dolor. Sed finibus, diam non fringilla mattis, quam erat porta felis, eget ornare purus libero sit amet neque. In a tellus molestie felis sollicitudin aliquet sed sed felis. Proin ac dolor ac sapien sagittis molestie et vel ex. Praesent blandit lectus arcu, quis iaculis justo ornare eget.</em></strong></p><hr><p>Vivamus euismod ullamcorper sapien, et volutpat tortor ullamcorper vel. Fusce vehicula purus in ante iaculis, sed bibendum lacus viverra. Aliquam quam magna, tincidunt at nibh nec, fringilla ultricies erat. Nunc luctus tortor mi. Nam egestas sapien velit, ornare vehicula nunc congue non. In vestibulum, sem at auctor tincidunt, ligula lorem venenatis sem, eu finibus erat felis eget neque. Proin gravida aliquet risus, et suscipit nisl mollis at. In felis augue, luctus nec magna sit amet, hendrerit mattis ex. Sed gravida felis ut urna tempor accumsan. <u><em><strong>Aenean sed vulputate ligula, at suscipit ante.</strong></em></u></p><p style=\'margin: 0px 0px 15px; padding: 0px; text-align: justify; color: rgb(0, 0, 0); font-family: \"Open Sans\", Arial, sans-serif; font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\'>Curabitur id tristique erat, eget ultrices ante. Aenean ut mauris molestie, molestie tellus quis, venenatis mi. Nullam nulla elit, varius ut volutpat non, efficitur sed nisl. Praesent nec placerat tortor. Etiam eget nulla nunc. Nunc in enim ac libero accumsan suscipit ut eu mauris. Proin vehicula nunc nec neque tristique, et semper lacus consectetur. Quisque vel ligula in dui vestibulum condimentum. In hac habitasse platea dictumst. Integer auctor magna non pretium maximus. Curabitur vel auctor leo, in suscipit quam. Duis non gravida nibh, ut varius enim. Lorem ipsum dolor sit amet, consectetur adipiscing elit. In vitae massa molestie, maximus neque nec, vulputate tortor.</p><p style=\'margin: 0px 0px 15px; padding: 0px; text-align: justify; color: rgb(0, 0, 0); font-family: \"Open Sans\", Arial, sans-serif; font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\'>Suspendisse dapibus fringilla tincidunt. In hac habitasse platea dictumst. Aliquam condimentum congue pulvinar. Vestibulum ultricies quam turpis, vitae laoreet dolor vehicula nec. Etiam vulputate purus egestas libero ultrices, id convallis purus ultrices. Proin id mauris mauris. Duis sit amet porta nunc. Proin elementum risus euismod accumsan ullamcorper. Nam porttitor quam ut urna sodales, ut tristique tellus lacinia. Sed feugiat aliquam elit, ac lacinia est sodales sed. Suspendisse et sapien ullamcorper, laoreet velit at, aliquet leo. Sed tempor rutrum tortor, ullamcorper tristique tortor placerat eu. Curabitur facilisis, mauris non blandit consequat, massa ligula auctor purus, nec ornare enim lorem eget est.</p><p style=\'margin: 0px 0px 15px; padding: 0px; text-align: justify; color: rgb(0, 0, 0); font-family: \"Open Sans\", Arial, sans-serif; font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\'>Donec quis metus tempor, faucibus nisi sit amet, malesuada nibh. Maecenas sit amet convallis nibh. Duis fermentum dui quis consectetur molestie. Aenean quis vehicula massa. In hac habitasse platea dictumst. Suspendisse faucibus egestas diam sed varius. Maecenas vulputate ornare sem ut consequat. Aliquam sit amet scelerisque ligula. Ut dapibus lorem id gravida rutrum.</p><p style=\'margin: 0px 0px 15px; padding: 0px; text-align: justify; color: rgb(0, 0, 0); font-family: \"Open Sans\", Arial, sans-serif; font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\'>Aliquam sit amet varius felis. In sollicitudin odio nec euismod iaculis. In cursus massa sem, ac interdum lectus condimentum id. Suspendisse pulvinar justo sed lobortis accumsan. Mauris aliquet massa at augue tincidunt, id fringilla dui placerat. Phasellus placerat, arcu id cursus egestas, mauris sapien mattis magna, nec pulvinar erat diam at elit. Ut vulputate sagittis odio eget consequat. Nullam feugiat dapibus dolor. Nullam iaculis pulvinar nunc, ac viverra nisi molestie eu. Ut ullamcorper porttitor mattis. Nullam sed auctor libero. Duis sed libero ac tellus malesuada eleifend. Duis ac facilisis dolor, eget accumsan lacus. Suspendisse in dui vitae sapien suscipit elementum. Fusce fermentum, enim ornare tempus cursus, sem tellus vestibulum mauris, at euismod ipsum mauris et libero.</p><p style=\'margin: 0px 0px 15px; padding: 0px; text-align: justify; color: rgb(0, 0, 0); font-family: \"Open Sans\", Arial, sans-serif; font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\'>Curabitur id tristique erat, eget ultrices ante. Aenean ut mauris molestie, molestie tellus quis, venenatis mi. Nullam nulla elit, varius ut volutpat non, efficitur sed nisl. Praesent nec placerat tortor. Etiam eget nulla nunc. Nunc in enim ac libero accumsan suscipit ut eu mauris. Proin vehicula nunc nec neque tristique, et semper lacus consectetur. Quisque vel ligula in dui vestibulum condimentum. In hac habitasse platea dictumst. Integer auctor magna non pretium maximus. Curabitur vel auctor leo, in suscipit quam. Duis non gravida nibh, ut varius enim. Lorem ipsum dolor sit amet, consectetur adipiscing elit. In vitae massa molestie, maximus neque nec, vulputate tortor.</p><p style=\'margin: 0px 0px 15px; padding: 0px; text-align: justify; color: rgb(0, 0, 0); font-family: \"Open Sans\", Arial, sans-serif; font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\'>Suspendisse dapibus fringilla tincidunt. In hac habitasse platea dictumst. Aliquam condimentum congue pulvinar. Vestibulum ultricies quam turpis, vitae laoreet dolor vehicula nec. Etiam vulputate purus egestas libero ultrices, id convallis purus ultrices. Proin id mauris mauris. Duis sit amet porta nunc. Proin elementum risus euismod accumsan ullamcorper. Nam porttitor quam ut urna sodales, ut tristique tellus lacinia. Sed feugiat aliquam elit, ac lacinia est sodales sed. Suspendisse et sapien ullamcorper, laoreet velit at, aliquet leo. Sed tempor rutrum tortor, ullamcorper tristique tortor placerat eu. Curabitur facilisis, mauris non blandit consequat, massa ligula auctor purus, nec ornare enim lorem eget est.</p><p style=\'margin: 0px 0px 15px; padding: 0px; text-align: justify; color: rgb(0, 0, 0); font-family: \"Open Sans\", Arial, sans-serif; font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\'>Curabitur id tristique erat, eget ultrices ante. Aenean ut mauris molestie, molestie tellus quis, venenatis mi. Nullam nulla elit, varius ut volutpat non, efficitur sed nisl. Praesent nec placerat tortor. Etiam eget nulla nunc. Nunc in enim ac libero accumsan suscipit ut eu mauris. Proin vehicula nunc nec neque tristique, et semper lacus consectetur. Quisque vel ligula in dui vestibulum condimentum. In hac habitasse platea dictumst. Integer auctor magna non pretium maximus. Curabitur vel auctor leo, in suscipit quam. Duis non gravida nibh, ut varius enim. Lorem ipsum dolor sit amet, consectetur adipiscing elit. In vitae massa molestie, maximus neque nec, vulputate tortor.</p><p style=\'margin: 0px 0px 15px; padding: 0px; text-align: justify; color: rgb(0, 0, 0); font-family: \"Open Sans\", Arial, sans-serif; font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\'>Suspendisse dapibus fringilla tincidunt. In hac habitasse platea dictumst. Aliquam condimentum congue pulvinar. Vestibulum ultricies quam turpis, vitae laoreet dolor vehicula nec. Etiam vulputate purus egestas libero ultrices, id convallis purus ultrices. Proin id mauris mauris. Duis sit amet porta nunc. Proin elementum risus euismod accumsan ullamcorper. Nam porttitor quam ut urna sodales, ut tristique tellus lacinia. Sed feugiat aliquam elit, ac lacinia est sodales sed. Suspendisse et sapien ullamcorper, laoreet velit at, aliquet leo. Sed tempor rutrum tortor, ullamcorper tristique tortor placerat eu. Curabitur facilisis, mauris non blandit consequat, massa ligula auctor purus, nec ornare enim lorem eget est.</p>', '1615663553U of Sales.png', '2021-03-13 19:25:54', '2021-03-13 19:25:54'),
(59, 34, 4, 'España es un buen país', '<p>Contenido del post España es un buen país :)</p>', '1617234915asddd.jpg', '2021-03-31 23:05:37', '2021-03-31 23:05:37');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `surname` varchar(100) DEFAULT NULL,
  `role` varchar(20) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `description` text,
  `image` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `remember_token` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `name`, `surname`, `role`, `email`, `password`, `description`, `image`, `created_at`, `updated_at`, `remember_token`) VALUES
(18, 'Alejandro', 'Chicala', 'ROLE_USER', 'chicalaale6xdD@gmail.com', '$2y$04$./mT6LcoRlnTYRGLNhBXp.eAryT.FPuXqjp83PY4dxJFjxk6mfYvK', NULL, NULL, '2021-02-17 15:55:08', '2021-02-17 15:55:08', NULL),
(19, 'Alejandro', 'Chicala', 'ROLE_USER', 'ale_chicala@gmail.com', '$2y$04$4LIvVQ5pUa187iw2w7N5/OxA3B7zpRG8b/thXgBf.BtScuuCSBZr2', NULL, NULL, '2021-02-17 15:58:19', '2021-02-17 15:58:19', NULL),
(20, 'Romina', 'Caballero', 'ROLE_USER', 'romy@gmail.com', '5994471abb01112afcc18159f6cc74b4f511b99806da59b3caf5a9c173cacfc5', NULL, NULL, '2021-02-17 16:40:10', '2021-02-17 16:40:10', NULL),
(21, 'Pruebita222', 'ApellidoPruebita', 'ROLE_USER', 'prueba@prueba.com', '655e786674d9d3e77bc05ed1de37b4b6bc89f788829f9f3c679e7687b410c89b', NULL, NULL, '2021-02-20 01:52:58', '2021-02-20 02:16:39', NULL),
(22, 'asdasd', 'sadasda', 'ROLE_USER', 'asdas@asd.com', 'c5273884b90d490134e7737b29a65405cea0f7bb786ca82c6337ceb24de6f5ed', NULL, NULL, '2021-03-05 10:17:30', '2021-03-05 10:17:30', NULL),
(23, 'qwe', 'qwewqe', 'ROLE_USER', 'qweq@wqe.csa', '688787d8ff144c502c7f5cffaafe2cc588d86079f9de88304c26b0cb99ce91c6', NULL, NULL, '2021-03-05 10:19:52', '2021-03-05 10:19:52', NULL),
(25, 'David', 'Lopez', 'ROLE_USER', 'david@david.com', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', NULL, NULL, '2021-03-05 10:23:49', '2021-03-05 10:23:49', NULL),
(26, 'Alejandro Andres', 'Chicala', 'ROLE_USER', 'asd@asd.com', '688787d8ff144c502c7f5cffaafe2cc588d86079f9de88304c26b0cb99ce91c6', '<p><strong>Ahre</strong></p>', '1615662495pexels-david-geib-3268732.jpg', '2021-03-05 10:26:25', '2021-03-13 19:13:55', NULL),
(27, 'asd', 'asd', 'ROLE_USER', 'asd@asd.comc', '688787d8ff144c502c7f5cffaafe2cc588d86079f9de88304c26b0cb99ce91c6', NULL, NULL, '2021-03-05 10:44:05', '2021-03-05 10:44:05', NULL),
(28, 'asd', 'asd', 'ROLE_USER', 'asd@asd.comw', '688787d8ff144c502c7f5cffaafe2cc588d86079f9de88304c26b0cb99ce91c6', NULL, NULL, '2021-03-05 10:45:43', '2021-03-05 10:45:43', NULL),
(29, 'asd', 'asd', 'ROLE_USER', 'asd@asd.cq', '688787d8ff144c502c7f5cffaafe2cc588d86079f9de88304c26b0cb99ce91c6', NULL, NULL, '2021-03-05 10:46:35', '2021-03-05 10:46:35', NULL),
(30, 'asd', 'asd', 'ROLE_USER', 'asd@asd.comx', '688787d8ff144c502c7f5cffaafe2cc588d86079f9de88304c26b0cb99ce91c6', NULL, NULL, '2021-03-05 10:49:03', '2021-03-05 10:49:03', NULL),
(31, 'asd', 'asd', 'ROLE_USER', 'asd@asd.comg', '688787d8ff144c502c7f5cffaafe2cc588d86079f9de88304c26b0cb99ce91c6', NULL, NULL, '2021-03-05 10:50:05', '2021-03-05 10:50:05', NULL),
(32, 'asd', 'asd', 'ROLE_USER', 'asd@asd.comr', '688787d8ff144c502c7f5cffaafe2cc588d86079f9de88304c26b0cb99ce91c6', NULL, NULL, '2021-03-05 10:50:42', '2021-03-05 10:50:42', NULL),
(33, 'asd', 'asd', 'ROLE_USER', 'asd@asd.comz', '688787d8ff144c502c7f5cffaafe2cc588d86079f9de88304c26b0cb99ce91c6', NULL, NULL, '2021-03-05 10:51:32', '2021-03-05 10:51:32', NULL),
(34, 'Alejandro', 'Chicala', 'ROLE_USER', 'a@a.com', 'ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb', '<p>Peluquería <em><strong>profesional.</strong></em></p>', '16156623201.png', '2021-03-06 10:12:33', '2021-03-13 20:05:34', NULL);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `posts`
--
ALTER TABLE `posts`
  ADD CONSTRAINT `fk_post_category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`),
  ADD CONSTRAINT `fk_post_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
