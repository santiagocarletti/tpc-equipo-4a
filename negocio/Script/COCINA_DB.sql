use master 
go
create database COCINA_DB
go
use COCINA_DB
go

--RolUsuarios
CREATE TABLE [dbo].[RolUsuarios](
    [Id] INT IDENTITY(1,1) NOT NULL,
    [Nombre] VARCHAR(20) NULL,
    CONSTRAINT [PK_RolUsuarios] PRIMARY KEY CLUSTERED ([Id])
);
GO

--Sectores
CREATE TABLE [dbo].[Sectores](
    [Id] INT IDENTITY(1,1) NOT NULL,
    [Nombre] VARCHAR(20) NOT NULL,
    [Descripcion] VARCHAR(20) NULL,
    CONSTRAINT [PK_Sectores] PRIMARY KEY CLUSTERED ([Id])
);
GO

--Productos
CREATE TABLE [dbo].[Productos](
    [Id] INT IDENTITY(1,1) NOT NULL,
    [Nombre] VARCHAR(20) NOT NULL,
    [MinutosPreparacion] INT NOT NULL,
    [Activo] BIT NOT NULL,
    [IdSector] INT NOT NULL,
--(FK --> Sectores)
    CONSTRAINT [PK_Productos] PRIMARY KEY CLUSTERED ([Id]),
    CONSTRAINT [FK_Productos_Sectores] FOREIGN KEY([IdSector]) REFERENCES [dbo].[Sectores]([Id])
);
GO
--Relación: 1 Sector --> muchos Productos (1:n)

--Combos
CREATE TABLE [dbo].[Combos](
    [Id] INT IDENTITY(1,1) NOT NULL,
    [Nombre] VARCHAR(20) NOT NULL,
    [Descripcion] VARCHAR(20) NULL,
    [Activo] BIT NOT NULL,
    CONSTRAINT [PK_Combos] PRIMARY KEY CLUSTERED ([Id])
);
GO
--Relación: 1 Combo --> muchos ComboDetalles (1:n)

--ComboDetalles
CREATE TABLE [dbo].[ComboDetalles](
    [Id] INT IDENTITY(1,1) NOT NULL,
    [IdCombo] INT NOT NULL,
-- (FK --> Combos)
    [IdProducto] INT NOT NULL,
--(FK --> Productos)
    [Cantidad] INT NOT NULL,
    CONSTRAINT [PK_ComboDetalles] PRIMARY KEY CLUSTERED ([Id]),
    CONSTRAINT [FK_ComboDetalles_Combos] FOREIGN KEY([IdCombo]) REFERENCES [dbo].[Combos]([Id]),
    CONSTRAINT [FK_ComboDetalles_Productos] FOREIGN KEY([IdProducto]) REFERENCES [dbo].[Productos]([Id])
);
GO
--Relación: 1 Producto --> puede aparecer en muchos ComboDetalles (n:1), 1 Combo --> muchos productos (1:n)

--EstadoComandas
CREATE TABLE [dbo].[EstadoComandas](
    [Id] INT IDENTITY(1,1) NOT NULL,
    [Nombre] VARCHAR(20) NOT NULL,
    [Descripcion] VARCHAR(20) NULL,
    CONSTRAINT [PK_EstadoComandas] PRIMARY KEY CLUSTERED ([Id])
);
GO

--Usuarios
CREATE TABLE [dbo].[Usuarios](
    [Id] INT IDENTITY(1,1) NOT NULL,
    [NombreUsuario] VARCHAR(20) NOT NULL,
    [Contraseña] VARCHAR(20) NOT NULL,
    [IdRol] INT NOT NULL,
--(FK --> RolUsuarios)
    [Activo] BIT NOT NULL,
    CONSTRAINT [PK_Usuarios] PRIMARY KEY CLUSTERED ([Id]),
    CONSTRAINT [FK_Usuarios_RolUsuarios] FOREIGN KEY([IdRol]) REFERENCES [dbo].[RolUsuarios]([Id])
);
GO
--Relación: 1 RolUsuario --> muchos Usuarios (1:n)

