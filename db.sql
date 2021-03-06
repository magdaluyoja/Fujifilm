USE [Fujifilm_WMS]
GO
/****** Object:  StoredProcedure [dbo].[UserPageAccess_Validate]    Script Date: 3/24/2020 9:35:46 PM ******/
DROP PROCEDURE [dbo].[UserPageAccess_Validate]
GO
/****** Object:  StoredProcedure [dbo].[UserPageAccess_INSERT_UPDATE]    Script Date: 3/24/2020 9:35:46 PM ******/
DROP PROCEDURE [dbo].[UserPageAccess_INSERT_UPDATE]
GO
/****** Object:  StoredProcedure [dbo].[UserPageAccess_GetAccessList]    Script Date: 3/24/2020 9:35:46 PM ******/
DROP PROCEDURE [dbo].[UserPageAccess_GetAccessList]
GO
/****** Object:  StoredProcedure [dbo].[User_Login]    Script Date: 3/24/2020 9:35:46 PM ******/
DROP PROCEDURE [dbo].[User_Login]
GO
/****** Object:  StoredProcedure [dbo].[User_InsertUpdate]    Script Date: 3/24/2020 9:35:46 PM ******/
DROP PROCEDURE [dbo].[User_InsertUpdate]
GO
/****** Object:  StoredProcedure [dbo].[User_Delete]    Script Date: 3/24/2020 9:35:46 PM ******/
DROP PROCEDURE [dbo].[User_Delete]
GO
/****** Object:  StoredProcedure [dbo].[Type_InsertUpdate]    Script Date: 3/24/2020 9:35:46 PM ******/
DROP PROCEDURE [dbo].[Type_InsertUpdate]
GO
/****** Object:  StoredProcedure [dbo].[Type_Delete]    Script Date: 3/24/2020 9:35:46 PM ******/
DROP PROCEDURE [dbo].[Type_Delete]
GO
/****** Object:  StoredProcedure [dbo].[SupplierMaster_InsertUpdate]    Script Date: 3/24/2020 9:35:46 PM ******/
DROP PROCEDURE [dbo].[SupplierMaster_InsertUpdate]
GO
/****** Object:  StoredProcedure [dbo].[SupplierMaster_Delete]    Script Date: 3/24/2020 9:35:46 PM ******/
DROP PROCEDURE [dbo].[SupplierMaster_Delete]
GO
/****** Object:  StoredProcedure [dbo].[Receiving_POItemsInsertUpdate]    Script Date: 3/24/2020 9:35:46 PM ******/
DROP PROCEDURE [dbo].[Receiving_POItemsInsertUpdate]
GO
/****** Object:  StoredProcedure [dbo].[Receiving_GetPOItems]    Script Date: 3/24/2020 9:35:46 PM ******/
DROP PROCEDURE [dbo].[Receiving_GetPOItems]
GO
/****** Object:  StoredProcedure [dbo].[PurchaseOrder_InsertUpdate]    Script Date: 3/24/2020 9:35:46 PM ******/
DROP PROCEDURE [dbo].[PurchaseOrder_InsertUpdate]
GO
/****** Object:  StoredProcedure [dbo].[PurchaseOrder_GetPurchaseUploadDetails]    Script Date: 3/24/2020 9:35:46 PM ******/
DROP PROCEDURE [dbo].[PurchaseOrder_GetPurchaseUploadDetails]
GO
/****** Object:  StoredProcedure [dbo].[PurchaseOrder_GetList]    Script Date: 3/24/2020 9:35:46 PM ******/
DROP PROCEDURE [dbo].[PurchaseOrder_GetList]
GO
/****** Object:  StoredProcedure [dbo].[PurchaseOrder_Delete]    Script Date: 3/24/2020 9:35:46 PM ******/
DROP PROCEDURE [dbo].[PurchaseOrder_Delete]
GO
/****** Object:  StoredProcedure [dbo].[pPurchaseOrderUpload_Insert]    Script Date: 3/24/2020 9:35:46 PM ******/
DROP PROCEDURE [dbo].[pPurchaseOrderUpload_Insert]
GO
/****** Object:  StoredProcedure [dbo].[Page_InsertUpdate]    Script Date: 3/24/2020 9:35:46 PM ******/
DROP PROCEDURE [dbo].[Page_InsertUpdate]
GO
/****** Object:  StoredProcedure [dbo].[Page_Delete]    Script Date: 3/24/2020 9:35:46 PM ******/
DROP PROCEDURE [dbo].[Page_Delete]
GO
/****** Object:  StoredProcedure [dbo].[LocationMaster_InsertUpdate]    Script Date: 3/24/2020 9:35:46 PM ******/
DROP PROCEDURE [dbo].[LocationMaster_InsertUpdate]
GO
/****** Object:  StoredProcedure [dbo].[LocationMaster_Delete]    Script Date: 3/24/2020 9:35:46 PM ******/
DROP PROCEDURE [dbo].[LocationMaster_Delete]
GO
/****** Object:  StoredProcedure [dbo].[ItemMaster_InsertUpdate]    Script Date: 3/24/2020 9:35:46 PM ******/
DROP PROCEDURE [dbo].[ItemMaster_InsertUpdate]
GO
/****** Object:  StoredProcedure [dbo].[ItemMaster_Delete]    Script Date: 3/24/2020 9:35:46 PM ******/
DROP PROCEDURE [dbo].[ItemMaster_Delete]
GO
/****** Object:  StoredProcedure [dbo].[General_InsertUpdate]    Script Date: 3/24/2020 9:35:46 PM ******/
DROP PROCEDURE [dbo].[General_InsertUpdate]
GO
/****** Object:  StoredProcedure [dbo].[General_Delete]    Script Date: 3/24/2020 9:35:46 PM ******/
DROP PROCEDURE [dbo].[General_Delete]
GO
/****** Object:  StoredProcedure [dbo].[CostCenterMaster_InsertUpdate]    Script Date: 3/24/2020 9:35:46 PM ******/
DROP PROCEDURE [dbo].[CostCenterMaster_InsertUpdate]
GO
/****** Object:  StoredProcedure [dbo].[CostCenterMaster_Delete]    Script Date: 3/24/2020 9:35:46 PM ******/
DROP PROCEDURE [dbo].[CostCenterMaster_Delete]
GO
ALTER TABLE [dbo].[mUsers] DROP CONSTRAINT [DF_mUsers_UpdateDate]
GO
ALTER TABLE [dbo].[mUsers] DROP CONSTRAINT [DF_mUsers_CreateDate]
GO
ALTER TABLE [dbo].[mUsers] DROP CONSTRAINT [DF_mUsers_IsDeleted]
GO
ALTER TABLE [dbo].[mUserPageAccess] DROP CONSTRAINT [DF_mUserPageAccess_UpdateDate]
GO
ALTER TABLE [dbo].[mUserPageAccess] DROP CONSTRAINT [DF_mUserPageAccess_CreateDate]
GO
ALTER TABLE [dbo].[mUserPageAccess] DROP CONSTRAINT [DF_mUserPageAccess_Write]
GO
ALTER TABLE [dbo].[mTypes] DROP CONSTRAINT [DF_mTypes_UpdateDate]
GO
ALTER TABLE [dbo].[mTypes] DROP CONSTRAINT [DF_mTypes_CreateDate]
GO
ALTER TABLE [dbo].[mTypes] DROP CONSTRAINT [DF_mTypes_IsDeleted]
GO
ALTER TABLE [dbo].[mPages] DROP CONSTRAINT [DF_mPagses_UpdateDate]
GO
ALTER TABLE [dbo].[mPages] DROP CONSTRAINT [DF_mPagses_CreateDate]
GO
ALTER TABLE [dbo].[mPages] DROP CONSTRAINT [DF_mPages_IsDeleted]
GO
ALTER TABLE [dbo].[mPages] DROP CONSTRAINT [DF_mPages_ParentOrder]
GO
ALTER TABLE [dbo].[mGeneral] DROP CONSTRAINT [DF_mGeneralMaster_UpdateDate]
GO
ALTER TABLE [dbo].[mGeneral] DROP CONSTRAINT [DF_mGeneralMaster_CreateDate]
GO
ALTER TABLE [dbo].[mGeneral] DROP CONSTRAINT [DF_mGeneralMaster_IsDeleted]
GO
/****** Object:  Index [Username_mUsers]    Script Date: 3/24/2020 9:35:46 PM ******/
ALTER TABLE [dbo].[mUsers] DROP CONSTRAINT [Username_mUsers]
GO
/****** Object:  Table [dbo].[pPurchaseOrderUpload]    Script Date: 3/24/2020 9:35:46 PM ******/
DROP TABLE [dbo].[pPurchaseOrderUpload]
GO
/****** Object:  Table [dbo].[pActualReceivingDetails]    Script Date: 3/24/2020 9:35:46 PM ******/
DROP TABLE [dbo].[pActualReceivingDetails]
GO
/****** Object:  Table [dbo].[mUsers]    Script Date: 3/24/2020 9:35:46 PM ******/
DROP TABLE [dbo].[mUsers]
GO
/****** Object:  Table [dbo].[mUserPageAccess]    Script Date: 3/24/2020 9:35:46 PM ******/
DROP TABLE [dbo].[mUserPageAccess]
GO
/****** Object:  Table [dbo].[mTypes]    Script Date: 3/24/2020 9:35:46 PM ******/
DROP TABLE [dbo].[mTypes]
GO
/****** Object:  Table [dbo].[mSupplier]    Script Date: 3/24/2020 9:35:46 PM ******/
DROP TABLE [dbo].[mSupplier]
GO
/****** Object:  Table [dbo].[mPages]    Script Date: 3/24/2020 9:35:46 PM ******/
DROP TABLE [dbo].[mPages]
GO
/****** Object:  Table [dbo].[mLocation]    Script Date: 3/24/2020 9:35:46 PM ******/
DROP TABLE [dbo].[mLocation]
GO
/****** Object:  Table [dbo].[mItemMaster]    Script Date: 3/24/2020 9:35:46 PM ******/
DROP TABLE [dbo].[mItemMaster]
GO
/****** Object:  Table [dbo].[mGeneral]    Script Date: 3/24/2020 9:35:46 PM ******/
DROP TABLE [dbo].[mGeneral]
GO
/****** Object:  Table [dbo].[mCostCenter]    Script Date: 3/24/2020 9:35:46 PM ******/
DROP TABLE [dbo].[mCostCenter]
GO
/****** Object:  Table [dbo].[mCostCenter]    Script Date: 3/24/2020 9:35:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mCostCenter](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[DepartmentID] [bigint] NULL,
	[CostCenterCode] [nvarchar](max) NULL,
	[CostCenterName] [nvarchar](max) NULL,
	[Status] [int] NULL,
	[IsDeleted] [int] NULL,
	[CreateID] [nvarchar](max) NULL,
	[CreateDate] [datetime] NULL,
	[UpdateID] [nvarchar](max) NULL,
	[UpdateDate] [datetime] NULL,
 CONSTRAINT [PK_mCostCenter] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[mGeneral]    Script Date: 3/24/2020 9:35:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[mGeneral](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TypeID] [int] NOT NULL,
	[Value] [varchar](255) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[CreateID] [nvarchar](50) NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateID] [nvarchar](50) NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_mGeneral] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[mItemMaster]    Script Date: 3/24/2020 9:35:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mItemMaster](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[PartNumber] [nvarchar](max) NULL,
	[PartName] [nvarchar](max) NULL,
	[UOM] [int] NULL,
	[Model] [int] NULL,
	[Category] [int] NULL,
	[Status] [int] NULL,
	[IsDeleted] [int] NULL,
	[CreateID] [nvarchar](max) NULL,
	[CreateDate] [datetime] NULL,
	[UpdateID] [nvarchar](max) NULL,
	[UpdateDate] [datetime] NULL,
 CONSTRAINT [PK_mItemMaster] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[mLocation]    Script Date: 3/24/2020 9:35:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mLocation](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Area] [nvarchar](max) NULL,
	[Position] [nvarchar](max) NULL,
	[X] [int] NULL,
	[Y] [int] NULL,
	[Z] [int] NULL,
	[PalletCapacity] [decimal](18, 2) NULL,
	[BoxCapacity] [decimal](18, 2) NULL,
	[Status] [int] NULL,
	[IsDeleted] [int] NULL,
	[CreateID] [nvarchar](max) NULL,
	[CreateDate] [datetime] NULL,
	[UpdateID] [nvarchar](max) NULL,
	[UpdateDate] [datetime] NULL,
 CONSTRAINT [PK_mLocation] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[mPages]    Script Date: 3/24/2020 9:35:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mPages](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[GroupLabel] [nvarchar](max) NULL,
	[PageName] [nvarchar](50) NOT NULL,
	[PageLabel] [nvarchar](max) NULL,
	[URL] [nvarchar](100) NOT NULL,
	[HasSub] [bit] NOT NULL,
	[ParentMenu] [nvarchar](50) NOT NULL,
	[ParentOrder] [int] NOT NULL,
	[Order] [int] NOT NULL,
	[Icon] [nvarchar](50) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[CreateID] [nvarchar](50) NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateID] [nvarchar](50) NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_mPagses] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[mSupplier]    Script Date: 3/24/2020 9:35:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mSupplier](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[SupplierCode] [nvarchar](max) NULL,
	[SupplierName] [nvarchar](max) NULL,
	[SupplierAbbrev] [nvarchar](max) NULL,
	[Status] [int] NULL,
	[IsDeleted] [int] NULL,
	[CreateID] [nvarchar](max) NULL,
	[CreateDate] [datetime] NULL,
	[UpdateID] [nvarchar](max) NULL,
	[UpdateDate] [datetime] NULL,
 CONSTRAINT [PK_mSupplier] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[mTypes]    Script Date: 3/24/2020 9:35:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mTypes](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Type] [nvarchar](255) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[CreateID] [nvarchar](50) NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateID] [nvarchar](50) NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_mTypes] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[mUserPageAccess]    Script Date: 3/24/2020 9:35:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mUserPageAccess](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[PageID] [int] NOT NULL,
	[Status] [bit] NOT NULL,
	[ReadAndWrite] [bit] NOT NULL,
	[Delete] [bit] NULL,
	[CreateID] [nvarchar](50) NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateID] [nvarchar](50) NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_mUserPageAccess] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[mUsers]    Script Date: 3/24/2020 9:35:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mUsers](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](20) NOT NULL,
	[Password] [nvarchar](255) NOT NULL,
	[Email] [nvarchar](255) NOT NULL,
	[FirstName] [nvarchar](max) NULL,
	[LastName] [nvarchar](max) NULL,
	[Department] [nvarchar](max) NULL,
	[PostFunction_Approver] [bit] NULL,
	[Role] [nvarchar](50) NULL,
	[IsDeleted] [bit] NOT NULL,
	[CreateID] [nvarchar](50) NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateID] [nvarchar](50) NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [ID_mUsers] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[pActualReceivingDetails]    Script Date: 3/24/2020 9:35:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pActualReceivingDetails](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[PONo] [nvarchar](max) NULL,
	[PO_Ln_No] [nvarchar](5) NULL,
	[PartNumber] [nvarchar](max) NULL,
	[Actual_Qty] [decimal](18, 2) NULL,
	[Received_Date] [datetime] NULL,
	[IsDeleted] [int] NULL,
	[CreateID] [nvarchar](max) NULL,
	[CreateDate] [datetime] NULL,
	[UpdateID] [nvarchar](max) NULL,
	[UpdateDate] [datetime] NULL,
 CONSTRAINT [PK_pActualReceivingDetails] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[pPurchaseOrderUpload]    Script Date: 3/24/2020 9:35:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pPurchaseOrderUpload](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Department] [nvarchar](max) NULL,
	[Vendor_Code] [nvarchar](max) NULL,
	[Vendor_Name] [nvarchar](max) NULL,
	[PO_Issued_Date] [date] NULL,
	[PO_Ln_No] [nvarchar](max) NULL,
	[PO_No] [nvarchar](max) NULL,
	[Material] [nvarchar](max) NULL,
	[Material_Description] [nvarchar](max) NULL,
	[Unit] [nvarchar](max) NULL,
	[Requested_Delivery_Date] [date] NULL,
	[PO_Balance] [decimal](18, 2) NULL,
	[Cost_Center] [nvarchar](max) NULL,
	[IsDeleted] [bit] NULL,
	[CreateID] [nvarchar](max) NULL,
	[CreateDate] [datetime] NULL,
	[UpdateID] [nvarchar](max) NULL,
	[UpdateDate] [datetime] NULL,
 CONSTRAINT [PK_pPurchaseOrderUpload] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[mCostCenter] ON 

INSERT [dbo].[mCostCenter] ([ID], [DepartmentID], [CostCenterCode], [CostCenterName], [Status], [IsDeleted], [CreateID], [CreateDate], [UpdateID], [UpdateDate]) VALUES (1, 0, N'SAD AKO', N'SAD AKO', 0, 1, N'ijbdichoson', CAST(N'2020-03-05 20:10:14.110' AS DateTime), N'ijbdichoson', CAST(N'2020-03-05 20:32:37.907' AS DateTime))
INSERT [dbo].[mCostCenter] ([ID], [DepartmentID], [CostCenterCode], [CostCenterName], [Status], [IsDeleted], [CreateID], [CreateDate], [UpdateID], [UpdateDate]) VALUES (2, 0, N'sad', N'sd', 0, 1, N'ijbdichoson', CAST(N'2020-03-05 20:13:43.423' AS DateTime), N'ijbdichoson', CAST(N'2020-03-05 20:32:35.653' AS DateTime))
INSERT [dbo].[mCostCenter] ([ID], [DepartmentID], [CostCenterCode], [CostCenterName], [Status], [IsDeleted], [CreateID], [CreateDate], [UpdateID], [UpdateDate]) VALUES (3, 2, N'CCD', N'CCN2', 1, 1, N'ijbdichoson', CAST(N'2020-03-05 20:18:52.160' AS DateTime), N'ijbdichoson', CAST(N'2020-03-05 20:32:19.627' AS DateTime))
INSERT [dbo].[mCostCenter] ([ID], [DepartmentID], [CostCenterCode], [CostCenterName], [Status], [IsDeleted], [CreateID], [CreateDate], [UpdateID], [UpdateDate]) VALUES (4, 2, N'111', N'Sample CC', 0, 0, N'ijbdichoson', CAST(N'2020-03-07 15:06:54.970' AS DateTime), N'ijbdichoson', CAST(N'2020-03-07 15:06:54.970' AS DateTime))
INSERT [dbo].[mCostCenter] ([ID], [DepartmentID], [CostCenterCode], [CostCenterName], [Status], [IsDeleted], [CreateID], [CreateDate], [UpdateID], [UpdateDate]) VALUES (5, 7, N'YBA1AA00', N'COST CENTER NAME', 0, 0, N'ijbdichoson', CAST(N'2020-03-09 22:08:03.350' AS DateTime), N'ijbdichoson', CAST(N'2020-03-09 22:08:03.350' AS DateTime))
SET IDENTITY_INSERT [dbo].[mCostCenter] OFF
SET IDENTITY_INSERT [dbo].[mGeneral] ON 

INSERT [dbo].[mGeneral] ([ID], [TypeID], [Value], [IsDeleted], [CreateID], [CreateDate], [UpdateID], [UpdateDate]) VALUES (1, 3, N'Raw Material', 0, N'ijbdichoson', CAST(N'2020-03-04 20:16:15.237' AS DateTime), N'ijbdichoson', CAST(N'2020-03-04 20:16:15.237' AS DateTime))
INSERT [dbo].[mGeneral] ([ID], [TypeID], [Value], [IsDeleted], [CreateID], [CreateDate], [UpdateID], [UpdateDate]) VALUES (2, 1, N'Software Innovation', 0, N'ijbdichoson', CAST(N'2020-03-04 20:16:31.350' AS DateTime), N'ijbdichoson', CAST(N'2020-03-04 20:16:31.350' AS DateTime))
INSERT [dbo].[mGeneral] ([ID], [TypeID], [Value], [IsDeleted], [CreateID], [CreateDate], [UpdateID], [UpdateDate]) VALUES (3, 2, N'LX270', 0, N'ijbdichoson', CAST(N'2020-03-04 20:16:39.303' AS DateTime), N'ijbdichoson', CAST(N'2020-03-04 20:16:39.303' AS DateTime))
INSERT [dbo].[mGeneral] ([ID], [TypeID], [Value], [IsDeleted], [CreateID], [CreateDate], [UpdateID], [UpdateDate]) VALUES (4, 4, N'BOX', 0, N'ijbdichoson', CAST(N'2020-03-05 00:09:15.787' AS DateTime), N'ijbdichoson', CAST(N'2020-03-05 00:09:44.560' AS DateTime))
INSERT [dbo].[mGeneral] ([ID], [TypeID], [Value], [IsDeleted], [CreateID], [CreateDate], [UpdateID], [UpdateDate]) VALUES (5, 4, N'EA', 0, N'ijbdichoson', CAST(N'2020-03-05 00:09:26.197' AS DateTime), N'ijbdichoson', CAST(N'2020-03-05 00:09:26.197' AS DateTime))
INSERT [dbo].[mGeneral] ([ID], [TypeID], [Value], [IsDeleted], [CreateID], [CreateDate], [UpdateID], [UpdateDate]) VALUES (6, 4, N'PCS', 0, N'ijbdichoson', CAST(N'2020-03-05 00:09:38.260' AS DateTime), N'ijbdichoson', CAST(N'2020-03-05 00:09:38.260' AS DateTime))
INSERT [dbo].[mGeneral] ([ID], [TypeID], [Value], [IsDeleted], [CreateID], [CreateDate], [UpdateID], [UpdateDate]) VALUES (7, 1, N'LX', 0, N'ijbdichoson', CAST(N'2020-03-09 22:07:09.920' AS DateTime), N'ijbdichoson', CAST(N'2020-03-09 22:07:09.920' AS DateTime))
INSERT [dbo].[mGeneral] ([ID], [TypeID], [Value], [IsDeleted], [CreateID], [CreateDate], [UpdateID], [UpdateDate]) VALUES (8, 1, N'General Admin', 0, N'ijbdichoson', CAST(N'2020-03-09 22:08:17.763' AS DateTime), N'ijbdichoson', CAST(N'2020-03-09 22:08:17.763' AS DateTime))
INSERT [dbo].[mGeneral] ([ID], [TypeID], [Value], [IsDeleted], [CreateID], [CreateDate], [UpdateID], [UpdateDate]) VALUES (9, 1, N'Purchasing', 0, N'ijbdichoson', CAST(N'2020-03-11 09:55:26.357' AS DateTime), N'ijbdichoson', CAST(N'2020-03-11 09:55:26.357' AS DateTime))
SET IDENTITY_INSERT [dbo].[mGeneral] OFF
SET IDENTITY_INSERT [dbo].[mItemMaster] ON 

INSERT [dbo].[mItemMaster] ([ID], [PartNumber], [PartName], [UOM], [Model], [Category], [Status], [IsDeleted], [CreateID], [CreateDate], [UpdateID], [UpdateDate]) VALUES (1, N'Sample Part Number 1', N'Sample Part Number 1', 1, 3, 1, 1, 1, N'ijbdichoson', CAST(N'2020-03-05 00:25:26.513' AS DateTime), N'ijbdichoson', CAST(N'2020-03-07 16:09:24.613' AS DateTime))
INSERT [dbo].[mItemMaster] ([ID], [PartNumber], [PartName], [UOM], [Model], [Category], [Status], [IsDeleted], [CreateID], [CreateDate], [UpdateID], [UpdateDate]) VALUES (2, N'Sample Part Number 2', N'Sample Part Number 2', 4, 3, 1, 0, 1, N'ijbdichoson', CAST(N'2020-03-05 00:28:31.660' AS DateTime), N'ijbdichoson', CAST(N'2020-03-07 16:09:21.427' AS DateTime))
INSERT [dbo].[mItemMaster] ([ID], [PartNumber], [PartName], [UOM], [Model], [Category], [Status], [IsDeleted], [CreateID], [CreateDate], [UpdateID], [UpdateDate]) VALUES (3, N'Item 1', N'Item Name 1', 4, 3, 1, 0, 1, N'ijbdichoson', CAST(N'2020-03-07 16:09:45.940' AS DateTime), N'jayr', CAST(N'2020-03-23 19:49:27.213' AS DateTime))
INSERT [dbo].[mItemMaster] ([ID], [PartNumber], [PartName], [UOM], [Model], [Category], [Status], [IsDeleted], [CreateID], [CreateDate], [UpdateID], [UpdateDate]) VALUES (4, N'100000054524', N'100000054524', 5, 3, 1, 0, 0, N'ijbdichoson', CAST(N'2020-03-09 22:22:09.667' AS DateTime), N'jayr', CAST(N'2020-03-23 19:45:58.690' AS DateTime))
INSERT [dbo].[mItemMaster] ([ID], [PartNumber], [PartName], [UOM], [Model], [Category], [Status], [IsDeleted], [CreateID], [CreateDate], [UpdateID], [UpdateDate]) VALUES (5, N'100000054525', N'100000054525', 5, 3, 1, 0, 0, N'ijbdichoson', CAST(N'2020-03-09 22:22:23.543' AS DateTime), N'jayr', CAST(N'2020-03-23 19:49:39.917' AS DateTime))
SET IDENTITY_INSERT [dbo].[mItemMaster] OFF
SET IDENTITY_INSERT [dbo].[mLocation] ON 

INSERT [dbo].[mLocation] ([ID], [Area], [Position], [X], [Y], [Z], [PalletCapacity], [BoxCapacity], [Status], [IsDeleted], [CreateID], [CreateDate], [UpdateID], [UpdateDate]) VALUES (1, N'Area 2', N'Position 2', 2, 3, 4, CAST(20.00 AS Decimal(18, 2)), CAST(30.00 AS Decimal(18, 2)), 1, 1, N'ijbdichoson', CAST(N'2020-03-09 13:08:07.837' AS DateTime), N'ijbdichoson', CAST(N'2020-03-09 13:17:51.883' AS DateTime))
INSERT [dbo].[mLocation] ([ID], [Area], [Position], [X], [Y], [Z], [PalletCapacity], [BoxCapacity], [Status], [IsDeleted], [CreateID], [CreateDate], [UpdateID], [UpdateDate]) VALUES (2, N'Area 1', N'Position 1', 1, 2, 3, CAST(10.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 0, 0, N'ijbdichoson', CAST(N'2020-03-09 13:37:57.890' AS DateTime), N'ijbdichoson', CAST(N'2020-03-09 13:37:57.890' AS DateTime))
SET IDENTITY_INSERT [dbo].[mLocation] OFF
SET IDENTITY_INSERT [dbo].[mPages] ON 

INSERT [dbo].[mPages] ([ID], [GroupLabel], [PageName], [PageLabel], [URL], [HasSub], [ParentMenu], [ParentOrder], [Order], [Icon], [IsDeleted], [CreateID], [CreateDate], [UpdateID], [UpdateDate]) VALUES (1, N'', N'Master', N'Master', N'/MasterMaintenance', 1, N'0', 3, 0, N'fa fa-cogs', 0, N'jayr', CAST(N'2019-11-06 14:48:10.613' AS DateTime), N'jayr', CAST(N'2020-01-24 10:07:08.907' AS DateTime))
INSERT [dbo].[mPages] ([ID], [GroupLabel], [PageName], [PageLabel], [URL], [HasSub], [ParentMenu], [ParentOrder], [Order], [Icon], [IsDeleted], [CreateID], [CreateDate], [UpdateID], [UpdateDate]) VALUES (2, NULL, N'UserMaster', N'User Master', N'/MasterMaintenance/UserMaster', 0, N'Master', 0, 2, N'0', 0, N'jayr', CAST(N'2019-11-06 14:54:10.383' AS DateTime), N'jayr', CAST(N'2019-11-06 16:36:25.200' AS DateTime))
INSERT [dbo].[mPages] ([ID], [GroupLabel], [PageName], [PageLabel], [URL], [HasSub], [ParentMenu], [ParentOrder], [Order], [Icon], [IsDeleted], [CreateID], [CreateDate], [UpdateID], [UpdateDate]) VALUES (3, NULL, N'PageMaster', N'Page Master', N'/MasterMaintenance/PageMaster', 0, N'Master', 0, 3, N'0', 0, N'jayr', CAST(N'2019-11-06 14:54:47.453' AS DateTime), N'jayr', CAST(N'2019-11-06 16:36:29.330' AS DateTime))
INSERT [dbo].[mPages] ([ID], [GroupLabel], [PageName], [PageLabel], [URL], [HasSub], [ParentMenu], [ParentOrder], [Order], [Icon], [IsDeleted], [CreateID], [CreateDate], [UpdateID], [UpdateDate]) VALUES (4, N'', N'FieldMaster', N'Field Master', N'/MasterMaintenance/GeneralMaster', 0, N'Master', 0, 4, N'0', 0, N'jayr', CAST(N'2020-01-31 18:18:31.093' AS DateTime), N'jayr', CAST(N'2020-01-31 18:18:31.093' AS DateTime))
INSERT [dbo].[mPages] ([ID], [GroupLabel], [PageName], [PageLabel], [URL], [HasSub], [ParentMenu], [ParentOrder], [Order], [Icon], [IsDeleted], [CreateID], [CreateDate], [UpdateID], [UpdateDate]) VALUES (5, N'', N'PurchaseOrderUpload', N'Purchase Order Upload', N'/Input/PurchaseUpload', 0, N'PurchaseOrderUpload', 4, 5, N'fa fa-list-ol', 0, N'ijbdichoson', CAST(N'2020-03-01 13:52:21.893' AS DateTime), N'ijbdichoson', CAST(N'2020-03-06 22:35:41.067' AS DateTime))
INSERT [dbo].[mPages] ([ID], [GroupLabel], [PageName], [PageLabel], [URL], [HasSub], [ParentMenu], [ParentOrder], [Order], [Icon], [IsDeleted], [CreateID], [CreateDate], [UpdateID], [UpdateDate]) VALUES (6, N'', N'ItemMaster', N'Item Master', N'/MasterMaintenance/ItemMaster', 0, N'Master', 0, 5, N'0', 0, N'ijbdichoson', CAST(N'2020-03-01 16:35:51.393' AS DateTime), N'ijbdichoson', CAST(N'2020-03-01 16:35:51.393' AS DateTime))
INSERT [dbo].[mPages] ([ID], [GroupLabel], [PageName], [PageLabel], [URL], [HasSub], [ParentMenu], [ParentOrder], [Order], [Icon], [IsDeleted], [CreateID], [CreateDate], [UpdateID], [UpdateDate]) VALUES (7, N'', N'SupplierMaster', N'Supplier Master', N'/MasterMaintenance/SupplierMaster', 0, N'Master', 0, 6, N'0', 0, N'ijbdichoson', CAST(N'2020-03-05 00:47:22.223' AS DateTime), N'ijbdichoson', CAST(N'2020-03-05 18:15:17.733' AS DateTime))
INSERT [dbo].[mPages] ([ID], [GroupLabel], [PageName], [PageLabel], [URL], [HasSub], [ParentMenu], [ParentOrder], [Order], [Icon], [IsDeleted], [CreateID], [CreateDate], [UpdateID], [UpdateDate]) VALUES (8, N'', N'CostCenterMaster', N'Cost Center Master', N'/MasterMaintenance/CostCenter', 0, N'Master', 0, 7, N'0', 0, N'ijbdichoson', CAST(N'2020-03-05 19:31:08.700' AS DateTime), N'ijbdichoson', CAST(N'2020-03-05 20:03:30.280' AS DateTime))
INSERT [dbo].[mPages] ([ID], [GroupLabel], [PageName], [PageLabel], [URL], [HasSub], [ParentMenu], [ParentOrder], [Order], [Icon], [IsDeleted], [CreateID], [CreateDate], [UpdateID], [UpdateDate]) VALUES (9, N'', N'LocationMaster', N'Location Master', N'/MasterMaintenance/LocationMaster', 0, N'Master', 0, 8, N'0', 0, N'ijbdichoson', CAST(N'2020-03-09 12:15:11.023' AS DateTime), N'ijbdichoson', CAST(N'2020-03-09 14:05:05.467' AS DateTime))
INSERT [dbo].[mPages] ([ID], [GroupLabel], [PageName], [PageLabel], [URL], [HasSub], [ParentMenu], [ParentOrder], [Order], [Icon], [IsDeleted], [CreateID], [CreateDate], [UpdateID], [UpdateDate]) VALUES (10, N'', N'ActualReceiving', N'Actual Receiving', N'/ActualReceiving/Receiving', 0, N'ActualReceiving', 5, 9, N'fa fa-pallet', 0, N'ijbdichoson', CAST(N'2020-03-09 14:03:44.523' AS DateTime), N'ijbdichoson', CAST(N'2020-03-09 15:22:29.757' AS DateTime))
SET IDENTITY_INSERT [dbo].[mPages] OFF
SET IDENTITY_INSERT [dbo].[mSupplier] ON 

INSERT [dbo].[mSupplier] ([ID], [SupplierCode], [SupplierName], [SupplierAbbrev], [Status], [IsDeleted], [CreateID], [CreateDate], [UpdateID], [UpdateDate]) VALUES (1, N'SAD AKO SA GINAWA MO!', N'SAD AKO SA GINAWA MO! 2', N'SAD AKO SA GINAWA MO! 2', 1, 1, N'ijbdichoson', CAST(N'2020-03-05 18:38:32.070' AS DateTime), N'ijbdichoson', CAST(N'2020-03-07 15:47:51.487' AS DateTime))
INSERT [dbo].[mSupplier] ([ID], [SupplierCode], [SupplierName], [SupplierAbbrev], [Status], [IsDeleted], [CreateID], [CreateDate], [UpdateID], [UpdateDate]) VALUES (2, N'SAD AKO SA GINAWA MO CATH', N'SAD AKO SA GINAWA MO CATH', N'SAD AKO SA GINAWA MO CATH', 1, 1, N'ijbdichoson', CAST(N'2020-03-05 18:38:42.233' AS DateTime), N'ijbdichoson', CAST(N'2020-03-05 19:05:37.407' AS DateTime))
INSERT [dbo].[mSupplier] ([ID], [SupplierCode], [SupplierName], [SupplierAbbrev], [Status], [IsDeleted], [CreateID], [CreateDate], [UpdateID], [UpdateDate]) VALUES (3, N'A100', N'Supplier 1', N'SuppAbbrev', 0, 0, N'ijbdichoson', CAST(N'2020-03-07 15:48:29.043' AS DateTime), N'ijbdichoson', CAST(N'2020-03-07 15:48:29.043' AS DateTime))
INSERT [dbo].[mSupplier] ([ID], [SupplierCode], [SupplierName], [SupplierAbbrev], [Status], [IsDeleted], [CreateID], [CreateDate], [UpdateID], [UpdateDate]) VALUES (4, N'A631000364', N'FFHK-RMB', N'ABBREV1', 0, 0, N'ijbdichoson', CAST(N'2020-03-09 22:07:32.060' AS DateTime), N'ijbdichoson', CAST(N'2020-03-09 22:07:32.060' AS DateTime))
INSERT [dbo].[mSupplier] ([ID], [SupplierCode], [SupplierName], [SupplierAbbrev], [Status], [IsDeleted], [CreateID], [CreateDate], [UpdateID], [UpdateDate]) VALUES (5, N'A631000230', N'Supplier Name 2', N'ABBREV 2', 0, 0, N'ijbdichoson', CAST(N'2020-03-09 22:08:41.083' AS DateTime), N'ijbdichoson', CAST(N'2020-03-09 22:08:41.083' AS DateTime))
SET IDENTITY_INSERT [dbo].[mSupplier] OFF
SET IDENTITY_INSERT [dbo].[mTypes] ON 

INSERT [dbo].[mTypes] ([ID], [Type], [IsDeleted], [CreateID], [CreateDate], [UpdateID], [UpdateDate]) VALUES (1, N'Department', 0, N'jayr', CAST(N'2020-02-25 18:18:31.203' AS DateTime), N'jayr', CAST(N'2020-02-25 18:18:31.203' AS DateTime))
INSERT [dbo].[mTypes] ([ID], [Type], [IsDeleted], [CreateID], [CreateDate], [UpdateID], [UpdateDate]) VALUES (2, N'Model', 0, N'ijbdichoson', CAST(N'2020-03-04 20:13:22.830' AS DateTime), N'ijbdichoson', CAST(N'2020-03-04 20:13:22.830' AS DateTime))
INSERT [dbo].[mTypes] ([ID], [Type], [IsDeleted], [CreateID], [CreateDate], [UpdateID], [UpdateDate]) VALUES (3, N'Category', 0, N'ijbdichoson', CAST(N'2020-03-04 20:13:48.170' AS DateTime), N'ijbdichoson', CAST(N'2020-03-04 20:13:48.170' AS DateTime))
INSERT [dbo].[mTypes] ([ID], [Type], [IsDeleted], [CreateID], [CreateDate], [UpdateID], [UpdateDate]) VALUES (4, N'Unit of Measurement', 0, N'ijbdichoson', CAST(N'2020-03-05 00:09:06.177' AS DateTime), N'ijbdichoson', CAST(N'2020-03-05 00:09:06.177' AS DateTime))
SET IDENTITY_INSERT [dbo].[mTypes] OFF
SET IDENTITY_INSERT [dbo].[mUserPageAccess] ON 

INSERT [dbo].[mUserPageAccess] ([ID], [UserID], [PageID], [Status], [ReadAndWrite], [Delete], [CreateID], [CreateDate], [UpdateID], [UpdateDate]) VALUES (1, 1, 1, 1, 0, 0, N'2', CAST(N'2019-11-07 13:24:32.267' AS DateTime), N'1', CAST(N'2020-03-24 14:44:01.290' AS DateTime))
INSERT [dbo].[mUserPageAccess] ([ID], [UserID], [PageID], [Status], [ReadAndWrite], [Delete], [CreateID], [CreateDate], [UpdateID], [UpdateDate]) VALUES (2, 1, 2, 1, 1, 1, N'2', CAST(N'2019-11-07 13:24:32.270' AS DateTime), N'1', CAST(N'2020-03-24 14:44:01.290' AS DateTime))
INSERT [dbo].[mUserPageAccess] ([ID], [UserID], [PageID], [Status], [ReadAndWrite], [Delete], [CreateID], [CreateDate], [UpdateID], [UpdateDate]) VALUES (3, 1, 3, 1, 1, 1, N'2', CAST(N'2019-11-07 13:24:32.270' AS DateTime), N'1', CAST(N'2020-03-24 14:44:01.290' AS DateTime))
INSERT [dbo].[mUserPageAccess] ([ID], [UserID], [PageID], [Status], [ReadAndWrite], [Delete], [CreateID], [CreateDate], [UpdateID], [UpdateDate]) VALUES (4, 1, 4, 1, 1, 1, N'1', CAST(N'2020-01-31 18:27:33.847' AS DateTime), N'1', CAST(N'2020-03-24 14:44:01.290' AS DateTime))
INSERT [dbo].[mUserPageAccess] ([ID], [UserID], [PageID], [Status], [ReadAndWrite], [Delete], [CreateID], [CreateDate], [UpdateID], [UpdateDate]) VALUES (5, 2, 1, 1, 0, 0, N'jayr', CAST(N'2020-02-25 18:21:15.123' AS DateTime), N'2', CAST(N'2020-03-09 15:21:06.667' AS DateTime))
INSERT [dbo].[mUserPageAccess] ([ID], [UserID], [PageID], [Status], [ReadAndWrite], [Delete], [CreateID], [CreateDate], [UpdateID], [UpdateDate]) VALUES (6, 2, 2, 1, 1, 1, N'jayr', CAST(N'2020-02-25 18:21:15.123' AS DateTime), N'2', CAST(N'2020-03-09 15:21:06.670' AS DateTime))
INSERT [dbo].[mUserPageAccess] ([ID], [UserID], [PageID], [Status], [ReadAndWrite], [Delete], [CreateID], [CreateDate], [UpdateID], [UpdateDate]) VALUES (7, 2, 3, 1, 1, 1, N'jayr', CAST(N'2020-02-25 18:21:15.123' AS DateTime), N'2', CAST(N'2020-03-09 15:21:06.670' AS DateTime))
INSERT [dbo].[mUserPageAccess] ([ID], [UserID], [PageID], [Status], [ReadAndWrite], [Delete], [CreateID], [CreateDate], [UpdateID], [UpdateDate]) VALUES (8, 2, 4, 1, 1, 1, N'jayr', CAST(N'2020-02-25 18:21:15.123' AS DateTime), N'2', CAST(N'2020-03-09 15:21:06.670' AS DateTime))
INSERT [dbo].[mUserPageAccess] ([ID], [UserID], [PageID], [Status], [ReadAndWrite], [Delete], [CreateID], [CreateDate], [UpdateID], [UpdateDate]) VALUES (9, 2, 5, 1, 1, 1, N'2', CAST(N'2020-03-01 13:52:35.857' AS DateTime), N'2', CAST(N'2020-03-09 15:21:06.670' AS DateTime))
INSERT [dbo].[mUserPageAccess] ([ID], [UserID], [PageID], [Status], [ReadAndWrite], [Delete], [CreateID], [CreateDate], [UpdateID], [UpdateDate]) VALUES (10, 2, 6, 1, 1, 1, N'2', CAST(N'2020-03-01 16:36:01.677' AS DateTime), N'2', CAST(N'2020-03-09 15:21:06.670' AS DateTime))
INSERT [dbo].[mUserPageAccess] ([ID], [UserID], [PageID], [Status], [ReadAndWrite], [Delete], [CreateID], [CreateDate], [UpdateID], [UpdateDate]) VALUES (11, 1, 5, 1, 1, 1, N'ijbdichoson', CAST(N'2020-03-05 00:10:13.407' AS DateTime), N'1', CAST(N'2020-03-24 14:44:01.290' AS DateTime))
INSERT [dbo].[mUserPageAccess] ([ID], [UserID], [PageID], [Status], [ReadAndWrite], [Delete], [CreateID], [CreateDate], [UpdateID], [UpdateDate]) VALUES (12, 1, 6, 1, 1, 1, N'ijbdichoson', CAST(N'2020-03-05 00:10:13.407' AS DateTime), N'1', CAST(N'2020-03-24 14:44:01.290' AS DateTime))
INSERT [dbo].[mUserPageAccess] ([ID], [UserID], [PageID], [Status], [ReadAndWrite], [Delete], [CreateID], [CreateDate], [UpdateID], [UpdateDate]) VALUES (13, 2, 7, 1, 1, 1, N'2', CAST(N'2020-03-05 00:47:36.990' AS DateTime), N'2', CAST(N'2020-03-09 15:21:06.670' AS DateTime))
INSERT [dbo].[mUserPageAccess] ([ID], [UserID], [PageID], [Status], [ReadAndWrite], [Delete], [CreateID], [CreateDate], [UpdateID], [UpdateDate]) VALUES (14, 2, 8, 1, 1, 1, N'2', CAST(N'2020-03-05 19:31:25.570' AS DateTime), N'2', CAST(N'2020-03-09 15:21:06.670' AS DateTime))
INSERT [dbo].[mUserPageAccess] ([ID], [UserID], [PageID], [Status], [ReadAndWrite], [Delete], [CreateID], [CreateDate], [UpdateID], [UpdateDate]) VALUES (15, 1, 7, 0, 0, 0, N'2', CAST(N'2020-03-05 21:49:45.583' AS DateTime), N'1', CAST(N'2020-03-24 14:44:01.290' AS DateTime))
INSERT [dbo].[mUserPageAccess] ([ID], [UserID], [PageID], [Status], [ReadAndWrite], [Delete], [CreateID], [CreateDate], [UpdateID], [UpdateDate]) VALUES (16, 1, 8, 0, 0, 0, N'2', CAST(N'2020-03-05 21:49:45.587' AS DateTime), N'1', CAST(N'2020-03-24 14:44:01.290' AS DateTime))
INSERT [dbo].[mUserPageAccess] ([ID], [UserID], [PageID], [Status], [ReadAndWrite], [Delete], [CreateID], [CreateDate], [UpdateID], [UpdateDate]) VALUES (17, 2, 9, 1, 1, 1, N'2', CAST(N'2020-03-09 12:15:27.767' AS DateTime), N'2', CAST(N'2020-03-09 15:21:06.670' AS DateTime))
INSERT [dbo].[mUserPageAccess] ([ID], [UserID], [PageID], [Status], [ReadAndWrite], [Delete], [CreateID], [CreateDate], [UpdateID], [UpdateDate]) VALUES (18, 2, 10, 1, 1, 1, N'2', CAST(N'2020-03-09 14:05:22.897' AS DateTime), N'2', CAST(N'2020-03-09 15:21:06.670' AS DateTime))
INSERT [dbo].[mUserPageAccess] ([ID], [UserID], [PageID], [Status], [ReadAndWrite], [Delete], [CreateID], [CreateDate], [UpdateID], [UpdateDate]) VALUES (19, 1, 9, 0, 0, 0, N'1', CAST(N'2020-03-24 14:44:01.290' AS DateTime), N'1', CAST(N'2020-03-24 14:44:01.290' AS DateTime))
INSERT [dbo].[mUserPageAccess] ([ID], [UserID], [PageID], [Status], [ReadAndWrite], [Delete], [CreateID], [CreateDate], [UpdateID], [UpdateDate]) VALUES (20, 1, 10, 1, 1, 1, N'1', CAST(N'2020-03-24 14:44:01.303' AS DateTime), N'1', CAST(N'2020-03-24 14:44:01.303' AS DateTime))
SET IDENTITY_INSERT [dbo].[mUserPageAccess] OFF
SET IDENTITY_INSERT [dbo].[mUsers] ON 

INSERT [dbo].[mUsers] ([ID], [Username], [Password], [Email], [FirstName], [LastName], [Department], [PostFunction_Approver], [Role], [IsDeleted], [CreateID], [CreateDate], [UpdateID], [UpdateDate]) VALUES (1, N'jayr', N'MTIzNDU2', N'jj.magdaluyo@seiko-it.com.ph', N'Jay-R', N'Magdaluyo', N'2', 0, N'Custom', 0, N'jayr', CAST(N'2019-10-24 13:22:42.957' AS DateTime), N'ijbdichoson', CAST(N'2020-03-05 00:10:13.403' AS DateTime))
INSERT [dbo].[mUsers] ([ID], [Username], [Password], [Email], [FirstName], [LastName], [Department], [PostFunction_Approver], [Role], [IsDeleted], [CreateID], [CreateDate], [UpdateID], [UpdateDate]) VALUES (2, N'ijbdichoson', N'MTIzNDU2', N'ij.dichoson@seiko-it.com.ph', N'Isaac Jacob', N'Dichoson', N'2', 1, N'Custom', 0, N'jayr', CAST(N'2020-02-25 18:21:15.100' AS DateTime), N'ijbdichoson', CAST(N'2020-03-05 00:10:07.160' AS DateTime))
SET IDENTITY_INSERT [dbo].[mUsers] OFF
SET IDENTITY_INSERT [dbo].[pActualReceivingDetails] ON 

INSERT [dbo].[pActualReceivingDetails] ([ID], [PONo], [PO_Ln_No], [PartNumber], [Actual_Qty], [Received_Date], [IsDeleted], [CreateID], [CreateDate], [UpdateID], [UpdateDate]) VALUES (1, N'YB00032244', N'70', NULL, CAST(1.00 AS Decimal(18, 2)), CAST(N'2020-03-10 00:00:00.000' AS DateTime), 0, N'jayr', CAST(N'2020-03-24 20:05:19.193' AS DateTime), NULL, NULL)
INSERT [dbo].[pActualReceivingDetails] ([ID], [PONo], [PO_Ln_No], [PartNumber], [Actual_Qty], [Received_Date], [IsDeleted], [CreateID], [CreateDate], [UpdateID], [UpdateDate]) VALUES (2, N'YB00032244', N'60', NULL, CAST(100.00 AS Decimal(18, 2)), CAST(N'2020-03-31 00:00:00.000' AS DateTime), 0, N'jayr', CAST(N'2020-03-24 20:05:19.193' AS DateTime), NULL, NULL)
SET IDENTITY_INSERT [dbo].[pActualReceivingDetails] OFF
SET IDENTITY_INSERT [dbo].[pPurchaseOrderUpload] ON 

INSERT [dbo].[pPurchaseOrderUpload] ([ID], [Department], [Vendor_Code], [Vendor_Name], [PO_Issued_Date], [PO_Ln_No], [PO_No], [Material], [Material_Description], [Unit], [Requested_Delivery_Date], [PO_Balance], [Cost_Center], [IsDeleted], [CreateID], [CreateDate], [UpdateID], [UpdateDate]) VALUES (1, N'7', N'4', N'', CAST(N'2020-03-20' AS Date), N'60', N'YB00032244', N'3', N'', N'BOX', CAST(N'2020-03-25' AS Date), CAST(34443.00 AS Decimal(18, 2)), N'YBA1AA00', 0, N'jayr', CAST(N'2020-03-23 19:37:50.283' AS DateTime), N'jayr', CAST(N'2020-03-23 19:37:50.283' AS DateTime))
INSERT [dbo].[pPurchaseOrderUpload] ([ID], [Department], [Vendor_Code], [Vendor_Name], [PO_Issued_Date], [PO_Ln_No], [PO_No], [Material], [Material_Description], [Unit], [Requested_Delivery_Date], [PO_Balance], [Cost_Center], [IsDeleted], [CreateID], [CreateDate], [UpdateID], [UpdateDate]) VALUES (2, N'2', N'4', N'', CAST(N'2020-03-06' AS Date), N'70', N'YB00032244', N'4', N'', N'EA', CAST(N'2020-03-09' AS Date), CAST(1.00 AS Decimal(18, 2)), N'111', 0, N'jayr', CAST(N'2020-03-23 19:45:02.563' AS DateTime), N'jayr', CAST(N'2020-03-23 19:45:07.593' AS DateTime))
SET IDENTITY_INSERT [dbo].[pPurchaseOrderUpload] OFF
SET ANSI_PADDING ON

GO
/****** Object:  Index [Username_mUsers]    Script Date: 3/24/2020 9:35:46 PM ******/
ALTER TABLE [dbo].[mUsers] ADD  CONSTRAINT [Username_mUsers] UNIQUE NONCLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[mGeneral] ADD  CONSTRAINT [DF_mGeneralMaster_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[mGeneral] ADD  CONSTRAINT [DF_mGeneralMaster_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[mGeneral] ADD  CONSTRAINT [DF_mGeneralMaster_UpdateDate]  DEFAULT (getdate()) FOR [UpdateDate]
GO
ALTER TABLE [dbo].[mPages] ADD  CONSTRAINT [DF_mPages_ParentOrder]  DEFAULT ((0)) FOR [ParentOrder]
GO
ALTER TABLE [dbo].[mPages] ADD  CONSTRAINT [DF_mPages_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[mPages] ADD  CONSTRAINT [DF_mPagses_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[mPages] ADD  CONSTRAINT [DF_mPagses_UpdateDate]  DEFAULT (getdate()) FOR [UpdateDate]
GO
ALTER TABLE [dbo].[mTypes] ADD  CONSTRAINT [DF_mTypes_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[mTypes] ADD  CONSTRAINT [DF_mTypes_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[mTypes] ADD  CONSTRAINT [DF_mTypes_UpdateDate]  DEFAULT (getdate()) FOR [UpdateDate]
GO
ALTER TABLE [dbo].[mUserPageAccess] ADD  CONSTRAINT [DF_mUserPageAccess_Write]  DEFAULT ((0)) FOR [ReadAndWrite]
GO
ALTER TABLE [dbo].[mUserPageAccess] ADD  CONSTRAINT [DF_mUserPageAccess_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[mUserPageAccess] ADD  CONSTRAINT [DF_mUserPageAccess_UpdateDate]  DEFAULT (getdate()) FOR [UpdateDate]
GO
ALTER TABLE [dbo].[mUsers] ADD  CONSTRAINT [DF_mUsers_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[mUsers] ADD  CONSTRAINT [DF_mUsers_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[mUsers] ADD  CONSTRAINT [DF_mUsers_UpdateDate]  DEFAULT (getdate()) FOR [UpdateDate]
GO
/****** Object:  StoredProcedure [dbo].[CostCenterMaster_Delete]    Script Date: 3/24/2020 9:35:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CostCenterMaster_Delete](
	@ID		varchar(50)
   ,@UpdateID		varchar(50)
   ,@Error			bit OUTPUT
   ,@ErrorMessage	varchar(50) OUTPUT
) AS
BEGIN
	UPDATE mCostCenter
		SET IsDeleted = 1,
			UpdateID = @UpdateID,
			UpdateDate = GETDATE()
		WHERE ID = @ID

	SET @Error = 0
	SET @ErrorMessage = '';
END

				





GO
/****** Object:  StoredProcedure [dbo].[CostCenterMaster_InsertUpdate]    Script Date: 3/24/2020 9:35:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CostCenterMaster_InsertUpdate](
	 @ID int
	,@DepartmentID nvarchar(MAX)
	,@CostCenterCode nvarchar(MAX)
	,@CostCenterName nvarchar(MAX)
    ,@Status bit
	,@IsDeleted bit
	,@CreateID VARCHAR(20)
    ,@Error Bit OUTPUT
    ,@ErrorMessage VARCHAR(50) OUTPUT
	,@EndMsg VARCHAR(50) OUTPUT
) AS
SET NOCOUNT ON
BEGIN 
	DECLARE @UserID AS int;

	IF(@ID = 0)
		BEGIN
			SET @EndMsg = 'saved.'
			IF EXISTS(SELECT [CostCenterName] FROM[dbo].[mCostCenter] WHERE ID = @ID AND IsDeleted = 0)
				BEGIN
					SET @Error = 1
					SET @ErrorMessage = 'Cost Center already exist. Please try again.'
				END
			ELSE IF EXISTS(SELECT [CostCenterName] FROM[dbo].[mCostCenter] WHERE ID = @ID AND IsDeleted = 1)
				BEGIN
					UPDATE [dbo].[mCostCenter]
						SET IsDeleted = '0'
							,DepartmentID = @DepartmentID
							,CostCenterCode = @CostCenterCode
							,CostCenterName = @CostCenterName
						    ,[Status] = @Status 
							,UpdateID = @CreateID
							,UpdateDate = GETDATE()
						WHERE ID = @ID
					SET @Error = 0
					SET @ErrorMessage = ''
				END
			ELSE
				BEGIN
					INSERT INTO [mCostCenter](
						DepartmentID
						,CostCenterCode
						,CostCenterName
					    ,[Status] 
					    ,IsDeleted 
						,CreateID
						,CreateDate
						,UpdateID
						,UpdateDate
					)VALUES(
						@DepartmentID
						,@CostCenterCode
						,@CostCenterName
					    ,@Status
					    ,@IsDeleted
						,@CreateID
						,GETDATE()
						,@CreateID
						,GETDATE()
					)
				END
		END
	ELSE
		BEGIN
			SET @EndMsg = 'updated.'
			UPDATE [mCostCenter] SET
					DepartmentID = @DepartmentID
					,CostCenterCode = @CostCenterCode
					,CostCenterName = @CostCenterName
				    ,[Status] = @Status 
				    ,IsDeleted = @IsDeleted 
					,UpdateID = @CreateID
					,UpdateDate = GETDATE()
			WHERE ID=@ID
		END
	

	SET @Error = 0
    SET @ErrorMessage = ''
END




GO
/****** Object:  StoredProcedure [dbo].[General_Delete]    Script Date: 3/24/2020 9:35:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[General_Delete](
	@ID	varchar(50)
   ,@UpdateID		varchar(10)
   ,@Error			bit OUTPUT
   ,@ErrorMessage	varchar(50) OUTPUT
) AS
BEGIN
	UPDATE mGeneral
		SET IsDeleted = 1,
			UpdateID = @UpdateID,
			UpdateDate = GETDATE()
		WHERE ID = @ID

	SET @Error = 0
	SET @ErrorMessage = '';
END

				





GO
/****** Object:  StoredProcedure [dbo].[General_InsertUpdate]    Script Date: 3/24/2020 9:35:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[General_InsertUpdate](
	 @ID int
	,@TypeID int
	,@Value VARCHAR(255)
	,@CreateID VARCHAR(20)
    ,@Error Bit OUTPUT
    ,@ErrorMessage VARCHAR(50) OUTPUT
	,@EndMsg VARCHAR(50) OUTPUT
) AS
SET NOCOUNT ON
BEGIN 
	SET @Error = 0
	SET @ErrorMessage = ''

	IF(@ID = 0)
		BEGIN
			SET @EndMsg = 'saved.'
			
			IF EXISTS(SELECT [TypeID] FROM[dbo].[mGeneral] WHERE [TypeID] = @TypeID AND Value=@Value AND IsDeleted = 0)
				BEGIN
					SET @Error = 1
					SET @ErrorMessage = 'Type and Value comibination already exists. Please try different value.'
				END
			ELSE IF EXISTS(SELECT [TypeID] FROM[dbo].[mGeneral] WHERE [TypeID] = @TypeID AND Value=@Value AND IsDeleted = 1)
				BEGIN
					UPDATE [dbo].[mGeneral]
						SET IsDeleted = '0',
							UpdateID = @CreateID,
							UpdateDate = GETDATE()
						WHERE [TypeID] = @TypeID AND Value=@Value
					SET @Error = 0
					SET @ErrorMessage = ''
				END
			ELSE
				BEGIN
					INSERT INTO mGeneral(
						 [TypeID]
						,Value
						,CreateID
						,CreateDate
						,UpdateID
						,UpdateDate
					)VALUES(
						 @TypeID
						,@Value
						,@CreateID
						,GETDATE()
						,@CreateID
						,GETDATE()
					)
				END
		END
	ELSE
		BEGIN
			SET @EndMsg = 'updated.'
			UPDATE mGeneral SET
				 [TypeID]=@TypeID
				,Value=@Value
				,UpdateID = @CreateID
				,UpdateDate = GETDATE()
			WHERE ID=@ID
		END
END




GO
/****** Object:  StoredProcedure [dbo].[ItemMaster_Delete]    Script Date: 3/24/2020 9:35:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ItemMaster_Delete](
	@ID		varchar(50)
   ,@UpdateID		varchar(50)
   ,@Error			bit OUTPUT
   ,@ErrorMessage	varchar(50) OUTPUT
) AS
BEGIN
	UPDATE mItemMaster
		SET IsDeleted = 1,
			UpdateID = @UpdateID,
			UpdateDate = GETDATE()
		WHERE ID = @ID

	SET @Error = 0
	SET @ErrorMessage = '';
END

				





GO
/****** Object:  StoredProcedure [dbo].[ItemMaster_InsertUpdate]    Script Date: 3/24/2020 9:35:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ItemMaster_InsertUpdate](
	 @ID int
	,@PartNumber varchar(20)
	,@PartName varchar(255)
	,@Model varchar(255)
	,@Category varchar(255)
	,@UOM varchar(255)
    ,@Status bit
	,@IsDeleted bit
	,@CreateID VARCHAR(20)
    ,@Error Bit OUTPUT
    ,@ErrorMessage VARCHAR(50) OUTPUT
	,@EndMsg VARCHAR(50) OUTPUT
) AS
SET NOCOUNT ON
BEGIN 
	DECLARE @UserID AS int;

	IF(@ID = 0)
		BEGIN
			SET @EndMsg = 'saved.'
			IF EXISTS(SELECT Username FROM[dbo].[mUsers] WHERE Username = @PartNumber AND IsDeleted = 0)
				BEGIN
					SET @Error = 1
					SET @ErrorMessage = 'Part Number already exist. Please try again.'
				END
			ELSE IF EXISTS(SELECT Username FROM[dbo].[mUsers] WHERE Username = @PartNumber AND IsDeleted = 1)
				BEGIN
					UPDATE [dbo].[mItemMaster]
						SET IsDeleted = '0'
							,PartName = @PartName
							,Model = @Model
							,Category = @Category
							, UOM = @UOM
						    ,[Status] = @Status 
							,UpdateID = @CreateID
							,UpdateDate = GETDATE()
						WHERE PartNumber = @PartNumber
					SET @Error = 0
					SET @ErrorMessage = ''
				END
			ELSE
				BEGIN
					INSERT INTO mItemMaster(
						PartNumber
						,PartName
						,Model
						,Category
						,UOM
					    ,[Status] 
					    ,IsDeleted 
						,CreateID
						,CreateDate
						,UpdateID
						,UpdateDate
					)VALUES(
						@PartNumber
						,@PartName
						,@Model
						,@Category
						,@UOM
					    ,@Status
					    ,@IsDeleted
						,@CreateID
						,GETDATE()
						,@CreateID
						,GETDATE()
					)
				END
		END
	ELSE
		BEGIN
			SET @EndMsg = 'updated.'
			UPDATE mItemMaster SET
					PartName = @PartNumber
					,Model = @Model
					,Category = @Category
					,UOM =@UOM
				    ,[Status] = @Status 
				    ,IsDeleted = @IsDeleted 
					,UpdateID = @CreateID
					,UpdateDate = GETDATE()
			WHERE PartNumber=@PartNumber
		END
	

	SET @Error = 0
    SET @ErrorMessage = ''
END




GO
/****** Object:  StoredProcedure [dbo].[LocationMaster_Delete]    Script Date: 3/24/2020 9:35:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[LocationMaster_Delete](
	@ID		varchar(50)
   ,@UpdateID		varchar(50)
   ,@Error			bit OUTPUT
   ,@ErrorMessage	varchar(50) OUTPUT
) AS
BEGIN
	UPDATE mLocation
		SET IsDeleted = 1,
			UpdateID = @UpdateID,
			UpdateDate = GETDATE()
		WHERE ID = @ID

	SET @Error = 0
	SET @ErrorMessage = '';
END

				





GO
/****** Object:  StoredProcedure [dbo].[LocationMaster_InsertUpdate]    Script Date: 3/24/2020 9:35:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[LocationMaster_InsertUpdate](
	 @ID int
	,@Area nvarchar(MAX)
	,@Position nvarchar(MAX)
	,@X int
	,@Y int
	,@Z int
	,@PalletCapacity decimal(18,2)
	,@BoxCapacity decimal(18,2)
    ,@Status bit
	,@IsDeleted bit
	,@CreateID VARCHAR(20)
    ,@Error Bit OUTPUT
    ,@ErrorMessage VARCHAR(50) OUTPUT
	,@EndMsg VARCHAR(50) OUTPUT
) AS
SET NOCOUNT ON
BEGIN 
	DECLARE @UserID AS int;

	IF(@ID = 0)
		BEGIN
			SET @EndMsg = 'saved.'
			IF EXISTS(SELECT [Area] FROM[dbo].[mLocation] WHERE Area = @Area AND Position=@Position AND X=@X AND Y=@Y AND Z=@Z AND IsDeleted = 0)
				BEGIN
					SET @Error = 1
					SET @ErrorMessage = 'Location already exist. Please try again.'
				END
			ELSE IF EXISTS(SELECT [Area] FROM[dbo].[mLocation] WHERE ID = @ID AND IsDeleted = 1)
				BEGIN
					UPDATE [dbo].[mLocation]
						SET IsDeleted = '0'
							,Area = @Area
							,Position = @Position
							,X = @X
							,Y = @Y
							,Z = @Z
							,PalletCapacity = @PalletCapacity
							,BoxCapacity = @BoxCapacity
						    ,[Status] = @Status 
							,UpdateID = @CreateID
							,UpdateDate = GETDATE()
						WHERE ID = @ID
					SET @Error = 0
					SET @ErrorMessage = ''
				END
			ELSE
				BEGIN
					INSERT INTO [mLocation](
						Area
						,Position
						,X
						,Y
						,Z
						,PalletCapacity
						,BoxCapacity
					    ,[Status] 
					    ,IsDeleted 
						,CreateID
						,CreateDate
						,UpdateID
						,UpdateDate
					)VALUES(
						@Area
						,@Position
						,@X
						,@Y
						,@Z
						,@PalletCapacity
						,@BoxCapacity
					    ,@Status
					    ,@IsDeleted
						,@CreateID
						,GETDATE()
						,@CreateID
						,GETDATE()
					)
				END
		END
	ELSE
		BEGIN
			SET @EndMsg = 'updated.'
			UPDATE [mLocation] SET
					Area = @Area
					,Position = @Position
					,X = @X
					,Y = @Y
					,Z = @Z
					,PalletCapacity = @PalletCapacity
					,BoxCapacity = @BoxCapacity
				    ,[Status] = @Status 
				    ,IsDeleted = @IsDeleted 
					,UpdateID = @CreateID
					,UpdateDate = GETDATE()
			WHERE ID=@ID
		END
	

	SET @Error = 0
    SET @ErrorMessage = ''
END




GO
/****** Object:  StoredProcedure [dbo].[Page_Delete]    Script Date: 3/24/2020 9:35:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Page_Delete](
	@PageName		varchar(50)
   ,@UpdateID		varchar(50)
   ,@Error			bit OUTPUT
   ,@ErrorMessage	varchar(50) OUTPUT
) AS
BEGIN
	UPDATE mPages
		SET IsDeleted = 1,
			UpdateID = @UpdateID,
			UpdateDate = GETDATE()
		WHERE PageName = @PageName

	SET @Error = 0
	SET @ErrorMessage = '';
END

				





GO
/****** Object:  StoredProcedure [dbo].[Page_InsertUpdate]    Script Date: 3/24/2020 9:35:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Page_InsertUpdate](
	 @ID int
	,@GroupLabel VARCHAR(50)
	,@PageName VARCHAR(50)
	,@PageLabel VARCHAR(50)
	,@URL VARCHAR(100)
    ,@HasSub int
    ,@ParentMenu VARCHAR(50)
	,@ParentOrder int
    ,@Order int
    ,@Icon VARCHAR(50)
	,@CreateID VARCHAR(20)
    ,@Error Bit OUTPUT
    ,@ErrorMessage VARCHAR(50) OUTPUT
	,@EndMsg VARCHAR(50) OUTPUT
) AS
SET NOCOUNT ON
BEGIN 
	IF(@ID = 0)
	BEGIN
		SET @EndMsg = 'saved.'
		INSERT INTO mPages(
			GroupLabel
			,PageName
			,PageLabel
			,URL
		    ,HasSub
		    ,ParentMenu
			,ParentOrder
		    ,[Order]
		    ,Icon
			,CreateID
            ,CreateDate
            ,UpdateID
            ,UpdateDate
		)VALUES(
			 @GroupLabel
			,@PageName
			,@PageLabel
			,@URL
		    ,@HasSub
		    ,@ParentMenu
			,@ParentOrder
		    ,@Order
		    ,@Icon
			,@CreateID
			,GETDATE()
			,@CreateID
			,GETDATE()
		)
	END

	ELSE
	BEGIN
		SET @EndMsg = 'updated.'
		UPDATE mPages SET
			GroupLabel=@GroupLabel
			,PageName=@PageName
			,PageLabel=@PageLabel
			,URL=@URL
		    ,HasSub=@HasSub
		    ,ParentMenu=@ParentMenu
			,ParentOrder=@ParentOrder
		    ,[Order]=@Order
		    ,Icon=@Icon
            ,UpdateID = @CreateID
            ,UpdateDate = GETDATE()
		WHERE PageName=@PageName

	END

	SET @Error = 0
    SET @ErrorMessage = ''
END




GO
/****** Object:  StoredProcedure [dbo].[pPurchaseOrderUpload_Insert]    Script Date: 3/24/2020 9:35:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE[dbo].[pPurchaseOrderUpload_Insert] (
--DECLARE
     @NoError varchar(200)
    ,@Department varchar(200)
    ,@Vendor_Code varchar(200)
    ,@Vendor_Name varchar(200)
    ,@PO_Issued_Date varchar(200)
    ,@PO_No varchar(200)
	,@PO_Ln_No varchar(200)
    ,@Material varchar(200)
    ,@Material_Description varchar(200)
    ,@Unit varchar(200)
    ,@Requested_Delivery_Date varchar(200)
    ,@PO_Balance varchar(200)
    ,@Cost_Center varchar(200)

    ,@Error Bit OUTPUT
    ,@ErrorMessage VARCHAR(200) OUTPUT
) AS
SET NOCOUNT ON;
	Declare @DepartmentID int,
			@VendorID int,
			@MaterialID int,
			@UnitID int,
			@CostCenterID int

	Set @DepartmentID = (select ID from mGeneral where [Value]=@Department and IsDeleted=0)
	Set @VendorID = (select ID from mSupplier where SupplierCode=@Vendor_Code and IsDeleted=0)
	Set @MaterialID = (select ID from mItemMaster where PartNumber=@Material and IsDeleted=0)
	Set @UnitID = (select ID from mGeneral where [Value]=@Unit and IsDeleted=0)
	Set @CostCenterID = (select ID from mCostCenter where CostCenterCode=@Cost_Center and IsDeleted=0)

    BEGIN
        INSERT INTO [dbo].[pPurchaseOrderUpload]
        (
             Department
            ,Vendor_Code
            ,Vendor_Name
            ,PO_Issued_Date
            ,PO_No
			,PO_Ln_No
            ,Material
            ,Material_Description
            ,Unit
            ,Requested_Delivery_Date
            ,PO_Balance
            ,Cost_Center
			,IsDeleted
        )
        VALUES(
             @DepartmentID
            ,@VendorID
            ,''
            ,@PO_Issued_Date
            ,@PO_No
			,@PO_Ln_No
            ,@MaterialID
            ,''
            ,@UnitID
            ,@Requested_Delivery_Date
            ,@PO_Balance
            ,@CostCenterID
			,0
        )
        SET @Error = 0
        SET @ErrorMessage = ''
    END

GO
/****** Object:  StoredProcedure [dbo].[PurchaseOrder_Delete]    Script Date: 3/24/2020 9:35:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PurchaseOrder_Delete](
	@ID				int
   ,@UpdateID		varchar(50)
   ,@Error			bit OUTPUT
   ,@ErrorMessage	varchar(50) OUTPUT
) AS
BEGIN
	UPDATE pPurchaseOrderUpload
		SET IsDeleted = 1,
			UpdateID = @UpdateID,
			UpdateDate = GETDATE()
		WHERE ID = @ID

	SET @Error = 0
	SET @ErrorMessage = '';
END

				





GO
/****** Object:  StoredProcedure [dbo].[PurchaseOrder_GetList]    Script Date: 3/24/2020 9:35:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PurchaseOrder_GetList]
AS
BEGIN 
	SELECT a.ID
	, b.[value] as Department
	, c.SupplierCode as Vendor_Code
	, c.SupplierName as Vendor_Name
	, a.PO_Issued_Date
	, PO_Ln_No
	, PO_No
	, d.PartNumber as Material
	, d.PartName as Material_Description
	--, e.[Value] as Unit
	, a.Unit
	, a.Requested_Delivery_Date
	, a.PO_Balance
	--, f.CostCenterCode as Cost_Center
	, CONCAT(f.CostCenterCode,'-',f.CostCenterName) as Cost_Center
	, a.IsDeleted 
	FROM [pPurchaseOrderUpload] a 
	left join mGeneral b on a.Department=b.ID 
	left join mSupplier c on a.Vendor_Code=c.ID 
	left join mItemMaster d on a.Material=d.ID 
	left join mGeneral e on a.Unit=e.ID 
	--left join mCostCenter f on a.Cost_Center=f.ID 
	left join mCostCenter f on a.Cost_Center=f.CostCenterCode 
	where a.IsDeleted=0
END




GO
/****** Object:  StoredProcedure [dbo].[PurchaseOrder_GetPurchaseUploadDetails]    Script Date: 3/24/2020 9:35:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PurchaseOrder_GetPurchaseUploadDetails](
	@ID int
)
AS
BEGIN 
	SELECT a.ID
	, a.Department
	, b.[value] as Department_Desc
	, a.Vendor_Code as VendorID
	, c.SupplierCode as Vendor_Code
	, c.SupplierName as Vendor_Name
	, a.PO_Issued_Date
	, PO_Ln_No
	, PO_No
	, a.Material
	, d.PartName as Material_Description
	, a.Unit
	, a.Requested_Delivery_Date
	, a.PO_Balance
	, a.Cost_Center
	, f.CostCenterName as Cost_Center_Desc
	, a.IsDeleted 
	FROM [pPurchaseOrderUpload] a 
	left join mGeneral b on a.Department=b.ID 
	left join mSupplier c on a.Vendor_Code=c.ID 
	left join mItemMaster d on a.Material=d.ID 
	--left join mGeneral e on a.Unit=e.ID 
	--left join mCostCenter f on a.Cost_Center=f.ID 
	left join mCostCenter f on a.Cost_Center=f.CostCenterCode 
	where a.IsDeleted=0 AND a.ID=@ID
END




GO
/****** Object:  StoredProcedure [dbo].[PurchaseOrder_InsertUpdate]    Script Date: 3/24/2020 9:35:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PurchaseOrder_InsertUpdate](
	 @ID int
	,@Department int
	,@Vendor_Code NVARCHAR(20)
	,@PO_Issued_Date date
	,@PO_No varchar(255)
	,@PO_Ln_No int
	,@Material int
	,@Unit varchar(20)
    ,@Requested_Delivery_Date date
	,@PO_Balance decimal(18,2)
	,@Cost_Center nvarchar(20)
	,@CreateID VARCHAR(20)
    ,@Error Bit OUTPUT
    ,@ErrorMessage VARCHAR(50) OUTPUT
	,@EndMsg VARCHAR(50) OUTPUT
) AS
SET NOCOUNT ON
BEGIN 
	DECLARE @UserID AS int;
	SET @Error = 0
	SET @ErrorMessage = ''

	IF(@ID = 0)
		BEGIN
			SET @EndMsg = 'saved.'
			IF EXISTS(SELECT Material FROM[dbo].[pPurchaseOrderUpload] WHERE [PO_No] = @PO_No AND [Material] = @Material AND IsDeleted = 0)
				BEGIN
					SET @Error = 1
					SET @ErrorMessage = 'Part Number already existing under Same PO No. Please try again.'
				END
			ELSE IF EXISTS(SELECT Material FROM[dbo].[pPurchaseOrderUpload] WHERE [PO_No] = @PO_No AND [Material] = @Material AND IsDeleted = 1)
				BEGIN
					UPDATE [dbo].[pPurchaseOrderUpload]
						SET IsDeleted = '0'
							,[Department] = @Department
							,[Vendor_Code] = @Vendor_Code
							,[Vendor_Name] = ''
							,[PO_Issued_Date] = @PO_Issued_Date
							,[PO_Ln_No] = @PO_Ln_No
							,[PO_No] = @PO_No
							,[Material] = @Material
							,[Material_Description] = ''
							,[Unit] = @Unit
							,[Requested_Delivery_Date] = @Requested_Delivery_Date
						    ,[PO_Balance] = @PO_Balance
							,[Cost_Center] = @Cost_Center
							,CreateID = @CreateID
							,CreateDate = GETDATE()
							,UpdateID = @CreateID
							,UpdateDate = GETDATE()
						WHERE [PO_No] = @PO_No AND [Material] = @Material
					SET @Error = 0
					SET @ErrorMessage = ''
				END
			ELSE
				BEGIN
					INSERT INTO [pPurchaseOrderUpload](
						     [IsDeleted]
							,[Department]
							,[Vendor_Code]
							,[Vendor_Name]
							,[PO_Issued_Date]
							,[PO_Ln_No]
							,[PO_No]
							,[Material]
							,[Material_Description]
							,[Unit]
							,[Requested_Delivery_Date]
						    ,[PO_Balance]
							,[Cost_Center]
							,CreateID 
							,CreateDate
							,UpdateID
							,UpdateDate 
					)VALUES(
							'0'
							,@Department
							,@Vendor_Code
							,''
							,@PO_Issued_Date
							,@PO_Ln_No
							,@PO_No
							,@Material
							,''
							,@Unit
							,@Requested_Delivery_Date
						    ,@PO_Balance
							,@Cost_Center
							,@CreateID
							,GETDATE()
							,@CreateID
							,GETDATE()
					)
				END
		END
	ELSE
		BEGIN
			SET @EndMsg = 'updated.'
			UPDATE [dbo].[pPurchaseOrderUpload]
						SET IsDeleted = '0'
							,[Department] = @Department
							,[Vendor_Code] = @Vendor_Code
							,[Vendor_Name] = ''
							,[PO_Issued_Date] = @PO_Issued_Date
							,[PO_Ln_No] = @PO_Ln_No
							,[PO_No] = @PO_No
							,[Material] = @Material
							,[Material_Description] = ''
							,[Unit] = @Unit
							,[Requested_Delivery_Date] = @Requested_Delivery_Date
						    ,[PO_Balance] = @PO_Balance
							,[Cost_Center] = @Cost_Center
							,CreateID = @CreateID
							,CreateDate = GETDATE()
							,UpdateID = @CreateID
							,UpdateDate = GETDATE()
			WHERE [PO_No] = @PO_No AND [Material] = @Material
		END
END




GO
/****** Object:  StoredProcedure [dbo].[Receiving_GetPOItems]    Script Date: 3/24/2020 9:35:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Receiving_GetPOItems](
	@PONO varchar(20)
)
AS
BEGIN 
	SELECT 
		  a.ID
		, b.[value] as Department
		, c.SupplierCode as Vendor_Code
		, c.SupplierName as Vendor_Name
		, a.PO_Issued_Date
		, PO_Ln_No
		, PO_No
		, d.PartNumber as Material
		, d.PartName as Material_Description
		, a.Unit
		, a.Requested_Delivery_Date
		, a.PO_Balance - ISNULL( (Select SUM([Actual_Qty]) FROM pActualReceivingDetails where IsDeleted=0 AND PONo=a.PO_No),0) as PO_Balance
		, CASE 
			WHEN ISNULL((Select SUM([Actual_Qty]) FROM pActualReceivingDetails where IsDeleted=0 AND PONo=a.PO_No),0) > 0 THEN 'True'
			ELSE 'False'
		  END AS HasHistory
		, f.CostCenterCode as Cost_Center
		, a.IsDeleted 
	FROM [pPurchaseOrderUpload] a 
	left join mGeneral b on a.Department=b.ID 
	left join mSupplier c on a.Vendor_Code=c.ID 
	left join mItemMaster d on a.Material=d.ID 
	--left join mGeneral e on a.Unit=e.ID 
	left join mCostCenter f on a.Cost_Center=f.CostCenterCode 
	where a.IsDeleted=0 and a.PO_No=@PONO
END




GO
/****** Object:  StoredProcedure [dbo].[Receiving_POItemsInsertUpdate]    Script Date: 3/24/2020 9:35:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Receiving_POItemsInsertUpdate] (
--DECLARE
	 @PONo			nvarchar(20)
	,@PO_Ln_No		nvarchar(5)
	,@Actual_Qty	int 
	,@Received_Date nvarchar(20)
	,@CreateID 		VARCHAR(20)
)AS
BEGIN
	INSERT [pActualReceivingDetails](
	   [PONo]
      ,[PO_Ln_No]
      ,[Actual_Qty]
      ,[Received_Date]
      ,[IsDeleted]
      ,[CreateID]
      ,[CreateDate]
	)
	
	VALUES (
		  @PONo
		, @PO_Ln_No
		, @Actual_Qty
		, @Received_Date
		, 0
		, @CreateID
		, GETDATE()	
	);

END

GO
/****** Object:  StoredProcedure [dbo].[SupplierMaster_Delete]    Script Date: 3/24/2020 9:35:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SupplierMaster_Delete](
	@ID		varchar(50)
   ,@UpdateID		varchar(50)
   ,@Error			bit OUTPUT
   ,@ErrorMessage	varchar(50) OUTPUT
) AS
BEGIN
	UPDATE mSupplier
		SET IsDeleted = 1,
			UpdateID = @UpdateID,
			UpdateDate = GETDATE()
		WHERE ID = @ID

	SET @Error = 0
	SET @ErrorMessage = '';
END

				





GO
/****** Object:  StoredProcedure [dbo].[SupplierMaster_InsertUpdate]    Script Date: 3/24/2020 9:35:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SupplierMaster_InsertUpdate](
	 @ID int
	,@SupplierCode nvarchar(MAX)
	,@SupplierName nvarchar(MAX)
	,@SupplierAbbrev nvarchar(MAX)
    ,@Status bit
	,@IsDeleted bit
	,@CreateID VARCHAR(20)
    ,@Error Bit OUTPUT
    ,@ErrorMessage VARCHAR(50) OUTPUT
	,@EndMsg VARCHAR(50) OUTPUT
) AS
SET NOCOUNT ON
BEGIN 
	DECLARE @UserID AS int;

	IF(@ID = 0)
		BEGIN
			SET @EndMsg = 'saved.'
			IF EXISTS(SELECT [SupplierName] FROM[dbo].[mSupplier] WHERE ID = @ID AND IsDeleted = 0)
				BEGIN
					SET @Error = 1
					SET @ErrorMessage = 'Supplier already exist. Please try again.'
				END
			ELSE IF EXISTS(SELECT [SupplierName] FROM[dbo].[mSupplier] WHERE ID = @ID AND IsDeleted = 1)
				BEGIN
					UPDATE [dbo].[mSupplier]
						SET IsDeleted = '0'
							,SupplierName = @SupplierName
							,SupplierAbbrev = @SupplierAbbrev
						    ,[Status] = @Status 
							,UpdateID = @CreateID
							,UpdateDate = GETDATE()
						WHERE ID = @ID
					SET @Error = 0
					SET @ErrorMessage = ''
				END
			ELSE
				BEGIN
					INSERT INTO [mSupplier](
						SupplierCode
						,SupplierName
						,SupplierAbbrev
					    ,[Status] 
					    ,IsDeleted 
						,CreateID
						,CreateDate
						,UpdateID
						,UpdateDate
					)VALUES(
						@SupplierCode
						,@SupplierName
						,@SupplierAbbrev
					    ,@Status
					    ,@IsDeleted
						,@CreateID
						,GETDATE()
						,@CreateID
						,GETDATE()
					)
				END
		END
	ELSE
		BEGIN
			SET @EndMsg = 'updated.'
			UPDATE [mSupplier] SET
					SupplierCode = @SupplierCode
					,SupplierName = @SupplierName
					,SupplierAbbrev = @SupplierAbbrev
				    ,[Status] = @Status 
				    ,IsDeleted = @IsDeleted 
					,UpdateID = @CreateID
					,UpdateDate = GETDATE()
			WHERE ID=@ID
		END
	

	SET @Error = 0
    SET @ErrorMessage = ''
END




GO
/****** Object:  StoredProcedure [dbo].[Type_Delete]    Script Date: 3/24/2020 9:35:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Type_Delete](
	@ID	varchar(50)
   ,@UpdateID		varchar(10)
   ,@Error			bit OUTPUT
   ,@ErrorMessage	varchar(50) OUTPUT
) AS
BEGIN
	UPDATE mTypes
		SET IsDeleted = 1,
			UpdateID = @UpdateID,
			UpdateDate = GETDATE()
		WHERE ID = @ID

	SET @Error = 0
	SET @ErrorMessage = '';
END



GO
/****** Object:  StoredProcedure [dbo].[Type_InsertUpdate]    Script Date: 3/24/2020 9:35:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Type_InsertUpdate](
	 @ID int
	,@Type VARCHAR(50)
	,@CreateID VARCHAR(20)
    ,@Error Bit OUTPUT
    ,@ErrorMessage VARCHAR(50) OUTPUT
	,@EndMsg VARCHAR(50) OUTPUT
) AS
SET NOCOUNT ON
BEGIN 
	IF(@ID = 0)
		BEGIN
			SET @EndMsg = 'saved.'
			IF EXISTS(SELECT [Type] FROM[dbo].[mTypes] WHERE [Type] = @Type AND IsDeleted = 1)
				BEGIN
					UPDATE [dbo].[mTypes]
						SET IsDeleted = '0',
							UpdateID = @CreateID,
							UpdateDate = GETDATE()
						WHERE [Type] = @Type
					SET @Error = 0
					SET @ErrorMessage = ''
				END
			ELSE
				BEGIN
					INSERT INTO mTypes(
						 [Type]
						,CreateID
						,CreateDate
						,UpdateID
						,UpdateDate
					)VALUES(
						 @Type
						,@CreateID
						,GETDATE()
						,@CreateID
						,GETDATE()
					)
				END
		END
	ELSE
		BEGIN
			SET @EndMsg = 'updated.'
			UPDATE mTypes SET
				 [Type]=@Type
				,UpdateID = @CreateID
				,UpdateDate = GETDATE()
			WHERE ID=@ID

		END

	SET @Error = 0
    SET @ErrorMessage = ''
END




GO
/****** Object:  StoredProcedure [dbo].[User_Delete]    Script Date: 3/24/2020 9:35:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[User_Delete](
	@Username		varchar(50)
   ,@UpdateID		varchar(50)
   ,@Error			bit OUTPUT
   ,@ErrorMessage	varchar(50) OUTPUT
) AS
BEGIN
	UPDATE mUsers
		SET IsDeleted = 1,
			UpdateID = @UpdateID,
			UpdateDate = GETDATE()
		WHERE Username = @Username

	SET @Error = 0
	SET @ErrorMessage = '';
END

				





GO
/****** Object:  StoredProcedure [dbo].[User_InsertUpdate]    Script Date: 3/24/2020 9:35:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[User_InsertUpdate](
	 @ID int
	,@Username varchar(20)
	,@Password varchar(255)
	,@Email varchar(255)
	,@FirstName varchar(255)
    ,@LastName varchar(255)
    ,@Department varchar(255)
    ,@PostFunction_Approver bit
    ,@Role varchar(255)
	,@CreateID VARCHAR(20)
	,@ReadAndWrite bit
	,@CanDelete bit
    ,@Error Bit OUTPUT
    ,@ErrorMessage VARCHAR(50) OUTPUT
	,@EndMsg VARCHAR(50) OUTPUT
) AS
SET NOCOUNT ON
BEGIN 
	DECLARE @UserID AS int;

	IF(@ID = 0)
		BEGIN
			SET @EndMsg = 'saved.'
			IF EXISTS(SELECT Username FROM[dbo].[mUsers] WHERE Username = @Username AND IsDeleted = 0)
				BEGIN
					SET @Error = 1
					SET @ErrorMessage = 'Username already exist. Please try again.'
				END
			ELSE IF EXISTS(SELECT Username FROM[dbo].[mUsers] WHERE Username = @Username AND IsDeleted = 1)
				BEGIN
					UPDATE [dbo].[mUsers]
						SET IsDeleted = '0'
							,[Password] = @Password
							,Email = @Email
							,FirstName = @FirstName
						    ,LastName = @LastName 
						    ,Department = @Department 
						    ,PostFunction_Approver = @PostFunction_Approver 
						    ,Role = @Role 
							,UpdateID = @CreateID
							,UpdateDate = GETDATE()
						WHERE Username = @Username
					SET @Error = 0
					SET @ErrorMessage = ''
					SET @UserID = (SELECT ID FROM mUsers WHERE Username = @Username)
				END
			ELSE
				BEGIN
					INSERT INTO mUsers(
						Username
						,[Password]
						,Email
						,FirstName 
					    ,LastName 
					    ,Department 
					    ,PostFunction_Approver 
					    ,Role 
						,CreateID
						,CreateDate
						,UpdateID
						,UpdateDate
					)VALUES(
						@Username
						,@Password
						,@Email
						,@FirstName
					    ,@LastName
					    ,@Department
					    ,@PostFunction_Approver
					    ,@Role
						,@CreateID
						,GETDATE()
						,@CreateID
						,GETDATE()
					)
					SET @UserID = @@IDENTITY
				END
		END
	ELSE
		BEGIN
			SET @EndMsg = 'updated.'
			UPDATE mUsers SET
					[Password] = @Password
					,Email = @Email
					,FirstName = @FirstName
				    ,LastName = @LastName 
				    ,Department = @Department 
				    ,PostFunction_Approver = @PostFunction_Approver 
				    ,Role = @Role 
					,UpdateID = @CreateID
					,UpdateDate = GETDATE()
			WHERE Username=@Username
			SET @UserID = @ID
		END


	IF OBJECT_ID('tempdb..#tmpUserPages') IS NOT NULL
	BEGIN
		DROP TABLE #tmpUserPages
	END

	CREATE TABLE #tmpUserPages ([UserID] Int,PageID Int,[Status] bit, ReadAndWrite bit, [Delete] bit,CreateID nvarchar(50), CreateDate datetime, UpdateID nvarchar(50), UpdateDate datetime)

	INSERT INTO #tmpUserPages
	SELECT @UserID, ID, '1', @ReadAndWrite, @CanDelete,@CreateID,GETDATE(),@CreateID,GETDATE() FROM mPages;

	MERGE mUserPageAccess AS TARGET
	USING #tmpUserPages AS SOURCE 
	ON (TARGET.[UserID] = SOURCE.[UserID] AND TARGET.[PageID]=SOURCE.[PageID]) 
	WHEN MATCHED AND (TARGET.[Status] <> SOURCE.[Status] OR TARGET.ReadAndWrite<>SOURCE.ReadAndWrite OR TARGET.[Delete]<>SOURCE.[Delete])
		THEN UPDATE SET TARGET.[Status] = SOURCE.[Status],TARGET.ReadAndWrite=SOURCE.ReadAndWrite,TARGET.[Delete]=SOURCE.[Delete],TARGET.UpdateID=SOURCE.UpdateID,TARGET.UpdateDate=SOURCE.UpdateDate
	WHEN NOT MATCHED BY TARGET 
		THEN INSERT ([UserID], [PageID], [Status], ReadAndWrite,[Delete],CreateID, CreateDate, UpdateID, UpdateDate) 
		VALUES ([UserID], [PageID], [Status], ReadAndWrite,[Delete],@CreateID,GETDATE(),@CreateID,GETDATE());

	SET @Error = 0
    SET @ErrorMessage = ''
END




GO
/****** Object:  StoredProcedure [dbo].[User_Login]    Script Date: 3/24/2020 9:35:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[User_Login](
	 @Username varchar(20),
	 @Password varchar(255)
) AS
SET NOCOUNT ON
BEGIN 
	SELECT a.*, b.Value as DepartmentName FROM [dbo].[mUsers] a
	left join mGeneral b on a.Department=b.ID
	WHERE a.Username = @Username AND a.[Password] = @Password AND a.IsDeleted = 0
END




GO
/****** Object:  StoredProcedure [dbo].[UserPageAccess_GetAccessList]    Script Date: 3/24/2020 9:35:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UserPageAccess_GetAccessList](
	 @ID int
) AS
SET NOCOUNT ON
BEGIN 
	IF(@ID != 0)
	BEGIN
		IF(@ID=2)
			BEGIN
				SELECT P.*, A.* FROM mPages AS P
				LEFT JOIN mUserPageAccess AS A ON P.ID = A.PageID AND A.UserID=@ID
			END
		ELSE
			BEGIN
				SELECT P.*, A.* FROM mPages AS P
				LEFT JOIN mUserPageAccess AS A ON P.ID = A.PageID AND A.UserID=@ID 
				WHERE P.PageName!='Page Master'
			END
	END
END




GO
/****** Object:  StoredProcedure [dbo].[UserPageAccess_INSERT_UPDATE]    Script Date: 3/24/2020 9:35:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UserPageAccess_INSERT_UPDATE](
	 @UserID int
	,@PageID int
	,@Status bit
	,@ReadAndWrite bit
	,@Delete bit
	,@CreateID int
    ,@Error Bit OUTPUT
    ,@ErrorMessage VARCHAR(50) OUTPUT
) AS
SET NOCOUNT ON
BEGIN 
	
	declare @Role as varchar(50)
	declare @NewRole as varchar(50)

	set @Role = (SELECT [Role] from [mUsers] where ID=@UserID)
	if(@Role = 'Administrator' AND (@ReadAndWrite=0 OR @Delete=0))
		begin
			set @NewRole = 'Custom';
		end;
	else if(@Role = 'Encoder' AND (@ReadAndWrite=0 OR @Delete=1))
		begin
			set @NewRole = 'Custom';
		end;
	else if(@Role = 'Viewer' AND (@ReadAndWrite=1 OR @Delete=1))
		begin
			set @NewRole = 'Custom';
		end;

	if(@Role != @NewRole)
		begin
			Update mUsers set [Role] = @NewRole where ID=@UserID;
		end;


	IF EXISTS(SELECT PageID FROM mUserPageAccess WHERE UserID=@UserID and PageID=@PageID)
	BEGIN
		UPDATE mUserPageAccess SET 
            [Status] = @Status,
			ReadAndWrite = @ReadAndWrite,
			[Delete] = @Delete,
            UpdateID = @CreateID,
            UpdateDate = GETDATE()
		WHERE UserID=@UserID AND PageID = @PageID;
	END

	ELSE
	BEGIN
		INSERT INTO mUserPageAccess(
            UserID,
            PageID,
            [Status],
			ReadAndWrite,
			[Delete],
            CreateID,
            CreateDate,
			UpdateID,
			UpdateDate
        )
        VALUES(
            @UserID,
            @PageID,
            @Status,
			@ReadAndWrite,
			@Delete,
            @CreateID,
            GETDATE(),
            @CreateID,
            GETDATE()
        );
	END

	SET @Error = 0
    SET @ErrorMessage = ''
END




GO
/****** Object:  StoredProcedure [dbo].[UserPageAccess_Validate]    Script Date: 3/24/2020 9:35:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UserPageAccess_Validate](
	 @UserID int,
	 @PURL varchar(225),
	 @Error Bit OUTPUT,
     @ErrorMessage VARCHAR(50) OUTPUT
) AS
SET NOCOUNT ON
BEGIN 
	DECLARE @PageCount int;
    
	SET @PageCount =(SELECT COUNT(*) FROM mUserPageAccess AS A 
						LEFT JOIN mPages AS P ON P.ID = A.PageID
						WHERE P.IsDeleted=0  AND A.UserID=@UserID AND CHARINDEX(P.URL,@PURL) > 0 AND A.[Status]=1)
                        
	IF @PageCount = 0 AND @PURL != '/' AND (NOT CHARINDEX('/Profile',@PURL) > 0) 
		BEGIN
			SET @ErrorMessage = 'You don not have access to this page.';
			SET @Error = 1;
		END
    ELSE
		BEGIN
			if(@UserID=2)
				BEGIN
					SELECT P.*, A.ReadAndWrite, A.[Delete] as DeleteEnabled FROM mUserPageAccess AS A 
					LEFT JOIN mPages AS P ON P.ID = A.PageID
					WHERE P.IsDeleted=0  AND A.UserID=@UserID AND  A.[Status]=1
				END
			else
				BEGIN
					SELECT P.*, A.ReadAndWrite, A.[Delete] as DeleteEnabled FROM mUserPageAccess AS A 
					LEFT JOIN mPages AS P ON P.ID = A.PageID
					WHERE P.IsDeleted=0  AND A.UserID=@UserID AND  A.[Status]=1 AND (P.PageName!='Page Master')
				END
			SET @ErrorMessage= '';
			SET @Error = 0;
		END
END




GO
