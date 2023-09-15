drop table detalle_facturas;
drop table facturas;
drop table productos;
drop table clientes;




CREATE TABLE clientes (
  cod_cliente CHAR(5) NOT NULL PRIMARY KEY,
  nombres VARCHAR2(30) NOT NULL,
  distrito VARCHAR2(30) NULL,
  telefono VARCHAR2(10) NULL
);
 
-- CREANDO TABLA PRODUCTOS
CREATE TABLE productos (
  cod_producto CHAR(5) NOT NULL PRIMARY KEY,
  descripcion VARCHAR2(30) NULL,
  precio_unitario NUMBER(9,2) NULL
);
 
-- CREANDO TABLA FACTURAS
CREATE TABLE facturas (
  cod_factura CHAR(5) NOT NULL PRIMARY KEY,
  cod_cliente CHAR(5) NOT NULL,
  fecha_emision DATE NULL,
  importe_total DECIMAL(9,2) NULL
);
 
-- CREANDO TABLA DETALLE_FACTURAS
CREATE TABLE detalle_facturas (
  cod_factura CHAR(5) NOT NULL,
  cod_producto CHAR(5) NOT NULL,
  cantidad SMALLINT NOT NULL,
  subtotal DECIMAL(9,2) -- quitamos el not null para poder ahcer la demostracion 
);
 
-- AGREGANDO RELACIONES Y CLAVES PRIMARIAS
 
ALTER TABLE facturas
ADD FOREIGN KEY (cod_cliente)
REFERENCES clientes(cod_cliente);
 
ALTER TABLE detalle_facturas
ADD PRIMARY KEY (cod_factura,cod_producto);
 
ALTER TABLE detalle_facturas
ADD FOREIGN KEY (cod_factura)
REFERENCES facturas(cod_factura);
 
ALTER TABLE detalle_facturas
ADD FOREIGN KEY (cod_producto)
REFERENCES productos(cod_producto);
 
-- INSERTANDO REGISTROS A LA TABLA CLIENTES
 
INSERT INTO clientes
  VALUES('C0001',' Julián Pérez ','Lince','3214568');
INSERT INTO clientes
  VALUES('C0002','       Maria Chavez','Jesus Maria','4215678');


-- trigger para eliminar estapcios al final e inicio de cuando se agerga un nuevo cliente, util para ahorrar espacio
-- de errores recurrentes a la hora de llenar fomrularios
CREATE OR REPLACE TRIGGER trim_nombres
BEFORE INSERT ON clientes
FOR EACH ROW
BEGIN
  :new.nombres := TRIM(:new.nombres);
END;

-- Insertar un nuevo cliente en la tabla clientes
INSERT INTO clientes (cod_cliente, nombres, distrito, telefono)
VALUES ('C001', '   Juan Pérez   ', 'Medellin', '1234567890');
 -- visualizamos
select * from clientes;




 
-- INSERTANDO REGISTROS A LA TABLA PRODUCTOS
 
INSERT INTO productos
  VALUES('P0001','Memoria DDR 256 Mb',120.00);
INSERT INTO productos
  VALUES('P0002','Memoria DDR 500 Mb',190.00);
INSERT INTO productos
  VALUES('P0003','Memoria DDR 750 Mb',230.00);

   
-- INSERTANDO REGISTROS A TABLA FACTURAS
INSERT INTO facturas
  VALUES('F0001','C0001',SYSDATE,3800);
INSERT INTO facturas
  VALUES('F0002','C0002',SYSDATE,5240);
 
-- INSERTANDO REGISTROS A LA TABLA DETALLE FACTURAS
INSERT INTO detalle_facturas
  VALUES('F0001','P0002',3,840.00);
INSERT INTO detalle_facturas
  VALUES('F0001','P0001',5,1950.00);


select * from PRODUCTOS;
select * from DETALLE_FACTURAS;
select * from FACTURAS;
select * from clientes;




 -- el otro trigger
CREATE OR REPLACE TRIGGER actualiza_subtotal
BEFORE INSERT OR UPDATE ON detalle_facturas
FOR EACH ROW
BEGIN
  DECLARE
    precio_unitario NUMBER(9, 2);
  BEGIN
    -- obtener el precio unitario del producto
    SELECT precio_unitario
    INTO precio_unitario
    FROM productos
    WHERE cod_producto = :NEW.cod_producto;

    -- calcular el subtotal
    :NEW.subtotal := :NEW.cantidad * precio_unitario;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      -- si no se encuentra el precio, establecer el subtotal en -1
      :NEW.subtotal := -1;
  END;
END;

-- isertar un registro en la tabla detalle_facturas
INSERT INTO detalle_facturas (cod_factura, cod_producto, cantidad)
VALUES ('F0001', 'P0003', 6);
select * from DETALLE_FACTURAS;
