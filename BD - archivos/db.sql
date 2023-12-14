create database proyecto_salvame;

use proyecto_salvame;

ALTER USER 'root'@'localhost' IDENTIFIED BY 'spideyforever';
FLUSH PRIVILEGES;

-- Crear una tabla para perfil_usuario
CREATE TABLE perfil_usuario (
  idPerfilUsuario INT PRIMARY KEY AUTO_INCREMENT,
  rol ENUM('Basico', 'Moderador', 'Administrador') NOT NULL
);

INSERT INTO perfil_usuario(rol) VALUES ('Basico');
INSERT INTO perfil_usuario(rol) VALUES ('Basico');
INSERT INTO perfil_usuario(rol) VALUES ('Basico');


-- Crear una tabla para usuario_basico
CREATE TABLE usuario_basico (
  idPerfilUsuario INT PRIMARY KEY AUTO_INCREMENT,
  nombres VARCHAR(30) NOT NULL,
  apellidos VARCHAR(30) NOT NULL,
  dni VARCHAR(8) UNIQUE NOT NULL,
  correo VARCHAR(50) UNIQUE NOT NULL,
  contraseña varchar(50) NOT NULL,
  fechaNac DATE NOT NULL,
  FOREIGN KEY (idPerfilUsuario) REFERENCES perfil_usuario(idPerfilUsuario)
);

INSERT INTO usuario_basico (nombres, apellidos, dni, correo, contraseña, fechaNac) VALUES
  ('Darwin Karls', 'Mendoza Bermejo', '77354147', 'darw.mendz@gmail.com', '123456', '2000-01-01');

-- Primer registro
INSERT INTO usuario_basico (nombres, apellidos, dni, correo, contraseña, fechaNac) VALUES
  ('María Tan', 'González Pérez', '54872369', 'maria.g@gmail.com', 'password123', '1995-03-15');

-- Segundo registro
INSERT INTO usuario_basico (nombres, apellidos, dni, correo, contraseña, fechaNac) VALUES
  ('Juan Ful', 'Martínez López', '71583426', 'juan.m@gmail.com', 'securepwd', '1992-09-22');



-- Crear una tabla para usuario_especial
CREATE TABLE usuario_especial (
  idPerfilUsuario INT PRIMARY KEY AUTO_INCREMENT,
  correo VARCHAR(255) NOT NULL UNIQUE,
  tipoDocumento VARCHAR(20) NOT NULL,
  nroDocumento VARCHAR(20) NOT NULL UNIQUE,
  nombres VARCHAR(30) NOT NULL,
  apellidos VARCHAR(30) NOT NULL,
  direccion VARCHAR(30),
  distrito VARCHAR(30) NOT NULL,
  provincia VARCHAR(30) NOT NULL,
  departamento VARCHAR(30) NOT NULL,
  genero VARCHAR(30),
  telefono VARCHAR(30),
  contraseña varchar(50),
  fechaNac DATE NOT NULL,
  imgDNI BLOB,
  imgCertiONG BLOB,
  FOREIGN KEY (idPerfilUsuario) REFERENCES perfil_usuario(idPerfilUsuario)
);

-- Crear una tabla para animal
CREATE TABLE animal (
  idAnimal int PRIMARY KEY auto_increment,
  nombreCientifico VARCHAR(30),
  nombreComun VARCHAR(30) NOT NULL,
  familia VARCHAR(30) NOT NULL,
  especie VARCHAR(30) NOT NULL,
  genero VARCHAR(20),
  descripcion VARCHAR(200) NOT NULL
);


-- Crear una tabla para ubicacion
CREATE TABLE ubicacion (
  codigoPostal int PRIMARY KEY,
  longitud DECIMAL(10, 6) NOT NULL,
  latitud DECIMAL(10, 6) NOT NULL,
  altitud DECIMAL(10, 6) NOT NULL,
  direccion VARCHAR(30) NOT NULL,
  provincia VARCHAR(30),
  departamento VARCHAR(30)
);

-- Primer registro
INSERT INTO ubicacion (codigoPostal, longitud, latitud, altitud, direccion, provincia, departamento)
VALUES (12345, 45.678901, -67.890123, 100.567890, 'Calle Principal 123', 'Provincia A', 'Departamento X');

-- Segundo registro
INSERT INTO ubicacion (codigoPostal, longitud, latitud, altitud, direccion, provincia, departamento)
VALUES (54321, 34.567890, -78.901234, 200.678901, 'Avenida Central 456', 'Provincia B', 'Departamento Y');

-- Tercer registro
INSERT INTO ubicacion (codigoPostal, longitud, latitud, altitud, direccion, provincia, departamento)
VALUES (67890, 12.345678, -45.678901, 150.123456, 'Calle Secundaria 789', 'Provincia A', 'Departamento X');

-- Cuarto registro
INSERT INTO ubicacion (codigoPostal, longitud, latitud, altitud, direccion, provincia, departamento)
VALUES (23456, -23.456789, 56.789012, 300.234567, 'Calle Norte 101', 'Provincia C', 'Departamento Z');

