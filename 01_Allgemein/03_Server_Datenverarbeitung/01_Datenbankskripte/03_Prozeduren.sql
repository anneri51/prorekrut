USE [combit_Recruiting2]
GO

/****** Object:  StoredProcedure [dbo].[cmbt_sp_Convert2NChar]    Script Date: 09.04.2019 18:11:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[cmbt_sp_get_dist_appl_comp] (
   @p_appl_id nvarchar(400), 
   @p_comp_id nvarchar(400),
   @rad integer 
   )
AS
BEGIN

   
   
          with ds as 
			(
			 select sqrt(power((ap.address_position_ns - cp.address_position_ns),2) + 
			             power((ap.address_position_ew - cp.address_position_ew),2)) * 100 abst, ap.id, firstname, name, company, cp.id, ap.address_position_ns ap_ns, ap.address_position_ew ap_ew, cp.address_position_ns cp_ns, cp.address_position_ew cp_ew, org_type, org_type_de, org_type_en
			  from 
			    (
				  select id, firstname, name, address_position_ew, address_position_ns  2 org_type, 'applicant' org_type_en, 'Kandidat' org_type_de
				  from dbo.applicants 
				  where address_position_ns is not null
				) as ap 
			              ,
				(
				 select id,  company descr, address_position_ew, address_position_ns , 3 org_type, 'company' org_type_en, 'Firma' org_type_de
				 from dbo.companies 
				 where address_position_ns is not null
				 ) as cp
			),
			abst as (
			      	 select ID, ORG_TYPE_NO, COORD_NS, COORD_EW,DESCR, ORG_TYPE_EN, ORG_TYPE_DE
					 from ds
				      where (abst <= @p_rad or @p_rad is null)
					    and (comp_id = @p_comp_id or @p_comp_id is null)
						and (appl_id = @p_appl_id or @p_appl_id is null)
				)
			select distinct *
			INTO dbo. DIST_APPL_COMP
			from abstr
			union
			select distinct *
			INTO dbo. DIST_APPL_COMP
			from abstr;

   
/*
	-- BEGIN drop all indexes from the table (not PK indexes)
	DECLARE index_cursor CURSOR FOR
	select object_name(id), name
	from sysindexes
	where indid <> 1 AND indid <> 255 AND object_name(id) = @TableName
	DECLARE @table varchar(200), @indexname varchar(200)
	OPEN index_cursor
	FETCH NEXT FROM index_cursor INTO @table, @indexname
	DECLARE @Query nvarchar(500)
	WHILE @@FETCH_STATUS = 0 -- while FETCH statement is successful
	BEGIN
		IF LEFT(@indexname, 3)<> '_WA'
		BEGIN
			SET @Query = 'DROP INDEX ' + @table + '.' + @indexname
			IF @Query <> ''
			BEGIN
				exec sp_executesql @Query
				PRINT 'DROPPED INDEX --> ' + @Query
			END
		END 
		
		-- go to next 
		FETCH NEXT FROM index_cursor
		INTO @table, @indexname
	END
	CLOSE index_cursor
	DEALLOCATE index_cursor
	-- END drop all indexes from the table
	-- BEGIN Get the PKs for the table
	DECLARE @PKName varchar(100), @PKSum varchar(1000)
	DECLARE pk_cursor CURSOR FOR
	Select COLUMN_NAME
	FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
	WHERE TABLE_NAME = @TableName
	OPEN pk_cursor
	FETCH NEXT FROM pk_cursor
	INTO @PKName
	SET @PKSum = '' -- initialize once
	WHILE @@FETCH_STATUS = 0 -- while FETCH statement is successful
	BEGIN
		SET @PKSum = @PKSum + @PKName + ';'
		-- go to next 
		FETCH NEXT FROM pk_cursor
		INTO @PKName
	END
	CLOSE pk_cursor
	DEALLOCATE pk_cursor
	-- END Get the PKs for the table
	
	*/
END

