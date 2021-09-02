/* Script 2
  Reporte de diagrama de barras mostrar cuantos transportes ha realizado un transportista
*/
select 
trans_nombres as nombre,
count (env_puntuacion )
as TotalEnvios
from envio
inner join transportista on envio.trans_id = transportista.trans_id
and (env_fecha) BETWEEN '2020-01-01' AND '2021-06-30'
group by nombre

