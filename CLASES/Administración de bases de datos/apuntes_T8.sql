Matrices
Son ARRAYS
insert into tabla values ('joan', '{96,56,76}');
SELECT parcials[3] from tabla; --Solo selecciona la tercera pocicion de esa colunma

Funciones

Predefinidas
SQRT Raiz quadrada
UPPER
LOWER
Escritas con PL/PgSQL
Tres tipos de Funciones

TIpo de base: DELETE 
    CREATE OR REMPLACE FUNCTION suma(int4,int4)
    RETURNS int4 AS $$
    SELECT $1 +$2;  $1 hace referencia al primer parametro $2 hace referencia al segundo parametro
    $$LANGUAGE SQL

CREATE OR REMPLACE FUCTION detAlumne(id INTEGER)
RETURN INTEGER AS $$
DECLARE
    existe BOOLEAN
SELECT TRUE INTO EXISTE
    FROM alumnes
    WHERE id_alumne = id
IF NOT existe THEN
    RAISE EXCEPTION 'El turista no existe'
ELSE
    RETURN num_res;
END IF;
END