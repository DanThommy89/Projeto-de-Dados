select * from [dbo].[TB_ACT_OLIST_SELLERS]
select * from  [dbo].[TB_ACT_OLIST_CATEGORY]
select * from  [dbo].[TB_ACT_OLIST_PRODUCTS]
SELECT * FROM [dbo].[TB_ACT_OLIST_CUSTOMERS]
select * from [dbo].[TB_ACT_OLIST_PAYMENTS]
select * from .[TB_ACT_OLIST_ORDER]
SELECT * FROM [dbo].[TB_ACT_OLIST_REVIEWS]


/*Cidade do cliente com o maior valor pago */


SELECT C.[CUSTOMER_CITY], MAX(P.[PAYMENT_VALUE]) AS VALOR FROM [dbo].[TB_ACT_OLIST_ORDER] O INNER JOIN [dbo].[TB_ACT_OLIST_CUSTOMERS] C
ON C.[CUSTOMER_ID] = O.[CUSTOMER_ID] 
INNER JOIN [dbo].[TB_ACT_OLIST_PAYMENTS] P
ON P.[ORDER_ID]=O.[ORDER_ID]
GROUP BY C.[CUSTOMER_CITY] ORDER BY VALOR DESC

/*Total de pedidos geral */
CREATE VIEW TOTAL_PEDIDOS
AS
SELECT COUNT([ORDER_ID]) FROM [dbo].[TB_ACT_OLIST_ORDER]


/*Todos os pedidos aprovados em 2018 e o total por data */
SELECT [ORDER_APPROVED_AT] AS " Data e Hor�rio Pedidos Aprovados em 2018", COUNT([ORDER_APPROVED_AT]) AS Total FROM  [dbo].[TB_ACT_OLIST_ORDER]
WHERE  [ORDER_APPROVED_AT] BETWEEN'2018-01-01' and '2018-12-31' GROUP BY [ORDER_APPROVED_AT]  ORDER BY COUNT([ORDER_APPROVED_AT]) desc

/*Pedidos n�o entregues */
SELECT COUNT([ORDER_STATUS]) AS Pedido,[ORDER_STATUS] as Status FROM  [dbo].[TB_ACT_OLIST_ORDER]
WHERE ORDER_STATUS not in (SELECT [ORDER_STATUS] FROM [dbo].[TB_ACT_OLIST_ORDER] WHERE [ORDER_STATUS] = 'DELIVERED') group by [ORDER_STATUS]
 
/*Nome de produtos com peso acima de 500 em ordem decrescente*/
CREATE VIEW VW__PRODUTOS_PESO_500
AS

SELECT [PRODUCT_CATEGORY_NAME],[PRODUCT_WEIGHT_Q]  FROM [dbo].[TB_ACT_OLIST_PRODUCTS] where [PRODUCT_WEIGHT_Q] > 500  ORDER BY [PRODUCT_WEIGHT_Q] desc

/*Clientes que efetuaram uma compra e sua cidade*/

CREATE VIEW VW__PEDIDOS_POR_CLIENTE
AS
SELECT C.[CUSTOMER_ID], C.CUSTOMER_CITY,  O.* FROM[dbo].[TB_ACT_OLIST_CUSTOMERS] AS C INNER JOIN [dbo].[TB_ACT_OLIST_ORDER] AS O
ON C.[CUSTOMER_ID] = O.[CUSTOMER_ID] where ORDER_STATUS='delivered'


/*Quantidade total de clientes que fizeram um pedido*/
SELECT count(distinct[CUSTOMER_ID]) FROM [dbo].[TB_ACT_OLIST_ORDER] 

/*As dez cidades com mais pedidos entregues*/
CREATE VIEW VW__TOP10_CIDADES_COM_MAIS_PEDIDOS_ENTREGUES
AS
SELECT  TOP 10 C.[CUSTOMER_CITY] AS "CIDADE", COUNT(O.[CUSTOMER_ID])AS "PEDIDOS" FROM [dbo].[TB_ACT_OLIST_CUSTOMERS] AS C INNER JOIN [dbo].[TB_ACT_OLIST_ORDER] AS O
ON C.[CUSTOMER_ID] = O.[CUSTOMER_ID] where ORDER_STATUS ='delivered' GROUP BY C.[CUSTOMER_CITY] ORDER BY COUNT(O.[CUSTOMER_ID]) DESC


/*Categoria do produto mais pesado*/
SELECT top 1 [PRODUCT_CATEGORY_NAME],[PRODUCT_WEIGHT_Q]  FROM [dbo].[TB_ACT_OLIST_PRODUCTS] order by [PRODUCT_WEIGHT_Q] desc

