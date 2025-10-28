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