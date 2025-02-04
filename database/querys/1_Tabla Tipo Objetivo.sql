CREATE DATABASE lima_bici;

USE lima_bici;

--ENTIDADES FUERTES
CREATE TABLE tipo_Objetivo (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(100)
);

CREATE TABLE estado_objetivo (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(100)
);

CREATE TABLE tipo_PuntoInteres (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(100)
);

CREATE TABLE usuario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    telefono VARCHAR(20) NOT NULL UNIQUE ,
    fechaCumple DATE,
    fotoPerfil VARCHAR(255)
);
------------------------------------
--ENTIDADES DEBILES
CREATE TABLE objetivo (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    id_tipo INT,
    FOREIGN KEY (id_tipo) REFERENCES tipo_Objetivo(id) ON DELETE CASCADE
);

CREATE TABLE perfil_Login (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario VARCHAR(100) NOT NULL,
    contrasenha VARCHAR(280) NOT NULL,
    intentos_Fallidos INT DEFAULT 0,
    id_usuario INT,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id) ON DELETE CASCADE
);

CREATE TABLE sesion (
    id INT AUTO_INCREMENT PRIMARY KEY,
    estado_sesion BOOLEAN  NOT NULL DEFAULT 0,
    estado_recorrido BOOLEAN  NOT NULL DEFAULT 0,
    calorias_quemadas DECIMAL(10, 2) DEFAULT 0,
    velocidad_promedio DECIMAL(10, 2) DEFAULT 0,
    km_recorridos DECIMAL(10, 2) DEFAULT 0,
    dispositivo VARCHAR(255),
    id_perfil INT,
    FOREIGN KEY (id_perfil) REFERENCES perfil_Login(id) ON DELETE CASCADE
);

CREATE TABLE ruta (
    id INT AUTO_INCREMENT PRIMARY KEY,
    duracion TIME,
    distancia DECIMAL(10, 2),
    punto_inicio_latitud DECIMAL(9, 6) NOT NULL,
    punto_inicio_longitud DECIMAL(9, 6) NOT NULL,
    punto_final_latitud DECIMAL(9, 6) NOT NULL,
    punto_final_longitud DECIMAL(9, 6) NOT NULL,
    descripcion VARCHAR(350),
    id_creador INT,
    FOREIGN KEY (id_creador) REFERENCES usuario(id) ON DELETE CASCADE
);

CREATE TABLE coordenada (
    id INT AUTO_INCREMENT PRIMARY KEY,
    orden INT,
    latitud DECIMAL(9, 6) NOT NULL,
    longitud DECIMAL(9, 6) NOT NULL,
    id_ruta INT,
    FOREIGN KEY (id_ruta) REFERENCES ruta(id) ON DELETE CASCADE
);

CREATE TABLE punto_interes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    direccion VARCHAR(255),
    descripcion VARCHAR(350),
    foto_referencial VARCHAR(255),
    id_creador INT,
    id_tipo INT,
    FOREIGN KEY (id_creador) REFERENCES usuario(id) ON DELETE CASCADE,
    FOREIGN KEY (id_tipo) REFERENCES tipo_PuntoInteres(id) ON DELETE CASCADE
);

--ASOCIATIVAS

CREATE TABLE usuario_objetivo (
    id INT AUTO_INCREMENT PRIMARY KEY,
    progreso  DECIMAL(9, 4) NOT NULL DEFAULT 0,
    fecha_fin DATE NOT NULL,
    fecha_inicio DATE NOT NULL,
    duracion INT,
    id_usuario INT,
    id_objetivo INT,
    id_estado_objetivo INT,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id) ON DELETE CASCADE,
    FOREIGN KEY (id_objetivo) REFERENCES objetivo(id) ON DELETE CASCADE,
    FOREIGN KEY (id_estado_objetivo) REFERENCES estado_objetivo(id) ON DELETE CASCADE
);
CREATE TABLE usuario_ruta (
    id INT AUTO_INCREMENT PRIMARY KEY,
    progreso DECIMAL(9, 4) NOT NULL DEFAULT 0,
    fecha_inicio DATE NOT NULL,
    flg_desvio BOOLEAN  NOT NULL DEFAULT 0,
    flg_finalizo BOOLEAN  NOT NULL DEFAULT 0,
    id_usuario INT,
    id_ruta INT,
    FOREIGN KEY (id_ruta) REFERENCES ruta(id) ON DELETE CASCADE,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id) ON DELETE CASCADE
);

CREATE TABLE favoritos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    fecha_agregado DATE NOT NULL,
    descripcion VARCHAR(350),
    icon_favorito VARCHAR(255),
    id_usuario INT,
    id_ruta INT,
    id_punto_interes INT,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id) ON DELETE CASCADE,
    FOREIGN KEY (id_ruta) REFERENCES ruta(id) ON DELETE CASCADE,
    FOREIGN KEY (id_punto_interes) REFERENCES punto_interes(id) ON DELETE CASCADE
);