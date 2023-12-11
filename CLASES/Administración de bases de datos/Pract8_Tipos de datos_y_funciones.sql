Para obtener todas las funciones predefinidas en PostgreSQL, puedes usar dos métodos12:

Realizar una consulta a la tabla pg_proc del catálogo1.
Si utilizas el cliente estándar, puedes ejecutar el comando \df1.

Para crear una función “bisiesto” en PostgreSQL, puedes usar el comando CREATE FUNCTION.
Aquí tienes un ejemplo de cómo podría ser la función


1------
-- Consultas a tabla de funciones pg_proc

    -- nos muestra todos los nombres de las funciones
select proname from pg_proc; 
    SELECT proname FROM pg_catalog.pg_proc;

select proname,prosrc from pg_proc where prosrc like '%texto%'; -- Cambiamos '%texto%' para buscar la funcion en específico



2-------
CREATE FUNCTION bisiesto(year1 INT)
RETURNS BOOLEAN AS $$
BEGIN
    IF year1 % 4 != 0 OR (year1 % 100 = 0 AND year1 % 400 != 0) THEN
        RETURN FALSE;
    ELSE
        RETURN TRUE;
    END IF;
EXCEPTION WHEN OTHERS THEN
    RAISE EXCEPTION 'El valor introducido no es numérico';
END;
$$ LANGUAGE plpgsql;

3------
ALTER TABLE turistas ADD COLUMN Destinos_preferidos TEXT[3];

INSERT INTO turistas (nombre_turista, pais_origen, Destinos_preferidos) VALUES
('Juan Pérez', 'España', '{"Palma", "Barcelona", "Madrid"}')

4------
INSERT INTO turistas (nombre_turista, pais_origen, Destinos_preferidos) VALUES
('Juan Pérez', 'España', '{"Palma", "Barcelona", "Madrid"}')

5------
CREATE FUNCTION total_turistes()
RETURNS INT AS $$
BEGIN
    RETURN (SELECT COUNT(*) FROM turistas);
EXCEPTION WHEN NO_DATA_FOUND THEN
    RAISE EXCEPTION 'No hay turistas en la tabla';
END;
$$ LANGUAGE plpgsql;

6-----

CREATE OR REPLACE FUNCTION total_reserves_turista(int4)
RETURNS INTEGER AS $$
DECLARE
    total INTEGER;
    exists INTEGER;
BEGIN
    SELECT COUNT(*) INTO exists FROM turistas WHERE id_turista = $1;
    IF exists = 0 THEN
        RAISE EXCEPTION 'No existeix el turista';
    END IF;
    SELECT COUNT(*) INTO total FROM reservas WHERE id_turista = $1;
    RETURN total;
END;
$$ LANGUAGE plpgsql;

7-----

CREATE OR REPLACE FUNCTION import_reserves_turista_any(turista_id int4, year int4)
RETURNS NUMERIC AS $$
DECLARE
    total NUMERIC;
    exists INTEGER;
BEGIN
    SELECT COUNT(*) INTO exists FROM turistas WHERE id_turista = turista_id;
    IF exists = 0 THEN
        RAISE EXCEPTION 'No existeix el turista';
    END IF;
        SELECT SUM(importe) INTO total FROM reservas WHERE id_turista = $1 AND EXTRACT(YEAR FROM fecha_inicio) = $2;
    RETURN total;
END;
$$ LANGUAGE plpgsql;

8------
SELECT bisiesto(2024);
SELECT total_turistes();
SELECT total_reserves_turista(4);
SELECT import_reserves_turista_any(1,2023);

