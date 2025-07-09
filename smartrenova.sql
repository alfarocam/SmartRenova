-- Borrar base y usuarios anteriores
DROP SCHEMA IF EXISTS smartrenova;
DROP USER IF EXISTS usuario_prueba;
DROP USER IF EXISTS usuario_reportes;

-- Crear base de datos
CREATE SCHEMA smartrenova;
USE smartrenova;

-- Crear usuarios
CREATE USER 'usuario_prueba'@'%' IDENTIFIED BY 'Usuar1o_Clave.';
CREATE USER 'usuario_reportes'@'%' IDENTIFIED BY 'Usuar1o_Reportes.';

-- Asignar privilegios
GRANT ALL PRIVILEGES ON smartrenova.* TO 'usuario_prueba'@'%';
GRANT SELECT ON smartrenova.* TO 'usuario_reportes'@'%';
FLUSH PRIVILEGES;

-- Crear tablas
CREATE TABLE categoria (
  id_categoria INT NOT NULL AUTO_INCREMENT,
  descripcion VARCHAR(30) NOT NULL,
  ruta_imagen VARCHAR(1024),
  activo BOOLEAN,
  PRIMARY KEY (id_categoria)
);

CREATE TABLE producto (
  id_producto INT NOT NULL AUTO_INCREMENT,
  id_categoria INT NOT NULL,
  descripcion VARCHAR(100) NOT NULL,
  detalle VARCHAR(1600) NOT NULL,
  precio DECIMAL(10,2),
  existencias INT,
  ruta_imagen VARCHAR(1024),
  activo BOOLEAN,
  PRIMARY KEY (id_producto),
  CONSTRAINT fk_producto_categoria FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria)
);

CREATE TABLE usuario (
  id_usuario INT NOT NULL AUTO_INCREMENT,
  username VARCHAR(20) NOT NULL,
  password VARCHAR(512) NOT NULL,
  nombre VARCHAR(20) NOT NULL,
  apellidos VARCHAR(30) NOT NULL,
  correo VARCHAR(75),
  telefono VARCHAR(15),
  ruta_imagen VARCHAR(1024),
  activo BOOLEAN,
  PRIMARY KEY (id_usuario)
);

CREATE TABLE factura (
  id_factura INT NOT NULL AUTO_INCREMENT,
  id_usuario INT NOT NULL,
  fecha DATE,
  total DECIMAL(10,2),
  estado INT,
  PRIMARY KEY (id_factura),
  CONSTRAINT fk_factura_usuario FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);

CREATE TABLE venta (
  id_venta INT NOT NULL AUTO_INCREMENT,
  id_factura INT NOT NULL,
  id_producto INT NOT NULL,
  precio DECIMAL(10,2),
  cantidad INT,
  PRIMARY KEY (id_venta),
  CONSTRAINT fk_venta_factura FOREIGN KEY (id_factura) REFERENCES factura(id_factura),
  CONSTRAINT fk_venta_producto FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);

-- Eliminamos tabla 'role' duplicada/conflictiva con 'rol'
DROP TABLE IF EXISTS role;

CREATE TABLE rol (
  id_rol INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(20),
  id_usuario INT,
  PRIMARY KEY (id_rol)
);

CREATE TABLE ruta (
  id_ruta INT AUTO_INCREMENT NOT NULL,
  patron VARCHAR(255) NOT NULL,
  rol_name VARCHAR(50) NOT NULL,
  PRIMARY KEY (id_ruta)
);

CREATE TABLE ruta_permit (
  id_ruta INT AUTO_INCREMENT NOT NULL,
  patron VARCHAR(255) NOT NULL,
  PRIMARY KEY (id_ruta)
);

CREATE TABLE constante (
  id_constante INT AUTO_INCREMENT NOT NULL,
  atributo VARCHAR(25) NOT NULL,
  valor VARCHAR(150) NOT NULL,
  PRIMARY KEY (id_constante)
);

-- Insertar datos de usuario
INSERT INTO usuario (username, password, nombre, apellidos, correo, telefono, ruta_imagen, activo) VALUES 
('juan','$2a$10$P1.w58XvnaYQUQgZUCk4aO/RTRl8EValluCqB3S2VMLTbRt.tlre.','Juan','Castro Mora','jcastro@gmail.com','4556-8978','https://img2.rtve.es/i/?w=1600&i=1677587980597.jpg', true),
('rebeca','$2a$10$GkEj.ZzmQa/aEfDmtLIh3udIH5fMphx/35d0EYeqZL5uzgCJ0lQRi','Rebeca','Contreras Mora','acontreras@gmail.com','5456-8789','https://media.licdn.com/...', true),
('pedro','$2a$10$koGR7eS22Pv5KdaVJKDcge04ZB53iMiw76.UjHPY.XyVYlYqXnPbO','Pedro','Mena Loria','lmena@gmail.com','7898-8936','https://upload.wikimedia.org/...', true);

