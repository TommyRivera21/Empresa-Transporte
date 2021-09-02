/* Script 2
  Cursor que se muestre la empresa a la que se le ha hecho un envio la cantidad que se le ha cobrado la cantidad 
  que se obtiene como ganancia y la cantidad que se obtiene como perdida.
*/
do $$
declare
        tabla record;
        listado cursor for 									
					select  cliente.cli_nombre_empresa,sum( envio.env_valor_pago) as total, sum (costos.cenv_precios) as ganancia
							from envio
							inner join cliente on envio.cli_id = cliente.cli_id
							inner join costos on envio.cenv_id = costos.cenv_id
							group by  cliente.cli_nombre_empresa
							order by ganancia desc;							
							
begin
for tabla in listado loop
Raise notice 'Nombre de la empresa: %, Pago Total:  %, Ganancia: % , Perdida: 0 $', tabla.cli_nombre_empresa, 
tabla.total, tabla.ganancia;
end loop;
end $$
language 'plpgsql';
