-- TRATAMENTO DOS DADOS


CREATE OR REPLACE TABLE `satisfacao-funcionarios.analisefuncionarios.analise_dados_funcionarios` AS
  SELECT *,  

-- Segmentação das idades dos funcionarios
    CASE 
      WHEN Age BETWEEN 18 AND 24 THEN '1. 18 a 24 Anos' 
      WHEN Age BETWEEN 25 AND 29 THEN '2. 25 a 29 Anos' 
      WHEN Age BETWEEN 30 AND 34 THEN '3. 30 a 34 Anos' 
      WHEN Age BETWEEN 35 AND 39 THEN '4. 35 a 39 Anos' 
      WHEN Age BETWEEN 40 AND 44 THEN '5. 40 a 44 Anos' 
      WHEN Age BETWEEN 45 AND 49 THEN '6. 45 a 49 Anos' 
      WHEN Age BETWEEN 50 AND 54 THEN '7. 50 a 54 Anos' 
      ELSE '8. 55 a 60 anos'
    END AS Age_segment,
    
-- Atribuindo nome do grau de escolaridade
    CASE
      WHEN Education = 1 THEN 'Below College'
      WHEN Education = 2 THEN 'College'
      WHEN Education = 3 THEN 'Bachelor'
      WHEN Education = 4 THEN 'Master'
      ELSE'Doctor'
    END AS Education_degree,

  -- Atribuindo categoria de satisfação ambiente
    CASE
      WHEN EnvironmentSatisfaction = 1 THEN 'Low'
      WHEN EnvironmentSatisfaction = 2 THEN 'Medium'
      WHEN EnvironmentSatisfaction = 3 THEN 'High'
      ELSE 'Very High'
    END AS EnvironmentSatisfaction_segment,

  -- Atribuindo categoria de Job Involvement segmento
    CASE
      WHEN JobInvolvement = 1 THEN 'Low'
      WHEN JobInvolvement = 2 THEN 'Medium'
      WHEN JobInvolvement = 3 THEN 'High'
      ELSE 'Very High'
    END AS JobInvolvement_segment,

  -- Atribuindo categoria de JobSatisfaction segmento
  CASE
      WHEN JobSatisfaction = 1 THEN 'Low'
      WHEN JobSatisfaction = 2 THEN 'Medium'
      WHEN JobSatisfaction = 3 THEN 'High'
      ELSE 'Very High'
    END AS JobSatisfaction_segment,

  -- Atribuindo categoria de PerformanceRating segmento
  CASE
      WHEN PerformanceRating = 1 THEN 'Low'
      WHEN PerformanceRating = 2 THEN 'Good'
      WHEN PerformanceRating = 3 THEN 'Excellent'
      ELSE 'Outstanding'
  END AS PerformanceRating_segment,

  -- Atribuindo categoria de RelationshipSatisfaction segmento
  CASE
      WHEN RelationshipSatisfaction = 1 THEN 'Low'
      WHEN RelationshipSatisfaction = 2 THEN 'Medium'
      WHEN RelationshipSatisfaction = 3 THEN 'High'
      ELSE 'Very High'
    END AS RelationshipSatisfaction_segment,

  -- Atribuindo categoria de WorkLifeBalance segmento
  CASE
      WHEN WorkLifeBalance = 1 THEN 'Bad'
      WHEN WorkLifeBalance = 2 THEN 'Good'
      WHEN WorkLifeBalance = 3 THEN 'Better'
      ELSE 'Best'
    END AS WorkLifeBalance_segment,
  
  -- Atribuindo categoria de DistanceFromHome segmento
  CASE 
      WHEN DistanceFromHome <= 2 THEN '1 - Until 2'
      WHEN DistanceFromHome BETWEEN 3 AND 5 THEN '2 - Between 3 and 5'
      WHEN DistanceFromHome BETWEEN 6 AND 10 THEN '3 - Between 6 and 10'
      WHEN DistanceFromHome BETWEEN 11 AND 20 THEN '4 - Between 11 and 20'
      ELSE '5 - More than 20'
  END AS DistanceFromHome_segment

FROM `satisfacao-funcionarios.analisefuncionarios.dados_funcionarios`;

