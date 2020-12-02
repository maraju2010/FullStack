/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author manoraju
 */
public class DBAccess {
    private Connection connection;
     
     
    public DBAccess() throws ClassNotFoundException {
            
         String sqluser = "root";
         String sqlpass = "XXXXXXXXXX";
         Class.forName("com.mysql.jdbc.Driver");
         
         try {
            if (this.connection==null) {
                this.connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/jseap?useSSL=false", sqluser, sqlpass);
                
            }else {
                System.out.println("connection already established");
               
                
            }
             
         } catch (SQLException e) {
              System.out.println(e);
         
         }
         
    }

     
     
    public boolean dologin(login loginuser) throws ClassNotFoundException, SQLException {
                boolean status = false;
                
                try (
                       
                        PreparedStatement preparedStatement = this.connection.prepareStatement("select * from login where username = ? and password = ? ;")){
                                                           preparedStatement.setString(1, loginuser.getUsername());
                                                           preparedStatement.setString(2, loginuser.getPassword());
                
                                                           
                      System.out.println(preparedStatement);
                      ResultSet rs = preparedStatement.executeQuery();
                      status = rs.next();
                      System.out.println(status);                                                           
                    
                
                } catch(SQLException e) {
                    System.out.println(e);
          }
                
         return status;   
    }
    
    
    public List viewprofile(String username) throws ClassNotFoundException {
          List<Map<String, Object>> temprows = null;
                
            try (
                   
                PreparedStatement preparedStatement = this.connection.prepareStatement("select * from login where username = ?;")){
                                                           preparedStatement.setString(1, username);
                
                System.out.println(preparedStatement);
                ResultSet rs = preparedStatement.executeQuery();
                      
                temprows  = resultSetToList(rs);  
                
                } catch(SQLException e) {
                     System.out.println(e);
          }
                
            return temprows;
    
    }
       
    private List<Map<String, Object>> resultSetToList(ResultSet rs) throws SQLException {
            ResultSetMetaData md = rs.getMetaData();
            int columns = md.getColumnCount();
            System.out.println(columns);
            List<Map<String, Object>> rows = new ArrayList<>();
            while (rs.next()){
                Map<String, Object> row = new HashMap<>(columns);
                for(int i = 1; i <= columns; ++i){
                    row.put(md.getColumnName(i), rs.getObject(i));
            }
            rows.add(row);
        }
        return rows;
    }

    public List getreport(int pageid, int total) {
                String data ;
                List<Map<String, Object>> temprows = null;
                try {
                        PreparedStatement preparedStatement = this.connection.prepareStatement("select * from account limit "+(pageid-1)+","+total);
                
                                                           
                      System.out.println(preparedStatement);
                      ResultSet rs = preparedStatement.executeQuery();
                      
                      temprows  = resultSetToList(rs);          
                
                }catch(SQLException e) {
                     System.out.println(e);
          }
           
         
         return temprows;  
    }
    
    public int rowcount() {
        int rowcount = 0;
         try {
                        PreparedStatement preparedStatement = this.connection.prepareStatement("select count(*) as rowcount from account");
                
                                                           
                      System.out.println(preparedStatement);
                      ResultSet rs = preparedStatement.executeQuery();
                      
                      rs.next();
                      rowcount = rs.getInt("rowcount");
                
                }catch(SQLException e) {
                     System.out.println(e);
          }    
        return rowcount;
        
        
    }

