CREATE  DATABASE banco_db;
CREATE TABLE Cuentas (ncta CHAR(1) NOT NULL PRIMARY KEY, dcta CHAR(15) NOT NULL, fecha DATE NOT NULL, saldo DECIMAL NOT NULL, CHECK (saldo >=0));
CREATE TABLE TranCuentas (ncta CHAR(1) NOT NULL, fecha DATE NOT NULL, impt DECIMAL NOT NULL, CHECK (impt!=0), FOREIGN KEY (ncta) REFERENCES Cuentas);
insert into Cuentas VALUES ('A', '12-345-8', '19-12-2022', 300);
insert into Cuentas VALUES ('B', '14-421-7', '20-12-2022', 50);
insert into TranCuentas VALUES ('A', '19-12-2022', 300);
insert into TranCuentas VALUES ('B', '20-12-2022', 50);




-- Iniciar la transacción
START TRANSACTION;

-- Retirar 150 de la cuenta 'A'
UPDATE Cuentas SET saldo = saldo - 150 WHERE ncta = 'A';

-- Ingresar 150 a la cuenta 'B'
UPDATE Cuentas SET saldo = saldo + 150 WHERE ncta = 'B';

-- Confirmar la transacción
COMMIT;

insert into TranCuentas VALUES ('A', '19-12-2022', 150);
insert into TranCuentas VALUES ('B', '20-12-2022', -150);

