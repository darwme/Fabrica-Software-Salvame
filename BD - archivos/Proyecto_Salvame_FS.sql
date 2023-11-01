CREATE TABLESPACE PROYECTOSALVAME
DATAFILE 'C:\app\Kevin\product\21c\oradata\XE\PROYECTOSALVAME.dbf' --  C:\oraclexe\app\oracle\oradata\
SIZE 50M AUTOEXTEND ON NEXT 4M MAXSIZE 100M
EXTENT MANAGEMENT LOCAL
SEGMENT SPACE MANAGEMENT AUTO
LOGGING;

-- Eliminar Table space
--DROP TABLESPACE PROYECTOSALVAME INCLUDING CONTENTS AND DATAFILES;

--Creacion de Usuario sistemaSalvame: contiene todos los permisos de la base de datos


CREATE USER C##sistema_Salvame IDENTIFIED BY sistema_salvame;
GRANT ALL PRIVILEGES TO C##sistema_salvame;

--probando
--CREATE TABLE historial_alerta (
  --idHistorialA VARCHAR2(30) PRIMARY KEY,
  --estatus VARCHAR2(20) NOT NULL
--) TABLESPACE PROYECTOSALVAME;

--Se debe crear las tablas en el siguiente orden

CREATE TABLE C##sistema_salvame.perfil_usuario (
  idPerfilUsuario CHAR(10) PRIMARY KEY,
  rol VARCHAR2(30) NOT NULL,
  descripcion VARCHAR2(200)  
) TABLESPACE PROYECTOSALVAME;

CREATE TABLE C##sistema_salvame.usuario_basico (
  nroDocumento CHAR(10) PRIMARY KEY,
  idPerfilUsuario CHAR(10),
  FOREIGN KEY (idPerfilUsuario) REFERENCES C##sistema_salvame.perfil_usuario(idPerfilUsuario),
  nombres VARCHAR2(30) NOT NULL,
  apellidos VARCHAR2(30) NOT NULL,
  correo VARCHAR2(50),
  fechaNac DATE NOT NULL
) TABLESPACE PROYECTOSALVAME;

CREATE TABLE C##sistema_salvame.usuario_especial (
  nroDocumento CHAR(10) PRIMARY KEY,
  idPerfilUsuario CHAR(10),
  FOREIGN KEY (idPerfilUsuario) REFERENCES C##sistema_salvame.perfil_usuario(idPerfilUsuario),
  nombres VARCHAR2(30) NOT NULL,
  apellidos VARCHAR2(30) NOT NULL,
  direccion VARCHAR2(30),
  distrito VARCHAR2(30) NOT NULL,
  provincia VARCHAR2(30) NOT NULL,
  departamento VARCHAR2(30) NOT NULL,
  genero VARCHAR2(30),
  telefono VARCHAR2(30),
  correo VARCHAR2(50) NOT NULL,
  fechaNac DATE NOT NULL,
  imgDNI BLOB,
  imgCertiONG  BLOB
) TABLESPACE PROYECTOSALVAME;

CREATE TABLE C##sistema_salvame.animal (
  idAnimal VARCHAR2(30) PRIMARY KEY,
  nombreCientifico VARCHAR2(30),
  nombreComun VARCHAR2(30) NOT NULL,
  familia VARCHAR2(30) NOT NULL,
  especie VARCHAR2(30) NOT NULL,
  genero VARCHAR2(20),
  descripcion VARCHAR2(200) NOT NULL
) TABLESPACE PROYECTOSALVAME;

CREATE TABLE C##sistema_salvame.ubicacion (
  codigoPostal VARCHAR2(30) PRIMARY KEY,
  longitud NUMBER NOT NULL,
  latitud NUMBER NOT NULL,
  altitud NUMBER NOT NULL,
  direccion VARCHAR2(30) NOT NULL,
  provincia VARCHAR2(30),
  departamento VARCHAR2(30)
) TABLESPACE PROYECTOSALVAME;

CREATE TABLE C##sistema_salvame.historial_alerta (
  idHistorialA VARCHAR2(30) PRIMARY KEY,
  estatus VARCHAR2(20) NOT NULL
) TABLESPACE PROYECTOSALVAME;

CREATE TABLE C##sistema_salvame.alerta (
  idAlerta CHAR(10) PRIMARY KEY,
  nroDocumento CHAR(10) NOT NULL,
  codigoPostal VARCHAR2(30) NOT NULL,
  idHistorialA VARCHAR2(30) NOT NULL,
  idAnimal VARCHAR2(30),
  fechaAlerta VARCHAR2(30) NOT NULL,
  horaAlerta VARCHAR2(30) NOT NULL,
  tipoAlerta VARCHAR2(30) NOT NULL,
  descripcionAnimal VARCHAR2(30),
  descripcionHechos VARCHAR2(30),
  imgEvidencia VARCHAR2(50) NOT NULL,
  FOREIGN KEY (nroDocumento) REFERENCES C##sistema_salvame.usuario_basico(nroDocumento),
  FOREIGN KEY (codigoPostal) REFERENCES C##sistema_salvame.ubicacion(codigoPostal),
  FOREIGN KEY (idHistorialA) REFERENCES C##sistema_salvame.historial_alerta(idHistorialA),
  FOREIGN KEY (idAnimal) REFERENCES C##sistema_salvame.animal(idAnimal)
) TABLESPACE PROYECTOSALVAME;



