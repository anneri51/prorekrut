
package prorekrut.DB;

import java.sql.*;
import javax.swing.table.AbstractTableModel;

public class DBUtilities extends AbstractTableModel {

    Connection connection = null;
    Statement statement = null;
    ResultSet resultSet = null;


    private Statement statement1;
    private ResultSet resultSet1;
    private ResultSetMetaData metaData;
    private int numberOfRows;
    
    private boolean connectedToDatabase = false;

    
    
    public DBUtilities(String query)   throws SQLException  {
    	
     try {
    	setConnection();
        connection = DriverManager.getConnection(Config.connection_url, Config.DATABASE_USER_ID, Config.DATABASE_PASSWORD);

        statement1 = connection.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);

        connectedToDatabase = true;

        if (!connectedToDatabase) {
            throw new IllegalStateException("Not Connected to Database");
        }

        resultSet1 = statement1.executeQuery(query);
        metaData = resultSet1.getMetaData();
        resultSet1.last();
        numberOfRows = resultSet1.getRow();

        fireTableStructureChanged();
     }
     catch (SQLException ex) {
    	 
         System.out.println("The following error has occured: " + ex.getMessage());
     }
    	
    }
    	
    private void setConnection() {
        try {
            connection = DriverManager.getConnection(Config.connection_url, Config.DATABASE_USER_ID, Config.DATABASE_PASSWORD);

        } catch (SQLException ex) {
            System.out.println("The following error has occured: " + ex.getMessage());
        }
        
        
    }

    public Connection getConnection() {
        return connection;
    }

    public void ExecuteSQLStatement(String sql_stmt) {
        try {
            statement = connection.createStatement();

           // statement.executeUpdate(sql_stmt);
            statement.execute("Select * from dbo.Applicants");
        } catch (SQLException ex) {
            System.out.println("The following error has occured: " + ex.getMessage());
        }
    }
    
  


  

    @Override
    public int getRowCount() throws IllegalStateException {
        if (!connectedToDatabase) {
            throw new IllegalStateException("Not Connected to Database");
        }

        return numberOfRows;
    }

    @Override
    public int getColumnCount() throws IllegalStateException {
        if (!connectedToDatabase) {
            throw new IllegalStateException("Not Connected to Database");
        }

        try {
            return metaData.getColumnCount();
        } catch (SQLException sex) {
            System.out.println(sex.getMessage());
        }

        return 0;
    }

	 @Override
	    public Object getValueAt(int row, int column)
	            throws IllegalStateException {
	        if (!connectedToDatabase) {
	            throw new IllegalStateException("Not Connected to Database");
	        }

	        try {
	            resultSet.absolute(row + 1);
	            return resultSet.getObject(column + 1);
	        } catch (SQLException sex) {
	            System.out.println(sex.getMessage());
	        }

	        return "";
	    }
	 
	 public void disconnectFromDatabase() {
	        if (connectedToDatabase) {
	            try {
	                resultSet.close();
	                statement.close();
	                connection.close();
	            } catch (SQLException sex) {
	                System.out.println(sex.getMessage());
	            } finally {
	                connectedToDatabase = false;
	            }
	        }
	    }
    
    

    
}
