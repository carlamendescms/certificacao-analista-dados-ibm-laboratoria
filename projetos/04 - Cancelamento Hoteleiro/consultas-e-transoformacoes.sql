  -- Seção 3 
  
-- Transformando dados e adicionando campos calculados -- Criando coluna com ano, mês e dia concatenados
CREATE OR REPLACE TABLE
  `analise-cancelamento-hoteleiro.projeto004.hotel-analise` AS
SELECT
  *,
  CONCAT(arrival_date_year,'-', arrival_date_month, '-', arrival_date_day_of_month) AS arrival_date
FROM
  `analise-cancelamento-hoteleiro.projeto004.hotel`; 
  
  
-- Criando coluna com estação DO ano
CREATE OR REPLACE TABLE
  `analise-cancelamento-hoteleiro.projeto004.hotel-analise` AS
SELECT
  *,
  CASE
    WHEN arrival_date_month IN ('January', 'February', 'March') THEN 'Verão'
    WHEN arrival_date_month IN ('April',
    'May',
    'June') THEN 'Outono'
    WHEN arrival_date_month IN ('July', 'August', 'September') THEN 'Inverno'
  ELSE
  'Primavera'
END
  AS arrival_season
FROM
  `analise-cancelamento-hoteleiro.projeto004.hotel-analise`; 
  
  
-- Criando segmentação de lead_time
CREATE OR REPLACE TABLE
  `analise-cancelamento-hoteleiro.projeto004.hotel-analise` AS
SELECT
  *,
  CASE
    WHEN lead_time < 30 THEN 'Curto'
    WHEN lead_time BETWEEN 30
  AND 90 THEN 'Médio'
  ELSE
  'Longo'
END
  AS lead_time_segment
FROM
  `analise-cancelamento-hoteleiro.projeto004.hotel-analise`; -- Criando conversão de coluna mês para tipo número
CREATE OR REPLACE TABLE
  `analise-cancelamento-hoteleiro.projeto004.hotel-analise` AS
SELECT
  *,
  CASE
    WHEN arrival_date_month = 'Janunary' THEN '01'
    WHEN arrival_date_month = 'February' THEN '02'
    WHEN arrival_date_month = 'March' THEN '03'
    WHEN arrival_date_month = 'April   ' THEN '04'
    WHEN arrival_date_month = 'May' THEN '05'
    WHEN arrival_date_month = 'June' THEN '06'
    WHEN arrival_date_month = 'July' THEN '07'
    WHEN arrival_date_month = 'August' THEN '08'
    WHEN arrival_date_month = 'September' THEN '09'
    WHEN arrival_date_month = 'October' THEN '10'
    WHEN arrival_date_month = 'November' THEN '11'
  ELSE
  '12'
END
  AS arrival_date_month_number
FROM
  `analise-cancelamento-hoteleiro.projeto004.hotel-analise`; 
  
-- Concatenando DATA usando a coluna de mês que foi convertida para número
CREATE OR REPLACE TABLE
  `analise-cancelamento-hoteleiro.projeto004.hotel-analise` AS
SELECT
  *,
  CONCAT(arrival_date_year,'-', arrival_date_month_number, '-', arrival_date_day_of_month) AS arrival_date_v2
FROM
  `analise-cancelamento-hoteleiro.projeto004.hotel-analise`; 
  
-- Alterando o tipo para DATE para que essa coluna seja usada nas análises
CREATE OR REPLACE TABLE
  `analise-cancelamento-hoteleiro.projeto004.hotel-analise` AS
SELECT
  *,
  CAST(arrival_date_v2 AS DATE) AS arrival_date_v3
FROM
  `analise-cancelamento-hoteleiro.projeto004.hotel-analise`; -- Criando coluna booking_date
CREATE OR REPLACE TABLE
  `analise-cancelamento-hoteleiro.projeto004.hotel-analise` AS
SELECT
  *,
  DATE_SUB(arrival_date_v3, INTERVAL lead_time DAY) AS booking_date
FROM
  `analise-cancelamento-hoteleiro.projeto004.hotel-analise`; 
  
-- 5.1 Calculando o impacto de um cancelamento devido ao pagamento de comissão de MKT 
-- Criando tabela 'hotel-impacto-cancelamento'
CREATE OR REPLACE TABLE
  `analise-cancelamento-hoteleiro.projeto004.hotel-impacto-cancelamento` AS
SELECT
  booking_date,
  SUM(is_canceled) AS canceled_bookings,
  COUNT(is_canceled)-SUM(is_canceled) AS not_canceled_bookings,
  SUM(is_canceled) * 1.5 AS canceled_bookings_payment,
  (COUNT(is_canceled)-SUM(is_canceled)) * 1.5 AS not_canceled_bookings_payment
