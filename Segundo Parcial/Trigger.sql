/* Script 1
  Trigger que impida que un transportista con 40% o más de inconvenientes 
  realice el transporte de un envio de un buen cliente. 
*/
create or replace function enviobuencliente() returns trigger
as $enviobuencliente$
    declare
		numinconvenientes int;
		numenvios int;
		cliente boolean;
begin
		select count(trans_id) into numenvios from envio where trans_id = new.trans_id;
		select count(trans_id) into numinconvenientes from envio where (env_puntuacion = 'Mal envio' or env_puntuacion = 'No enviado' )
		and trans_id = new.trans_id;
		select cli_puntuacion into cliente from cliente where cli_id = new.cli_id;		
        if( numinconvenientes > (numenvios*0.40) and cliente) then            
			raise exception 'El transportista cuenta con mas del 40 porciento de inconvenientes, y no puede 
			realizar el envio de un buen cliente';
        end if;
        return new;
end;
$enviobuencliente$
language plpgsql;

create trigger enviobuenclienteTrigger before insert
on envio for each row
execute procedure enviobuencliente();