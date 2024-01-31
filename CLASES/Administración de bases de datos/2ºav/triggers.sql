Los TRIGGERSson procedimientos almacenados en la base de datos
 que se ejecutan automáticamente cuando se hace un INSERT, DELETE O UPDATE
 realiza comprobaciones para ver si se puede insertar, borrar o UPDATE
 
 No se pueden llevar a termino en un select porque este no afecta a la base de datos 





 BEFORE | AFTER nos dice si se ejecuta antes de hacer la acción o despues
    Si se hace antes y hay un error no lo hace
    Si se hace despues, hace también las comprobaciones y realizará un ROLLBACK

EVENTOS INSERT | UPDATE | DELETE - Estos pueden hacer cambios en la base de datos

FOR EACH ROW (SOLO AFECTA A UNA FILA)|For each STATEMENT ()

VARIABLES A TENER EN cuenta

    NEW - Nueva fila cuando se ejecuta un TRIGGER
        UPDATE - El valor una vez se ejecuta 
    OLD - El valor antiguo de las operaciones UPDATE/DELETE


MODIFICACIONES Y ELIMINACIONES

    CASCADE - Suprime automaticamente los objetos que dependen del TRIGGER
    RESTRICT - Valor por defecto y se niega a suprimir el disparador si objetos dependen de el


CREATE FUNCTION reg_empleat() RETURNS trigger AS $reg_empleat$
BEGIN
    -- Comprueba que se informe del nombre y el salario
    IF NEW.nom_empleat IS NULL THEN -- comprueba si el nombre del empleado es NULL
        Raise EXCEPTION ´nom_empleat no pot ser null´;
    END IF;
    IF NEW.salari IS NULL THEN
        RAISE EXCEPTION ´el salari no pot ser null´;
        NEW.nom_empleat;
    END IF;
    -- Comprueba que el salario sea positivo.
    ID NEW.salari < 0 THEN
        RAISE ECXEPTION ´el salario de % no puede ser negativo´,
        NEW.nom_empleat;
    END IF;
    --Registre de quien ha hecho la modifición
    NEW.darrera_modif := ´now´;
    NEW.darrer_usuari := current_user;
END;
$reg_empleat$ Language plpsql;

CREATE TRIGGER reg_empleat BEFORE INSERT OR UPDATE ON empleat --Este trigger ejecutará la funcion antes mencionada cuando se haga un insert o un update
FOR EACH ROW EXECUTE PROCEDURE regempleat(); 