/* A parte do script (c.PERTRIBUTADO IN (58.33, 58.34, 38.89)) é para identificar todas as tributações que estão com a redução para cesta básica,
isso é para uma análise completa considerando todas as tributações, apenas para conferir se todas as tributações relacionadas a carne estão parametrizadas 
com a TIPOCALCICMSFISCI (utilizar o código 21 - "21 - ICMS Calculado - GIA do MS") / para filtro apenas das tributações com código 21 c.TIPOCALCICMSFISCI = 21 */

SELECT 
    MAX(a.NROTRIBUTACAO) AS NROTRIBUTACAO, -- ou MIN(a.nrotributacao)
    c.UFCLIENTEFORNEC,
    SUBSTRING_INDEX(SUBSTRING_INDEX(TRIBUTACAO, 'NCM ', -1), ' CEST', 1) AS NCM,
    SUBSTRING_INDEX(SUBSTRING_INDEX(TRIBUTACAO, ' CEST ', -1), ' ', 1) AS CEST,
    a.TRIBUTACAO, 
    a.DESCAPLICACAO,
    b.DESCRICAO,
    b.COD_SEGMENTO,
    b.SEGMENTO,  
    c.PERTRIBUTADO, 
    c.PERISENTO, 
    c.PEROUTRO,
    c.PERALIQUOTA,
    c.PERACRESCST,
    c.PERALIQUOTAST,
    c.PERTRIBUTST,
    c.PERTRIBUTADOCALC, 
    c.PERISENTOCALC, 
    c.PEROUTROCALC, 
    c.PERALIQICMSCALCPRECO, 
    c.TIPOCALCICMSFISCI,
    c.SITUACAONF,
    c.SITUACAONFCALC,
    c.PERICMSRESOLUCAO13,	
    c.PERTRIBUTADORESOL13,
    c.PERISENTORESOL13,
    c.PEROUTRORESOL13,
    c.PERACRESCSTRESOLUCAO13,
    c.PERALIQICMSCALCRESOL13   
FROM
    db_trib_rev.tb_capas_fonseca_sp a
INNER JOIN db_trib_rev.tb_convenio_atual b ON SUBSTRING_INDEX(SUBSTRING_INDEX(TRIBUTACAO, ' CEST ', -1), ' ', 1) = b.CODCEST
INNER JOIN db_trib_rev.tb_grade_fonseca_sp c ON a.nrotributacao = c.nrotributacao
WHERE c.tiptributacao = 'EI' -- Entrada Indústria
AND c.PERTRIBUTADO IN (58.33, 58.34, 38.89) 
/*Não adicionado filtro para o ccampo PERALIQICMSCALCPRECO = a 0, dessa forma os analistas podem analisar se não existem também tributações ausentes com o Calc 0*/
GROUP BY 
    a.NROTRIBUTACAO,
    c.UFCLIENTEFORNEC,
    a.TRIBUTACAO, 
    a.DESCAPLICACAO,
    b.DESCRICAO,
    b.COD_SEGMENTO,
    b.SEGMENTO,  
    c.PERTRIBUTADO, 
    c.PERISENTO, 
    c.PEROUTRO,
    c.PERALIQUOTA,
    c.PERACRESCST,
    c.PERALIQUOTAST,
    c.PERTRIBUTST,
    c.PERTRIBUTADOCALC, 
    c.PERISENTOCALC, 
    c.PEROUTROCALC, 
    c.PERALIQICMSCALCPRECO, 
    c.TIPOCALCICMSFISCI,
    c.SITUACAONF,
    c.SITUACAONFCALC,
    c.PERICMSRESOLUCAO13,	
    c.PERTRIBUTADORESOL13,
    c.PERISENTORESOL13,
    c.PEROUTRORESOL13,
    c.PERACRESCSTRESOLUCAO13,
    c.PERALIQICMSCALCRESOL13    -- Calc
ORDER BY 1, 2;
