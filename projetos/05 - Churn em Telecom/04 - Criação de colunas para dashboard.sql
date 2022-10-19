-- Seção 5

-- Criação de colunas para dashboard

  -- Criando faixas de idade
CREATE OR REPLACE TABLE
  `laboratoria-telco-361601.Dataset_telco.master_churn` AS
SELECT *,
  CASE 
    WHEN Age < 41 THEN '1. 0 a 40 anos'
    WHEN Age BETWEEN 41 AND 60 THEN '2. 41 a 60 anos' 
    ELSE '3. Mais de 60 anos' 
    END AS range_age
FROM
  `laboratoria-telco-361601.Dataset_telco.master_churn`; 

  -- criando faixas de quantidades de referências
CREATE OR REPLACE TABLE
  `laboratoria-telco-361601.Dataset_telco.master_churn` AS
SELECT *,
  CASE 
    WHEN Number_of_Referrals <= 0 THEN '1. 0 referências'
    WHEN Number_of_Referrals BETWEEN 1 AND 4 THEN '2. 1 a 4 referências'
    WHEN Number_of_Referrals BETWEEN 5 AND 8 THEN '3. 5 a 8 referências' 
    ELSE '4. Mais de 8 referências' 
    END AS reference_range
FROM
  `laboratoria-telco-361601.Dataset_telco.master_churn`; 

  -- criando faixas de tenure_in_months
  -- Para a variável range_tenure_months, as categorias são 1 a 12 meses, 13 a 24 meses, 25 a 36 meses, 37 a 48 meses, 49 a 60 meses, 61 a 72 meses.

CREATE OR REPLACE TABLE
  `laboratoria-telco-361601.Dataset_telco.master_churn` AS
SELECT *,
  CASE 
    WHEN Tenure_in_Months BETWEEN 1 AND 12 THEN '1. 1 a 12 meses'
    WHEN Tenure_in_Months BETWEEN 13 AND 24 THEN '2. 13 a 24 meses'
    WHEN Tenure_in_Months BETWEEN 25 AND 36 THEN '3. 25 a 36 meses' 
    WHEN Tenure_in_Months BETWEEN 37 AND 48 THEN '4. 37 a 48 meses'
    WHEN Tenure_in_Months BETWEEN 49 AND 60 THEN '5. 49 a 60 meses'
    ELSE '6. 61 a 72 meses'
    END AS range_tenure_months
FROM
  `laboratoria-telco-361601.Dataset_telco.master_churn`; 

  -- Criando segmentos dos clientes usando tipo de contrato, idade, número de referências e tempo em meses de contrato

CREATE OR REPLACE TABLE
  `laboratoria-telco-361601.Dataset_telco.master_churn` AS
SELECT *,
CASE
    WHEN Contract = 'Month-to-Month' AND Age > 64 THEN 'G1'
    WHEN Contract = 'Month-to-Month' AND Age < 64 AND Number_of_Referrals <= 1 THEN 'G2'
    WHEN Contract != 'Month-to-Month' AND Age > 64 AND Number_of_Referrals <= 1 THEN 'G3'
    WHEN Contract != 'Month-to-Month' AND Tenure_in_Months < 40 THEN 'G4'
    ELSE 'sem grupo'
END AS risk_group
FROM
  `laboratoria-telco-361601.Dataset_telco.master_churn`; 

  -- Criando nova tabela com campo idade média 
CREATE OR REPLACE  TABLE `laboratoria-telco-361601.Dataset_telco.master_churn` AS(
  WITH base_tenure_prom AS (
        SELECT Contract,AVG(Tenure_in_Months) AS media_tenure
        FROM `laboratoria-telco-361601.Dataset_telco.master_churn`
        GROUP BY 1
  )
  SELECT a.*,
        b.media_tenure
  FROM `laboratoria-telco-361601.Dataset_telco.master_churn` a
  LEFT JOIN base_tenure_prom b
    ON a.Contract = b.Contract
);

  -- Criando coluna com o valor estimado do cliente

CREATE OR REPLACE  TABLE `laboratoria-telco-361601.Dataset_telco.master_churn` AS (
SELECT *,
    media_tenure*Total_Revenue/3 AS ingresso_estimado
FROM `laboratoria-telco-361601.Dataset_telco.master_churn`
);

 -- Criando nova tabela com segmentos ou quartis para os clientes que não se desligaram

 CREATE OR REPLACE TABLE `laboratoria-telco-361601.Dataset_telco.champions_customers` AS (
    SELECT *,NTILE(4) OVER( PARTITION BY Contract 
                    ORDER BY ingresso_estimado ASC) AS quartil_estimado  
    FROM  `laboratoria-telco-361601.Dataset_telco.master_churn`
    WHERE Churn_Value=0
)