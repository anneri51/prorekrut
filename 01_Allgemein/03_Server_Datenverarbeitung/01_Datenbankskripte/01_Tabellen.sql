alter table dbo.applicants add address_position_ns float, address_position_ew float;

alter table dbo.companies add address_position_ns float, address_position_ew float;

create table dbo.Dist_Appl_Comp as
select *
into dbo.dist_appl_comp
from cmbt_view_dist_appl_comp