FROM
  `analise-cancelamento-hoteleiro.projeto004.hotel-analise`
GROUP BY
  booking_date
ORDER BY
  booking_date; 
  
-- 5.2 Impacto de um cancelamento feito com menos de 3 dias de antecedência 
-- Criando tabela 'canceled_bookings_days_diff' 

-- A tabela gerada será usada na 'Consulta 5.2 - Cancelamentos com menos de 3 dias de antecedência'
CREATE OR REPLACE TABLE
  `analise-cancelamento-hoteleiro.projeto004.hotel-analise` AS
SELECT
  *,
  booking_date AS reservation_date,
  DATE_DIFF(arrival_date_v3, reservation_status_date, DAY) AS days_between_cancelation_and_arrival
FROM
  `analise-cancelamento-hoteleiro.projeto004.hotel-analise`
WHERE
  is_canceled = 1; 

-- HIPÓTESES -- 

-- 6.1 Hipótese 1: Reservas feitas com antecedência correm alto risco de cancelamento

-- A Tabela gerada será usada na Consulta 6.1
CREATE OR REPLACE TABLE
  `analise-cancelamento-hoteleiro.projeto004.hotel-analise` AS
SELECT
  *,
  CASE
    WHEN lead_time < 15 THEN 'Menor que 15 dias'
    WHEN lead_time >= 15
  AND lead_time < 30 THEN 'Entre 15 e 30 dias'
    WHEN lead_time >= 30 AND lead_time < 30 THEN 'Entre 30 e 60 dias'
    WHEN lead_time >= 60
  AND lead_time < 90 THEN 'Entre 60 e 90 dias'
    WHEN lead_time >= 90 AND lead_time < 180 THEN 'Entre 90 e 180 dias'
    WHEN lead_time >= 180
  AND lead_time < 360 THEN 'Entre 180 e 360 dias'
  ELSE
  'Maior de 360 dias'
END
  AS lead_time_category
FROM
  `analise-cancelamento-hoteleiro.projeto004.hotel-analise`; 
  
-- 6.3 Hipótese 3: Os usuários que fizeram uma alteração em sua reserva têm menor risco de cancelamento 
-- Criando segmentação para quantidade de alterações realizadas na reserva

-- A Tabela gerada será usada na Consulta 6.3
CREATE OR REPLACE TABLE
  `analise-cancelamento-hoteleiro.projeto004.hotel-analise` AS
SELECT
  *,
  CASE
    WHEN booking_changes BETWEEN 1 AND 10 THEN 'Entre 1 e 10 alterações'
    WHEN booking_changes > 10 THEN '10 alterações ou mais'
  ELSE
  'Sem alterações'
END
  AS booking_changes_category
FROM
  `analise-cancelamento-hoteleiro.projeto004.hotel-analise`; 
  
-- 6.4 Hipótese 4: Quando o usuário fez uma solicitação especial, o risco de cancelamento é menor 
-- Criando segmentação de quantidades de solicitação especial por reserva

-- A Tabela gerada será usada na Consulta 6.4
CREATE OR REPLACE TABLE
  `analise-cancelamento-hoteleiro.projeto004.hotel-analise` AS
SELECT
  *,
  CASE
    WHEN total_of_special_requests = 1 THEN 'Reserva possui 1 solicitação especial'
    WHEN total_of_special_requests > 1 AND total_of_special_requests <= 4 THEN 'Reserva possui de 2 a 4 solicitações especiais'
    WHEN total_of_special_requests >= 5 THEN 'Reserva possui 5 ou mais solicitações especiais'
  ELSE
  'Reserva não possui solicitações especiais'
END
  AS total_of_special_requests_category
FROM
  `analise-cancelamento-hoteleiro.projeto004.hotel-analise`;

-- 6.5 Hipótese 5: As reservas que possuem um baixo "adr" o risco é menor 
-- Criando segmentação de valores médios por reserva

-- A Tabela gerada será usada na Consulta 6.5
CREATE OR REPLACE TABLE
  `analise-cancelamento-hoteleiro.projeto004.hotel-analise` AS
SELECT
  *,
  CASE
    WHEN adr < 100 THEN 'Diária menor de $100'
    WHEN adr >= 100 AND adr < 200 THEN 'Diária de $100 até $200'
    WHEN adr >= 200 AND adr < 300 THEN 'Diária de $200 até $300'
    WHEN adr >= 300 AND adr < 400 THEN 'Diária de $300 até $400'
  ELSE
  'Diária maior que $400'
END
  AS adr_category
FROM
  `analise-cancelamento-hoteleiro.projeto004.hotel-analise`;