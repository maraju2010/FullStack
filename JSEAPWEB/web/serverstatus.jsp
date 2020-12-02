
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

<script>
   
$(document).ready(function(){
	// Activate tooltips
	
       $('#SVRTABLE').dataTable({
       
       "order": [[ 1, "asc" ]],
      "bPaginate": false,
      "bInfo" : false,
      "searching":true,
      dom: 'Bfrtip',
      buttons: [ 'copy', 'csv','excel', 'pdf' ]
  
    });    

    
});




</script>  


</head>
<body>
            <div class="container-fluid" id="containerflag">
                    <h2 class="sub-header placeholders">Service Status Report </h2>
                  <div class="row-cols-0">
                      <span class="counter pull-right"></span>
                                <div class="table-responsive">
                                <div class="table-wrapper">
                                <div class="mt-4">
                                <div class="divider-1">    
                                <table id="SVRTABLE" class="table table-striped table-hover table-bordered table-sm results">
                                    
                                    <thead class="thead-light">
                                        <tr>
                                            <th>#</th>
                                            <th>ServerHostName</th>
                                            <th>ServerIPAddress</th>
                                            <th>Service</th>
                                            <th>Status</th>
                                            <th>UP Time</th>                                       
                                        </tr>
                                    </thead>
                              <tbody>
                 <!--   for (Todo todo: todos) {  -->
                              <c:set var="count" value="${countervalue}" scope="page" /> 
                                <c:forEach var="todo" items="${List}">
                                <c:set var="count" value="${count + 1}" scope="page"/>

                                <tr>                      
                                   <th scope="row">${count}</th>
                                   <td><c:out value="${todo.ServerHostName}" /></td>
                                    <td><c:out value="${todo.ServerIPAddress}" /></td>
                                    <td><c:out value="${todo.Service}" /></td>
                                    <td><c:out value="${todo.Status}" /></td>
                                    <td><c:out value="${todo.UPTime}" /></td>
                                </tr>
                                </c:forEach>
                 <!-- } -->
                            </tbody>
                        </table>
                      </div>
                    </div>
                  </div>
                </div>	
           
               
</div>                                                                             
 </div>
</body>
</html>