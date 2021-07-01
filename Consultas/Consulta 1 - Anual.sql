select 
env_id,
env_fecha       as Fecha,
trans_nombres   as Nombre,
trans_apellidos as Apellido
from envio
inner join transportista on envio.trans_id = transportista.trans_id 
where transportista.trans_nombres = 'Jud'
and (env_fecha) BETWEEN '2020-01-01' AND '2021-05-31'
