
-- Categorías (8 principales o precargadas)
INSERT INTO categoria (descripcion) VALUES ('Pinturas')
ON DUPLICATE KEY UPDATE descripcion = VALUES(descripcion);
INSERT INTO categoria (descripcion) VALUES ('Electricidad e iluminación')
ON DUPLICATE KEY UPDATE descripcion = VALUES(descripcion);
INSERT INTO categoria (descripcion) VALUES ('Revestimientos y pisos')
ON DUPLICATE KEY UPDATE descripcion = VALUES(descripcion);
INSERT INTO categoria (descripcion) VALUES ('Puertas y ventanas')
ON DUPLICATE KEY UPDATE descripcion = VALUES(descripcion);
INSERT INTO categoria (descripcion) VALUES ('Techos y cubiertas')
ON DUPLICATE KEY UPDATE descripcion = VALUES(descripcion);
INSERT INTO categoria (descripcion) VALUES ('Herramientas y accesorios')
ON DUPLICATE KEY UPDATE descripcion = VALUES(descripcion);
INSERT INTO categoria (descripcion) VALUES ('Materiales de construcción')
ON DUPLICATE KEY UPDATE descripcion = VALUES(descripcion);
INSERT INTO categoria (descripcion) VALUES ('Materiales de carpintería')
ON DUPLICATE KEY UPDATE descripcion = VALUES(descripcion);
