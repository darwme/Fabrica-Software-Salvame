create database proyecto_salvame;

use proyecto_salvame;

ALTER USER 'root'@'localhost' IDENTIFIED BY 'spideyforever';
FLUSH PRIVILEGES;



-- Crear una tabla para perfil_usuario
CREATE TABLE perfil_usuario (
  idPerfilUsuario int PRIMARY KEY auto_increment,
  rol VARCHAR(30) NOT NULL
);



-- Crear una tabla para usuario_basico
CREATE TABLE usuario_basico (
  idUsuarioBasico int primary key auto_increment,
  idPerfilUsuario int,
  nombres VARCHAR(30) NOT NULL,
  apellidos VARCHAR(30) NOT NULL,
  correo VARCHAR(50),
  contraseña varchar(50),
  fechaNac DATE NOT NULL,
  FOREIGN KEY (idPerfilUsuario) REFERENCES perfil_usuario(idPerfilUsuario)
);


-- Crear una tabla para usuario_especial
CREATE TABLE usuario_especial (
  nroDocumento varchar(10) PRIMARY KEY,
  idPerfilUsuario int,
  nombres VARCHAR(30) NOT NULL,
  apellidos VARCHAR(30) NOT NULL,
  direccion VARCHAR(30),
  distrito VARCHAR(30) NOT NULL,
  provincia VARCHAR(30) NOT NULL,
  departamento VARCHAR(30) NOT NULL,
  genero VARCHAR(30),
  telefono VARCHAR(30),
  correo VARCHAR(50) NOT NULL,
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



-- Crear una tabla para historial_alerta
CREATE TABLE historial_alerta (
  idHistorialA int PRIMARY KEY auto_increment,
  tipoAlerta varchar(30),
  estatus VARCHAR(20) NOT NULL
);

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
  FOREIGN KEY (nroDocumento) REFERENCES usuario_especial(nroDocumento),
  FOREIGN KEY (codigoPostal) REFERENCES ubicacion(codigoPostal),
  FOREIGN KEY (idHistorialA) REFERENCES historial_alerta(idHistorialA),
  FOREIGN KEY (idAnimal) REFERENCES animal(idAnimal)
);


INSERT INTO perfil_usuario (rol) VALUES
  ('Administrador'),
  ('Usuario Basico'),
  ('Usuario Especial');



CREATE PROCEDURE GetAlertsInfo()
BEGIN
    SELECT 
        a.idAlerta AS AlertNumber,
        COALESCE(aa.fechaAlerta, a.fechaAlerta) AS FechaPublicacion,
        ha.tipoAlerta AS TipoAlerta,
        ha.estatus AS EstadoAlerta
    FROM 
        alerta a
        LEFT JOIN alerta_anonima aa ON a.idAlerta = aa.idAlerta
        INNER JOIN historial_alerta ha ON ha.idHistorialA = a.idHistorialA
    UNION
    SELECT 
        aa.idAlerta AS AlertNumber,
        aa.fechaAlerta AS FechaPublicacion,
        ha.tipoAlerta AS TipoAlerta,
        ha.estatus AS EstadoAlerta
    FROM 
        alerta_anonima aa
        INNER JOIN historial_alerta ha ON ha.idHistorialA = aa.idHistorialA;
END 