--Comandas
CREATE TABLE [dbo].[Comandas](
    [Id] INT IDENTITY(1,1) NOT NULL,
    [NumeroComanda] VARCHAR(6) NOT NULL,
    [FechaCreacion] DATETIME NOT NULL,
    [IdEstadoComanda] INT NOT NULL,
--(FK --> EstadoComandas)
    [IdUsuarioCajero] INT NOT NULL,
    CONSTRAINT [PK_Comandas] PRIMARY KEY CLUSTERED ([Id]),
    CONSTRAINT [FK_Comandas_EstadoComandas] FOREIGN KEY([IdEstadoComanda]) REFERENCES [dbo].[EstadoComandas]([Id]),
    CONSTRAINT [FK_Comandas_Usuarios] FOREIGN KEY([IdUsuarioCajero]) REFERENCES [dbo].[Usuarios]([Id])
);
GO
--Relación: 1 EstadoComanda --> muchas Comandas (1:n), 1 Comanda --> muchos ComandaItems (1:n)

--ComandaItems
CREATE TABLE [dbo].[ComandaItems](
    [Id] INT IDENTITY(1,1) NOT NULL,
    [IdComanda] INT NOT NULL,
--(FK --> Comandas)
    [IdProducto] INT NULL,
--(FK --> Productos, nulleable)
    [IdCombo] INT NULL,
--(FK --> Combos, nulleable)
    [Cantidad] INT NOT NULL,
    [Comentario] VARCHAR(20) NULL,
    CONSTRAINT [PK_ComandaItems] PRIMARY KEY CLUSTERED ([Id]),
    CONSTRAINT [FK_ComandaItems_Comandas] FOREIGN KEY([IdComanda]) REFERENCES [dbo].[Comandas]([Id]),
    CONSTRAINT [FK_ComandaItems_Productos] FOREIGN KEY([IdProducto]) REFERENCES [dbo].[Productos]([Id]),
    CONSTRAINT [FK_ComandaItems_Combos] FOREIGN KEY([IdCombo]) REFERENCES [dbo].[Combos]([Id])
);
GO
--Relación: 1 Comanda --> muchos ComandaItems (1:n), 1 ComandaItem --> varios ComandaItemModificadores (1:n)

--ComandaItemModificadores
CREATE TABLE [dbo].[ComandaItemModificadores](
    [Id] INT IDENTITY(1,1) NOT NULL,
    [IdComandaItem] INT NOT NULL,
--(FK --> ComandaItems)
    [Descripcion] VARCHAR(50) NULL,
    CONSTRAINT [PK_ComandaItemModificadores] PRIMARY KEY CLUSTERED ([Id]),
    CONSTRAINT [FK_ComandaItemModificadores_ComandaItems] FOREIGN KEY([IdComandaItem]) REFERENCES [dbo].[ComandaItems]([Id])
);
GO
--Relación: 1 ComandaItem --> muchos ComandaItemModificadores (1:n)

----------------------------------------------------------------------
--31/10/2025: Cambio la relación entre Usuarios y RolUsuarios, quitando IdRol de la primera, y agregando IdUsuario a la segunda

DELETE FROM RolUsuarios;
DELETE FROM Usuarios;
GO

ALTER TABLE Usuarios
DROP CONSTRAINT FK_Usuarios_RolUsuarios;

ALTER TABLE Usuarios
DROP COLUMN IdRol;

ALTER TABLE RolUsuarios
ADD IdUsuario INT NOT NULL
    CONSTRAINT FK_RolUsuarios_Usuarios FOREIGN KEY (IdUsuario) REFERENCES Usuarios(Id);

--Datos nuevos en QueryLlenadoDb.sql
----------------------------------------------------------------------
--06/11/2025: Volvemos a la versión previa de la tabla Usuarios
ALTER TABLE Usuarios
ADD IdRol INT NULL;
GO

--Asignar rol por defecto
UPDATE Usuarios
SET IdRol = 9
WHERE IdRol IS NULL;
GO

--NOT NULL
ALTER TABLE Usuarios
ALTER COLUMN IdRol INT NOT NULL;
GO

--FK: Usuarios --> RolUsuarios
ALTER TABLE Usuarios
ADD CONSTRAINT FK_Usuarios_RolUsuarios
FOREIGN KEY (IdRol) REFERENCES RolUsuarios(Id);
GO

---------------------------------------
--BLOQUE PENDIENTE

--Eliminar FK de RolUsuarios
ALTER TABLE RolUsuarios
DROP CONSTRAINT FK_RolUsuarios_Usuarios;
GO