GO

    with ds as 
			(
			 select sqrt(power((ap.address_position_ns - cp.address_position_ns),2) + 
			             power((ap.address_position_ew - cp.address_position_ew),2)) * 100 abst, ap.id appl_id,  ap.descr ap_descr, cp.id, ap.address_position_ns ap_ns, ap.address_position_ew ap_ew, cp.address_position_ns cp_ns, cp.address_position_ew cp_ew, ap.org_type ap_org_type, ap.org_type_de ap_org_type_de, ap.org_type_en ap_org_type_en, cp.descr cp_descr, cp.org_type cp_org_type, cp.org_type_en cp_org_type_en, cp.org_type_de cp_org_type_de, cp.id comp_id,  row_number() over (order by (select null))  rnr_all
			  from 
			    (
				  select id, firstname + ' ' + name descr, address_position_ew, address_position_ns,  2 org_type, 'applicant' org_type_en, 'Kandidat' org_type_de
				  from dbo.applicants 				  
				  where address_position_ns is not null
				  and (id in ('61CE096A-E353-A247-AEA7-00069391CEBF',
						'54EE9537-71A1-1542-ACBE-00093313B43D',
                          '2901A59F-B337-BE4E-AA5A-000B0A549DB2') or '61CE096A-E353-A247-AEA7-00069391CEBF'  is null)
				) as ap 
			              ,
				(
				 select id,  company descr, address_position_ew, address_position_ns , 3 org_type, 'company' org_type_en, 'Firma' org_type_de
				 from dbo.companies 
				 where address_position_ns is not null
				  and (id = null or null is null)
				 ) as cp
			),
			abst as (
			      	 select appl_ID, ap_ORG_TYPE, ap_NS, ap_EW,ap_DESCR, ap_ORG_TYPE_EN, ap_ORG_TYPE_DE, comp_id,  cp_ns, cp_ew, cp_descr ,
					 cp_org_type, cp_org_type_de, cp_org_type_en
					 from ds
				      where (abst <= 30 or 30 is null)
					    
						 
				)
			select distinct appl_ID, ap_ORG_TYPE, ap_NS, ap_EW,ap_DESCR, ap_ORG_TYPE_EN, ap_ORG_TYPE_DE, appl_ID
		--	INTO dbo. DIST_APPL_COMP
			from abst
			where ap_org_type = 2
			union
			select comp_id, cp_org_type, cp_ns, cp_ew, cp_descr, cp_org_type_en, cp_org_type_de, appl_id			
			from abst
			where cp_org_type = 3;

			USE [combit_Recruiting2]
GO

USE [combit_Recruiting2]
GO

USE [combit_Recruiting2]
GO

