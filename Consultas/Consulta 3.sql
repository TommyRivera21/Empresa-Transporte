select 
env_fecha        as Fecha,
env_puntuacion   as Puntuacion,
env_descripcion  as Descripcion
from envio
inner join transportista on envio.trans_id = transportista.trans_id
where transportista.trans_nombres = 'Jud'
and (env_fecha) BETWEEN '2020-01-01' AND '2021-05-31'
and (env_puntuacion)<='2' -- Las puntuaciones iguales o menores a dos se clasifican como inconvenientes 