    public boolean addphone(String fileName, InputStream fileContent) throws IOException, SQLException {
             boolean status = false;
             int count = 0;
             int batchSize = 20;
             
             try (BufferedReader br = new BufferedReader(new InputStreamReader(
                fileContent, StandardCharsets.UTF_8));) {
                String hline = br.readLine();// consume first line and ignore
                String[] hattr = hline.split(",");
                System.out.println(hattr);
                if(hattr[0].equals("MachineId")){
                     String sqlquery = "INSERT INTO machine (MachineId,Line,Phone,PartitionId,recordingFlag,recordingMediaSource,recordingProfileName,monitoringCssName,e164Mask,displayAscii) VALUES ( ?, ?, ?, ?,?,?,?,?,?,?)";
                PreparedStatement stmt = this.connection.prepareStatement(sqlquery); 
                String line = br.readLine();
                while (line != null)  {
                    String[] attributes = line.split(",");
                    //call db from here
                    String MachineId = attributes[0].replaceAll(" ", "");
                    String Line = attributes[1].replaceAll(" ", "");
                    String Phone = attributes[2].replaceAll(" ", "");
                    String PartitionId;
                    String recordingFlag;
                    String recordingMediaSource;
                    String recordingProfileName;
                    String monitoringCssName;
                    String e164Mask;
                    String displayAscii;
                        
                       if (attributes[3].replaceAll("\\s+","") != null ){
                        // do stuff
                           PartitionId = attributes[3].replaceAll("\\s+","");
                        } else {
                            PartitionId = "None";
                        }
                       
                       if (attributes[4].replaceAll("\\s+","") != null ) {
                           recordingFlag = attributes[4].replaceAll(" ", "");;
                       } else {
                           recordingFlag  = "None";
                       
                       }
                        
                         if (attributes[5].replaceAll("\\s+","") != null ) {
                           recordingMediaSource = attributes[5].replaceAll("\\s+","") ;
                       } else {
                           recordingMediaSource  = "None";
                       
                       }
                         
                       if (attributes[6].replaceAll("\\s+","")!= null ) {
                           recordingProfileName = attributes[6].replaceAll("\\s+","");
                       } else {
                          recordingProfileName  = "None";
                       
                       }
                       
                        if (attributes[7].replaceAll("\\s+","") != null ) {
                            monitoringCssName = attributes[7].replaceAll("\\s+","") ;
                       } else {
                           monitoringCssName  = "None";
                       
                       }
                        
                       if (attributes[8].replaceAll("\\s+","")  != null ) {
                           e164Mask = attributes[8].replaceAll("\\s+","") ;
                       } else {
                           e164Mask  = "None";
                       
                       }
                       
                         if (attributes[9].replaceAll("\\s+","") != null ) {
                           displayAscii = attributes[9].replaceAll("\\s+","") ;
                       } else {
                           displayAscii  = "None";
                       
                       }
                    
                    this.addbatch2(stmt, MachineId, Line, Phone, PartitionId, recordingFlag, recordingMediaSource, recordingProfileName, monitoringCssName, e164Mask, displayAscii);
                    if (count % batchSize == 0) {
                        
                        stmt.executeBatch();
                        
                    }
                    
                    line = br.readLine();
                    
                }
                stmt.executeBatch();
                br.close();
                status=true;
               
                    
            } else {
               String sqlquery = "INSERT INTO account (UserId,Line,Phone,PartitionId,recordingFlag,recordingMediaSource,recordingProfileName,monitoringCssName,e164Mask,displayAscii) VALUES ( ?, ?, ?, ?,?,?,?,?,?,?)";
               PreparedStatement stmt; 
               stmt = this.connection.prepareStatement(sqlquery);
                    
                    
                String line = br.readLine();
                while (line != null)  {
                    String[] attributes = line.split(",");
                    //call db from here
                    String UserId = attributes[0].replaceAll(" ", "");
                    String Line = attributes[1].replaceAll(" ", "");
                    String Phone = attributes[2].replaceAll(" ", "");
                    String PartitionId;
                    String recordingFlag;
                    String recordingMediaSource;
                    String recordingProfileName;
                    String monitoringCssName;
                    String e164Mask;
                    String displayAscii;
                        
                       if (attributes[3].replaceAll("\\s+","") != null ){
                        // do stuff
                           PartitionId = attributes[3].replaceAll("\\s+","");
                        } else {
                            PartitionId = "None";
                        }
                       
                       if (attributes[4].replaceAll("\\s+","") != null ) {
                           recordingFlag = attributes[4].replaceAll(" ", "");;
                       } else {
                           recordingFlag  = "None";
                       
                       }
                        
                         if (attributes[5].replaceAll("\\s+","") != null ) {
                           recordingMediaSource = attributes[5].replaceAll("\\s+","") ;
                       } else {
                           recordingMediaSource  = "None";
                       
                       }
                         
                       if (attributes[6].replaceAll("\\s+","")!= null ) {
                           recordingProfileName = attributes[6].replaceAll("\\s+","");
                       } else {
                          recordingProfileName  = "None";
                       
                       }
                       
                        if (attributes[7].replaceAll("\\s+","") != null ) {
                            monitoringCssName = attributes[7].replaceAll("\\s+","") ;
                       } else {
                           monitoringCssName  = "None";
                       
                       }
                        
                       if (attributes[8].replaceAll("\\s+","")  != null ) {
                           e164Mask = attributes[8].replaceAll("\\s+","") ;
                       } else {
                           e164Mask  = "None";
                       
                       }
                       
                         if (attributes[9].replaceAll("\\s+","") != null ) {
                           displayAscii = attributes[9].replaceAll("\\s+","") ;
                       } else {
                           displayAscii  = "None";
                       
                       }
                    
                    this.addbatch(stmt, UserId, Line, Phone, PartitionId, recordingFlag, recordingMediaSource, recordingProfileName, monitoringCssName, e164Mask, displayAscii);
                    if (count % batchSize == 0) {
                        
                        stmt.executeBatch();
                        
                    }
                    
                    line = br.readLine();
                    
                }
                stmt.executeBatch();
                br.close();
                status=true;
                
           }
    } catch (Exception e) {
        status =false;
        
    }

   return status; 
    
}
  
    
    
