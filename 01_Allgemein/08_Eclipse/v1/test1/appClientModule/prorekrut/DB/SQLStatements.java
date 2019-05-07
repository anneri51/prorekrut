package prorekrut.DB;

public class SQLStatements {
	
	//Sql-Statements
	public static String qysel1 = "Select id , name, firstname from dbo.Applicants  where 1=1 ";
	public static String qysel2 = "SELECT [appl_id_all] ,[rnr_appl]  ,[descr] FROM [dbo].[DIST_APPL_COMP] where org_type =2  group by [appl_id_all] ,[rnr_appl]   ,[descr] ";
	public static String qyexss1 = "Declare @execution_id bigint\r\n" + 
			"EXEC [SSISDB].[catalog].[create_execution] @package_name=N'03_Abstandsermittlung 1.dtsx', @execution_id=@execution_id OUTPUT, @folder_name=N'Datenimport', @project_name=N'Datenimport', @use32bitruntime=False, @reference_id=Null, @runinscaleout=False\r\n" + 
			"Select @execution_id\r\n" + 
			"DECLARE @var0 int = 43\r\n" + 
			"EXEC [SSISDB].[catalog].[set_execution_parameter_value] @execution_id,  @object_type=30, @parameter_name=N'Appl_rnr', @parameter_value=@var0\r\n" + 
			"DECLARE @var1 int = 5\r\n" + 
			"EXEC [SSISDB].[catalog].[set_execution_parameter_value] @execution_id,  @object_type=30, @parameter_name=N'Umkreis_Radius', @parameter_value=@var1\r\n" + 
			"DECLARE @var2 smallint = 1\r\n" + 
			"EXEC [SSISDB].[catalog].[set_execution_parameter_value] @execution_id,  @object_type=50, @parameter_name=N'LOGGING_LEVEL', @parameter_value=@var2\r\n" + 
			"EXEC [SSISDB].[catalog].[start_execution] @execution_id\r\n" + 
			"GO\r\n" + 
			"";
	
	//Error Messages
	public static  String er1 = "The following error has occured: " ;
	public static  String er2 = "Not Connected to Database";
	public static  String er3 = "Failed to Connect to Database";
	public static  String er4 = "Error Connection";

}
