# Conferência Calc Carne

## Módulo Fiscal

**ICMS Calculado – Impacto no Módulo Fiscal (Thiago)**

Utilizado para quando a Nota Fiscal de entrada/saída tem alíquota diferente da alíquota aplicada (efetiva) para o cálculo do crédito/débito de ICMS e para que a escrituração no livro fiscal seja de acordo com as regras legais quanto a permissão deste crédito/débito, como por exemplo nas aquisições de carnes por empresas optantes pelo Regime Especial de Carnes - SP (Decreto 62.647/2017) ou por aquisições interestaduais de produtos/mercadorias que contemplam os itens da cesta básica com redução na base de cálculo, conforme RICMS de cada UF. Além das tratativas na Tributação por UF, para que a Nota Fiscal integre no livro fiscal com a alíquota efetiva (redução na Base de Cálculo – Cesta Básica) ou sem o crédito de ICMS (aquisições de carnes no Estado de SP), o parâmetro ICMS Calculado deverá estar marcado.

### 1.Parâmetros

> Caminho: *Módulo Fiscal - Configuração - Parâmetros - Empresa - aba Registro Fiscal.*

> ***Exemplo 1 (Carnes) – Aquisição de carnes por empresa optante pelo Regime Especial de Carnes (SP) – Utilização Tipo Calc. 21***

Conforme Decreto 62.647/2017 é vedado o aproveitamento de quaisquer outros créditos do imposto para estas aquisições, portanto, nas aquisições de carnes, o valor do ICMS destacado nas Notas Fiscais de aquisição deverão ser lançadas como “Outras” no Livro Registro de Entradas, CST X90. Para melhor visualização, verifique o anexo compartilhado pelo Thiago (ICMS_Calculado_Fiscal).

> ![image](https://github.com/Wellingtondan/Doc_calc_carne/assets/119419112/9d03918a-2e8b-4879-9554-0b5a87d9076b)

`Exemplo (Nota fiscal)`

|***Produto***  |***Cortes Resfriados Frango*** | 
| ----------| --------------| 
| Valor do produto | R$ 99,45 | 
| Base de Cálculo ICMS (Valor do produto x Redução (58,33%) ) | R$ 58,01 |
| Valor ICMS (Base de Cálculo ICMS x alíquota efetiva (12%)) | R$ 6,96 | 
| Alíquota ICMS | 12% | 
| CST (Situação tributária NF) | 020 | 

> ![image](https://github.com/Wellingtondan/Doc_calc_carne/assets/119419112/035cd86f-43da-4822-a58b-b30ef919921f)

### 2.Consulta de Notas Fiscais

Aqui nesse caminho é apenas para identificar como são lançados os dados parametrizados para o ICMS Calc. Quando cliente opta para Emissão Livros “ICMS Calculado”, os dados sobem corretamente com os cálculos devidos.

Mas segue as observações que precisam estar configuradas quando for utilizadas para os produtos Carne:

> ![image](https://github.com/Wellingtondan/Doc_calc_carne/assets/119419112/0dffa0e7-7af2-4190-a02c-28ced25f4175)

### 3.Registro de Entradas (Livro)

É verificado o valor da operação (Total da entrada) e também o “COD” que para esse caso é o 3 (Operações sem crédito de Imposto-Outras).

> ![image](https://github.com/Wellingtondan/Doc_calc_carne/assets/119419112/1418bd1c-a9c7-4072-a31b-f407091c2ddb)


## Grade de tributação por UF

### 1.TRIBUTAÇÃO POR UF

Conforme exemplo no Módulo Fiscal  a CST destacada em nota, estava considerando a “020” que representa a aba “Situação Tributária NF”. Como nesse caso não há aproveitamento de quaisquer outros créditos, o lançamento deve ser considerado como “Outras” no Livro Registro de Entradas com a CST x90 para a “Situação tributária NF de ICMS Calculado”, como na imagem abaixo:

> ![image](https://github.com/Wellingtondan/Doc_calc_carne/assets/119419112/5722ac5a-3099-4feb-86a6-f78af2dc8622)

> Tipo Calc.ICMS *(Observação: 21 - ICMS Calculado - GIA do MS)*

Tipo de cálculo Fiscal implementado para calcular ICMS Calculado com Redução da base de Calculo, ao parametrizar o tipo 21, a tributação por UF exigirá as informações de %Base/%Isento/%Outras, o valor de ICMS Calculado será considerado no custo da mercadoria, no módulo Fiscal o valor calculado será considerado nas apurações.

**Observação** – Este TIPOCALCICMSFISCI é utilizado por diversos clientes em diversas operações, solicitar a modificação do nome para 21 ICMS Calculado – Com Redução.

> ![image](https://github.com/Wellingtondan/Doc_calc_carne/assets/119419112/ee269552-eb5f-48bf-ba39-965967d8ea2c)

Conforme a exigência na grade de tributação para os campos citados no **Tipo Calc.ICMS**, segue ilustração abaixo da parametrização nos campos (%Tributado Calc./ %Isento Calc./ %Outros Calc./ Alíquota ICMS Calc.)

> ![image](https://github.com/Wellingtondan/Doc_calc_carne/assets/119419112/9d01ead3-7c59-4b9e-a923-c119f3c4a338)

`Exemplo do cálculo sistema:`

|***Descrição***  |***Valor*** | 
| ----------| --------------| 
| Valor do Produto:  | R$100,00 | 
| %Redução BASE Calculado: | 61,11% |
| %BASE | 38,89% | 
| %Isento | 61,11%  | 
| Alíquota Calculado |18% | 

**Cálculo:**

|***Descrição***  |***Valor*** | 
| ----------| --------------| 
| Base do Calculado: R$100,00x38,89% | R$38,89 | 
| Valor ICMS Calculado: R$38,89x18% | R$7,00 |


## Scripts

- O Calc para tributações de carne, é aplicado zero para não tomar crédito na saída.

- A parte do script (c.PERTRIBUTADO IN (58.33, 58.34, 38.89)) é para identificar todas as tributações que estão com a redução para cesta básica, isso é para uma análise completa considerando todas as tributações, apenas para conferir se todas as tributações relacionadas a carne estão parametrizadas com a ***TIPOCALCICMSFISCI*** (utilizar o código 21 - "21 - ICMS Calculado - GIA do MS") / para filtro apenas das tributações com código 21 .TIPOCALCICMSFISCI = 21

> [Conferência Trib.Carnes](https://github.com/Wellingtondan/Doc_calc_carne/blob/main/5.Confer%C3%AAncia%20tributa%C3%A7%C3%B5es%20de%20carne%20aba%20ind%C3%BAstri.sql)
