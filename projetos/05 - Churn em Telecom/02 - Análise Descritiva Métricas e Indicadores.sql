  -- Seção 3 - DESCRIÇÃO DAS TABELAS
  
  -- Análise descritiva dos dados e criação de métricas/indicadores

-- Quantidade de registros
SELECT COUNT(*)
FROM `laboratoria-telco-361601.Dataset_telco.master_churn`

-- Países
SELECT DISTINCT Country
FROM `laboratoria-telco-361601.Dataset_telco.master_churn`

-- Quantidade diferentes de cidades
SELECT COUNT(DISTINCT City)
FROM `laboratoria-telco-361601.Dataset_telco.master_churn`

-- Cidades
SELECT DISTINCT City
FROM `laboratoria-telco-361601.Dataset_telco.master_churn`

-- Idade mínima, máxima e média
SELECT 
  MIN(Age) AS edad_minima,
  MAX(Age) AS edad_maxima,
  AVG(Age) AS edad_promedio
FROM `laboratoria-telco-361601.Dataset_telco.master_churn`

-- Quantidades de clientes por gênero
SELECT Gender, COUNT(Customer_ID) AS clientes_totales
FROM `laboratoria-telco-361601.Dataset_telco.master_churn`
GROUP BY Gender

-- Quantidades de clientes por cidades
SELECT City, COUNT(Customer_ID) AS clientes_totales
FROM `laboratoria-telco-361601.Dataset_telco.master_churn`
GROUP BY 1
ORDER BY 2 DESC 