    public void addbatch(PreparedStatement statement,String UserId,String Line,String Phone,String PartitionId,String recordingFlag,String recordingMediaSource,
            String recordingProfileName,String monitoringCssName,String e164Mask,String displayAscii) throws SQLException {
    
             
             statement.setString(1, UserId);
             statement.setString(2, Line);
             statement.setString(3, Phone);
             statement.setString(4, PartitionId);
             statement.setString(5, recordingFlag);
             statement.setString(6, recordingMediaSource);
             statement.setString(7, recordingProfileName);
             statement.setString(8, monitoringCssName);
             statement.setString(9, e164Mask);
             statement.setString(10, displayAscii);
             statement.addBatch();
         
    }

    public List lookup_realtime() {
                String data ;
                List<Map<String, Object>> temprows = null;
                try {
                     PreparedStatement preparedStatement = this.connection.prepareStatement("select * from phone_events");                                      
                      System.out.println(preparedStatement);
                      ResultSet rs = preparedStatement.executeQuery();
                      
                      temprows  = resultSetToList(rs);          
                
                }catch(SQLException e) {
                     System.out.println(e);
                }
    
        return temprows; 
    } 

    public boolean SingleLine(String UserId, String Line, String Phone, String PartitionId, String recordingFlag,String recordingMediaSource,String recordingProfileName, String monitoringCssName, String e164Mask, String displayAscii) throws SQLException {
        boolean status=false;
        try {
            String sqlquery = "INSERT INTO Account (UserId,Line,Phone,PartitionId,recordingFlag,recordingMediaSource,recordingProfileName,monitoringCssName,e164Mask,displayAscii) VALUES (?, ?, ?, ?, ?,?,?,?,?,?)";
            PreparedStatement statement = this.connection.prepareStatement(sqlquery);
            statement.setString(1, UserId);
            statement.setString(2, Line);
            statement.setString(3, Phone);
            statement.setString(4, PartitionId);
            statement.setString(5, recordingFlag);
            statement.setString(6, recordingMediaSource);
            statement.setString(7, recordingProfileName);
            statement.setString(8, monitoringCssName);
            statement.setString(9, e164Mask);
            statement.setString(10, displayAscii);

            boolean rs = statement.execute();
            
            status = true;

             System.out.println(status);
             
          
            } catch(SQLException e) {
                    System.out.println(e);
                    status = false;
          }
                
         
         return status;
        
    }

    public boolean SingleLine(String FirstName, String LastName, String Company, String EmailAddress, String TimeZone, String UserName, String Password) {
        boolean status=false;
        try {
            String sqlquery = "UPDATE  login set FirstName=? ,LastName=? ,Company=?,EmailAddress=?,TimeZone=?,Password=? where UserName=?";
            PreparedStatement statement = this.connection.prepareStatement(sqlquery);
            statement.setString(1, FirstName.replaceAll(" ", ""));
            statement.setString(2, LastName.replaceAll(" ", ""));
            statement.setString(3, Company.replaceAll(" ", ""));
            statement.setString(4, EmailAddress.replaceAll(" ", ""));
            statement.setString(5, TimeZone.replaceAll(" ", ""));
            statement.setString(6, Password.replaceAll(" ", ""));
            statement.setString(7, UserName.replaceAll(" ", ""));
            boolean rs = statement.execute();
            
            status = true;

             System.out.println(status);
             
          
            } catch(SQLException e) {
                    System.out.println(e);
          }
                
         
         return status;
        
    }

