WITH quantidade_funcionarios AS (
  SELECT COUNT(1) AS Quantidade_Total_Funcionarios
  FROM `satisfacao-funcionarios.analisefuncionarios.analise_dados_funcionarios`
), 

  dados_funcionarios AS (
    SELECT Gender,Age_segment, MaritalStatus, Education_degree, EducationField, JobRole, YearsInCurrentRole_segment, YearsSinceLastPromotion_segment,  PerformanceRating_segment, WorkLifeBalance_segment, RelationshipSatisfaction_segment, DistanceFromHome_segment, JobSatisfaction_segment,
       count(1) AS Quantidade 
    FROM `satisfacao-funcionarios.analisefuncionarios.analise_dados_funcionarios` 
    GROUP BY Gender,Age_segment, MaritalStatus, Education_degree, EducationField, JobRole, YearsInCurrentRole_segment, YearsSinceLastPromotion_segment,  PerformanceRating_segment, WorkLifeBalance_segment, RelationshipSatisfaction_segment, DistanceFromHome_segment, JobSatisfaction_segment
)

select *, Quantidade/quantidade_funcionarios.Quantidade_Total_Funcionarios AS Percentual
from dados_funcionarios 
  INNER JOIN quantidade_funcionarios 
  ON 1 = 1

