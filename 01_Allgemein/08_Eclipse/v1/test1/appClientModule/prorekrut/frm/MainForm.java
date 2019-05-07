package prorekrut.frm;

import java.io.*;
import java.awt.Desktop;
import java.awt.GridBagConstraints;

import java.awt.GridBagLayout;
import java.awt.Insets;
import java.awt.event.*;

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

public class MainForm implements WindowListener,ActionListener {
	
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
	private static JButton btn2 = new JButton("Open HTML Kandidat");
	private static JTextField tf2 = new JTextField("");
	
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
    	
    		gbc.gridx = 0;
            gbc.gridy++;
            gbc.gridx++;
            add(btn2, gbc);
            
            gbc.gridx = 0;
            gbc.gridy++;
            gbc.gridx++;
            add(tf2, gbc);

            
            
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
		
		btn2.addActionListener(e -> {
			try {
				createMainForm();
				tf2.setText(cb1.getSelectedItem().toString());
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		});
		
	//	con.excuteSQL("SELECT SALUTATION + ' ' + NAME + ' ' + FIRSTNAME AS TXT, ID\r\n" + 
	//			"FROM \"dbo\".APPLICANTS");
		
		
		
		try {  
			
	         con = DriverManager.getConnection(Config.connection_url, Config.DATABASE_USER_ID, Config.DATABASE_PASSWORD);
             stmt =  con.createStatement();
 
			 ResultSet r=stmt.executeQuery(SQLStatements.qysel2 );

			 while (r.next()) {  
				 //String pat = r.getString("name") +" "+ r.getString("firstname")  + ", " + r.getString("id");
				 String pat1 = r.getString("descr") +" "+ r.getString("appl_id_all") + ", " + r.getString("rnr_appl");
				 cb1.addItem(pat1);  
			 }

             //ResultSet r1 = stmt.executeQuery(SQLStatements.qyexss1);
             
			  con.close();
			    } catch (Exception e) {  
			        jop1.showMessageDialog(null,SQLStatements.er3,SQLStatements.er4, jop1.WARNING_MESSAGE);  
			
		            System.out.println("The following error has occured: " + e.getMessage());
		      
			        System.exit(0);  
			}  
		
		
		
		
		
		
		
		
		
		frm.add( new MainForm().new TestPane());
		frm.setVisible(true);
		
		
	}

	@Override
	public void actionPerformed(ActionEvent e) {
		// TODO Auto-generated method stub
		/*
		File f = new File("C:\\Users\\crmt\\Documents\\Visual Studio 2017\\GEO\\GEO_05_Clientdatenanzeige\\02_Datenausleitung_für_Anzeige\\01_Version1\\index.html");
        try {
            Desktop.getDesktop().open(f);
        } catch (IOException e1) {
            // TODO Auto-generated catch block
            e1.printStackTrace();
        }
        */
		
	}

	@Override
	public void windowOpened(WindowEvent e) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void windowClosing(WindowEvent e) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void windowClosed(WindowEvent e) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void windowIconified(WindowEvent e) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void windowDeiconified(WindowEvent e) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void windowActivated(WindowEvent e) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void windowDeactivated(WindowEvent e) {
		// TODO Auto-generated method stub
		
	}
	
	
	
}