--Eliminación de columna
ALTER TABLE RolUsuarios
DROP COLUMN IdUsuario;
GO
------------------------------------------------------------------------------
--18/11/2025
--TABLA NUEVA: PRODUCTOS INGREDIENTES
CREATE TABLE ProductoIngredientes (
    Id INT IDENTITY(1,1) NOT NULL,
    IdProducto INT NOT NULL,                 -- FK --> Productos
    NombreIngrediente VARCHAR(50) NOT NULL,
    EsOpcional BIT NOT NULL DEFAULT 0,       -- 0 = No puede quitarse o agregarse
    IdSector INT NOT NULL,
    Activo BIT NOT NULL DEFAULT 0,
    MinutosPreparacion INT NOT NULL DEFAULT 0,

    CONSTRAINT PK_ProductoIngredientes PRIMARY KEY CLUSTERED (Id),

    CONSTRAINT FK_ProductoIngredientes_Productos 
        FOREIGN KEY (IdProducto) REFERENCES Productos(Id),

    CONSTRAINT FK_ProductoIngredientes_Sectores 
        FOREIGN KEY (IdSector) REFERENCES Sectores(Id)
);
GO

--CARGA DE DATOS DE PRUEB: PRODUCTO CHEESEBURGER
INSERT INTO Productos(Nombre, MinutosPreparacion, Activo, IdSector) VALUES('Cheeseburger', 0, 1, 2)

--CARGA DE DATOS DE PRUEBA: INGREDIENTES PARA CHEESEBURGER
INSERT INTO ProductoIngredientes (IdProducto, NombreIngrediente, EsOpcional, IdSector, Activo, MinutosPreparacion)
VALUES 
(10, 'Pan', 0, 4, 1, 3),
(10, 'Carne de res', 1, 2, 1, 5),
(10, 'Queso cheddar', 1, 2, 1, 2),
(10, 'Lechuga', 1, 4, 1, 2),
(10, 'Tomate', 1, 4, 1, 2),
(10, 'Cebolla', 1, 4, 1, 2),
(10, 'Pepinillos', 1, 4, 1, 2),
(10, 'Ketchup', 1, 4, 1, 2),
(10, 'Mayonesa', 1, 4, 1, 2);

--------------------------------------------------
--19/11/2025

--ProductoIngredientes pasa a tabla intermedia
DROP TABLE ProductoIngredientes

CREATE TABLE Ingredientes (
  Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  Nombre VARCHAR(50) NOT NULL,
  IdSector INT NOT NULL,
  MinutosPreparacion INT NOT NULL DEFAULT 0,
  Activo BIT NOT NULL DEFAULT 0,
  CONSTRAINT FK_Ingredientes_Sectores FOREIGN KEY (IdSector) REFERENCES Sectores(Id)
);
GO

CREATE TABLE ProductoIngredientes (
  Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  IdProducto INT NOT NULL,
  IdIngrediente INT NOT NULL,
  EsOpcional BIT NOT NULL DEFAULT 0,
  Cantidad INT NULL, 
  CONSTRAINT FK_ProductoIngredientes_Productos FOREIGN KEY (IdProducto) REFERENCES Productos(Id),
  CONSTRAINT FK_ProductoIngredientes_Ingredientes FOREIGN KEY (IdIngrediente) REFERENCES Ingredientes(Id)
);
GO

--Datos de prueba para Cheeseburger
INSERT INTO Ingredientes (Nombre, IdSector, MinutosPreparacion, Activo)
VALUES 
('Pan', 4, 3, 0),
('Carne de res', 2, 5, 0),
('Queso cheddar', 2, 2, 0),
('Lechuga',4, 2, 0),
('Tomate', 4, 2, 0),
('Cebolla', 4, 2, 0),
('Pepinillos', 4, 2, 0),
('Ketchup', 4, 2, 0),
('Mayonesa', 4, 2, 0);

--Relacionar Ingredientes con Cheeseburger (En este caso IdProducto = 10)

INSERT INTO ProductoIngredientes (IdProducto, IdIngrediente, EsOpcional, Cantidad) VALUES (10, 2, 1, 1)

------------------------------------------------
--23/11/2025

CREATE TABLE GruposProducto (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL
);

INSERT INTO GruposProducto VALUES 
('Principal'), 
('Side'), 
('Bebida'), 
('Postre'); 

ALTER TABLE Productos
ADD IdGrupo INT NULL
    CONSTRAINT FK_Productos_GruposProducto FOREIGN KEY (IdGrupo) REFERENCES GruposProducto(Id);
---------------------------------------
--25/11/2025
--Eliminar FK de RolUsuarios
ALTER TABLE RolUsuarios
DROP CONSTRAINT FK_RolUsuarios_Usuarios;
GO

--Eliminación de columna
ALTER TABLE RolUsuarios
DROP COLUMN IdUsuario;
GO
---------------------------------------