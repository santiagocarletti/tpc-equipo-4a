USE COCINA_DB

SELECT * FROM RolUsuarios
SELECT * FROM Sectores
SELECT * FROM Productos
SELECT * FROM Combos
SELECT * FROM ComboDetalles
SELECT * FROM EstadoComandas
SELECT * FROM Usuarios
SELECT * FROM Comandas
SELECT * FROM ComandaItems
SELECT * FROM ComandaItemModificadores

--Nota: Evaluar si se cambia la relación Usuario / RolUsuarios para que 
--un Usuario pueda tener varios Roles
INSERT INTO RolUsuarios (Nombre)
VALUES 
('Encargado'),
('Cajero'),
('Cocinero'),
('Despachante');
GO

INSERT INTO Sectores (Nombre)
VALUES 
('Caja'),
('Plancha'),
('Freidora'),
('Armado'),
('Despacho');
GO

INSERT INTO Productos (Nombre, MinutosPreparacion, Activo, IdSector)
VALUES 
('Carne', 5, 1, 2), 
('Papas', 3, 1, 3), 
('Coca-Cola original', 1, 1, 5), 
('Mayonesa', 1, 1, 4), 
('Queso', 1, 1, 2), 
('Bebida', 1, 1, 5); 
GO

--Combos: Aumentar caracteres para Descripción
ALTER TABLE Combos
ALTER COLUMN Descripcion VARCHAR(50) NULL;
GO

INSERT INTO Combos (Nombre, Descripcion, Activo)
VALUES 
('Clásico', 'Hamburguesa clásica + Papas + Bebida', 1), 
('Mediano', 'Doble carne + Papas + Bebida', 1);  
GO

INSERT INTO ComboDetalles (IdCombo, IdProducto, Cantidad)
VALUES 
(4, 1, 1), 
(4, 2, 1), 
(4, 6, 1), 
(5, 1, 2), 
(5, 2, 1), 
(5, 6, 1); 
GO

INSERT INTO EstadoComandas (Nombre, Descripcion)
VALUES 
('En preparación', 'Orden en preparación'), 
('Lista', 'Orden preparada'); 
GO

INSERT INTO Usuarios (NombreUsuario, Contraseña, IdRol, Activo) 
VALUES 
('Juan', 'juan123', 1, 1), 
('Carlos', 'carlos123', 2, 1), 
('Ricardo', 'ricardo123', 3, 1), 
('Sonia', 'sonia123', 3, 1), 
('Patricio', 'patricio123', 4, 1); 
GO
----------------------------------------------------------------
--31/10/'25: Llenado de Usuarios y RolUsuarios después del cambio
INSERT INTO Usuarios (NombreUsuario, Contraseña, Activo) 
VALUES 
('Juan', 'juan123', 1), 
('Carlos', 'carlos123', 1), 
('Ricardo', 'ricardo123', 1), 
('Sonia', 'sonia123', 1), 
('Patricio', 'patricio123', 1); 
GO

INSERT INTO RolUsuarios (Nombre, IdUsuario)
VALUES 
('Encargado', 6),
('Cajero', 7),
('Despachante', 8),
('Cocinero', 9),
('Cocinero', 9);
GO