    public List lookup_service() {
                String data ;
                List<Map<String, Object>> temprows = null;
                try {
                     PreparedStatement preparedStatement = this.connection.prepareStatement("select * from monitor_real_time");                                      
                      System.out.println(preparedStatement);
                      ResultSet rs = preparedStatement.executeQuery();
                      
                      temprows  = resultSetToList(rs);          
                
                }catch(SQLException e) {
                     System.out.println(e);
                }
    
        return temprows; 
    }

    public boolean deletephone(String UserId) {
        boolean status=false;
        String userid = UserId.replaceAll(" ", "");
        try {
            String sqlquery = "delete  from account where UserId = ?";
            PreparedStatement statement = this.connection.prepareStatement(sqlquery);
            statement.setString(1, userid);
            boolean rs = statement.execute();
            
            status = true;

             System.out.println(status);
             
          
            } catch(SQLException e) {
                    System.out.println(e);
                    status=false;
          }
                
         
         return status;
    }

    public List getreport2(int pageid, int total) {
        String data ;
                List<Map<String, Object>> temprows = null;
                try {
                        PreparedStatement preparedStatement = this.connection.prepareStatement("select * from machine limit "+(pageid-1)+","+total);
                
                                                           
                      System.out.println(preparedStatement);
                      ResultSet rs = preparedStatement.executeQuery();
                      
                      temprows  = resultSetToList(rs);          
                
                }catch(SQLException e) {
                     System.out.println(e);
          }
           
         
         return temprows;
    }

    public boolean deletephone2(String MachineId) {
         boolean status=false;
         String machineid = MachineId.replaceAll(" ", "");
        try {
            String sqlquery = "delete  from machine where MachineId = ?";
            PreparedStatement statement = this.connection.prepareStatement(sqlquery);
            statement.setString(1, MachineId);
            boolean rs = statement.execute();
            
            status = true;

             System.out.println(status);
             
          
            } catch(SQLException e) {
                    System.out.println(e);
          }
                
         
         return status;
    }

    public boolean SingleLine2(String MachineId, String Line, String Phone, String PartitionId, String recordingFlag,String recordingMediaSource,String recordingProfileName, String monitoringCssName, String e164Mask, String displayAscii) {
         boolean status=false;
        try {
            String sqlquery = "INSERT INTO Machine ( MachineId,Line,Phone,PartitionId,recordingFlag,recordingMediaSource,recordingProfileName,monitoringCssName,e164Mask,displayAscii) VALUES (?, ?, ?, ?, ?,?,?,?,?,?)";
            PreparedStatement statement = this.connection.prepareStatement(sqlquery);
               
            statement.setString(1, MachineId);
            statement.setString(2, Line);
            statement.setString(3, Phone);
            statement.setString(4, PartitionId);
            statement.setString(5, recordingFlag);
            statement.setString(6, recordingMediaSource);
            statement.setString(7, recordingProfileName);
            statement.setString(8, monitoringCssName);
            statement.setString(9, e164Mask);
            statement.setString(10, displayAscii);
            boolean rs = statement.execute();
            status = true;

             System.out.println(status);
          
          
            } catch(SQLException e) {
                    System.out.println(e);
                     status = false;
          }     
         return status;
    }

    public int rowcount2() {
        int rowcount = 0;
         try {
                        PreparedStatement preparedStatement = this.connection.prepareStatement("select count(*) as rowcount from machine");
                
                                                           
                      System.out.println(preparedStatement);
                      ResultSet rs = preparedStatement.executeQuery();
                      
                      rs.next();
                      rowcount = rs.getInt("rowcount");
                
                }catch(SQLException e) {
                     System.out.println(e);
          }    
        return rowcount;
    }

