# Projeto 3: Segmentação de clientes de um e-commerce

Realizar uma segmentação de clientes aplicando a metodologia RFM para um comércio eletrônico.

## Finalidade da Aprendizagem
- Pré-processar dados em planilhas
- Manipular dados em planilhas
- Organize os dados em planilhas
- Visualize dados em planilhas
- Realize uma análise por coorte
- Segmentar clientes usando o modelo RFM

# Descrição do problema

Neste trabalho será necessário realizar uma análise descritiva que mostrará à CEO de uma empresa de varejo o quão bem ou mal as vendas estão indo na empresa, medirá o engajamento do cliente com base em uma análise de coorte e realizará uma segmentação de clientes aplicando a [metodologia RFM](https://www.putler.com/rfm-analysis/), para que o negócio possa focar seus esforços e adotar estratégias diferenciadas para cada segmento. Além disso, você aprenderá a importância da limpeza e do tratamento dos dados antes de realizar qualquer análise.

# Contexto e Objetivos

Após analisar o contexto do problema descrito no [Kaggle](https://www.kaggle.com/datasets/datacertlaboratoria/projeto-3-segmentao-de-clientes-no-ecommerce) com apoio do [Guia Detalhado](https://www.kaggle.com/code/datacertlaboratoria/guia-de-resolu-o-projeto-3) é possível responder as seguintes perguntas:

1. Quanto vocês vendem em média por mês? 
2. Quantas vendas vocês têm em cada mês? 
3. Qual é o mês em que vocês mais vendem? 
4. Quais são seus clientes mais importantes? 
5. Qual é o valor médio que seus clientes gastam? 
6. Qual porcentagem de seus clientes voltou a comprar? 
7. Como esta informação é desagregada de acordo com os países onde vocês vendem?

# [Resolução utilizando Python](https://github.com/carlamendescms/certificacao-analista-dados-ibm-laboratoria/blob/29a14c4269e9529a8b86cc0c0060945e50524315/projetos/03%20-%20Segmenta%C3%A7%C3%A3o%20de%20clientes%20no%20ecommerce/segmentacao-clientes-ecommerce.ipynb)

## Este projeto está divido em 4 partes:

### Pré processamento dos dados

- Revisar a qualidade do banco de dados, remover dados duplicados que não façam sentido, encontrar dados ausentes e substituí-los/removê-los e procurar dados não correspondentes (por exemplo, números negativos em colunas que normalmente são números positivos). 

- O pré-processamento dos dados é uma etapa fundamental e básica em todas as análises de dados.

O item 2 neste notebook abrangerá essa parte.

### Análise Exploratória

- Utilizar uma ferramenta de visualização, no caso o Google Data Studio, e fazer gráficos, resumir e estruturar as informações mais relevantes.

- A ideia é poder mostrar visualmente as principais características do conjunto de dados, com foco em métricas de vendas como as listadas por seu chefe no briefing.

O item 3 irá auxiliar na criação dos gráficos.

### Análise de Coorte

- Aplicar uma análise de coorte para clientes britânicos e estrangeiros para ver qual dos dois públicos tem os clientes mais leais.

O notebook Jupyter 02 - Análise de coorte de clientes contem a análise de coorte gerada.

### Segmentação de clientes

- Segmentar seus clientes com base em três características: Recência, Frequência e Valor Monetário.

O notebook Jupyter 03 - Segmentação de clientes usando RFM irá apresentar a segmentação dos clientes e terá como resultado a categorização deles.

Você pode encontrar a resolução deste projeto nesse [notebook Jupyter](https://github.com/carlamendescms/certificacao-analista-dados-ibm-laboratoria/blob/29a14c4269e9529a8b86cc0c0060945e50524315/projetos/03%20-%20Segmenta%C3%A7%C3%A3o%20de%20clientes%20no%20ecommerce/segmentacao-clientes-ecommerce.ipynb)


