-- Tabla turistas

CREATE TABLE turistas (
  id_turista SERIAL NOT NULL,
  nombre_turista VARCHAR(255) NOT NULL,
  pais_origen VARCHAR(255) NOT NULL,
  PRIMARY KEY (id_turista)
);

-- Tabla reservas

CREATE TABLE reservas (
  id_reserva SERIAL NOT NULL,
  id_turista INT NOT NULL,
  fecha_inicio DATE NOT NULL,
  fecha_fin DATE NOT NULL,
  lugar VARCHAR(255) NOT NULL,
  importe DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (id_reserva),
  FOREIGN KEY (id_turista) REFERENCES turistas (id_turista)
);

INSERT INTO turistas (nombre_turista, pais_origen) VALUES
('Juan Pérez', 'España'),
('María García', 'Argentina'),
('Pedro Rodríguez', 'Brasil');

INSERT INTO reservas (id_turista, fecha_inicio, fecha_fin, lugar, importe) VALUES
(1, '2023-12-01', '2023-12-10', 'Palma', 1000),
(2, '2023-12-15', '2023-12-22', 'Barcelona', 2000),
(3, '2023-12-25', '2023-12-31', 'Madrid', 3000);


3.-----------

CREATE VIEW vista_reservas_turistas AS
SELECT t.nombre_turista, r.fecha_inicio, r.fecha_fin, r.lugar
FROM reservas r
JOIN turistas t ON r.id_turista = t.id_turista;

4.-----------

CREATE OR REPLACE RULE no_reservas_pasadas AS
ON INSERT TO reservas
WHERE NEW.fecha_inicio < CURRENT_DATE
DO INSTEAD NOTHING;

5.-----------

CREATE VIEW vista_reservas_por_pais AS
SELECT t.nombre_turista, r.fecha_inicio, r.fecha_fin, r.lugar
FROM reservas r
JOIN turistas t ON r.id_turista = t.id_turista
WHERE t.pais_origen = 'Brasil';

6.-----------

CREATE OR REPLACE RULE no_eliminar_turistas_con_reservas AS
ON DELETE TO turistas
WHERE (SELECT COUNT(*) FROM reservas WHERE id_turista = OLD.id_turista) > 0
DO INSTEAD NOTHING;

7.------------

CREATE VIEW vista_reservas_duracion_superior_7dias AS
SELECT t.nombre_turista, r.fecha_inicio, r.fecha_fin, r.lugar
FROM reservas r
JOIN turistas t ON r.id_turista = t.id_turista
WHERE (r.fecha_fin - r.fecha_inicio) > 7;

8.------------

CREATE VIEW vista_reservas_proximos_3_dias AS
SELECT t.nombre_turista, r.fecha_inicio, r.fecha_fin, r.lugar
FROM reservas r
JOIN turistas t ON r.id_turista = t.id_turista
WHERE (r.fecha_fin - CURRENT_DATE) <= 3;

9.------------

CREATE OR REPLACE RULE no_actualizar_fechas_reservas_comenzadas AS
ON UPDATE TO reservas
WHERE NEW.fecha_inicio <= CURRENT_DATE
DO INSTEAD NOTHING;

10.-----------

CREATE OR REPLACE RULE no_reservas_importe_inferior_40 AS
ON INSERT TO reservas
WHERE NEW.importe < 40
DO INSTEAD NOTHING;


create databade wordpress;
use wordpress
create user 'wpuser'@'%' identified by 'p@ssword';
grant all on wordpress.* to 'wpuser'@'%';
flush privileges;