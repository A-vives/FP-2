CREATE OR REPLACE FUNCTION transferir_fondos(pagador CHAR, cobrador CHAR, importe DECIMAL, fecha DATE)
RETURN NUMBER IS 
  resultado NUMBER;
  cuenta_pagador Cuentas%ROWTYPE;
  cuenta_cobrador Cuentas%ROWTYPE;
BEGIN
  -- Verificar si el pagador y el cobrador existen
  SELECT * INTO cuenta_pagador FROM Cuentas WHERE ncta = pagador;
  SELECT * INTO cuenta_cobrador FROM Cuentas WHERE ncta = cobrador;

  IF cuenta_pagador IS NULL OR cuenta_cobrador IS NULL THEN
    RAISE_APPLICATION_ERROR(-20001, 'El pagador o el cobrador no existen');
  END IF;

  -- Inicio de la transacción
  SAVEPOINT inicio_transaccion;

  BEGIN
    -- Retirar 'importe' de la cuenta 'pagador'
    UPDATE Cuentas SET saldo = saldo - importe WHERE ncta = pagador;
    -- Ingresar 'importe' a la cuenta 'cobrador'
    UPDATE Cuentas SET saldo = saldo + importe WHERE ncta = cobrador;

    -- Si todo va bien, hacemos commit
    COMMIT;
    resultado := 1;
  EXCEPTION
    WHEN OTHERS THEN
      -- Si algo sale mal, hacemos rollback al inicio de la transacción
      ROLLBACK TO inicio_transaccion;
      resultado := 0;
  END;

  RETURN resultado;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20001, 'El pagador o el cobrador no existen');
END transferir_fondos;




CREATE OR REPLACE FUNCTION transferencia(pagador CHAR, cobrador CHAR, importe DECIMAL, fecha DATE)
RETURNS VARCHAR AS $$
DECLARE
    confirmacion VARCHAR;
BEGIN
    -- Comprobamos si existe el pagador
    IF NOT EXISTS (SELECT 1 FROM Cuentas WHERE ncta = pagador) THEN
        RAISE EXCEPTION 'La cuenta del pagador introducido no existe';
    END IF;
    -- Comprobamos si el comprador existe
    IF NOT EXISTS (SELECT 1 FROM Cuentas WHERE ncta = cobrador) THEN
        RAISE EXCEPTION 'La cuenta del cobrador introducido no existe';
    END IF;


    -- Comprobamos si el saldo queda negativo
    IF (SELECT saldo FROM cuentas WHERE ncta = pagador) - importe < 0 THEN
        RAISE EXCEPTION 'No tiene saldo suficiente para realizar esta transaccion';
    END IF;
    -- Cambio al saldo del pagador
    UPDATE Cuentas SET saldo = saldo - importe WHERE ncta = pagador;
     insert into TranCuentas (ncta,fecha,impt) values (pagador,fecha,-importe);
    -- Cambio de saldo al cobrador
    UPDATE Cuentas SET saldo = saldo + importe WHERE ncta = cobrador;
    insert into TranCuentas (ncta,fecha,impt) values (cobrador,fecha,importe);
    -- Mensaje de confirmación
    confirmacion := 'La transacción se ha podido realizar correctamente';
    -- Retorna el mensaje
    RETURN confirmacion;
EXCEPTION
    -- Para cualquier otro error
    WHEN OTHERS THEN
        -- Puedes agregar lógica de manejo específico si es necesario
        RETURN 'Error: ' || SQLERRM;
END;
$$ LANGUAGE plpgsql;




