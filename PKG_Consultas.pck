CREATE OR REPLACE PACKAGE codegroup.PKG_Consultas
IS

    TYPE T_Cursor IS REF CURSOR;

    PROCEDURE prc_Consulta_1(ret_CURSOR OUT T_Cursor);

    PROCEDURE prc_Consulta_2(ret_CURSOR OUT T_Cursor);

    PROCEDURE prc_Consulta_3(ret_CURSOR OUT T_Cursor);

    PROCEDURE prc_Consulta_4(par_brand_name IN	brands.brand_name%TYPE
	                        ,ret_CURSOR     OUT T_Cursor);
    
    PROCEDURE prc_Consulta_5(ret_CURSOR OUT T_Cursor);

END;
/
CREATE OR REPLACE PACKAGE BODY codegroup.PKG_Consultas IS

    PROCEDURE prc_Consulta_1(ret_CURSOR OUT T_Cursor)
    IS
    BEGIN
        -- Listar todos Clientes que não tenham realizado uma compra
        OPEN ret_CURSOR FOR
			SELECT A.customer_id
				  ,A.first_name || ' ' || A.last_name AS customer_name
				  ,A.phone
			FROM   customers A
			WHERE  NOT EXISTS(SELECT 1
							  FROM       orders      B 
							  INNER JOIN order_items C ON C.order_id = B.order_id
							  WHERE      B.customer_id = A.customer_id); 
    END prc_Consulta_1;


    PROCEDURE prc_Consulta_2(ret_CURSOR OUT T_Cursor)
    IS
    BEGIN
		-- Listar os Produtos que não tenham sido comprados
        OPEN ret_CURSOR FOR
			SELECT     A.product_id
					  ,A.product_name
					  ,b.category_name
					  ,c.brand_name
			FROM       products   A
			INNER JOIN categories B ON B.category_id = A.category_id
			INNER JOIN brands     C ON C.brand_id    = A.brand_id
			WHERE      NOT EXISTS(SELECT 1
								  FROM   order_items D 
								  WHERE  D.product_id = A.product_id);
    END prc_Consulta_2;


    PROCEDURE prc_Consulta_3(ret_CURSOR OUT T_Cursor)
    IS
    BEGIN
		-- Listar os Produtos sem Estoque
        OPEN ret_CURSOR FOR
			SELECT     A.product_id
					  ,A.product_name
					  ,B.category_name
					  ,C.brand_name
			FROM       products   A
			INNER JOIN categories B ON B.category_id = A.category_id
			INNER JOIN brands     C ON C.brand_id    = A.brand_id
			WHERE      NOT EXISTS(SELECT 1
								  FROM   stocks D 
								  WHERE  D.product_id = A.product_id
								  AND    NVL(D.quantity,0) > 0);	
    END prc_Consulta_3;


    PROCEDURE prc_Consulta_4(par_brand_name IN	brands.brand_name%TYPE
	                        ,ret_CURSOR     OUT T_Cursor)
    IS
    BEGIN
		-- Agrupar a quantidade de vendas de uma determinada Marca por Loja
        OPEN ret_CURSOR FOR
			SELECT     E.brand_name
					   D.store_name
					  ,SUM(A.quantity) AS quantity
			FROM       order_items A
			INNER JOIN orders      B ON B.order_id   = A.order_id
			INNER JOIN products    C ON C.product_id = A.product_id
			INNER JOIN stores      D ON D.store_id   = B.store_id
			INNER JOIN brands      E ON E.brand_id   = C.brand_id
			WHERE      UPPER(E.brand_name) = UPPER(par_brand_name)
			GROUP BY   E.brand_name
					  ,D.store_name;
    END prc_Consulta_4;


    PROCEDURE prc_Consulta_5(ret_CURSOR OUT T_Cursor)
    IS
    BEGIN
  	    -- Listar os Funcionários que não estejam relacionados a um pedido
        OPEN ret_CURSOR FOR
			SELECT A.staff_id
				  ,A.first_name || ' ' || A.last_name as customer_name
				  ,A.phone
			FROM   staffs A
			WHERE  NOT EXISTS(SELECT 1
							  FROM   orders B 
							  WHERE  B.staff_id = A.staff_id);
    END prc_Consulta_5;

END;
/
