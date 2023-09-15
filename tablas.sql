
DROP TABLE vehiculo CASCADE CONSTRAINTS;
DROP TABLE licencia CASCADE CONSTRAINTS;
DROP TABLE categorias_autorizadas CASCADE CONSTRAINTS;
DROP TABLE categorias_licencia CASCADE CONSTRAINTS;
DROP TABLE conductores CASCADE CONSTRAINTS;
DROP TABLE pasajero CASCADE CONSTRAINTS;
DROP TABLE viaje CASCADE CONSTRAINTS; 
DROP TABLE usuarios CASCADE CONSTRAINTS; 

CREATE TABLE usuarios (
    cc varchar2(15) PRIMARY KEY,
    nombre varchar2(20) NOT NULL,
    apellido varchar2(20) NOT NULL
);



CREATE TABLE categorias_licencia (
    id_categoria VARCHAR2(2) PRIMARY KEY,
    descripcion VARCHAR2(100) NOT NULL
);

CREATE TABLE categorias_autorizadas (
    id_categoria_autorizada NUMBER(9) PRIMARY KEY,
    fk_categoria_licencia VARCHAR2(2) NOT NULL,
    vigencia DATE NOT NULL,
    servicio VARCHAR(20) NOT NULL CHECK (servicio = 'PARTICULAR' OR servicio = 'PRIVADO'),
    FOREIGN KEY (fk_categoria_licencia) REFERENCES categorias_licencia(id_categoria)
);

CREATE TABLE licencia (
    id_licencia number(10) PRIMARY KEY,
    fecha_expedicion DATE NOT NULL,
    fecha_vencimiento DATE NOT NULL,
    categoria number(9) NOT NULL,
    FOREIGN KEY (categoria) REFERENCES categorias_autorizadas(id_categoria_autorizada)
);

CREATE TABLE vehiculo (
    matricula varchar2(6) PRIMARY KEY,
    modelo varchar2(30) NOT NULL,
    cilindraje varchar2(5) NOT NULL,
    capacidad varchar2(2) NOT NULL,
    marca varchar2(15) NOT NULL,
    combustible varchar2(15) NOT NULL,
    tipo_vehiculo varchar2(15) NOT NULL,
    registro varchar(30) NOT NULL,
    color varchar(15) NOT NULL
);

CREATE TABLE conductores (
    id_conductor number(10) PRIMARY KEY,
    fk_cedula varchar2(15),
    fk_licencia number(10),
    calificacion number(2,1) CHECK (calificacion between 0 and 5),
    fk_matricula varchar2(6),
    FOREIGN KEY (fk_cedula) REFERENCES usuarios(cc),
    FOREIGN KEY (fk_licencia) REFERENCES licencia(id_licencia),
    FOREIGN KEY (fk_matricula) REFERENCES vehiculo(matricula)
);
CREATE TABLE pasajero (
    id_pasajero number(9) PRIMARY KEY,
    fk_cedula varchar(15),
    calificacion decimal(2,1) CHECK (calificacion between 0 and 5),
    FOREIGN KEY (fk_cedula) REFERENCES usuarios(cc)
);

CREATE TABLE viaje (
    id_viaje number(9) PRIMARY KEY,
    destino varchar2(50) NOT NULL,
    parada varchar2(50) NOT NULL,
    fk_conductor number(10),
    fk_pasajero number(9),
    fk_vehiculo varchar2(6),
    FOREIGN KEY (fk_conductor) REFERENCES conductores(id_conductor),
    FOREIGN KEY (fk_pasajero) REFERENCES pasajero(id_pasajero),
    FOREIGN KEY (fk_vehiculo) REFERENCES vehiculo(matricula)
    
);





-- Insertar datos en la tabla usuarios
INSERT INTO usuarios (cc, nombre, apellido) VALUES ('123456789', 'Juan', 'Perez');
INSERT INTO usuarios (cc, nombre, apellido) VALUES ('123456782', 'Juan', 'Perezes');

-- Insertar datos en la tabla categorias_licencia
INSERT INTO categorias_licencia (id_categoria, descripcion) VALUES ('A', 'Licencia para automóviles');

-- Insertar datos en la tabla categorias_autorizadas
INSERT INTO categorias_autorizadas (id_categoria_autorizada, fk_categoria_licencia, vigencia, servicio)
VALUES (1, 'A', TO_DATE('2023-08-31', 'YYYY-MM-DD'), 'PARTICULAR');

-- Insertar datos en la tabla licencia
INSERT INTO licencia (id_licencia, fecha_expedicion, fecha_vencimiento, categoria)
VALUES (1, TO_DATE('2020-01-01', 'YYYY-MM-DD'), TO_DATE('2025-01-01', 'YYYY-MM-DD'), 1);

-- Insertar datos en la tabla vehiculo
INSERT INTO vehiculo (matricula, modelo, cilindraje, capacidad, marca, combustible, tipo_vehiculo, registro, color)
VALUES ('ABC123', 'Sedan', '1600', '5', 'Toyota', 'Gasolina', 'Particular', '2021-ABC123', 'Rojo');


-- Insertar datos en la tabla pasajero
INSERT INTO pasajero (id_pasajero, fk_cedula, calificacion)
VALUES (1, '123456789', 4.2);


-- insertar datos en la tablaa conductores
INSERT INTO conductores (id_conductor, fk_cedula, fk_licencia, calificacion, fk_matricula)
VALUES (1, '123456789', 1, 3.0, 'ABC123');

--insertar un viaje
INSERT INTO viaje (id_viaje, destino, parada, fk_conductor, fk_pasajero, fk_vehiculo)
VALUES (1, 'UdeA', 'San cristobal', 1, 1, 'ABC123');
    
SELECT * FROM pasajero;
SELECT * FROM licencia;
SELECT * FROM vehiculo;
SELECT * FROM categorias_autorizadas;
SELECT * FROM categorias_licencia;
SELECT * FROM usuarios;
SELECT * FROM conductores;
SELECT * FROM viaje;





