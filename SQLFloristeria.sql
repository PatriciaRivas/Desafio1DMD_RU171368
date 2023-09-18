
SELECT *
FROM FloristeriaFiorella


SELECT
	Pais,
	Articulo,
	[San Miguel],
	[San Salvador],
	[Santa ana]
FROM (SELECT
	Pais,
	Articulo,
	Articulo art,
	UNPV.Departamento,
	Compras
	FROM FloristeriaFiorella AS A
	UNPIVOT (Compras FOR Articulo IN ([Rosas], [Claveles], [Macetas], [Tierra], [Girasoles], [Hortensia], 
	[Globos], [Tarjetas], [Orquidias], [Carmesi], [Lirios], [Aurora], [Tulipanes], [Liston]))
	AS UNPV
WHERE Compras=1) AS B
PIVOT (count(art) FOR Departamento in ([San Miguel], [San Salvador], [Santa ana])) as pvt 
ORDER BY [San Salvador] DESC, [San Miguel] DESC, [Santa ana]