/****** Object:  StoredProcedure [dbo].[cmbt_sp_get_dist_appl_comp]    Script Date: 10.04.2019 15:02:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO







ALTER  PROCEDURE [dbo].[cmbt_sp_get_dist_appl_comp] (
   @p_appl_id nvarchar(400), 
   @p_comp_id nvarchar(400),
   @rad integer 
   )
AS
BEGIN

       drop table dbo.DIST_APPL_COMP;
   
       with ds as 
			(
			 select sqrt(power((ap.address_position_ns - cp.address_position_ns),2) + 
			             power((ap.address_position_ew - cp.address_position_ew),2)) * 100 abst, ap.id appl_id,  ap.descr ap_descr, cp.id, ap.address_position_ns ap_ns, ap.address_position_ew ap_ew, cp.address_position_ns cp_ns, cp.address_position_ew cp_ew, ap.org_type ap_org_type, ap.org_type_de ap_org_type_de, ap.org_type_en ap_org_type_en, cp.descr cp_descr, cp.org_type cp_org_type, cp.org_type_en cp_org_type_en, cp.org_type_de cp_org_type_de, cp.id comp_id,  row_number() over (order by (select null))  rnr_all, rnr_appl
			  from 
			    (
				  select id, firstname + ' ' + name descr, address_position_ew, address_position_ns,  2 org_type, 'applicant' org_type_en, 'Kandidat' org_type_de, row_number() over (order by (select null)) rnr_appl
				  from dbo.applicants 				  
				  where address_position_ns is not null
				  and (id in ('61CE096A-E353-A247-AEA7-00069391CEBF',
						'54EE9537-71A1-1542-ACBE-00093313B43D',
                          '2901A59F-B337-BE4E-AA5A-000B0A549DB2') or '61CE096A-E353-A247-AEA7-00069391CEBF'  is null)
				) as ap 
			              ,
				(
				 select id,  company descr, address_position_ew, address_position_ns , 3 org_type, 'company' org_type_en, 'Firma' org_type_de
				 from dbo.companies 
				 where address_position_ns is not null
				  and (id = null or null is null)
				 ) as cp
			),
			abst as (
			      	 select appl_ID, ap_ORG_TYPE, ap_NS, ap_EW,ap_DESCR, ap_ORG_TYPE_EN, ap_ORG_TYPE_DE, comp_id,  cp_ns, cp_ew, cp_descr  + ' ' + convert(nvarchar,round(abst,2)) cp_descr ,
					 cp_org_type, cp_org_type_de, cp_org_type_en, abst, rnr_appl
					 from ds
				     -- where (abst <= 50 or 30 is null)
					    
						 
				),
			un as (
			select distinct appl_ID id, ap_ORG_TYPE org_type, ap_NS address_Position_ns, ap_EW address_Position_ew,ap_DESCR descr, ap_ORG_TYPE_EN org_type_en, ap_ORG_TYPE_DE org_type_de, appl_ID appl_id_all,0 abst, rnr_appl
		--	INTO dbo. DIST_APPL_COMP
			from abst
			where ap_org_type = 2
			union
			select comp_id, cp_org_type, cp_ns, cp_ew, cp_descr, cp_org_type_en, cp_org_type_de, appl_id	, abst	, rnr_appl	
			from abst
			where cp_org_type = 3
			)
			select un.*
			into dbo.DIST_APPL_COMP
			from un;

   
/*
	-- BEGIN drop all indexes from the table (not PK indexes)
	DECLARE index_cursor CURSOR FOR
	select object_name(id), name
	from sysindexes
	where indid <> 1 AND indid <> 255 AND object_name(id) = @TableName
	DECLARE @table varchar(200), @indexname varchar(200)
	OPEN index_cursor
	FETCH NEXT FROM index_cursor INTO @table, @indexname
	DECLARE @Query nvarchar(500)
	WHILE @@FETCH_STATUS = 0 -- while FETCH statement is successful
	BEGIN
		IF LEFT(@indexname, 3)<> '_WA'
		BEGIN
			SET @Query = 'DROP INDEX ' + @table + '.' + @indexname
			IF @Query <> ''
			BEGIN
				exec sp_executesql @Query
				PRINT 'DROPPED INDEX --> ' + @Query
			END
		END 
		
		-- go to next 
		FETCH NEXT FROM index_cursor
		INTO @table, @indexname
	END
	CLOSE index_cursor
	DEALLOCATE index_cursor
	-- END drop all indexes from the table
	-- BEGIN Get the PKs for the table
	DECLARE @PKName varchar(100), @PKSum varchar(1000)
	DECLARE pk_cursor CURSOR FOR
	Select COLUMN_NAME
	FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
	WHERE TABLE_NAME = @TableName
	OPEN pk_cursor
	FETCH NEXT FROM pk_cursor
	INTO @PKName
	SET @PKSum = '' -- initialize once
	WHILE @@FETCH_STATUS = 0 -- while FETCH statement is successful
	BEGIN
		SET @PKSum = @PKSum + @PKName + ';'
		-- go to next 
		FETCH NEXT FROM pk_cursor
		INTO @PKName
	END
	CLOSE pk_cursor
	DEALLOCATE pk_cursor
	-- END Get the PKs for the table
	
	*/
END

GO






