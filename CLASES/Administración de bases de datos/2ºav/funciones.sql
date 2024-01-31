CREATE FUNCTION sales tax (subtotal real, OUT tax real) AS $$
BEGIN
tax :=  

Diferentes tipos de datos

como poner que retorne un valor

-- FUNCION QUE RETORNA MAS DE UN VALOR EN ¿FORMATO DE TABLA?

CREATE FUNCTION extended_sales(p_itemni int)
RETURNS TABLE(quantity int, total numeric) AS $$
BEGINRETURN QUERY SELELCT quantity, quantity * price FROM sales
WHERE itemno = p_itemno;
END;
$$ LANGUAGE plqpsql;

-- ASIGNAR VARIABLES

nombre_variable := valor;
nombre de variable := variable2 * valor/variable2

-- CONDICIONALES

IF ... THEN ... ( SIMPLE )
    -- Si la condicion se cumple se ejecutan las instrucciones que siguen en THEN
IF ... THEN ... ELSE ( DOBLE )
    -- Si la condicion se cumple se ejecuta THEN 
    -- Si la condicion NO se cumple se ejecutta ELSE
IF ... THEN ... ELSIF ... THEN ... ELSE
    -- Evalua desde el inicio cada condicion hasta que encuentra una que se cumple se ejecuta THEN
    -- si alguna no se cumple se ejecuta ELSE

-- ITERATIVOS

LOOP ()
    -- Se pone antes de la sentencia se ejecutará hasta que se cumpla la condicion
    -- La condicion se envlua al final
    -- Se ejecuta HASTA que se cumple
    LOOP
    sentencias
    exit when <condicion>
    sentencias
    exit when <condicion>
    ...
    end loop;

        opcion := 0;
        LOOP
        write ("1.ALTA")
        write ("2.SALIR")
        EXIT WHEN opcion = 2;
    
    
WHILE ... LOOP
    -- Se evalua al principio 
    -- Mientras se cumple 
FOR
    --Bucle que se ejecuta determinadas veces
    for <variable> in <rang.min>..<rang.max> 

-- CONTROL DE ERRORES
    -- Si queremos capturar los errores y recuperarlos jacerlo con un bloque BEGIN con la clausula EXCEPTION
    