/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;
import java.nio.file.Paths;
import java.sql.PreparedStatement;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import static org.apache.tomcat.jni.User.username;

/**
 *
 * @author manoraju
 */
@MultipartConfig
public class appcontroller extends HttpServlet {
    private dbcontroller dbcontrol = null;

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException {
            
            String servletpath = request.getServletPath();
            servletpath = servletpath.replaceAll("[^a-zA-Z0-9]", "");
            System.out.println(servletpath);
            response.setHeader("Cache-Control","no-cache"); 
            response.setHeader("Pragma","no-cache"); 
            response.setDateHeader ("Expires", -1);
            if (dbcontrol==null) {
                dbcontrol = new dbcontroller();
            }
            
            if (servletpath.equals("Login")) {
                String username = request.getParameter("username");
                String password = request.getParameter("password");
                HttpSession session=request.getSession(true);
                System.out.println(session);
                try {
                    if (dbcontrol.validate(username,password)) {
                        Cookie loginCookie = new Cookie("user",username);
                         loginCookie.setMaxAge(30*30);
                         session.setAttribute("sessionauth", username);
                         response.addCookie(loginCookie);
                         //HttpSession session = request.getSession();
                         // session.setAttribute("username",username);
                         response.sendRedirect("login.jsp");
                    } else {
                          request.setAttribute("status", "<font color=red>Either user name or password is wrong.</font>");
                          RequestDispatcher rd = getServletContext().getRequestDispatcher("/home.jsp");
                          rd.forward(request, response);
                          //processRequest(request,response);
                    }
                } catch (Exception e) {
                    System.out.println(e);
            
                }
            
            }
            
            else if (servletpath.equals("Home")) {
                try {
                    response.sendRedirect("login.jsp");
                } catch (Exception e) {
                    System.out.println(e);
            
                }
            
            }
            
            
            else if (servletpath.equals("Help")) {
                try {
                    response.sendRedirect("dashboard.jsp");
                } catch (Exception e) {
                    System.out.println(e);
            
                }
            
            }
             
             
           else if (servletpath.equals("ViewProfile")) {
                try {
                    String username =request.getParameter("user");
                    List templist = dbcontrol.viewprofile(username);
                    request.setAttribute("List", templist);
                    RequestDispatcher rd = getServletContext().getRequestDispatcher("/viewprofile.jsp");
                    rd.forward(request, response);
                } catch (Exception e) {
                    System.out.println(e);
            
                }
            
            } 
            
           else if (servletpath.equals("EditProfile")) {
                try {
                    String username =request.getParameter("user");
                    List templist = dbcontrol.viewprofile(username);
                    request.setAttribute("List", templist);
                    RequestDispatcher rd = getServletContext().getRequestDispatcher("/editprofile.jsp");
                    rd.forward(request, response);
                } catch (Exception e) {
                    System.out.println(e);
            
                }
            
            }
           
           
            else if (servletpath.equals("ResetProfile")) {
                try {
                    
                    String username =request.getParameter("user");
                    List templist = dbcontrol.viewprofile(username);
                    request.setAttribute("List", templist);
                    RequestDispatcher rd = getServletContext().getRequestDispatcher("/editprofile.jsp");
                    rd.forward(request, response);
                } catch (Exception e) {
                    System.out.println(e);
            
                }
            
            }
           
           
              else if (servletpath.equals("SaveChange")) {
                    try {
                    
                        String FirstName = request.getParameter("FirstName");
                        String LastName = request.getParameter("LastName");
                        String Company = request.getParameter("Company");
                        String EmailAddress = request.getParameter("EmailAddress");
                        String TimeZone = request.getParameter("TimeZone");
                        String UserName = request.getParameter("UserName");
                        String Password = request.getParameter("Password");
                        
                        boolean status = dbcontrol.ProfileUpdate(FirstName,LastName,Company,EmailAddress,TimeZone,UserName,Password);
                        if (status) {
                           
                           response.setContentType("text/html;charset=UTF-8");
                           PrintWriter out= response.getWriter();
                           out.println("successfully updated profile changes");
                            
                        } else {
                        
                            
                            response.setContentType("text/html;charset=UTF-8");
                            PrintWriter out= response.getWriter();
                            out.println("profile update failed, please check the logs for errors");
                            
                        
                        }
                    } catch (Exception e) { 
                            
                            System.err.println(e);
                            response.setContentType("text/html;charset=UTF-8");
                            PrintWriter out= response.getWriter();
                            out.println("<font color=result>Upload failed , please check the logs for errors</font>");
                            
                            
                    }
            
            
            }
           
                      
             
            else if (servletpath.equals("GetReport")) {
                try {
                    String spageid=request.getParameter("page");  
                    int pageid=Integer.parseInt(spageid);  
                    int total=5;
                    int countervalue = total* (Integer.valueOf(spageid)-1);
                    int totalrecords = dbcontrol.getrow();
                    int noofpages = 1;
                    
                    
                    if(pageid==1){
                
                    }  
                    else{  
                        pageid =pageid-1;  
                        pageid =pageid*total+1;
                        
                    } 
                    List templist = dbcontrol.getreport(pageid,total);
                    System.out.println(templist);
                    request.setAttribute("List", templist);
                    
                    request.setAttribute("currentpage",spageid);
                    
                    request.setAttribute("totalrecords",totalrecords);
                   
                    request.setAttribute("countervalue",countervalue);
                    if (templist.size()>0) {
                        if (totalrecords % total > 0) {
                         noofpages = totalrecords/total + 1;
                        } else {
                           noofpages = totalrecords/total; 
                        } 
                         request.setAttribute("recordsperpage",templist.size());
                         request.setAttribute("noofpages",noofpages);
                    } else {
                      
                        request.setAttribute("recordsperpage",0);
                        request.setAttribute("totalrecords",0);
                        request.setAttribute("noofpages",spageid);
                        
                    
                    }
                    RequestDispatcher rd = getServletContext().getRequestDispatcher("/getreport.jsp");
                    rd.forward(request, response);
                 } catch (Exception e) {
                    System.out.println(e);
            
                }
            
            }
            
           
            else if (servletpath.equals("RealTimeReport")) {
                try {
                    System.out.println("request recived reak time");
                    List templist = dbcontrol.getrealtime();
                    
                    request.setAttribute("List", templist);
                    request.setAttribute("Status","1");
            
                    
                    RequestDispatcher rd = getServletContext().getRequestDispatcher("/RealTimeView.jsp");
                    rd.forward(request, response);
                    
                }  catch (Exception e) {
                    System.err.println(e);
                    RequestDispatcher rd = getServletContext().getRequestDispatcher("/RealTimeView.jsp");
                    PrintWriter out= response.getWriter();
                    out.println("<font color=red>please check logs for errors/font>");
                    rd.forward(request, response);
                }
            }   
             
           else if (servletpath.equals("AddPhone")) {
                try {
                     RequestDispatcher rd = getServletContext().getRequestDispatcher("/addphone.jsp");
                     PrintWriter out= response.getWriter();
                     rd.forward(request, response);                
        
               } catch (Exception e) {
                    System.err.println(e);
                    RequestDispatcher rd = getServletContext().getRequestDispatcher("/addphone.jsp");
                    PrintWriter out= response.getWriter();
                    out.println("<font color=red>please check logs for errors/font>");
                    rd.forward(request, response);
            
                }
            
            }
            
          else  if (servletpath.equals("SearchPhone")) {
                try {
                    String username =request.getParameter("user");
                    List templist = dbcontrol.viewprofile(username);
                    request.setAttribute("List", templist);
                    RequestDispatcher rd = getServletContext().getRequestDispatcher("/editprofile.jsp");
                    rd.forward(request, response);
                } catch (Exception e) {
                    System.out.println(e);
            
                }
            
            }
            
           else if (servletpath.equals("ServerStatus")) {
                    try {
                    System.out.println("request service monitoring request");
                    List templist = dbcontrol.getmonitor();
                    
                    request.setAttribute("List", templist);
            
     
                    RequestDispatcher rd = getServletContext().getRequestDispatcher("/serverstatus.jsp");
                    rd.forward(request, response);
                    
                }  catch (Exception e) {
                    System.err.println(e);
                    RequestDispatcher rd = getServletContext().getRequestDispatcher("/serverstatus.jsp");
                    PrintWriter out= response.getWriter();
                    out.println("<font color=red>please check logs for errors/font>");
                    rd.forward(request, response);
                }
            
            }
            
            
            else   if (servletpath.equals("Logout")) {
                try {
                    
                    HttpSession session=request.getSession(false);
                    session.invalidate();
                    Cookie loginCookie = null;
                    Cookie[] cookies = request.getCookies();
                    if(cookies != null) {
                        for(Cookie cookie : cookies){
                                if(cookie.getName().equals("user")){
                                        loginCookie = cookie;
                                        break;
                                }
                        
                        }
                    
                    }
                    
                    if(loginCookie != null){
                        loginCookie.setMaxAge(0);
                        response.addCookie(loginCookie);
                    }
                    
                    request.setAttribute("status", "<font color=red>Successfully Logged Out</font>");
                    RequestDispatcher rd = getServletContext().getRequestDispatcher("/logout.jsp");
                    rd.forward(request, response);
                    
                } catch (Exception e) {
                    System.out.println(e);
                    
                    request.setAttribute("status", "exception occured while loggingout");
                    RequestDispatcher rd = getServletContext().getRequestDispatcher("/logout.jsp");
                    rd.forward(request, response);
            
                }
            
            }
            
            
            else if (servletpath.equals("UpdatePhone")) {
                try {
                    Part filePart = request.getPart("file");
                    String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                    InputStream fileContent = filePart.getInputStream();
                   
                    //Part filePart = request.getPart("file");
                    //String fileName = Paths.get(filePart.getSubmittedFileName()).toString();
                    //String filePath = Paths.get(File.pathSeparator).toString();
                    System.out.println(fileName);
                    System.out.println(fileName.length());
                    //System.out.println(filePath);
                    if(fileName.length()>0) {
                            System.out.println("file servlet invoked");
                            boolean status = dbcontrol.addphone(fileName,fileContent);
                            if (status==true) {
                               response.setContentType("text/html;charset=UTF-8");
                               PrintWriter out= response.getWriter();
                               out.println("successfully updated phone record");
                            
                            } else {
                               response.setContentType("text/html;charset=UTF-8");
                               PrintWriter out= response.getWriter();
                              out.println("Failed to  updated phone record");
                            
                            }
                            
                    }  else {
                        response.setContentType("text/html;charset=UTF-8");
                        PrintWriter out= response.getWriter();
                        out.println("file not found");
                    
                    }        
        
               } catch (Exception e) {
                    System.err.println(e);
                    response.setContentType("text/html;charset=UTF-8");
                    PrintWriter out= response.getWriter();
                    out.println("Failed to  updated phone record");
            
                }
            
            }
            
            else if(servletpath.equals("SinglePhone")) {
            
                    try {
                    
                        String UserId = request.getParameter("UserId").replaceAll("\\s+","");
                        System.out.println("reached singlephone servlet");
                        String Line = request.getParameter("Line").replaceAll("\\s+","");
                        String Phone = request.getParameter("Phone").replaceAll("\\s+","");
                        String PartitionId;
                        String recordingFlag;
                        String recordingMediaSource;
                        String recordingProfileName;
                        String monitoringCssName;
                        String e164Mask;
                        String displayAscii;
                        
                       if (request.getParameter("PartitionId") != null ){
                        // do stuff
                           PartitionId = request.getParameter("PartitionId").replaceAll("\\s+","");
                        } else {
                            PartitionId = "None";
                        }
                       
                       if (request.getParameter("recordingFlag") != null ) {
                           recordingFlag = request.getParameter("recordingFlag").replaceAll("\\s+","");
                       } else {
                           recordingFlag  = "None";
                       
                       }
                        
                         if (request.getParameter("recordingMediaSource") != null ) {
                           recordingMediaSource = request.getParameter("recordingMediaSource").replaceAll("\\s+","");
                       } else {
                           recordingMediaSource  = "None";
                       
                       }
                         
                       if (request.getParameter("recordingProfileName") != null ) {
                           recordingProfileName = request.getParameter("recordingProfileName").replaceAll("\\s+","");
                       } else {
                          recordingProfileName  = "None";
                       
                       }
                       
                        if (request.getParameter("monitoringCssName") != null ) {
                            monitoringCssName = request.getParameter("monitoringCssName").replaceAll("\\s+","");
                       } else {
                           monitoringCssName  = "None";
                       
                       }
                        
                       if (request.getParameter("e164Mask") != null ) {
                           e164Mask = request.getParameter("e164Mask").replaceAll("\\s+","");
                       } else {
                           e164Mask  = "None";
                       
                       }
                       
                         if (request.getParameter("displayAscii") != null ) {
                           displayAscii = request.getParameter("displayAscii").replaceAll("\\s+","");
                       } else {
                           displayAscii  = "None";
                       
                       }
                        boolean status = dbcontrol.SingleLine(UserId,Line,Phone,PartitionId,recordingFlag,recordingMediaSource,recordingProfileName,monitoringCssName,e164Mask,displayAscii);
                        if (status) {
                           
                           response.setContentType("text/html;charset=UTF-8");
                           PrintWriter out= response.getWriter();
                           out.println("successfully updated phone record , refresh the page to view record");
                            
                        } else {
                        
                            
                            response.setContentType("text/html;charset=UTF-8");
                            PrintWriter out= response.getWriter();
                            out.println("Upload failed , please check the logs for errors");
                            
                        
                        }
                    } catch (Exception e) { 
                            
                            System.err.println(e);
                            response.setContentType("text/html;charset=UTF-8");
                            PrintWriter out= response.getWriter();
                            out.println("Upload failed , please check the logs for errors");
                            
                            
                    }
            
            
            }
            
            else if(servletpath.equals("SinglePhone2")) {
            
                    try {
                    
                        String MachineId = request.getParameter("MachineId").replaceAll("\\s+","");
                        System.out.println(MachineId);
                        String Line = request.getParameter("Line").replaceAll("\\s+","");
                        System.out.println(Line);
                        String Phone = request.getParameter("Phone").replaceAll("\\s+","");
                        
                        String PartitionId;
                        String recordingFlag;
                        String recordingMediaSource;
                        String recordingProfileName;
                        String monitoringCssName;
                        String e164Mask;
                        String displayAscii;
                        
                       if (request.getParameter("PartitionId") != null ){
                        // do stuff
                           PartitionId = request.getParameter("PartitionId").replaceAll("\\s+","");
                        } else {
                            PartitionId = "None";
                        }
                       
                       if (request.getParameter("recordingFlag") != null ) {
                           recordingFlag = request.getParameter("recordingFlag").replaceAll("\\s+","");
                       } else {
                           recordingFlag  = "None";
                       
                       }
                        
                         if (request.getParameter("recordingMediaSource") != null ) {
                           recordingMediaSource = request.getParameter("recordingMediaSource").replaceAll("\\s+","");
                       } else {
                           recordingMediaSource  = "None";
                       
                       }
                         
                       if (request.getParameter("recordingProfileName") != null ) {
                           recordingProfileName = request.getParameter("recordingProfileName").replaceAll("\\s+","");
                       } else {
                          recordingProfileName  = "None";
                       
                       }
                       
                        if (request.getParameter("monitoringCssName") != null ) {
                            monitoringCssName = request.getParameter("monitoringCssName").replaceAll("\\s+","");
                       } else {
                           monitoringCssName  = "None";
                       
                       }
                        
                       if (request.getParameter("e164Mask") != null ) {
                           e164Mask = request.getParameter("e164Mask").replaceAll("\\s+","");
                       } else {
                           e164Mask  = "None";
                       
                       }
                       
                         if (request.getParameter("displayAscii") != null ) {
                           displayAscii = request.getParameter("displayAscii").replaceAll("\\s+","");
                       } else {
                           displayAscii  = "None";
                       
                       }
                       
                        boolean status = dbcontrol.SingleLine2(MachineId,Line,Phone,PartitionId,recordingFlag,recordingMediaSource,recordingProfileName,monitoringCssName,e164Mask,displayAscii);
                        if (status) {
                           
                           response.setContentType("text/html;charset=UTF-8");
                           PrintWriter out= response.getWriter();
                           out.println("successfully updated phone record , refresh the page to view record");
                            
                        } else {
                        
                            
                            response.setContentType("text/html;charset=UTF-8");
                            PrintWriter out= response.getWriter();
                            out.println("Upload failed , please check the logs for errors");
                            
                        
                        }
                    } catch (Exception e) { 
                            
                            System.err.println(e);
                            response.setContentType("text/html;charset=UTF-8");
                            PrintWriter out= response.getWriter();
                            out.println("Upload failed , please check the logs for errors");
                                                        
                    }

            }
            
            
            else if(servletpath.equals("EditSinglePhone")) {
            
                    try {
                         
                        String userId = request.getParameter("UserId");
                        System.out.println(userId);
                        String Line = request.getParameter("Line");
                        String Phone = request.getParameter("Phone");
                        String PartitionId;
                        String recordingFlag;
                        String recordingMediaSource;
                        String recordingProfileName;
                        String monitoringCssName;
                        String e164Mask;
                        String displayAscii;
                        
                       if (request.getParameter("PartitionId") != null ){
                        // do stuff
                           PartitionId = request.getParameter("PartitionId").replaceAll("\\s+","");
                        } else {
                            PartitionId = "None";
                        }
                       
                       if (request.getParameter("recordingFlag") != null ) {
                           recordingFlag = request.getParameter("recordingFlag").replaceAll("\\s+","");
                       } else {
                           recordingFlag  = "None";
                       
                       }
                        
                         if (request.getParameter("recordingMediaSource") != null ) {
                           recordingMediaSource = request.getParameter("recordingMediaSource").replaceAll("\\s+","");
                       } else {
                           recordingMediaSource  = "None";
                       
                       }
                         
                       if (request.getParameter("recordingProfileName") != null ) {
                           recordingProfileName = request.getParameter("recordingProfileName").replaceAll("\\s+","");
                       } else {
                          recordingProfileName  = "None";
                       
                       }
                       
                        if (request.getParameter("monitoringCssName") != null ) {
                            monitoringCssName = request.getParameter("monitoringCssName").replaceAll("\\s+","");
                       } else {
                           monitoringCssName  = "None";
                       
                       }
                        
                       if (request.getParameter("e164Mask") != null ) {
                           e164Mask = request.getParameter("e164Mask").replaceAll("\\s+","");
                       } else {
                           e164Mask  = "None";
                       
                       }
                       
                         if (request.getParameter("displayAscii") != null ) {
                           displayAscii = request.getParameter("displayAscii").replaceAll("\\s+","");
                       } else {
                           displayAscii  = "None";
                       
                       }
                        boolean status = dbcontrol.SingleLine(userId,Line,Phone,PartitionId,recordingFlag,recordingMediaSource,recordingProfileName,monitoringCssName,e164Mask,displayAscii);
                        if (status) {  
                           response.setContentType("text/html;charset=UTF-8");
                           PrintWriter out= response.getWriter();
                           out.println("successfully updated phone record, refresh the page to view record");
                         
                        } else {
                        
                            
                            response.setContentType("text/html;charset=UTF-8");
                            PrintWriter out= response.getWriter();
                            out.println("Upload failed , please check the logs for errors");
                            
                        
                        }
                    } catch (Exception e) { 
                            
                            System.err.println(e);
                            response.setContentType("text/html;charset=UTF-8");
                            PrintWriter out= response.getWriter();
                            out.println("Upload failed , please check the logs for errors");
                            
                            
                    }
            
            
            }
            
            
            
            
             else   if (servletpath.equals("SubmitSearch")) {
                try {
                    String username =request.getParameter("user");
                    List templist = dbcontrol.viewprofile(username);
                    request.setAttribute("List", templist);
                    RequestDispatcher rd = getServletContext().getRequestDispatcher("/editprofile.jsp");
                    rd.forward(request, response);
                } catch (Exception e) {
                    System.out.println(e);
            
                }
            
            }
             
            else   if (servletpath.equals("UpdateProfile")) {
                try {
                    String username =request.getParameter("user");
                    List templist = dbcontrol.viewprofile(username);
                    request.setAttribute("List", templist);
                    RequestDispatcher rd = getServletContext().getRequestDispatcher("/editprofile.jsp");
                    rd.forward(request, response);
                } catch (Exception e) {
                    System.out.println(e);
            
                }
            
            } 
            
            
            
            else if (servletpath.equals("GetMaxRows")) {
                try {
                    String spageid=request.getParameter("page");  
                    int pageid=Integer.parseInt(spageid);
                    String maxrows = request.getParameter("maxrows");
                    String maxrowentry = maxrows;
                    int total=Integer.parseInt(maxrows);
                    int countervalue = total* (Integer.valueOf(spageid)-1);
                    int totalrecords = dbcontrol.getrow();
                    int noofpages = 1;
                    
                    
                    if(pageid==1){
                
                    }  
                    else{  
                        pageid =pageid-1;  
                        pageid =pageid*total+1;
                        
                    } 
                    List templist = dbcontrol.getreport(pageid,total);
                    System.out.println(templist);
                    request.setAttribute("List", templist);
                    
                    request.setAttribute("currentpage",spageid);
                    
                    request.setAttribute("totalrecords",totalrecords);
                   
                    request.setAttribute("countervalue",countervalue);
                    
                    request.setAttribute("maxrowsval", total);
                    request.setAttribute("mrrow", maxrowentry);
                    
                    if (templist.size()>0) {
                        if (totalrecords % total > 0) {
                         noofpages = totalrecords/total + 1;
                        } else {
                           noofpages = totalrecords/total; 
                        } 
                         request.setAttribute("recordsperpage",templist.size());
                         request.setAttribute("noofpages",noofpages);
                    } else {
                      
                        request.setAttribute("recordsperpage",0);
                        request.setAttribute("totalrecords",0);
                        request.setAttribute("noofpages",spageid);
                        
                    
                    }
                    RequestDispatcher rd = getServletContext().getRequestDispatcher("/getreport.jsp");
                    rd.forward(request, response);
                 } catch (Exception e) {
                    System.out.println(e);
            
                }
            
            }
            
            
             else if (servletpath.equals("GetMaxRows2")) {
                try {
                    String spageid=request.getParameter("page");  
                    int pageid=Integer.parseInt(spageid);
                    String maxrows = request.getParameter("maxrows");
                    String maxrowentry = maxrows;
                    int total=Integer.parseInt(maxrows);
                    int countervalue = total* (Integer.valueOf(spageid)-1);
                    int totalrecords = dbcontrol.getrow2();
                    int noofpages = 1;
                    
                    
                    if(pageid==1){
                
                    }  
                    else{  
                        pageid =pageid-1;  
                        pageid =pageid*total+1;
                        
                    } 
                    List templist = dbcontrol.getreport2(pageid,total);
                    System.out.println(templist);
                    request.setAttribute("List", templist);
                    
                    request.setAttribute("currentpage",spageid);
                    
                    request.setAttribute("totalrecords",totalrecords);
                   
                    request.setAttribute("countervalue",countervalue);
                    
                    request.setAttribute("maxrowsval", total);
                    request.setAttribute("mrrow", maxrowentry);
                    
                    if (templist.size()>0) {
                        if (totalrecords % total > 0) {
                         noofpages = totalrecords/total + 1;
                        } else {
                           noofpages = totalrecords/total; 
                        } 
                         request.setAttribute("recordsperpage",templist.size());
                         request.setAttribute("noofpages",noofpages);
                    } else {
                      
                        request.setAttribute("recordsperpage",0);
                        request.setAttribute("totalrecords",0);
                        request.setAttribute("noofpages",spageid);
                        
                    
                    }
                    RequestDispatcher rd = getServletContext().getRequestDispatcher("/getreport2.jsp");
                    rd.forward(request, response);
                 } catch (Exception e) {
                    System.out.println(e);
            
                }
            
            }
            
            
            
            
            else if (servletpath.equals("GetMaxRowsPhone")) {
                try {
                    String spageid=request.getParameter("page");  
                    int pageid=Integer.parseInt(spageid);
                    String maxrows = request.getParameter("maxrows");
                    int total=Integer.parseInt(maxrows);
                    int countervalue = total* (Integer.valueOf(spageid)-1);
                    int totalrecords = dbcontrol.getrow();
                    int noofpages = 1;
                    
                    
                    if(pageid==1){
                
                    }  
                    else{  
                        pageid =pageid-1;  
                        pageid =pageid*total+1;
                        
                    } 
                    List templist = dbcontrol.getreport(pageid,total);
                    System.out.println(templist);
                    request.setAttribute("List", templist);
                    
                    request.setAttribute("currentpage",spageid);
                    
                    request.setAttribute("totalrecords",totalrecords);
                   
                    request.setAttribute("countervalue",countervalue);
                    
                    request.setAttribute("maxrowsval", total);
                    
                    if (templist.size()>0) {
                        if (totalrecords % total > 0) {
                         noofpages = totalrecords/total + 1;
                        } else {
                           noofpages = totalrecords/total; 
                        } 
                         request.setAttribute("recordsperpage",templist.size());
                         request.setAttribute("noofpages",noofpages);
                    } else {
                      
                        request.setAttribute("recordsperpage",0);
                        request.setAttribute("totalrecords",0);
                        request.setAttribute("noofpages",spageid);
                        
                    
                    }
                    RequestDispatcher rd = getServletContext().getRequestDispatcher("/singleuploadreport.jsp");
                    rd.forward(request, response);
                 } catch (Exception e) {
                    System.out.println(e);
            
                }
            
            }
            
            
            else   if (servletpath.equals("deletephone")) {
                
                    try {
                        String UserId = request.getParameter("UserId").replaceAll("\\s+","");
                        System.out.println(UserId);
                        boolean status = dbcontrol.deleteRecord(UserId);
                        if (status) {
                           
                           response.setContentType("text/html;charset=UTF-8");
                           PrintWriter out= response.getWriter();
                           out.println("successfully delete phone record,refresh page to fetch updated report");
                            
                        } else {
                        
                            
                            response.setContentType("text/html;charset=UTF-8");
                            PrintWriter out= response.getWriter();
                            out.println("delete failed , please check the logs for errors");
                            
                        
                        }
                    } catch (Exception e) { 
                            
                            System.err.println(e);
                            response.setContentType("text/html;charset=UTF-8");
                            PrintWriter out= response.getWriter();
                            out.println("delete failed , please check the logs for errors");
                            
                            
                    }
            
            } 
            
            else   if (servletpath.equals("deletephone2")) {
                
                    try {
                        String MachineId = request.getParameter("MachineId").replaceAll("\\s+","");
                        System.out.println(MachineId);
                        boolean status = dbcontrol.deleteRecord2(MachineId);
                        if (status) {
                           
                           response.setContentType("text/html;charset=UTF-8");
                           PrintWriter out= response.getWriter();
                           out.println("successfully delete phone record,refresh page to fetch updated report");
                            
                        } else {
                        
                            
                            response.setContentType("text/html;charset=UTF-8");
                            PrintWriter out= response.getWriter();
                            out.println("delete failed , please check the logs for errors");
                            
                        
                        }
                    } catch (Exception e) { 
                            
                            System.err.println(e);
                            response.setContentType("text/html;charset=UTF-8");
                            PrintWriter out= response.getWriter();
                            out.println("delete failed , please check the logs for errors");
                            
                            
                    }
            
            } 
            
            
            else   if (servletpath.equals("GetRealTimeReport")) {
                
                
                try {
                    String spageid=request.getParameter("page");  
                    int pageid=Integer.parseInt(spageid);
                    String maxrows = request.getParameter("maxrows");
                     String maxrowentry = maxrows;
                    int total=Integer.parseInt(maxrows);
                    int countervalue = total* (Integer.valueOf(spageid)-1);
                    int totalrecords = dbcontrol.getrealtimerow();
                    int noofpages = 1;
                    
                    
                    if(pageid==1){
                
                    }  
                    else{  
                        pageid =pageid-1;  
                        pageid =pageid*total+1;
                        
                    } 
                    List templist = dbcontrol.getrealtimereport(pageid,total);
                    System.out.println(templist);
                    request.setAttribute("List", templist);
                    
                    request.setAttribute("currentpage",spageid);
                    
                    request.setAttribute("totalrecords",totalrecords);
                   
                    request.setAttribute("countervalue",countervalue);
                    
                    request.setAttribute("maxrowsval", total);
                    request.setAttribute("mrrow", maxrowentry);
                    
                    if (templist.size()>0) {
                        if (totalrecords % total > 0) {
                         noofpages = totalrecords/total + 1;
                        } else {
                           noofpages = totalrecords/total; 
                        } 
                         request.setAttribute("recordsperpage",templist.size());
                         request.setAttribute("noofpages",noofpages);
                    } else {
                      
                        request.setAttribute("recordsperpage",0);
                        request.setAttribute("totalrecords",0);
                        request.setAttribute("noofpages",spageid);
                        
                    
                    }
                    RequestDispatcher rd = getServletContext().getRequestDispatcher("/RealTimeView.jsp");
                    rd.forward(request, response);
                 } catch (Exception e) {
                    System.out.println(e);
            
                }
            
                
            } 


            
            else {
                   RequestDispatcher rd = getServletContext().getRequestDispatcher("/login.jsp");
                   PrintWriter out= response.getWriter();
                   out.println("<font color=red>Server Could not fulfil the request.</font>");
                   rd.forward(request, response); 
                
            }
            
            
            
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(appcontroller.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            System.out.println("This is to check path " + request.getServletPath() );
            processRequest(request, response);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(appcontroller.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