-- Insertar categorías
INSERT INTO categoria (descripcion, ruta_imagen, activo) VALUES 
('Herramientas','https://d2ulnfq8we0v3.cloudfront.net/...',true),
('Materiales','https://cnnespanol.cnn.com/...',true),
('Pinturas','https://static-geektopia.com/...',true),
('Construccion','https://www.monumental.co.cr/...',false);

-- Insertar productos (corregidos los id_categoria según la lógica)
-- Todos los productos son de la categoría 1: Herramientas
INSERT INTO producto (id_categoria, descripcion, detalle, precio, existencias, ruta_imagen, activo) VALUES
(1,'Taladro Eléctrico Bosch','Potente taladro eléctrico de 750W con velocidad variable...',23000.00,5,'https://m.media-amazon.com/images/I/71TqV0zELtL._AC_SL1500_.jpg',true),
(1,'Amoladora Angular DeWalt','Amoladora de 4.5 pulgadas con motor de 900W...',27000.00,2,'https://m.media-amazon.com/images/I/71Yw1vZC+1L._AC_SL1500_.jpg',true),
(1,'Sierra Circular Makita 7-1/4”','Herramienta de corte potente y precisa...',24000.00,5,'https://m.media-amazon.com/images/I/61vmhKf1NEL._AC_SL1500_.jpg',true),
(1,'Rotomartillo SDS Plus','Rotomartillo de impacto para trabajos pesados...',27600.00,2,'https://m.media-amazon.com/images/I/81uQf9D5JfL._AC_SL1500_.jpg',true),
(1,'Caja de Herramientas 100 piezas','Completo set de herramientas manuales...',45000.00,5,'https://m.media-amazon.com/images/I/81uC7bFeJXL._AC_SL1500_.jpg',true),
(1,'Llave Inglesa Ajustable 12”','Llave de acero al carbono con mandíbula ajustable...',57000.00,2,'https://m.media-amazon.com/images/I/61D+xQmKLmL._AC_SL1500_.jpg',true),
(1,'Juego de Destornilladores Truper','Set de 6 piezas con mango ergonómico y punta imantada...',25000.00,5,'https://m.media-amazon.com/images/I/61poUYu+V4L._AC_SL1200_.jpg',true),
(1,'Cinta Métrica Profesional 8m','Cinta métrica de acero con freno automático...',27600.00,2,'https://m.media-amazon.com/images/I/61jEqkXp6zL._AC_SL1000_.jpg',true),
(1,'Martillo Uña 16oz Mango Fibra','Martillo con cabeza de acero y mango antiderrapante...',15780.00,5,'https://m.media-amazon.com/images/I/71ozgR8dScL._AC_SL1500_.jpg',true),
(1,'Serrucho Universal 20”','Sierra manual con hoja templada de acero...',15000.00,2,'https://m.media-amazon.com/images/I/71UOewBzkgL._AC_SL1500_.jpg',true),
(1,'Nivel Láser Autonivelante','Nivel láser con líneas cruzadas, autonivelante...',25400.00,5,'https://m.media-amazon.com/images/I/61TuZ3Eee2L._AC_SL1500_.jpg',true),
(1,'Flexómetro Stanley 5m','Flexómetro compacto con carcasa resistente...',45000.00,3,'https://m.media-amazon.com/images/I/61ZY3vUyxFL._AC_SL1000_.jpg',true),
(1,'Escalera de Aluminio 6 peldaños','Ligera y resistente, con plataforma amplia...',285000.00,0,'https://m.media-amazon.com/images/I/71hyeSP8gFL._AC_SL1500_.jpg',true),
(1,'Carretilla de Construcción','Carretilla metálica reforzada para carga pesada...',154000.00,0,'https://m.media-amazon.com/images/I/51Bv7-M3fQL._AC_SL1000_.jpg',true),
(1,'Andamio Plegable Profesional','Andamio de acero galvanizado con ruedas...',330000.00,0,'https://m.media-amazon.com/images/I/61eYjxgnv9L._AC_SL1000_.jpg',true),
(1,'Pulidora Orbital 5”','Pulidora eléctrica con velocidad variable...',273000.00,0,'https://m.media-amazon.com/images/I/61EYYI1PbtL._AC_SL1200_.jpg',true);

-- Insertar facturas
INSERT INTO factura (id_usuario, fecha, total, estado) VALUES
(1,'2025-06-05',211560.00,2),
(2,'2025-06-07',554340.00,2),
(3,'2025-07-07',871000.00,2),
(1,'2025-07-15',244140.00,1),
(2,'2025-07-17',414800.00,1),
(3,'2025-07-21',420000.00,1);

-- Insertar ventas
INSERT INTO venta (id_factura, id_producto, precio, cantidad) VALUES
(1,1,23000.00,2),
(1,5,45000.00,1),
(2,9,15780.00,3),
(3,13,285000.00,1);
