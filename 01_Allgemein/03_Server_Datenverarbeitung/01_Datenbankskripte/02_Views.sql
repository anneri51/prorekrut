select sqrt(power((ap.address_position_ns - cp.address_position_ns),2) + power((ap.address_position_ew - cp.address_position_ew),2)) * 100 distance, firstname, name, ap.id, cp.id, company
from 
(select * from dbo.applicants where address_position_ns is not null) ap 
,
 (select * from dbo.companies where address_position_ns is not null) cp




USE [combit_Recruiting2]
GO

/****** Object:  View [dbo].[cmbt_View_Dist_Appl_Comp]    Script Date: 09.04.2019 14:56:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[cmbt_View_Dist_Appl_Comp] (abst, id, firstname, name, company)
with schemabinding as
with ds as 
(
select sqrt(power((ap.address_position_ns - cp.address_position_ns),2) + power((ap.address_position_ew - cp.address_position_ew),2)) * 100 abst, ap.id, firstname, name, company
from 
(select id, firstname, name, address_position_ew, address_position_ns from dbo.applicants where address_position_ns is not null) as ap 
,
 (select company, address_position_ew, address_position_ns from dbo.companies where address_position_ns is not null) as cp
 )
 select abst, id, firstname, name, company
  from ds
GO


