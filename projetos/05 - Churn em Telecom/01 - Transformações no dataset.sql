  -- Seção 2 - CRIAÇÃO E EXPLORAÇÃO DE TABELAS
  
  -- Criando coluna "Lat_Long" contendo a concatenação das colunas 'Latitude' e 'Longitude'
CREATE OR REPLACE TABLE
  `laboratoria-telco-361601.Dataset_telco.churn_location` AS
SELECT *,
  CONCAT(Latitude,',', Longitude) AS Lat_Long
FROM
  `laboratoria-telco-361601.Dataset_telco.churn_location`; 



  -- Criando tabela com as informações principais de 'churn_location', 'churn_demographics', 'churn_services', 'churn_status'
CREATE OR REPLACE TABLE `laboratoria-telco-361601.Dataset_telco.master_churn`  AS (
SELECT a.* EXCEPT(Zip_Code),
        b.Gender,b.Age,b.Under_30,b.Senior_Citizen,
        b.Married,b.Dependents,b.Number_of_Dependents,
        c.Quarter,c.Referred_a_Friend,c.Number_of_Referrals,
        c.Tenure_in_Months,c.Offer,c.Phone_Service,
        c.Avg_Monthly_Long_Distance_Charges,c.Multiple_Lines,
        c.Internet_Service,c.Internet_Type,c.Avg_Monthly_GB_Download,
        c.Online_Security,c.Online_Backup,c.Device_Protection_Plan,
        c.Premium_Tech_Support,c.Streaming_TV,c.Streaming_Movies,
        c.Streaming_Music,c.Unlimited_Data,c.Contract,c.Paperless_Billing,
        c.Payment_Method,c.Monthly_Charge,c.Total_Charges,c.Total_Refunds,
        c.Total_Extra_Data_Charges,c.Total_Long_Distance_Charges,c.Total_Revenue,
        d.Customer_Status,d.Churn_Label,d.Churn_Value,
        d.Churn_Category,d.Churn_Reason 
FROM `laboratoria-telco-361601.Dataset_telco.churn_location` a
LEFT JOIN `laboratoria-telco-361601.Dataset_telco.churn_demographics` b
ON a.Customer_ID=b.Customer_ID
LEFT JOIN `laboratoria-telco-361601.Dataset_telco.churn_services` c
ON b.Customer_ID=c.Customer_ID
LEFT JOIN `laboratoria-telco-361601.Dataset_telco.churn_status` d
ON c.Customer_ID=d.Customer_ID
)

