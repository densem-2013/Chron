USE [Chronicler]
GO
/****** Object:  User [chronciler]    Script Date: 04/12/2012 16:13:43 ******/
CREATE USER [chronciler] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[chronciler]
GO
/****** Object:  Schema [chronciler]    Script Date: 04/12/2012 16:13:43 ******/
CREATE SCHEMA [chronciler] AUTHORIZATION [chronciler]
GO
/****** Object:  Table [dbo].[property_definition]    Script Date: 04/12/2012 16:13:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[property_definition](
	[property_definition_id] [numeric](12, 0) NOT NULL,
	[property_definition_name] [nvarchar](1000) NULL,
	[property_definition_descr] [nvarchar](1000) NULL,
	[property_type_id] [numeric](12, 0) NOT NULL,
 CONSTRAINT [XPKPROPERTY_DEFINITION] PRIMARY KEY NONCLUSTERED 
(
	[property_definition_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[property_collection_source]    Script Date: 04/12/2012 16:13:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[property_collection_source](
	[collection_source_id] [numeric](12, 0) NOT NULL IDENTITY(1,1),
	[source_refresh_interval] [numeric](12, 0) NOT NULL,
	[source_description] [nvarchar](1000) NULL,
	[source_group_name] [nvarchar](1000) NULL,
	[source_is_active] [numeric](1, 0) NULL,
	[source_server_id] [varchar](250) NULL,
 CONSTRAINT [PK_PROPERT_GROUP] PRIMARY KEY NONCLUSTERED 
(
	[collection_source_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[equipment_class]    Script Date: 04/12/2012 16:13:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[equipment_class](
	[equipment_class_id] [numeric](12, 0) NOT NULL,
	[equipment_class_name] [nvarchar](1000) NULL,
 CONSTRAINT [XPKequipment_class] PRIMARY KEY NONCLUSTERED 
(
	[equipment_class_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[department_class]    Script Date: 04/12/2012 16:13:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[department_class](
	[department_class_id] [numeric](12, 0) NOT NULL,
	[department_class_name] [nvarchar](1000) NULL,
 CONSTRAINT [XPKdepartment_class] PRIMARY KEY NONCLUSTERED 
(
	[department_class_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[property_type]    Script Date: 04/12/2012 16:13:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[property_type](
	[property_type_id] [numeric](12, 0) NOT NULL,
	[property_type_name] [nvarchar](1000) NULL,
	[property_type_description] [nvarchar](1000) NULL,
 CONSTRAINT [XPKPROPERTY_TYPE] PRIMARY KEY NONCLUSTERED 
(
	[property_type_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[property_storage_group]    Script Date: 04/12/2012 16:13:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[property_storage_group](
	[property_storage_group_id] [numeric](12, 0) NOT NULL,
	[storage_group_time] [numeric](18, 0) NULL,
	[storage_group_is_historical] [numeric](1, 0) NULL,
	[storage_group_description] [nvarchar](1000) NULL,
 CONSTRAINT [XPKproperty_storage_group] PRIMARY KEY NONCLUSTERED 
(
	[property_storage_group_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Default [dbo].[Default_Value_494]    Script Date: 04/12/2012 16:13:43 ******/
/****** Object:  Default [dbo].[Default_Value_494]    Script Date: 12/07/2009 15:53:54 ******/
CREATE DEFAULT [dbo].[Default_Value_494]
	AS '01-jan-9999'
GO
/****** Object:  Default [dbo].[Default_Value_439]    Script Date: 04/12/2012 16:13:43 ******/
/****** Object:  Default [dbo].[Default_Value_439]    Script Date: 12/07/2009 15:53:54 ******/
-- Batch submitted through debugger: SQLQuery1.sql|0|0|c:\temp\~vs494.sql

CREATE DEFAULT [dbo].[Default_Value_439]
	AS '0'
