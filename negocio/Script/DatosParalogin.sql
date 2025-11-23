USE master
GO
USE COCINA_DB
GO
ALTER TABLE RolUsuarios ADD PaginaInicio VARCHAR(100);
GO
UPDATE RolUsuarios SET PaginaInicio = 'Encargado.aspx' WHERE Nombre = 'Encargado';
UPDATE RolUsuarios SET PaginaInicio = 'Cajero.aspx' WHERE Nombre = 'Cajero';
UPDATE RolUsuarios SET PaginaInicio = 'Cocina.aspx' WHERE Nombre = 'Cocinero';
UPDATE RolUsuarios SET PaginaInicio = 'Despacho.aspx' WHERE Nombre = 'Despachante';
GO

select * from RolUsuarios