    public boolean addphone2(String fileName, InputStream fileContent) throws SQLException {
        boolean status = false;
        System.out.println("addphonereq");
             int count = 0;
             int batchSize = 20;
             String sqlquery = "INSERT INTO machine (MachineId,Line,Phone,PartitionId,recordingFlag,recordingMediaSource,recordingProfileName,monitoringCssName,e164Mask,displayAscii) VALUES ( ?, ?, ?, ?,?,?,?,?,?,?)";
             PreparedStatement stmt = this.connection.prepareStatement(sqlquery);
             try (BufferedReader br = new BufferedReader(new InputStreamReader(
                fileContent, StandardCharsets.UTF_8));) {
               String line1= br.readLine();// consume first line and ignore
                String line = br.readLine();
                System.out.println(line1);
                while (line != null)  {
                    String[] attributes = line.split(",");
                    //call db from here
                    String MachineId = attributes[0];
                    String Line = attributes[1].replaceAll(" ", "");
                    String Phone = attributes[2].replaceAll(" ", "");
                    
                    String PartitionId;
                    String recordingFlag;
                    String recordingMediaSource;
                    String recordingProfileName;
                    String monitoringCssName;
                    String e164Mask;
                    String displayAscii;
                        
                       if (attributes[3].replaceAll("\\s+","") != null ){
                        // do stuff
                           PartitionId = attributes[3].replaceAll("\\s+","");
                        } else {
                            PartitionId = "None";
                        }
                       
                       if (attributes[4].replaceAll("\\s+","") != null ) {
                           recordingFlag = attributes[4].replaceAll(" ", "");;
                       } else {
                           recordingFlag  = "None";
                       
                       }
                        
                         if (attributes[5].replaceAll("\\s+","") != null ) {
                           recordingMediaSource = attributes[5].replaceAll("\\s+","") ;
                       } else {
                           recordingMediaSource  = "None";
                       
                       }
                         
                       if (attributes[6].replaceAll("\\s+","")!= null ) {
                           recordingProfileName = attributes[6].replaceAll("\\s+","");
                       } else {
                          recordingProfileName  = "None";
                       
                       }
                       
                        if (attributes[7].replaceAll("\\s+","") != null ) {
                            monitoringCssName = attributes[7].replaceAll("\\s+","") ;
                       } else {
                           monitoringCssName  = "None";
                       
                       }
                        
                       if (attributes[8].replaceAll("\\s+","")  != null ) {
                           e164Mask = attributes[8].replaceAll("\\s+","") ;
                       } else {
                           e164Mask  = "None";
                       
                       }
                       
                         if (attributes[9].replaceAll("\\s+","") != null ) {
                           displayAscii = attributes[9].replaceAll("\\s+","") ;
                       } else {
                           displayAscii  = "None";
                       
                       }
                                                           
                    this.addbatch2(stmt, MachineId, Line, Phone, PartitionId, recordingFlag, recordingMediaSource, recordingProfileName, monitoringCssName, e164Mask, displayAscii);
                    if (count % batchSize == 0) {
                        
                        stmt.executeBatch();
                        
                    }
                    
                    line = br.readLine();
                    
                }
                stmt.executeBatch();
                br.close();
                status=true;
                
    } catch (Exception e) {
        System.out.println(e);
        status =false;
       
        
    }

   return status; 
    
    }

    public void addbatch2(PreparedStatement statement, String MachineId, String Line, String Phone, String PartitionId, String recordingFlag, String recordingMediaSource, 
            String recordingProfileName, String monitoringCssName, String e164Mask, String displayAscii) throws SQLException {
            System.out.println("MachineID req addbatch2");
             statement.setString(1, MachineId);
             statement.setString(2, Line);
             statement.setString(3, Phone);
             statement.setString(4, PartitionId);
             statement.setString(5, recordingFlag);
             statement.setString(6, recordingMediaSource);
             statement.setString(7, recordingProfileName);
             statement.setString(8, monitoringCssName);
             statement.setString(9, e164Mask);
             statement.setString(10, displayAscii);
             statement.addBatch();
             
             
    }

    public int rowcount3() {
           int rowcount = 0;
         try {
                        PreparedStatement preparedStatement = this.connection.prepareStatement("select count(*) as rowcount from phone_events");
                
                                                           
                      System.out.println(preparedStatement);
                      ResultSet rs = preparedStatement.executeQuery();
                      
                      rs.next();
                      rowcount = rs.getInt("rowcount");
                
                }catch(SQLException e) {
                     System.out.println(e);
          }    
        return rowcount;
    }

    public List getreport3(int pageid, int total) {
        String data ;
                List<Map<String, Object>> temprows = null;
                try {
                        PreparedStatement preparedStatement = this.connection.prepareStatement("select * from phone_events limit "+(pageid-1)+","+total);
                
                                                           
                      System.out.println(preparedStatement);
                      ResultSet rs = preparedStatement.executeQuery();
                      
                      temprows  = resultSetToList(rs);          
                
                }catch(SQLException e) {
                     System.out.println(e);
          }
           
         
         return temprows;
    }

   
     
   
}
