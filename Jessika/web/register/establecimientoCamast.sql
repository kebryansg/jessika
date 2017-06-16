USE [BD_SM]
GO
/****** Object:  Table [dbo].[camas]    Script Date: 13/06/2017 13:46:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[camas](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[medicinaInternaIndividual] [int] NULL,
	[medicinaInternaDoble] [int] NULL,
	[cirugiaIndividual] [int] NULL,
	[cirugiaDoble] [int] NULL,
	[ginecologiaYobstetriciaIndividual] [int] NULL,
	[ginecologiaYobstetriciaDoble] [int] NULL,
	[pediatriaIndividual] [int] NULL,
	[pediatriaDoble] [int] NULL,
	[cardiologiaIndividual] [int] NULL,
	[cardiologiaDoble] [int] NULL,
	[neumologiaIndividual] [int] NULL,
	[neumologiaDoble] [int] NULL,
	[psiquiatriaIndividual] [int] NULL,
	[psiquiatriaDoble] [int] NULL,
	[traumatologiaIndividual] [int] NULL,
	[traumotologiaDoble] [int] NULL,
	[infectologiaIndividual] [int] NULL,
	[infectologiaDoble] [int] NULL,
	[oftalmologiaIndividual] [int] NULL,
	[oftalmologiaDoble] [int] NULL,
	[urologiaIndividual] [int] NULL,
	[urologiaDoble] [int] NULL,
	[gastroenterologiaIndividual] [int] NULL,
	[gastroenterologiaDoble] [int] NULL,
	[emergencia] [int] NULL,
	[cuidadosIntensivos] [int] NULL,
 CONSTRAINT [PK_camas] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[establecimiento]    Script Date: 13/06/2017 13:46:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[establecimiento](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](100) NULL,
	[encargado] [nvarchar](100) NULL,
	[parroquia] [int] NULL,
	[direccion] [nvarchar](100) NULL,
	[telefono] [nvarchar](10) NULL,
	[email] [nvarchar](100) NULL,
	[logo] [nvarchar](50) NULL,
 CONSTRAINT [PK_hospital] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
