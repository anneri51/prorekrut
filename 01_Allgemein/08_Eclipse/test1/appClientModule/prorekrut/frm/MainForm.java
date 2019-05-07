package prorekrut.frm;

import java.awt.GridBagConstraints;

import java.awt.GridBagLayout;
import java.awt.Insets;

import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JMenu;
import javax.swing.JMenuBar;
import javax.swing.JMenuItem;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JTextField;

import prorekrut.DB.Config;
import prorekrut.DB.DBUtilities;
import prorekrut.DB.SQLStatements;
import java.sql.*;

public class MainForm {
	
	private static JFrame frm = new JFrame();
	private static JButton btn1 = new JButton("Get Data");
	private static JMenu mn1 = new JMenu();
	private static JMenuBar mnb1 = new JMenuBar();
	private static JMenuItem mnit1 = new JMenuItem("Test");
	private static String st1[] = {};
	private static JComboBox cb1  = new JComboBox(st1);
	private static JTextField tb1 = new JTextField("1000");
	private static String st2[] = {"km","m"};
	private static JComboBox cb2  = new JComboBox(st2 );
	private static JLabel lb1 = new JLabel("Umkreis: ");
	private static JOptionPane jop1 = new JOptionPane();
	
	//DB
	static Connection con = null;
	static Statement stmt = null;
	ResultSet resultSet = null;
	
	private class TestPane extends JPanel {

        public TestPane() {
            setLayout(new GridBagLayout());
            GridBagConstraints gbc = new GridBagConstraints();
            gbc.gridx = 0;
            gbc.gridy = 0;
            gbc.insets = new Insets(3, 5, 3, 5);

            //Zeile 1
            //add(new JLabel("Label 1"), gbc);
            gbc.gridx++;
            add(btn1, gbc);     
            
            gbc.gridx = 0;
            gbc.gridy++;
            gbc.fill = GridBagConstraints.HORIZONTAL;
            add(lb1, gbc); 
            gbc.gridx++;
    		add(tb1, gbc); 
    		gbc.gridx++;
    		add(cb2, gbc);
    		
    		gbc.gridx = 0;
            gbc.gridy++;
            gbc.gridx++;
    		add(cb1, gbc);        

            
            
            mnit1.setEnabled(true);
    		mn1.setEnabled(true);
    		
    		cb1.setVisible(true);
    		btn1.setVisible(true);

        }

    }

	
	public static void createMainForm () throws SQLException {

		frm.setTitle("Applicant Auswahl");
        frm.setSize(700, 250);       
		
		frm.setJMenuBar(mnb1);
		mnb1.add(mn1);
		mn1.add(mnit1);
		
		
		
	//	con.excuteSQL("SELECT SALUTATION + ' ' + NAME + ' ' + FIRSTNAME AS TXT, ID\r\n" + 
	//			"FROM \"dbo\".APPLICANTS");
		
		
		
		try {  
			
	         con = DriverManager.getConnection(Config.connection_url, Config.DATABASE_USER_ID, Config.DATABASE_PASSWORD);
             stmt =  con.createStatement();
 
			 ResultSet r=stmt.executeQuery(SQLStatements.qysel1 );

			 while (r.next()) {  
				 String pat = r.getString("name") +" "+ r.getString("firstname") + ", " + r.getString("id");
			     cb1.addItem(pat);  
			 }


			  con.close();
			    } catch (Exception e) {  
			jop1.showMessageDialog(null,SQLStatements.er3,SQLStatements.er4, jop1.WARNING_MESSAGE);  
			System.exit(0);  
			}  
		
		
		
		
		
		
		
		
		
		frm.add( new MainForm().new TestPane());
		frm.setVisible(true);
		
		
	}
	
	
}