GO
/****** Object:  Table [dbo].[equipment_class_dep]    Script Date: 04/12/2012 16:13:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[equipment_class_dep](
	[equipment_dependency_id] [numeric](12, 0) NOT NULL,
	[equipment_class_id] [numeric](12, 0) NOT NULL,
	[equipment_class_parent_id] [numeric](12, 0) NOT NULL,
 CONSTRAINT [XPKequipment_class_dep] PRIMARY KEY NONCLUSTERED 
(
	[equipment_dependency_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[department_class_dep]    Script Date: 04/12/2012 16:13:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[department_class_dep](
	[dependency_id] [numeric](12, 0) NOT NULL,
	[department_class_id] [numeric](12, 0) NOT NULL,
	[department_class_parent_id] [numeric](12, 0) NOT NULL,
 CONSTRAINT [XPKdepartment_class_dep] PRIMARY KEY NONCLUSTERED 
(
	[dependency_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[department]    Script Date: 04/12/2012 16:13:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[department](
	[department_id] [numeric](12, 0) NOT NULL,
	[department_name] [nvarchar](1000) NULL,
	[department_class_id] [numeric](12, 0) NULL,
	[department_description] [nvarchar](1000) NULL,
	[department_parent_id] [numeric](12, 0) NULL,
 CONSTRAINT [XPKdepartment] PRIMARY KEY NONCLUSTERED 
(
	[department_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[equipment]    Script Date: 04/12/2012 16:13:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[equipment](
	[equipment_id] [numeric](12, 0) NOT NULL,
	[equipment_name] [nvarchar](max) NULL,
	[equipment_class_id] [numeric](12, 0) NULL,
	[equipment_descriprion] [nvarchar](1000) NULL,
	[equipment_parent_id] [numeric](12, 0) NULL,
	[department_id] [numeric](12, 0) NULL,
 CONSTRAINT [XPKequipment] PRIMARY KEY NONCLUSTERED 
(
	[equipment_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[pr_chronicler_get_equipment_tree]    Script Date: 04/12/2012 16:13:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[pr_chronicler_get_equipment_tree]
    @i_department_id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
WITH tree (name, id, level, pathstr, parent_path)
AS (SELECT equipment_name, equipment_id, 0, 
         CAST(equipment_id AS NVARCHAR(MAX)),  
          CAST('' AS NVARCHAR(MAX)) 
     FROM equipment 
     WHERE equipment_parent_id IS NULL and department_id=@i_department_id
     UNION ALL 
     SELECT equipment_name, equipment_id, t.level + 1, 
            t.pathstr + ',' +CAST(V.equipment_id AS NVARCHAR(MAX)),
            t.parent_path  + CAST(V.equipment_parent_id AS NVARCHAR(MAX)) + '/'
     FROM equipment V 
         INNER JOIN tree t 
             ON t.id = V.equipment_parent_id) 
SELECT name, id, level, pathstr  , parent_path 
FROM tree 
ORDER BY pathstr,id
END
GO
/****** Object:  Table [dbo].[property]    Script Date: 04/12/2012 16:13:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[property](
	[property_id] [numeric](12, 0) IDENTITY(1,1) NOT NULL,
	[property_name] [nvarchar](1000) NOT NULL,
	[string_value] [nvarchar](1000) NULL,
	[integer_value] [numeric](38, 0) NULL,
	[boolean_value] [numeric](1, 0) NULL,
	[double_value] [float] NULL,
	[date_value] [datetime] NULL,
	[tag_name] [nvarchar](1000) NOT NULL,
	[last_update_date] [datetime] NOT NULL,
	[property_definition_id] [numeric](12, 0) NOT NULL,
	[collection_source_id] [numeric](12, 0) NOT NULL,
	[equipment_id] [numeric](12, 0) NOT NULL,
	[property_storage_group_id] [numeric](12, 0) NOT NULL,
	[property_value_type_id] [numeric](18, 0) NULL,
 CONSTRAINT [XPKPROPERTY] PRIMARY KEY NONCLUSTERED 
(
	[property_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[PR_PROPERTY_INSERT]    Script Date: 04/12/2012 16:13:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[PR_PROPERTY_INSERT] 
	-- Add the parameters for the stored procedure here
--	<@Param1, sysname, @p1> <Datatype_For_Param1, , int> = <Default_Value_For_Param1, , 0>, 
--	<@Param2, sysname, @p2> <Datatype_For_Param2, , int> = <Default_Value_For_Param2, , 0>
    @i_tag_name nvarchar(250),
    @i_property_name nvarchar(250),
    @i_property_value_type_id numeric
AS
BEGIN
  INSERT INTO property
  (tag_name, property_name, property_value_type_id, property_storage_group_id, collection_source_id, last_update_date, property_definition_id, equipment_id)
  VALUES
  (@i_tag_name, @i_property_name, @i_property_value_type_id, 1 ,2, '1999.01.01', 1, 1)

END
GO
/****** Object:  Table [dbo].[property_history]    Script Date: 04/12/2012 16:13:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[property_history](
	[property_history_id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[status] [numeric](18, 0) NOT NULL,
	[property_id] [numeric](12, 0) NOT NULL,
	[string_value] [nvarchar](1000) NULL,
	[integer_value] [numeric](38, 0) NULL,
	[boolean_value] [numeric](1, 0) NULL,
	[double_value] [float] NULL,
	[date_value] [datetime] NULL,
	[start_date] [datetime] NOT NULL,
	[finish_date] [datetime] NOT NULL,
 CONSTRAINT [PK_PROPERTY_HISTORY] PRIMARY KEY NONCLUSTERED 
(
	[property_history_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[pr_get_equipment]    Script Date: 04/12/2012 16:13:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[pr_get_equipment]
 (    @i_equipment_id int)
 AS
BEGIN TRY
begin transaction 

SELECT  [property_id]
      ,[property_name]
      ,[string_value]
      ,[integer_value]
      ,[boolean_value]
      ,[double_value]
      ,[date_value]
      ,[tag_name]
      ,[last_update_date]
      ,[property_definition_id]
      ,[collection_source_id]
      ,[equipment_id]
      ,[property_storage_group_id]
      ,[property_value_type_id]
  FROM [dbo].[property]
  where equipment_id =  @i_equipment_id
commit transaction;
END 
TRY
begin catch
 rollback transaction
end catch
GO
/****** Object:  StoredProcedure [dbo].[FN_PROPERTY_UPDATE2]    Script Date: 04/12/2012 16:13:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE  [dbo].[FN_PROPERTY_UPDATE2] (
        @i_property_id          int,
        @i_last_update_date     CHAR(23),
        @i_current_date         CHAR(23),
--        @i_property_type_id     int,
        @i_old_string_value     NVARCHAR(2000),
        @i_new_string_value     NVARCHAR(2000),
        @i_old_integer_value    bigint,
        @i_new_integer_value    bigint,
        @i_old_boolean_value    numeric,
        @i_new_boolean_value    numeric,
        @i_old_double_value     FLOAT,
        @i_new_double_value     FLOAT,
        @i_old_date_value       CHAR(23),   
        @i_new_date_value       CHAR(23))   

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
 	UPDATE property
	set string_value=@i_new_string_value,
        integer_value=@i_new_integer_value,
		boolean_value=@i_new_boolean_value,
		double_value=@i_new_double_value,
		date_value= convert(datetime, @i_new_date_value, 121),
		last_update_date=   convert(datetime, @i_current_date, 121)
	
    where property_id=@i_property_id;
    
    
    INSERT INTO property_history
    (
     property_id,
     string_value,
     integer_value,
     boolean_value,
     double_value,
     date_value,
     start_date,
     finish_date,
     status
--     property_type_id
     )
    VALUES
    ( 
     @i_property_id, 
     @i_old_string_value,
     @i_old_integer_value,
     @i_old_boolean_value,
     @i_old_double_value,
     convert(datetime, @i_old_date_value, 121),
     convert(datetime, @i_last_update_date, 121),
     convert(datetime, @i_current_date, 121),
     1 -- status
     
 --    @i_property_type_id
 );

END
GO
/****** Object:  StoredProcedure [dbo].[pr_get_equipment_history]    Script Date: 04/12/2012 16:13:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[pr_get_equipment_history]
 (    @i_property_id as int,
	  @i_start_time as Datetime,
	  @i_finifh_time as Datetime
 )
 AS
BEGIN TRY
begin transaction 

SELECT ph.[property_history_id]
      ,ph.[status]
      ,ph.[property_id]
      ,ph.[string_value]
      ,ph.[integer_value]
      ,ph.[boolean_value]
      ,ph.[double_value]
      ,ph.[date_value]
      ,ph.[start_date]
      ,ph.[finish_date]
      ,p.property_name
      ,e.equipment_name
  FROM [dbo].[property_history] ph
 inner join [property] p on (p.property_id  = ph.property_id)
 inner join equipment e on (e.equipment_id  = p.equipment_id)
  where p.property_id =  @i_property_id
  and ph.[start_date] >= @i_start_time   
  and ph.[finish_date] <= @i_finifh_time
commit transaction;
END 
TRY
begin catch
 rollback transaction
end catch
GO
/****** Object:  Default [DF_property_last_update_date]    Script Date: 04/12/2012 16:13:32 ******/
ALTER TABLE [dbo].[property] ADD  CONSTRAINT [DF_property_last_update_date]  DEFAULT ('1900.01.01') FOR [last_update_date]
GO
/****** Object:  ForeignKey [R_21]    Script Date: 04/12/2012 16:13:32 ******/
ALTER TABLE [dbo].[department]  WITH CHECK ADD  CONSTRAINT [R_21] FOREIGN KEY([department_parent_id])
REFERENCES [dbo].[department] ([department_id])
GO
ALTER TABLE [dbo].[department] CHECK CONSTRAINT [R_21]
GO
/****** Object:  ForeignKey [R_22]    Script Date: 04/12/2012 16:13:32 ******/
ALTER TABLE [dbo].[department]  WITH CHECK ADD  CONSTRAINT [R_22] FOREIGN KEY([department_class_id])
REFERENCES [dbo].[department_class] ([department_class_id])
GO
ALTER TABLE [dbo].[department] CHECK CONSTRAINT [R_22]
GO
/****** Object:  ForeignKey [R_24]    Script Date: 04/12/2012 16:13:32 ******/
ALTER TABLE [dbo].[department_class_dep]  WITH CHECK ADD  CONSTRAINT [R_24] FOREIGN KEY([department_class_id])
REFERENCES [dbo].[department_class] ([department_class_id])
GO
ALTER TABLE [dbo].[department_class_dep] CHECK CONSTRAINT [R_24]
GO
/****** Object:  ForeignKey [R_25]    Script Date: 04/12/2012 16:13:32 ******/
ALTER TABLE [dbo].[department_class_dep]  WITH CHECK ADD  CONSTRAINT [R_25] FOREIGN KEY([department_class_parent_id])
REFERENCES [dbo].[department_class] ([department_class_id])
GO
ALTER TABLE [dbo].[department_class_dep] CHECK CONSTRAINT [R_25]
GO
/****** Object:  ForeignKey [R_18]    Script Date: 04/12/2012 16:13:32 ******/
ALTER TABLE [dbo].[equipment]  WITH CHECK ADD  CONSTRAINT [R_18] FOREIGN KEY([equipment_parent_id])
REFERENCES [dbo].[equipment] ([equipment_id])
GO
ALTER TABLE [dbo].[equipment] CHECK CONSTRAINT [R_18]
GO
/****** Object:  ForeignKey [R_20]    Script Date: 04/12/2012 16:13:32 ******/
ALTER TABLE [dbo].[equipment]  WITH CHECK ADD  CONSTRAINT [R_20] FOREIGN KEY([department_id])
REFERENCES [dbo].[department] ([department_id])
GO
ALTER TABLE [dbo].[equipment] CHECK CONSTRAINT [R_20]
GO
/****** Object:  ForeignKey [R_23]    Script Date: 04/12/2012 16:13:32 ******/
ALTER TABLE [dbo].[equipment]  WITH CHECK ADD  CONSTRAINT [R_23] FOREIGN KEY([equipment_class_id])
REFERENCES [dbo].[equipment_class] ([equipment_class_id])
GO
ALTER TABLE [dbo].[equipment] CHECK CONSTRAINT [R_23]
GO
/****** Object:  ForeignKey [R_26]    Script Date: 04/12/2012 16:13:32 ******/
ALTER TABLE [dbo].[equipment_class_dep]  WITH CHECK ADD  CONSTRAINT [R_26] FOREIGN KEY([equipment_class_id])
REFERENCES [dbo].[equipment_class] ([equipment_class_id])
GO
ALTER TABLE [dbo].[equipment_class_dep] CHECK CONSTRAINT [R_26]
GO
/****** Object:  ForeignKey [R_27]    Script Date: 04/12/2012 16:13:32 ******/
ALTER TABLE [dbo].[equipment_class_dep]  WITH CHECK ADD  CONSTRAINT [R_27] FOREIGN KEY([equipment_class_parent_id])
REFERENCES [dbo].[equipment_class] ([equipment_class_id])
GO
ALTER TABLE [dbo].[equipment_class_dep] CHECK CONSTRAINT [R_27]
GO
/****** Object:  ForeignKey [FK_PROPERTY_GROUP]    Script Date: 04/12/2012 16:13:32 ******/
ALTER TABLE [dbo].[property]  WITH CHECK ADD  CONSTRAINT [FK_PROPERTY_GROUP] FOREIGN KEY([collection_source_id])
REFERENCES [dbo].[property_collection_source] ([collection_source_id])
GO
ALTER TABLE [dbo].[property] CHECK CONSTRAINT [FK_PROPERTY_GROUP]
GO
/****** Object:  ForeignKey [R_28]    Script Date: 04/12/2012 16:13:32 ******/
ALTER TABLE [dbo].[property]  WITH CHECK ADD  CONSTRAINT [R_28] FOREIGN KEY([equipment_id])
REFERENCES [dbo].[equipment] ([equipment_id])
GO
ALTER TABLE [dbo].[property] CHECK CONSTRAINT [R_28]
GO
/****** Object:  ForeignKey [FK_PROPERTY_ID2]    Script Date: 04/12/2012 16:13:32 ******/
ALTER TABLE [dbo].[property_history]  WITH CHECK ADD  CONSTRAINT [FK_PROPERTY_ID2] FOREIGN KEY([property_id])
REFERENCES [dbo].[property] ([property_id])
GO
ALTER TABLE [dbo].[property_history] CHECK CONSTRAINT [FK_PROPERTY_ID2]
GO
