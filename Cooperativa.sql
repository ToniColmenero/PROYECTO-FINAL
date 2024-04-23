-- create
CREATE TABLE Socios (
  NIF varchar(9) PRIMARY KEY,
  Nombre varchar(20) NOT NULL,
  Ap1 varchar(20) NOT NULL,
  Ap2 varchar(20),
  Dirección varchar(70) NOT NULL,
  Cod_P varchar(5) NOT NULL,
  Municipio varchar(30),
  Provincia varchar(30),
  Tlf varchar(9),
  Correo varchar(50),
  CONSTRAINT Socios_NIF_ck CHECK(`NIF` REGEXP '^[0-9]{8}[TRWAGMYFPDXBNJZSQVHLCKE]'
        OR `NIF` REGEXP'^[KLMXYZ][0-9]{7}[TRWAGMYFPDXBNJZSQVHLCKE]'
        OR `NIF` REGEXP '^[TRWAGMYFPDXBNJZSQVHLCKE]{1}[0-9]{8}')
  
);

CREATE TABLE Entrega_aceituna(
  Num_entrega integer AUTO_INCREMENT,
  Fecha_Hora timestamp NOT NULL,
  Cantidad integer NOT NULL,
  Tipo enum('Arbol','Suelo') NOT NULL,
  Parcela integer,
  Recinto integer,
  NIF_Socio varchar(9),
  CONSTRAINT Entrega_aceituna_pk PRIMARY KEY(Num_entrega),
  CONSTRAINT Entrega_NIF_Socio_fk FOREIGN KEY(NIF_Socio)
                                  REFERENCES Socios(NIF)
                                  ON UPDATE CASCADE
                                  ON DELETE NO ACTION,
  CONSTRAINT Entrega_aceituna_Cantidad_ck CHECK(Cantidad>0)
);

CREATE TABLE Producto (
  Código varchar(4) PRIMARY KEY,
  Denominación enum('Aceite de oliva virgen extra','Aceite de oliva virgen','Aceite de orujo','Hueso de aceituna') NOT NULL,
  Precio float NOT NULL, -- Es un float porque el precio no tiene por qué ser entero, además, el precio de nuestros productos siempre corresponde al litro o kilo, (depende de si hablamos de sólido o líquido)
  CONSTRAINT Producto_Precio_ck CHECK(precio>0)
);


CREATE TABLE Ventas (
  Num_Factura integer AUTO_INCREMENT PRIMARY KEY,
  Fecha_Hora timestamp NOT NULL
);

-- insert
INSERT INTO Socios VALUES ('12345678V', 'José', 'Rodriguez', 'Fernández', 'Avenida de Madrid 16','23001','Jaén','Jaén','659623343','jrodfer@hotmail.com');
INSERT INTO Socios VALUES ('49826745H', 'Álvaro', 'Sanchez', 'Alhambra', 'Camino de las cruces 19', '23009','Jaén','Jaén','692098867','asanalh@gmail.com');
INSERT INTO Socios VALUES ('12908456J', 'Manuel', 'Molina', 'González', 'Arquitecto Berges 3', '23003','Jaén','Jaén','682343341','mmolgol@gmail.com');

INSERT INTO Entrega_aceituna VALUES ('0001', '2023-10-05 12:30:34', '360', 'Árbol','416','1','12345678V');
INSERT INTO Entrega_aceituna VALUES ('0002', '2024-03-02 17:44:12', '1240', 'Suelo', '312','13','49826745H');
INSERT INTO Entrega_aceituna VALUES ('0003', '2024-04-01 09:00:57', '145', 'Árbol', '89','25','12908456J');

INSERT INTO Producto VALUES ('0012', 'Aceite de oliva virgen extra', '11.36');
INSERT INTO Producto VALUES ('0002', 'Hueso de aceituna', '4.86');
INSERT INTO Producto VALUES ('0056', 'Aceite de orujo', '4.40');

INSERT INTO Ventas VALUES ('0123', '2023-01-05 14:10:02');
INSERT INTO Ventas VALUES ('0256', '2024-02-24 21:21:12');
INSERT INTO Ventas VALUES ('0278', '2024-03-22 11:08:34');

-- fetch 
SELECT * FROM Socios;
SELECT * FROM Entrega_aceituna;
SELECT * FROM Ventas;
SELECT precio FROM Producto where Código='0012';