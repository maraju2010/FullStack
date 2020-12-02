<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
 pageEncoding="ISO-8859-1"%>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="ISO-8859-1">
        <META HTTP-EQUIV="PRAGMA" CONTENT="NO-CACHE"> 
<META HTTP-EQUIV="Expires" CONTENT="-1">
<meta name=?viewport? content=?width=device-width, initial-scale=1.0">
        <title>JSEAP Portal</title>
        <link rel="stylesheet" href="vendor/bootstrap.min.css">
        <link rel="stylesheet" href="newfont.css">
        <link rel="stylesheet" href="vendor/css/all.css"/> 
        <link rel="stylesheet" href="vendor/css/all.min.css"/> 
        

  
  
<style>
body,
		html {
			margin: 0;
			padding: 0;
			height: 100%;
			background: #60a3bc !important;
		} 
    
.login-form {
    width: 400px;
    margin: 125px auto;
  	font-size: 15px;
}
.login-form form {
    margin-bottom: 30px;
    background: #f7f7f7;
    box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
    padding: 30px;
}
.login-form h4 {
    margin: 0 0 15px;
}
.form-control, .btn {
    min-height: 38px;
    border-radius: 2px;
}
.btn {        
    font-size: 15px;
    font-weight: bold;
}



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
<%
response.setHeader("Cache-Control","no-cache"); 
response.setHeader("Pragma","no-cache"); 
response.setDateHeader ("Expires", -1);
%>


<script>
    
    
    var startpoll;
 var startmonitor;
    $(document).ready(function(){
          StopPoll();
         StopMonitorPoll();
        
    });
    
    
     function StopMonitorPoll(){
     clearInterval(startmonitor);
     startmonitor = null;
};  

 function StopPoll(){
     clearInterval(startpoll);
     startpoll = null;
};   
   
   

</script>

    </head>
<body class="fixed-sn light-blue-skin">
<div id="page-content-wrapper">   
       
<div class="login-form">
     <div>
            ${status}
        </div>
        
    <form action="<%=request.getContextPath()%>/Login" method="post" class="modal-body">
        
        <div class="divider-1">
         <i class="fas fa-sign-in-alt fa-2x"></i>
        </div>
         <div class="divider-1">
         <h4 class="align-top-text-top text-center text-dark">JSEAP Portal</h4>
        </div>
        
        <div class="form-group">
            <input type="text" class="form-control" placeholder="username" name="username" required="required">
        </div>
        <div class="form-group">
            <input type="password" class="form-control" placeholder="password" name="password" required="required">
        </div>
        <div class="form-group">
            <button type="submit" class="btn btn-primary btn-block">Log in</button>
        </div>
       
    </form>
    
</div>
        
   <jsp:include page="vendor/footer.jsp"></jsp:include>      
</div>  
    </body>

    </html>
    
    
    