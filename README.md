
Nome da Branch: CodeGroup-Teste-Avalia

Esté repositório contém um arquivo do tipo package para compilar em um banco de dados oracle (plsql)

o nome do arquivo é: PKG_Consultas
o objeto simula estar em um schema no banco de dados chamado: codegroup

Portanto, será compilado como: codegroup.PKG_Consultas

--------------------------------------------------------------------------------

O conteúdo da package PKG_Consultas é composto por 5 procedures para execução de 5 consultas propostas no caso de teste proposto para avaliação. 
Anexo no arquivo < Caso-Teste.docx >.

--------------------------------------------------------------------------------

Como executar os testes?

Cada consulta retorna um cursor contendo os dados.

No PLSQL Developer, após compilar a package, utilizar o modo teste da ferramenta para executar as seguintes consultas:

1) Listar todos Clientes que não tenham realizado uma compra
   PKG_Consultas.prc_Consulta_1
   PROCEDURE prc_Consulta_1(ret_CURSOR OUT T_Cursor)
	
2) Listar os Produtos que não tenham sido comprados
   PKG_Consultas.prc_Consulta_2 
   PROCEDURE prc_Consulta_2(ret_CURSOR OUT T_Cursor)
		
3) Listar os Produtos sem Estoque
   PKG_Consultas.prc_Consulta_3
   PROCEDURE prc_Consulta_3(ret_CURSOR OUT T_Cursor)
   
4) Agrupar a quantidade de vendas de uma determinada Marca por Loja: Informar o nome da loja no parâmetro < par_brand_name > 
   PKG_Consultas.prc_Consulta_4  
   PROCEDURE prc_Consulta_4(par_brand_name IN	brands.brand_name%TYPE
	                       ,ret_CURSOR     OUT T_Cursor)

5) Listar os Funcionários que não estejam relacionados a um pedido
   PKG_Consultas.prc_Consulta_5
   PROCEDURE prc_Consulta_5(ret_CURSOR OUT T_Cursor)
   
 -------------------------------------------------------------------------------------
 
 Observações:
 
 A ferramenta utilizada para escrever a package foi o notepad++, portanto não foi compilado ou testado em banco de dados.
 
 Obrigado pela oportunidade
 
 Adriano Ribeiro
 11 - 952954890
 
 --------------------------------------------------------------------------------------
 
 