-- Quinto registro
INSERT INTO ubicacion (codigoPostal, longitud, latitud, altitud, direccion, provincia, departamento)
VALUES (78901, 67.890123, -12.345678, 180.901234, 'Avenida Este 789', 'Provincia D', 'Departamento W');



CREATE TABLE historial_alerta (
  idHistorialA INT PRIMARY KEY AUTO_INCREMENT,
  tipoAlerta ENUM('Anonimo', 'Normal') NOT NULL,
  estatus ENUM('Sin Revisar', 'Revisado', 'Aceptado', 'Rechazado') NOT NULL
);

-- Primer registro
INSERT INTO historial_alerta (tipoAlerta, estatus) VALUES ('Normal', 'Sin Revisar');

-- Segundo registro
INSERT INTO historial_alerta (tipoAlerta, estatus) VALUES ('Anonimo', 'Revisado');

-- Tercer registro
INSERT INTO historial_alerta (tipoAlerta, estatus) VALUES ('Normal', 'Aceptado');

-- Cuarto registro
INSERT INTO historial_alerta (tipoAlerta, estatus) VALUES ('Normal', 'Rechazado');

-- Quinto registro
INSERT INTO historial_alerta (tipoAlerta, estatus) VALUES ('Anonimo', 'Sin Revisar');



-- Crear una tabla para historial_alerta
create table alerta_anonima(
  idAlerta int PRIMARY KEY,
  codigoPostal int NOT NULL,
  idHistorialA int NOT NULL,
  idAnimal int,
  fechaAlerta date NOT NULL,
  horaAlerta timestamp NOT NULL,
  descripcionAnimal VARCHAR(30),
  descripcionHechos VARCHAR(30),
  imgEvidencia VARCHAR(50),
  FOREIGN KEY (codigoPostal) REFERENCES ubicacion(codigoPostal),
  FOREIGN KEY (idHistorialA) REFERENCES historial_alerta(idHistorialA),
  FOREIGN KEY (idAnimal) REFERENCES animal(idAnimal)
);

-- Crear una tabla para alerta
CREATE TABLE alerta (
  idAlerta int PRIMARY KEY auto_increment,
  nroDocumento varchar(10),
  codigoPostal int NOT NULL,
  idHistorialA int NOT NULL,
  idAnimal int,
  fechaAlerta date NOT NULL,
  horaAlerta timestamp NOT NULL,
  descripcionAnimal VARCHAR(30),
  descripcionHechos VARCHAR(30),
  imgEvidencia VARCHAR(50) ,
  FOREIGN KEY (nroDocumento) REFERENCES usuario_basico(dni),
  FOREIGN KEY (codigoPostal) REFERENCES ubicacion(codigoPostal),
  FOREIGN KEY (idHistorialA) REFERENCES historial_alerta(idHistorialA),
  FOREIGN KEY (idAnimal) REFERENCES animal(idAnimal)
);

-- Primer registro
INSERT INTO alerta (nroDocumento, codigoPostal, idHistorialA, fechaAlerta, horaAlerta, descripcionAnimal, descripcionHechos, imgEvidencia)
VALUES ('77354147', 12345, 1, '2023-12-15', '2023-12-15 10:30:00', 'Gato', 'Incidente en la calle', 'imagen1.jpg');

-- Segundo registro
INSERT INTO alerta (nroDocumento, codigoPostal, idHistorialA, fechaAlerta, horaAlerta, descripcionAnimal, descripcionHechos, imgEvidencia)
VALUES ('54872369', 54321, 2, '2023-12-14', '2023-12-14 15:45:00', 'Perro', 'Encontrado en el parque', 'imagen2.jpg');

-- Tercer registro
INSERT INTO alerta (nroDocumento, codigoPostal, idHistorialA, fechaAlerta, horaAlerta, descripcionAnimal, descripcionHechos, imgEvidencia)
VALUES ('71583426', 67890, 3, '2023-12-13', '2023-12-13 08:15:00', 'Gato', 'Desaparecido desde ayer', 'imagen3.jpg');

-- Cuarto registro
INSERT INTO alerta (nroDocumento, codigoPostal, idHistorialA, fechaAlerta, horaAlerta, descripcionAnimal, descripcionHechos, imgEvidencia)
VALUES ('77354147', 12345, 4, '2023-12-12', '2023-12-12 14:20:00', 'Perro', 'Accidente en la calle', 'imagen4.jpg');

-- Quinto registro
INSERT INTO alerta (nroDocumento, codigoPostal, idHistorialA, fechaAlerta, horaAlerta, descripcionAnimal, descripcionHechos, imgEvidencia)
VALUES ('54872369', 78901, 5, '2023-12-11', '2023-12-11 11:55:00', 'Gato', 'Encontrado en el parque', 'imagen5.jpg');



DELIMITER //
CREATE PROCEDURE GetNormalAlerts()
BEGIN
    SELECT
        a.fechaAlerta AS FechaAlerta,
        a.idAlerta AS IDAlerta,
        CASE WHEN ha.tipoAlerta = 'Normal' THEN ha.estatus ELSE NULL END AS Estatus
    FROM
        alerta a
    INNER JOIN
        historial_alerta ha ON a.idHistorialA = ha.idHistorialA
    WHERE
        ha.tipoAlerta = 'Normal';
END 
//DELIMITER ;

