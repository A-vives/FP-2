1. Añade la columna NumTransferencias a la tabla Cuentas y pon el valor que  les corresponda según la tabla de TranCuentas para A y B. (10P) 

-- Añadir la columna NumTransferencias a la tabla Cuentas
ALTER TABLE Cuentas ADD NumTransferencias INT;

-- Actualizar el valor de NumTransferencias para la cuenta 'A'
UPDATE Cuentas SET NumTransferencias = (SELECT COUNT(*) FROM TranCuentas WHERE cuentas.ncta) WHERE ncta = 'A';

-- Actualizar el valor de NumTransferencias para la cuenta 'B'
UPDATE Cuentas SET NumTransferencias = (SELECT COUNT(*) FROM TranCuentas WHERE ncta = cuentas.ncta);

2. Crea un Trigger para que incremente de forma automática esos valores  cuando los usuarios realicen transferencias bancarias y comprueba su correcto  funcionamiento. Para realizar estas pruebas sería recomendable añadir 1 o 2  cuentas más. (60P) 



create or REPLACE FUNCTION act_trans_trigger()
returns trigger as $$
BEGIN
    UPDATE Cuentas SET NumTransferencias = (SELECT COUNT(*) 
                                            FROM TranCuentas 
                                            WHERE ncta = new.ncta)
                                            where ncta = new.ncta;
    return NEW;
end;
$$ language plpgsql;


CREATE TRIGGER incrementar_transferencias
AFTER INSERT ON TranCuentas
FOR EACH ROW
execute function act_trans_trigger();

INSERT INTO Cuentas VALUES ('C', '15-678-9', '21-12-2022', 200, 0);
INSERT INTO Cuentas VALUES ('D', '16-789-0', '22-12-2022', 100, 0);

-- Realizar algunas transferencias
INSERT INTO TranCuentas VALUES ('A', '23-12-2022', -50);
INSERT INTO TranCuentas VALUES ('C', '23-12-2022', 50);
INSERT INTO TranCuentas VALUES ('B', '24-12-2022', -30);
INSERT INTO TranCuentas VALUES ('D', '24-12-2022', 30);


3. Explicaciones: las capturas están bien explicadas (20P) 
4. Presentación: el nombre del documento cumple con lo solicitado, el  documento tiene portada, índice y bibliografía. (10P) 
