/*Se crea la base de datos */
DROP SCHEMA IF EXISTS smartRenova;
DROP USER IF EXISTS usuario_prueba;
DROP USER IF EXISTS usuario_reportes;

-- Crea la base de datos
CREATE SCHEMA smartRenova;
USE smartRenova;

/*Se crea un usuario para la base de datos llamado "usuario_prueba" y tiene la contraseña "Usuario_Clave."*/
create user 'usuario_prueba'@'%' identified by 'Usuar1o_Clave.';
create user 'usuario_reportes'@'%' identified by 'Usuar1o_Reportes.';

/*Se asignan los prvilegios sobre la base de datos smartRenova al usuario creado */
grant all privileges on smartRenova.* to 'usuario_prueba'@'%';
grant select on smartRenova.* to 'usuario_reportes'@'%';
flush privileges;

use smartRenova;

/* la tabla de categoria contiene categorias de productos*/
create table categoria (
  id_categoria INT NOT NULL AUTO_INCREMENT,
  descripcion VARCHAR(30) NOT NULL,
  ruta_imagen varchar(1024),
  activo bool,
  PRIMARY KEY (id_categoria))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

create table producto (
  id_producto INT NOT NULL AUTO_INCREMENT,
  id_categoria INT NOT NULL,
  descripcion VARCHAR(200) NOT NULL,  
  detalle VARCHAR(1600) NOT NULL, 
  precio double,
  existencias int,  
  ruta_imagen varchar(1024),
  activo bool,
  PRIMARY KEY (id_producto),
  foreign key fk_producto_caregoria (id_categoria) references categoria(id_categoria)  
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

/*Se crea la tabla de clientes llamada cliente... igual que la clase Cliente */
CREATE TABLE usuario (
  id_usuario INT NOT NULL AUTO_INCREMENT,
  username varchar(20) NOT NULL,
  password varchar(512) NOT NULL,
  nombre VARCHAR(20) NOT NULL,
  apellidos VARCHAR(30) NOT NULL,
  correo VARCHAR(75) NULL,
  telefono VARCHAR(15) NULL,
  ruta_imagen varchar(1024),
  activo boolean,
  PRIMARY KEY (`id_usuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

create table factura (
  id_factura INT NOT NULL AUTO_INCREMENT,
  id_usuario INT NOT NULL,
  fecha date,  
  total double,
  estado int,
  PRIMARY KEY (id_factura),
  foreign key fk_factura_usuario (id_usuario) references usuario(id_usuario)  
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

create table venta (
  id_venta INT NOT NULL AUTO_INCREMENT,
  id_factura INT NOT NULL,
  id_producto INT NOT NULL,
  precio double, 
  cantidad int,
  PRIMARY KEY (id_venta),
  foreign key fk_ventas_factura (id_factura) references factura(id_factura),
  foreign key fk_ventas_producto (id_producto) references producto(id_producto) 
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

/*Se insertan 3 registros en la tabla cliente como ejemplo */
INSERT INTO usuario (id_usuario, username,password,nombre, apellidos, correo, telefono,ruta_imagen,activo) VALUES 
(1,'sebas','$2a$10$P1.w58XvnaYQUQgZUCk4aO/RTRl8EValluCqB3S2VMLTbRt.tlre.','Sebastian', 'Castillo Murillo',    'scastillo@gmail.com',    '3456-9578', 'https://st.depositphotos.com/1144472/1971/i/450/depositphotos_19714321-stock-photo-young-happy-smiling-business-man.jpg',true),
(2,'camila','$2a$10$GkEj.ZzmQa/aEfDmtLIh3udIH5fMphx/35d0EYeqZL5uzgCJ0lQRi','Camila',  'Alfaro Rivera', 'calfaro@gmail.com', '2464-6535','https://b1688923.smushcdn.com/1688923/wp-content/uploads/2019/01/Louise-corporate-Headshot-melbourne-Julia-Nance-Portraits.jpg?lossy=2&strip=1&webp=1',true),
(3,'daniel','$2a$10$koGR7eS22Pv5KdaVJKDcge04ZB53iMiw76.UjHPY.XyVYlYqXnPbO','Daniel', 'Salazar Brenes',     'dsalazar@gmail.com',      '3564-2355','https://images.squarespace-cdn.com/content/v1/5e8f6e68e3736252a400545b/86d7b1e1-d429-45b3-a920-8d0bb523745c/Professional+business+headshot+for+LinkedIn+and+corporate+branding+%E2%80%93+Headshots+Malta+%281+of+1%29.jpg',true);



/*Se insertan 4 categorias de productos como ejemplo */
INSERT INTO categoria (id_categoria,descripcion,ruta_imagen,activo) VALUES 
('1','Pinturas','https://www.latamarte.com/media/d2/cache/86/23/8623f8ca45daf723257f10c10635814f.jpg',  true),
('2','Electricidad e iluminación', 'https://aragonelectronica.com/cdn/shop/collections/PORTADA_COLECCION_48.png?v=1710371596&width=750',   true),
('3','Revestimientos y pisos', 'https://constructor.lacuarta.com/wp-content/uploads/2021/11/Central_revestimientos_piso_ca1b52fcbf.jpg',   true),
('4','Puertas y ventanas', 'https://formasenmadera.es/wp-content/uploads/2015/03/puertas-ventanas-3.jpg',   true), 
('5','Techos y cubiertas',  'https://images.adsttc.com/media/images/5ace/16e5/f197/cc5c/9600/007c/newsletter/roofingguide_2.jpg?1523455710',   true),
('6','Herramientas y accesorios', 'https://aldacogrupoavance.es/wp-content/uploads/2022/11/blog-herramientas-scaled.webp',   true), 
('7','Materiales de construcción','https://revistaconsultoria.com.mx/wp-content/uploads/2018/07/Nuevos-materiales-en-la-construccion.jpg',    false),
('8','Materiales de carpintería','https://blog.centrodeelearning.com/wp-content/uploads/2023/07/herramientas-de-carpinteria.jpg',  true);

/*Se insertan 4 productos por categoria para poder hacer pruebas */
INSERT INTO producto (id_producto,id_categoria,descripcion,detalle,precio,existencias,ruta_imagen,activo) VALUES
-- Categoría 1: Pinturas (ID = 1) ---
(1, 1, 'Pintura Látex Blanco 4L', 'Pintura acrílica de alto rendimiento (14m²/L), acabado semi-mate. Libre de olores y de rápida secado.', 45000, 12, 'https://ferreteriavidri.com/images/items/large/163710.jpg?v=20250811', true),
(2, 1, 'Esmalte Sintético Negro 1L', 'Esmalte de alto brillo y secado rápido. Ideal para metales y madera. Resistente a la intemperie.', 22000, 8, 'https://http2.mlstatic.com/D_NQ_NP_665974-MLA74800962993_022024-O.webp', true),
(3, 1, 'Barniz Poliuretánico Mate', 'Barniz transparente para interiores, protección UV. Aplicable en maderas y muebles. Rendimiento: 12m²/L.', 38000, 10, 'https://www.lancopaints.com/america-central/wp-content/uploads/sites/2/2017/08/Barniz-Poliuretano-15min-GLN-1-478x500.png', true),
(4, 1, 'Impermeabilizante Acrílico', 'Revestimiento elástico para techos, 20m² por bidón de 20L. Resistente a grietas y cambios térmicos.', 95000, 5, 'https://oselcentrosur.com/wp-content/uploads/2021/07/Impermeabilizante-acrilico-fibratado-Osel-5-anos.jpg', true),

-- Categoría 2: Electricidad e iluminación (ID = 2) ---
(5, 2, 'Cable Eléctrico THW 2.5mm x 100m', 'Cable de cobre flexible, aislamiento termoplástico. Para instalaciones fijas en interiores.', 75000, 10, 'https://media.falabella.com/sodimacPE/4234308_2/w=800,h=800,fit=pad', true),
(6, 2, 'Interruptor Simple Blanco', 'Interruptor unipolar de 10A, para empotrar. Marca reconocida, acabado brillante.', 3500, 20, 'https://vetoelectric.com/wp-content/uploads/2022/07/PRE16023.jpg', true),
(7, 2, 'Foco LED 9W E27', 'Luz blanca cálida, equivalente a 60W. Vida útil 15,000 horas. Ahorro energético.', 4500, 30, 'https://almacenesmarriott.com/wp-content/uploads/2023/12/I00005__1.jpg', true),
(8, 2, 'Tubo Fluorescente LED T8 18W', 'Tubo LED de 120cm, luz día. No necesita balasto, conexión directa. Ideal para oficinas.', 12000, 15, 'https://comercialelectrica.mx/wp-content/uploads/2022/08/P201024-01-2.png', true),

-- Categoría 3: Revestimientos y pisos (ID = 3) ---
(9, 3, 'Cerámica 30x30 cm Beige', 'Cerámica para pisos, antideslizante. Resistente al tráfico intenso. 1.44m² por caja.', 22000, 8, 'https://www.graiman.com/sites/default/files/productos-texturas/830901E.png', true),
(10, 3, 'Porcelanato Rectificado 60x60', 'Acabado mate, para interior y exterior. Alta resistencia. 1.44m² por caja.', 45000, 6, 'https://www.colonoconstruccion.com/images/catalog/products/3240656.jpg', true),
(11, 3, 'Laminado Roble 8mm', 'Tablero laminado para pisos, fácil instalación. Resistente a la humedad y rayaduras.', 32000, 12, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTcGT0Fe_BqDhZAFsp_JF4W0h3TvgB6CL288A&s', true),
(12, 3, 'Vinílico Autoadhesivo 45x100cm', 'Piso vinílico autoadhesivo, diseño madera. Fácil limpieza y resistencia al agua.', 18000, 10, 'https://ae01.alicdn.com/kf/S756d6523a9a542ae8cefac732058c413n.jpg_640x640q90.jpg', true),

-- Categoría 4: Puertas y ventanas (ID = 4) ---
(13, 4, 'Puerta Interior Maciza', 'Puerta de madera maciza, 80x200 cm. Acabado en melamina blanca. Incluye bisagras.', 125000, 5, 'https://maderahogar.com/wp-content/uploads/puerta-pino-maciza-2-lineas-horizontales-al213.jpg', true),
(14, 4, 'Ventana Corrediza Aluminio', 'Ventana de aluminio, 120x120 cm. Vidrio templado de 6mm. Color blanco.', 180000, 4, 'https://elmundocr.com/wp-content/uploads/2022/09/0af0cd52-16e4-49b4-82e2-83bbca55d612.jpg', true),
(15, 4, 'Picaporte Bronce', 'Picaporte para puertas interiores, acabado bronce antiguo. Incluye cerradura.', 22000, 10, 'https://dev.vega.cr/wp-content/uploads/imagenes/N_F01230.jpg', true),
(16, 4, 'Bisagra Acero Inoxidable', 'Bisagra de 4 pulgadas, acero inoxidable. Paquete de 10 unidades.', 15000, 20, 'https://tecnifacil.com.co/wp-content/uploads/2022/04/FIBA0231-1.jpg', true),

-- Categoría 5: Techos y cubiertas (ID = 5) ---
(17, 5, 'Teja Colonial Roja', 'Teja de arcilla cocida, 40x20 cm. Para techos inclinados. Resistente a heladas.', 8500, 30, 'https://cdnx.jumpseller.com/ace-comaderas/image/12620457/39361.jpg?1693843634', true),
(18, 5, 'Panel Sándwich 5cm', 'Panel aislante térmico y acústico. 1m x 2m. Ideal para naves industriales.', 95000, 8, 'https://img.archiexpo.es/images_ae/photo-m2/138072-20295842.jpg', true),
(19, 5, 'Canaleta Plástica 4"', 'Canaleta para desagüe de agua, 3 metros. Color blanco.', 18000, 15, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS4BnmeO0W_Ebq-AdtodHP3yZB4_GGxru26fQ&s', true),
(20, 5, 'Tornillo Techo Autoperforante', 'Tornillo para fijación de chapas. Paquete de 50 unidades. Incluye arandela de goma.', 22000, 25, 'https://cr.epaenlinea.com/media/catalog/product/1/0/100011534.jpeg?optimize=medium&bg-color=255,255,255&fit=bounds&height=300&width=300&canvas=300:300', true),

-- Categoría 6: Herramientas y accesorios (ID = 6) ---
(21, 6, 'Taladro Percutor 750W', 'Taladro profesional con velocidad variable, función de impacto y empuñadura antivibración. Ideal para hormigón, madera y metal.', 125000, 8, 'https://ferreteriavidri.com/images/items/large/436316.jpg?v=20250811', true),
(22, 6, 'Amoladora Angular 4.5"', 'Amoladora de 850W con disco de 4.5 pulgadas, protección contra reinicio y empuñadura lateral ajustable.', 98000, 5, 'https://toolsservice.com.pe/wp-content/uploads/amoladora-angular-4punto5-18-voltios-11000-rpm-brushless.jpg', true),
(23, 6, 'Martillo Demoledor 1500W', 'Martillo eléctrico con potencia de 1500W, ideal para demoliciones en concreto y mampostería.', 210000, 3, 'https://image.vevor.com/es%2F65ADG000000000001V2%2Fgoods_img-v7%2Fjack-hammer-m100-1.2.jpg?timestamp=1636097459000', true),
(24, 6, 'Sierra Circular 1800W', 'Sierra circular con láser guía, profundidad de corte ajustable y base de aluminio para mayor precisión.', 145000, 6, 'https://grupodiasa.co.cr/wp-content/uploads/2021/05/014-3228-1200x1200.jpg', true),

-- Categoría 7: Materiales de construcción (ID = 7) ---
(25, 7, 'Ladrillos Huecos x12', 'Ladrillos cerámicos huecos, 18x19x33 cm. Ideales para tabiques divisorios. Paquete de 12 unidades.', 15000, 25, 'https://dcdn-us.mitiendanube.com/stores/001/207/902/products/ladrillo-hueco1-f7f58bc9b3f92cd72616445833229455-240-0.jpg', true),
(26, 7, 'Vigas de Madera 2x4', 'Vigas de pino tratado, 2x4 pulgadas x 3 metros. Resistente a humedad e insectos.', 12000, 30, 'https://nodomateriales.com/wp-content/uploads/2024/08/08VIGA11_1-1.jpg', true),
(27, 7, 'Plancha de Yeso 1.2x2.4m', 'Panel de yeso de 12.5mm de espesor, ideal para cielorrasos y tabiques. Resistente al fuego.', 8500, 15, 'https://http2.mlstatic.com/D_NQ_NP_661728-MLA54054693831_022023-O.webp', true),
(28, 7, 'Tornillos Tirafondo x100', 'Tornillos cabeza hexagonal, 3/8"x3". Incluye 100 unidades con arandelas. Zincado para mayor durabilidad.', 8000, 40, 'https://http2.mlstatic.com/D_NQ_NP_681750-MLA81006072829_112024-O.webp', true),

-- Categoría 8: Materiales de carpintería (ID = 8) ---
(29, 8, 'Tablero MDF 18mm 1.22x2.44m', 'Tablero de fibra de densidad media, ideal para muebles y trabajos de carpintería interior. Superficie lisa para pintar o laminar.', 42000, 10, 'https://promart.vteximg.com.br/arquivos/ids/530298-700-700/121294_4.jpg?v=637357003614300000', true),
(30, 8, 'Tabla de Pino Cepillada 1x6"x3m', 'Madera de pino cepillada en medidas estándar. Ideal para proyectos de carpintería, muebles y estructuras ligeras.', 18000, 15, 'https://www.veneciacr.com/wp-content/uploads/2020/05/192593.jpg', true),
(31, 8, 'Lijadora Orbital 1/4 de Hoja', 'Lijadora eléctrica con base triangular, sistema de extracción de polvo. Velocidad variable 12,000-16,000 OPM.', 65000, 8, 'https://m.media-amazon.com/images/I/31O36+dLYkL._SL500_.jpg', true),
(32, 8, 'Juego de Formones Profesionales 6 piezas', 'Set de formones de acero al cromo vanadio con mangos de madera. Incluye tamaños: 6, 12, 18, 24, 32 y 40 mm.', 38000, 12, 'https://gubias.com.es/1679-large_default/juego-de-6-formones-wood-line-profi-6-10-12-16-20-26-narex.jpg', true);

/*Se crean 6 facturas */   /*'Activa','Pagada','Anulada')*/
INSERT INTO factura (id_factura,id_usuario,fecha,total,estado) VALUES
(1,1,'2025-06-05',211560,2),
(2,2,'2025-06-07',554340,2),
(3,3,'2025-07-07',871000,2),
(4,1,'2025-07-15',244140,1),
(5,2,'2025-07-17',414800,1),
(6,3,'2025-07-21',420000,1);

INSERT INTO venta (id_venta,id_factura,id_producto,precio,cantidad) values
(1,1,5,45000,3),
(2,1,9,15780,2),
(3,1,10,15000,3),
(4,2,5,45000,1),
(5,2,14,154000,3),
(6,2,9,15780,3),
(7,3,14,154000,1),
(8,3,6,57000,1),
(9,3,15,330000,2),
(10,4,6,57000,2),
(11,4,8,27600,3),
(12,4,9,15780,3),
(13,5,8,27600,3),
(14,5,14,154000,2),
(15,5,3,24000,1),
(16,6,15,330000,1),
(17,6,12,45000,1),
(18,6,10,15000,3);

create table role (  
  rol varchar(20),
  PRIMARY KEY (rol)  
);

insert into role (rol) values ('ADMIN'), ('VENDEDOR'), ('USER');

create table rol (
  id_rol INT NOT NULL AUTO_INCREMENT,
  nombre varchar(20),
  id_usuario int,
  PRIMARY KEY (id_rol)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

insert into rol (id_rol, nombre, id_usuario) values
 (1,'ADMIN',1), (2,'VENDEDOR',1), (3,'USER',1),
 (4,'VENDEDOR',2), (5,'USER',2),
 (6,'USER',3);


CREATE TABLE ruta (
    id_ruta INT AUTO_INCREMENT NOT NULL,
    patron VARCHAR(255) NOT NULL,
    rol_name VARCHAR(50) NOT NULL,
	PRIMARY KEY (id_ruta))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

INSERT INTO ruta (patron, rol_name) VALUES 
('/producto/nuevo', 'ADMIN'),
('/producto/guardar', 'ADMIN'),
('/producto/modificar/**', 'ADMIN'),
('/producto/eliminar/**', 'ADMIN'),
('/categoria/nuevo', 'ADMIN'),
('/categoria/guardar', 'ADMIN'),
('/categoria/modificar/**', 'ADMIN'),
('/categoria/eliminar/**', 'ADMIN'),
('/usuario/**', 'ADMIN'),
('/constante/**', 'ADMIN'),
('/role/**', 'ADMIN'),
('/usuario_role/**', 'ADMIN'),
('/ruta/**', 'ADMIN'),
('/producto/listado', 'VENDEDOR'),
('/categoria/listado', 'VENDEDOR'),
('/pruebas/**', 'VENDEDOR'),
('/reportes/**', 'VENDEDOR'),
('/facturar/carrito', 'USER'),
('/payment/**', 'USER');

CREATE TABLE ruta_permit (
    id_ruta INT AUTO_INCREMENT NOT NULL,
    patron VARCHAR(255) NOT NULL,
	PRIMARY KEY (id_ruta))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

INSERT INTO ruta_permit (patron) VALUES 
('/'),
('/index'),
('/errores/**'),
('/carrito/**'),
('/registro/**'),
('/fav/**'),
('/js/**'),
('/webjars/**');

CREATE TABLE constante (
    id_constante INT AUTO_INCREMENT NOT NULL,
    atributo VARCHAR(25) NOT NULL,
    valor VARCHAR(150) NOT NULL,
	PRIMARY KEY (id_constante))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

INSERT INTO constante (atributo,valor) VALUES 
('dominio','localhost'),
('certificado','c:/cert'),
('dolar','520.75'),
('paypal.client-id','AUjOjw5Q1I0QLTYjbvRS0j4Amd8xrUU2yL9UYyb3TOTcrazzd3G3lYRc6o7g9rOyZkfWEj2wxxDi0aRz'),
('paypal.client-secret','EMdb08VRlo8Vusd_f4aAHRdTE14ujnV9mCYPovSmXCquLjzWd_EbTrRrNdYrF1-C4D4o-57wvua3YD2u'),
('paypal.mode','sandbox'),
('urlPaypalCancel','http://localhost/payment/cancel'),
('urlPaypalSuccess','http://localhost/payment/success');
