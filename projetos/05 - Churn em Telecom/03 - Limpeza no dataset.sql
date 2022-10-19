-- Seção 4

-- Removendo maior que 80 anos
-- Removendo as mensalidades negativas ou nulas
-- Convertendo a categoria “M” para Masculino e a categoria “F” para Feminino.

CREATE OR REPLACE TABLE `laboratoria-telco-361601.Dataset_telco.master_churn` AS
(
SELECT * EXCEPT(gender),
CASE
  WHEN gender = 'M' THEN 'Male'
  WHEN gender = 'F' THEN 'Female'
  ELSE gender END as gender
FROM `laboratoria-telco-361601.Dataset_telco.master_churn`
  WHERE Age<=80
  AND Monthly_Charge > 0
)