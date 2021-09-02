/* Script 3
   Procedimiento almacenado que permita ingresar en un parámetro de entrada la placa 
   del vehículo y que muestre la empresa y la cantidad de envíos que se han realizado a dichas empresas.
*/
CREATE or replace  FUNCTION procedimientoPlaca(varchar)	RETURNS varchar
AS $BODY$
DECLARE
	placa alias for $1;
	datos RECORD;
	cur_datos cursor FOR 	
								select cli_nombre_empresa  as empresa,
 								count (veh_placa  )
         					   				 as cantidad
								from envio
									inner join vehiculo on envio.vehiculo_id = vehiculo.vehiculo_id
									inner join cliente on envio.cli_id = cliente.cli_id
									where vehiculo.veh_placa =  $1
									group by empresa order by cantidad desc;
begin
	for datos in cur_datos loop
	Raise notice 'Empresa : % => Numero de envios: %', datos.empresa, datos.cantidad;
	end loop;
end; $BODY$
language 'plpgsql';

--Select de consulta

select procedimientoPlaca('32')

select procedimientoPlaca('411')

select procedimientoPlaca('928')