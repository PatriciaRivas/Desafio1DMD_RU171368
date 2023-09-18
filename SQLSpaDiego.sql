
SELECT 
	Sucursal,ID,
	SEXO,
	Edad,
	NTILE(5) over(order by promVisit) ClasificacionVisitas,
	NTILE(5) over(order by CantServicios) ClasificacionServicios,
	NTILE(5) over(order by ingresos) ClasificacionIngresos
FROM (
	SELECT 
		Sucursal, 
		COUNT(CASE WHEN VALOR=1 THEN 1 ELSE NULL END) OVER(PARTITION BY ID) CantServicios,
		CASE 
		WHEN Sexo=1 THEN 'F' ELSE 'M' 
		END Sexo, id, PromVisit, Edad, ingresos--,*
	FROM spaDiego AS U
	UNPIVOT (Valor for Servicio in (Sauna,Masaje,Hidro,Yoga)) AS UPV
) AS A
GROUP BY SUCURSAL,ID, Sexo, Edad, CantServicios, PromVisit, ingresos 
ORDER BY Sucursal, sexo, ClasificacionVisitas DESC, ClasificacionServicios DESC , ClasificacionIngresos DESC



SELECT 
	Sucursal,
	CASE 
	WHEN Sexo=1 THEN 'F' ELSE 'M' 
	END Sexo,
	concat((COUNT(Sexo)*100) / sum(COUNT(Sexo)) over(partition by sucursal), '%')  PorcentajeClientes,
	avg(ingresos) PromCompras,
	AVG(PromVisit) PromVisitas,
	CONCAT(MIN(Edad),'-',MAX(EDAD)) RangoEdades
FROM SpaDiego AS U
GROUP BY Sucursal, Sexo, CASE WHEN Edad BETWEEN 20 AND 45 THEN '20-45' ELSE '46-70' END
ORDER BY Sucursal, Sexo, PorcentajeClientes, PromVisitas DESC