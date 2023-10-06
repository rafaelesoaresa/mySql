-- 2) Selecione os nomes dos funcionários cujo salário é maior ou igual a R$ 4.000.
SELECT nome_funcionario
FROM funcionario
WHERE salario >= 4000.00;

-- 4) Calcular a média (estude como usar a função AVG) salarial dos funcionários com duas casas decimais de precisão após a vírgula, (estude como usar a função ROUND).
SELECT nome_funcionario, salario * 12 AS salario_anual
FROM funcionario;

-- 3) Calcular a média salarial dos funcionários.
SELECT  round((salario)) AS media_salarial
FROM funcionario;

-- 5) Encontre funcionários cujo nome contém "Gomes".
SELECT * FROM funcionario
WHERE nome_funcionario LIKE '%Gomes%';

-- 5) Identifique o funcionário com o salário mais alto (estude como usar a função MAX).
SELECT codigo_funcionario, nome_funcionario, salario
FROM funcionario
WHERE salario = (SELECT MAX(salario) FROM funcionario);

-- 6) Identifique os 2 salários mais altos (estude como usar a função LIMIT).
SELECT codigo_funcionario, nome_funcionario, salario
FROM funcionario
ORDER BY salario DESC
LIMIT 2;


