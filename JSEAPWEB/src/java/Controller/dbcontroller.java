/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

/**
 *
 * @author manoraju
 */

import Model.DBAccess;
import Model.login;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.Cookie;
        
public class dbcontroller {

    private DBAccess DB=null;
    private login loginuser;
    
    
    public dbcontroller() throws ClassNotFoundException {
        
       if (this.DB==null) {
            this.DB = new DBAccess();
       }
       
       if (this.loginuser ==null) {
         this.loginuser = new login(); 
       }
    }

    
 
    
    public boolean  validate(String username,String password) {
            boolean userstatus = false;
            
            this.loginuser.setUsername(username);
            this.loginuser.setPassword(password);
            try {
                if (this.DB.dologin(this.loginuser)) {
                    userstatus = true;
            } else {
               userstatus = false;
            }
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println(e);
            
        }
            return userstatus;
    }

    public List viewprofile(String username) throws ClassNotFoundException {
        List temprows = this.DB.viewprofile(username);
        return temprows;
       
    }

    public List getreport(int pageid, int total) {
        List temprows = this.DB.getreport(pageid,total);
        return temprows;
    }

    public int getrow() {
        int rowcount = this.DB.rowcount();
        return rowcount;
    }
   

    public boolean addphone(String fileName, InputStream fileContent) throws IOException, SQLException {
        boolean status = false;
        status = this.DB.addphone(fileName,fileContent);
  
        return status;
        
    }

    public List getrealtime() {
        List temprows = this.DB.lookup_realtime();
        return temprows;
    }

    public boolean SingleLine(String UserId, String Line, String Phone, String PartitionId, String recordingFlag,String recordingMediaSource,String recordingProfileName, String monitoringCssName, String e164Mask, String displayAscii) throws SQLException {
        boolean status = this.DB.SingleLine(UserId,Line,Phone,PartitionId,recordingFlag,recordingMediaSource,recordingProfileName,monitoringCssName,e164Mask,displayAscii);
        return status;
    }

    boolean ProfileUpdate(String FirstName, String LastName, String Company, String EmailAddress, String TimeZone, String UserName, String Password) {
            boolean status = this.DB.SingleLine(FirstName,LastName,Company,EmailAddress,TimeZone,UserName,Password);
            return status;
    }

   public List getmonitor() {
         List temprows = this.DB.lookup_service();
        return temprows;
    }

   public boolean deleteRecord(String UserId) {
         boolean status = this.DB.deletephone(UserId);
         return status;
    }

    public List getreport2(int pageid, int total) {
         List temprows = this.DB.getreport2(pageid,total);
        return temprows;
    }

    public boolean deleteRecord2(String MachineId) {
        boolean status = this.DB.deletephone2(MachineId);
         return status;
    }

    public boolean SingleLine2(String MachineId, String Line, String Phone, String PartitionId,String recordingFlag,String recordingMediaSource, String recordingProfileName, String monitoringCssName, String e164Mask, String displayAscii) {
        
        boolean status = this.DB.SingleLine2(MachineId,Line,Phone,PartitionId,recordingFlag,recordingMediaSource,recordingProfileName,monitoringCssName,e164Mask,displayAscii);
        return status;
    
    }

    public int getrow2() {
        int rowcount = this.DB.rowcount2();
        return rowcount;
    }

    public int getrealtimerow() {
        int rowcount = this.DB.rowcount3();
        return rowcount;
    }

    public List getrealtimereport(int pageid, int total) {
        List temprows = this.DB.getreport3(pageid,total);
        return temprows;
        
    }

    

        
    
    
}
