

CREATE DATABASE desafio-3-luis-peña-127


create table usuarios (
ID serial,
email varchar(50),
nombre varchar(50),
apellido varchar(50),
rol varchar);

SELECT * from usuarios;

INSERT INTO usuarios ( email,nombre,apellido,rol)
VALUES(
'usuario1@gmail.com','pedro','perez','usuario'),
('usuario2@gmail.com','carlos','flores','administrador'),
('usuario3@gmail.com','luis','gonzales','usuario'),
('usuario4@gmail.com','miguel','rivas','usuario'),
('usuario5@gmail.com','adrian','ruiz','usuario');

SELECT * FROM usuarios;


create table post(
	ID serial,
titulo varchar(150),
contenido text,
fecha_creacion timestamp,
fecha_actualizacion timestamp,
destacado boolean,
usuario_id bigint
);


SELECT * from post;

INSERT INTO post(titulo,contenido,fecha_creacion,fecha_actualizacion,destacado,usuario_id)
VALUES('titulo1','contenido1',NOW(),NOW(),true,2);

INSERT INTO post(titulo,contenido,fecha_creacion,fecha_actualizacion,destacado,usuario_id)
VALUES('titulo2','contenido2',NOW(),NOW(),true,2);

INSERT INTO post(titulo,contenido,fecha_creacion,fecha_actualizacion,destacado,usuario_id)
VALUES('titulo3','contenido3',NOW(),NOW(),true,1);

INSERT INTO post(titulo,contenido,fecha_creacion,fecha_actualizacion,destacado,usuario_id)
VALUES('titulo4','contenido4',NOW(),NOW(),false,4);

INSERT INTO post(titulo,contenido,fecha_creacion,fecha_actualizacion,destacado,usuario_id)
VALUES('titulo5','contenido5',NOW(),NOW(),true,NULL);


SELECT * from post;


create table comentario(
	ID serial,
contenido text,
fecha_creacion timestamp,
usuario_id bigint,
post_id bigint);


SELECT * from comentario;


INSERT INTO comentario(contenido,fecha_creacion,usuario_id,post_id)
VALUES('comentario1',NOW(),1,1);

INSERT INTO comentario(contenido,fecha_creacion,usuario_id,post_id)
VALUES('comentario2',NOW(),2,1);

INSERT INTO comentario(contenido,fecha_creacion,usuario_id,post_id)
VALUES('comentario3',NOW(),3,1);

INSERT INTO comentario(contenido,fecha_creacion,usuario_id,post_id)
VALUES('comentario4',NOW(),1,2);

INSERT INTO comentario(contenido,fecha_creacion,usuario_id,post_id)
VALUES('comentario5',NOW(),4,2);


SELECT * from comentario;



-- Cruza los datos de la tabla usuarios y posts mostrando las siguientes columnas.
-- nombre e email del usuario junto al título y contenido del post. (1 Punto)

SELECT usuarios.nombre,usuarios.email,post.titulo,post.contenido
FROM usuarios
JOIN post ON usuarios.id = post.usuario_id;


-- Muestra el id, título y contenido de los posts de los administradores. El
-- administrador puede ser cualquier id y debe ser seleccionado dinámicamente.
-- (1 Punto).


SELECT post.id,post.titulo,post.contenido
FROM post
JOIN usuarios ON post.usuario_id = usuarios.id WHERE rol = 'administrador';




-- Cuenta la cantidad de posts de cada usuario. La tabla resultante debe mostrar el id
-- e email del usuario junto con la cantidad de posts de cada usuario. (1 Punto)


SELECT usuarios.id,usuarios.email,COUNT(post.id)
FROM usuarios
LEFT JOIN post ON usuarios.id = post.usuario_id 
GROUP BY usuarios.id,usuarios.email;



-- Muestra el email del usuario que ha creado más posts. Aquí la tabla resultante tiene
-- un único registro y muestra solo el email. (1 Punto)

SELECT usuarios.email
FROM usuarios
JOIN post ON usuarios.id = post.usuario_id
GROUP BY usuarios.email
ORDER BY COUNT(post.usuario_id) DESC 
LIMIT 1;

--  Muestra la fecha del último post de cada usuario. (1 Punto)

SELECT MAX (fecha_creacion)
FROM usuarios 
JOIN post ON usuarios.id = post.usuario_id
GROUP BY usuarios.id;

--  Muestra el título y contenido del post (artículo) con más comentarios. (1 Punto)


SELECT *
FROM post
JOIN comentario ON post.id = comentario.post_id;

--  Muestra en una tabla el título de cada post, el contenido de cada post y el contenido
-- de cada comentario asociado a los posts mostrados, junto con el email del usuario
-- que lo escribió. (1 Punto)

SELECT p.titulo , p.contenido as contenido_post ,c.contenido as contenido_comentario, u.email 
from comentario c
JOIN post p ON p.id = c.post_id
JOIN usuarios u ON u.id = c.usuario_id;


--  Muestra el contenido del último comentario de cada usuario. (1 Punto)

SELECT c.usuario_id,MAX(c.fecha_creacion) as fecha
from comentario c  
GROUP BY  c.usuario_id;

--  Muestra los emails de los usuarios que no han escrito ningún comentario. (1 Punto)


SELECT * from usuarios u
LEFT JOIN comentario c on c.usuario_id = u.id
WHERE c.id is NULL;