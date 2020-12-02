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

<script>
    
$(document).ready(function(){
	// Activate tooltips
       $('#DBtable3').dataTable({
  
           
       order: [[ 1, "asc" ]],
      bPaginate: false,
      bInfo : false,
       autoWidth: false,
      searching:true,
      dom: 'Bfrtip',
      buttons: [
           { extend: 'copy', className: 'btn btn-info glyphicon glyphicon-duplicate' },
           { extend: 'csv', className: 'btn btn-info glyphicon glyphicon-save-file' },
            { extend: 'excel', className: 'btn btn-info glyphicon glyphicon-list-alt' },
           { extend: 'pdf', className: 'btn btn-info glyphicon glyphicon-file' }
        ]
    });
      
});




</script>    
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

div.dataTables_wrapper div.dataTables_info{
   padding-top: 0.2em !important; 
 }

</style>      

</head>
<body>
            
                <div class="container-fluid" id="containerflag">
                    
                    <h2 class="sub-header placeholders">Phone Events</h2>
                    <div class="row-cols-0">
                        
                          <div class="wrapper-editor">
                              
                        
                    <span class="counter pull-right"></span>
                    <div class="table">
                    <div class="table-wrapper">
                    
                    <div class="divider-1">
                                 <div class="col-sm-12 col-md-2">
                                   
                                   
                                   <div class="num-rows">       
                                   <div class="form-group"> 	
                                      <select class  ="form-control" name="state" id="maxRows">
                                          <option value="show all rows">Rows: ${mrrow}</option>
                                                 <option value="5">5</option>
                                                 <option value="10">10</option>
                                                <option value="15">15</option>
                                                <option value="20">20</option>
                                               
                                        </select>
                                    </div>
                                   
                                   </div>
                               </div>
                        
                    <table id="DBtable3" class="table table-responsive table-hover table-active table-bordered"  style="width:100%"  >
                        <caption>List of user & phones</caption>
                        <thead class="thead-dark">
                            <tr>
                                
                                <th class="th-sm">#</th>
                                <th class="th-sm">EventId</th>
                                <th class="th-sm">EventText</th>
                                <th class="th-sm">Service</th>
                                <th class="th-sm">TimeofEvent</th>
                                <th class="th-sm">ActionRequired</th>
                                <th class="th-sm">UserId</th>
                                <th class="th-sm">MachineId</th>
                                <th class="th-sm">Line</th>
                            </tr>
                        </thead>
                  <tbody>
     <!--   for (Todo todo: todos) {  -->
                  <c:set var="count" value="${countervalue}" scope="page" /> 
                    <c:forEach var="todo" items="${List}">
                    <c:set var="count" value="${count + 1}" scope="page"/>
                    
                    <tr>
                        
                        <th  scope="row">${count}</th>
                        <td><c:out value="${todo.EventId}" /></td>
                        <td><c:out value="${todo.EventText}" /></td>
                        <td><c:out value="${todo.Service}" /></td>
                        <td><c:out value="${todo.TimeofEvent}" /></td>
                        <td><c:out value="${todo.ActionRequired}" /></td>
                        <td><c:out value="${todo.UserId}" /></td>
                        <td><c:out value="${todo.MachineId}" /></td>
                        <td><c:out value="${todo.Line}" /></td>
                        
                    </tr>
                    </c:forEach>
     <!-- } -->
                </tbody>
            </table>
            </div>        
            <div class="clearfix">
                
                <div class="hint-text">Showing <b>${recordsperpage}</b> out of <b>${totalrecords}</b> entries</div>
                <ul class="pagination">
                <c:if test="${currentpage != 1}">
                
                     <li class="page-item">
                            <a class="page-link" href="<%=request.getContextPath()%>/GetRealTimeReport?page=${currentpage - 1}" id="previous" aria-label="Previous">
                            <span aria-hidden="true">&laquo;</span>
                            <span class="sr-only" >Previous</a></span>
                            
                    </li>
                </c:if>
                <c:forEach begin="1" end="${noofpages}" var="i">
                    <c:choose>
                       <c:when test="${currentpage eq i}">
                            <li class="page-item active"><a class="page-link" href="#" id="current">${currentpage}</a></li>
                       </c:when>                 
                             
                       <c:otherwise>
                           
                                <li class="page-item" ><a href="#" id="varpage_${i}" class="page-link">${i}</a></li>
                     </c:otherwise>
                     </c:choose>
                </c:forEach> 
                    <c:if test="${currentpage != 1}">
                    <li class="page-item">    
                        <a class="page-link" href="#" id="next" aria-label="Next">
                        <span aria-hidden="true">&raquo;</span>    
                        <span class="sr-only" >Next</a></span>
                    </li>
                    </c:if>
                </ul>
            </div>
        </div>
	
</div>	
</div>
</div>
                
               
<script>
                    
 var maxrows = 5;
 

                                        
$(function() {
 $("#next").click(function(evt) {
    if (${maxrowsval}) {
        
        maxrows=${maxrowsval};
        
    }
  realtimepage =   ${currentpage + 1};
  selectedrow=  maxrows;
  $("#containerflag").load("<%=request.getContextPath()%>/GetRealTimeReport?page=${currentpage + 1}" + "&maxrows=" + maxrows);
   evt.preventDefault();
});
}); 

$(function() {
 $("#previous").click(function(evt) {
      if (${maxrowsval}) {
        
        maxrows=${maxrowsval};
        
    }
  realtimepage =   ${currentpage + 1};
  selectedrow=  maxrows;   
  $("#containerflag").load("<%=request.getContextPath()%>/GetRealTimeReport?page=${currentpage - 1}" + "&maxrows=" + maxrows);
   evt.preventDefault();
});
});



$(function() {
 $("[id^=varpage_]").click(function(evt) {
  var selected_id = evt.target.id.slice(8);
   if (${maxrowsval}) {
        
        maxrows=${maxrowsval};
        
    }
  realtimepage =   selected_id;
  selectedrow=  maxrows;
  $("#containerflag").load("<%=request.getContextPath()%>/GetRealTimeReport?page=" + selected_id + "&maxrows=" + maxrows );
   evt.preventDefault();
});
});




$(function() {
 $("#current").click(function(evt) {
      if (${maxrowsval}) {
        
        maxrows=${maxrowsval};
        
    }
  realtimepage =   $("#current").text();
  selectedrow=  maxrows;   
  $("#containerflag").load("<%=request.getContextPath()%>/GetRealTimeReport?page=" + $("#current").text() + "&maxrows=" + maxrows);
   evt.preventDefault();
});
});



                                        
$(function() {
 $("#maxRows").on('change',function(evt) {
     maxrows = parseInt($(this).val());
   $("#containerflag").load("<%=request.getContextPath()%>/GetRealTimeReport?page=1&maxrows=" + maxrows);
   $('[name=state]').val( '' );
   evt.preventDefault();
});
});


</script> 



</div>
</body>
</html>                
                  

