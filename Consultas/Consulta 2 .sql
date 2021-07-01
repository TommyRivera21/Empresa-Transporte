select 
env_id,
env_fecha    as Fecha,
veh_modelo   as Marca
from envio
inner join vehiculo on envio.vehiculo_id = vehiculo.vehiculo_id
where vehiculo.veh_tipo = 'Lumina'
and (env_fecha) BETWEEN '2020-01-01' AND '2021-05-31'

