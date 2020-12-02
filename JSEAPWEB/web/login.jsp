<%-- 
    Document   : addphone
    Created on : Aug 2, 2020, 6:07:15 PM
    Author     : manoraju
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <META HTTP-EQUIV="PRAGMA" CONTENT="NO-CACHE"> 
<META HTTP-EQUIV="Expires" CONTENT="-1">
<meta name=”viewport” content=”width=device-width, initial-scale=1.0">
    <title>JSEAP Portal</title>
     <link rel="stylesheet" href="vendor/bootstrap.min.css"/>
      <link rel="stylesheet" href="vendor/datatable.css"/>
      <link rel="stylesheet" href="vendor/buttons.datatables.min.css"/> 
     <link rel="stylesheet" href="vendor/buttons.bootstrap.min.css"/> 
         <link rel="stylesheet" href="vendor/css/all.css"/> 
    <link rel="stylesheet" href="vendor/css/all.min.css"/> 
    <link rel="stylesheet" href="vendor/simple-sidebar.css"/>  
   

     
     
     <%
        String userName = null;
        Cookie[] cookies = request.getCookies();
        if(cookies !=null){
            for(Cookie cookie : cookies){
                if(cookie.getName().equals("user")) userName = cookie.getValue();
                }
            }
        if(userName == null) response.sendRedirect("home.jsp");
    %>
<%
response.setHeader("Cache-Control","no-cache"); 
response.setHeader("Pragma","no-cache"); 
response.setDateHeader ("Expires", -1);
%>    

  <style>

    .h2 {
    margin-top: 20px;
    margin-bottom: 10px;
}
 
.h2 {
    font-family: inherit;
    font-weight: 500;
    line-height: 1.1;
    color: inherit;
}

h2 {
    display: block;
    font-size: 1.5em;
    margin-block-start: 0.83em;
    margin-block-end: 0.83em;
    margin-inline-start: 0px;
    margin-inline-end: 0px;
    font-weight: bold;
}

.placeholders {
  margin-bottom: 30px;
  text-align: center;
}
.placeholders h4 {
  margin-bottom: 0;
}

.placeholder {
  margin-bottom: 20px;
}
</style>      
    
<script src="vendor/jquery.min_1.js"></script>
<script src="vendor/jquery-ui.js"></script> 
<script src="vendor/bootstrap.bundle.min.js"></script> 
  <script src="vendor/js/all.js"></script> 
  <script src="vendor/js/all.min.js"></script>
  <script src="vendor/datatable.js"></script>
  <script src="vendor/dataTables.buttons.min.js"></script>
  <script src="vendor/jszip.min.js"></script>
  <script src="vendor/pdfmake.min.js"></script>
   <script src="vendor/vfs_fonts.js"></script>
   <script src="vendor/buttons.html5.min.js"></script>
    <script src="vendor/buttons.bootstrap.min.js"></script>
     <script src="vendor/bootstable.js"></script>
    
     
    


</head>
<body class="fixed-sn light-blue-skin">
        
    <div id="page-content-wrapper">
    
        <jsp:include page="vendor/header1.jsp"></jsp:include>
        <div class="d-flex toggled" id="wrapper">            
            <jsp:include page="vendor/header.jsp"></jsp:include>
             <div class="overlay"></div>  
             
            <div class="container-fluid" id="containerflag">
              <div class="divider-1">
                <h1 class="page-header ">Welcome <%=userName%></h1>
                <p>2020 reserved rights</p>
            </div> 
            </div>
        </div>   
           
          <jsp:include page="vendor/footer.jsp"></jsp:include>       
    </div>
                
        
 <script>
    $("#menu-toggle").click(function(e) {
      e.preventDefault();
      $("#wrapper").toggleClass("toggled");
    });
    
  </script> 
  
      <script type="text/javascript">
 
 
 var startpoll;
 var startmonitor;
 var realtimepage;
 var selectedrow;
 
 
 $(function() {
      $("#serverstatus").click(function(evt) {
         $("#containerflag").load("<%=request.getContextPath()%>/ServerStatus");
         evt.preventDefault();
         StopPoll();
         StopMonitorPoll();
         startmonitor = setInterval(doMonitorPoll,10000);
      });
    });
    
 
 $(function() {
      $("#addphone").click(function(evt) {
         $("#containerflag").load("<%=request.getContextPath()%>/AddPhone");
         evt.preventDefault();
         StopPoll();
         StopMonitorPoll();
      });
    });
    
 $(function() {
      $("#viewreport").click(function(evt) {
         var maxrows = 5; 
         $("#containerflag").load("<%=request.getContextPath()%>/GetMaxRows?page=1&maxrows=" + maxrows);
         evt.preventDefault();
         StopPoll();
         StopMonitorPoll();
      });
    });  
 
  $(function() {
      $("#viewreport2").click(function(evt) {
         var maxrows = 5; 
         $("#containerflag").load("<%=request.getContextPath()%>/GetMaxRows2?page=1&maxrows=" + maxrows);
         evt.preventDefault();
         StopPoll();
         StopMonitorPoll();
      });
    });  
 
 
 
 $(function() {
      $("#realtimeview").click(function(evt) {
         realtimepage="1";
         selectedrow="10";
         $("#containerflag").load("<%=request.getContextPath()%>/GetRealTimeReport?page=" + realtimepage + "&maxrows=" + selectedrow);
         evt.preventDefault();
         StopMonitorPoll();
         StopPoll();
         startpoll = setInterval(doPoll,10000);
      });
    });  
 
 function doPoll(){
 
 $("#containerflag").text('refreshing database').append();
    
    $("#containerflag").load("<%=request.getContextPath()%>/GetRealTimeReport?page=" + realtimepage + "&maxrows=" + selectedrow);
};
   
   
 function StopPoll(){
     clearInterval(startpoll);
     startpoll = null;
};   
   
   
  function doMonitorPoll(){
 
 $("#containerflag").text('refreshing database').append();
    
    $("#containerflag").load("<%=request.getContextPath()%>/ServerStatus");
};
   
   
 function StopMonitorPoll(){
     clearInterval(startmonitor);
     startmonitor = null;
};  
   
   
  
  
  $(function() {
      $("#viewprofile").click(function(evt) {
         $("#containerflag").load("<%=request.getContextPath()%>/ViewProfile?user=<%=userName%>");
         evt.preventDefault();
         StopPoll();
         StopMonitorPoll();
      });
    }); 
    
    
      $(function() {
      $("#editprofile").click(function(evt) {
         $("#containerflag").load("<%=request.getContextPath()%>/EditProfile?user=<%=userName%>");
         evt.preventDefault();
         StopPoll();
         StopMonitorPoll();
      });
    }); 
    
    
     $(function() {
      $("#logout").click(function(evt) {
         $("#page-content-wrapper").load("<%=request.getContextPath()%>/Logout?user=<%=userName%>");
         evt.preventDefault();
         StopPoll();
         StopMonitorPoll();
      });
    });
    
      $(function() {
      $("#help").click(function(evt) {
         $("#containerflag").load("<%=request.getContextPath()%>/dashboard.jsp");
         evt.preventDefault();
         StopPoll();
         StopMonitorPoll();
      });
    });
    
    
       $(function() {
      $("#home").click(function(evt) {
         $("#containerflag").load("<%=request.getContextPath()%>/dashboard.jsp");
         evt.preventDefault();
         StopPoll();
         StopMonitorPoll();
      });
    });
    

 
    
</script> 

</body>     
</html>    