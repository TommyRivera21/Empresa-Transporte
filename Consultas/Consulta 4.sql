select 
cli_nombre_empresa   as Empresa,
env_fecha            as Fecha,
env_valor_pago       as Pagos,
sum (env_valor_pago) as Total
from envio
inner join cliente on envio.cli_id = cliente.cli_id
where (env_fecha) BETWEEN '2020-01-01' AND '2021-01-01'
group by 
cli_nombre_empresa,
env_fecha,
env_valor_pago    