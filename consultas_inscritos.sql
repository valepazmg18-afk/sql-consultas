CREATE TABLE inscritos (cantidad INT, fecha DATE, fuente VARCHAR);
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 44, '2021-01-01', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 56, '2021-01-01', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 39, '2021-01-02', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 81, '2021-01-02', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 12, '2021-01-03', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 91, '2021-01-03', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 48, '2021-01-04', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 45, '2021-01-04', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 55, '2021-01-05', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 33, '2021-01-05', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente) 
VALUES ( 18, '2021-01-06', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 12, '2021-01-06', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 34, '2021-01-07', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 24, '2021-01-07', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 83, '2021-01-08', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 99, '2021-01-08', 'Página' );

-- 1. Cuantos registros hay
SELECT count(*) AS total_registros FROM inscritos;

-- 2. Cuantos inscritos hay en total
SELECT SUM(cantidad) AS total_inscritos FROM inscritos;

-- 3. Registros de mayor antigüedad
SELECT * FROM inscritos WHERE fecha = (SELECT MIN(fecha) FROM inscritos);

-- 4. Inscritos por dia
SELECT fecha, SUM(cantidad) AS total_inscritos_por_dia
FROM inscritos
GROUP BY fecha;

-- 5. Inscritos por fuente
SELECT fuente, SUM(cantidad) AS total_inscritos_por_fuente
FROM inscritos
GROUP BY fuente;

-- 6. Día que se inscribió la mayor cantidad de personas Y Cuántas personas se inscribieron en ese día
SELECT fecha, SUM(cantidad) AS total_inscritos
FROM inscritos
GROUP BY fecha
HAVING SUM(cantidad) = (SELECT MAX(total_inscritos) FROM (SELECT SUM(cantidad) AS total_inscritos FROM inscritos GROUP BY fecha) AS totales);

-- 7. Día que se inscribió la mayor cantidad de personas utilizando el blog Y Cuántas personas fueron
SELECT fecha, SUM(cantidad) AS total_inscritos
FROM inscritos
WHERE fuente = 'Blog'
GROUP BY fecha
HAVING SUM(cantidad) = 
(SELECT MAX(total_inscritos) FROM (SELECT SUM(cantidad) AS total_inscritos FROM inscritos WHERE fuente = 'Blog' GROUP BY fecha) AS totales);

-- 8. Promedio de personas inscritas por día
SELECT fecha, AVG(cantidad) AS inscritos_por_dia
FROM inscritos
GROUP BY fecha;

-- 9. ¿Qué días se inscribieron más de 50 personas?
SELECT fecha, SUM(cantidad) AS total_inscritos
FROM inscritos
GROUP BY fecha
HAVING SUM(cantidad) > 50;

-- 10. Promedio por día de personas inscritas. Considerando sólo calcular desde el tercer día.
SELECT fecha, AVG(cantidad) AS promedio_diario
FROM (
    SELECT *
    FROM inscritos
    WHERE fecha >=(
    SELECT fecha
    FROM inscritos
    GROUP BY fecha
    ORDER BY fecha
    LIMIT 1 OFFSET 2
    )
) AS desde_tercer_dia
GROUP BY fecha;
