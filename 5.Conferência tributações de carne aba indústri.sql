5.Conferência tributações de carne aba indústria


/* A parte do script (c.PERTRIBUTADO IN (58.33, 58.34, 38.89)) é para identificar todas as tributações que estão com a redução para cesta básica,
isso é para uma análise completa considerando todas as tributações, apenas para conferir se todas as tributações relacionadas a carne estão parametrizadas 
com a TIPOCALCICMSFISCI (utilizar o código 21 - "21 - ICMS Calculado - GIA do MS") / para filtro apenas das tributações com código 21 c.TIPOCALCICMSFISCI = 21 */

SELECT 
    MAX(a.NROTRIBUTACAO) AS NROTRIBUTACAO, -- ou MIN(a.nrotributacao)
    c.UFCLIENTEFORNEC,
    SUBSTRING_INDEX(SUBSTRING_INDEX(TRIBUTACAO, 'NCM ', -1), ' CEST', 1) AS NCM_Code,
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
    c.TIPOCALCICMSFISCI
FROM
    db_trib_rev.tb_capas_fonseca_sp a
INNER JOIN db_trib_rev.tb_convenio_atual b ON SUBSTRING_INDEX(SUBSTRING_INDEX(TRIBUTACAO, ' CEST ', -1), ' ', 1) = b.CODCEST
INNER JOIN db_trib_rev.tb_grade_fonseca_sp c ON a.nrotributacao = c.nrotributacao
WHERE c.tiptributacao = 'EI' -- Entrada Indústria
AND c.PERTRIBUTADO IN (58.33, 58.34, 38.89)
GROUP BY 
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
    c.TIPOCALCICMSFISCI
ORDER BY 8, 1;
