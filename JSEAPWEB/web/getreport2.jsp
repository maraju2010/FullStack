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
       $('#DBtable2').dataTable({
  
           
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
                    
                    <h2 class="sub-header placeholders">Machine Phone Map</h2>
                    <div class="row-cols-0">
                        
                          <div class="wrapper-editor">
                              
                              <div id="singlestatus2"></div>
  <div class="row d-flex justify-content-center modalWrapper" data-backdrop="false">
    <div class="modal fade" id="modalView" tabindex="-1" role="dialog" aria-labelledby="modalView"
      aria-hidden="true">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header text-center">
            <h4 class="modal-title w-100 font-weight-bold ml-5 text-info">View</h4>
            <button type="button" class="close text-info" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body mx-3">
            <p class="text-center h4">Do you want to fetch report?</p>

          </div>
          <div class="modal-footer d-flex justify-content-center deleteButtonsWrapper">
            <button type="button" class="btn btn-success btnYesClass" id="btnYesview" data-dismiss="modal">Yes</button>
            <button type="button" class="btn btn-primary btnNoClass" id="btnNoview" data-dismiss="modal">No</button>
          </div>
        </div>
      </div>
    </div>  
      
      
    <div class="modal fade addNewInputs" id="modalAdd" tabindex="-1" role="dialog" aria-labelledby="modalAdd"
      aria-hidden="true">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header text-center">
            <h4 class="modal-title w-100 font-weight-bold text-primary ml-5">Add Machine-Phone</h4>
            <button type="button" class="close text-primary" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
           <form method="post" action="#" id="singleupload2">
          <div class="modal-body with-padding">
            <div class="form-group">
              <div class="row">
                <div class="col-sm-12">
                  <label>MachineId :</label>
                   <input type="text" name="MachineId" id="MachineId"  class="form-control" required>
                </div>
              </div>
            </div>
            <div class="form-group">
              <div class="row">
                <div class="col-sm-12">
                  <label>Line :</label>
                   <input type="text" name="Line" id="Extension"  class="form-control" required>
                </div>
              </div>
            </div>
              <div class="form-group">
              <div class="row">
                <div class="col-sm-12">
                  <label>Phone :</label>
                   <input type="text" name="Phone" id="Phone" class="form-control" required>
                </div>
              </div>
            </div>
             <div class="form-group">
              <div class="row">
                <div class="col-sm-12">
                  <label>PartitionId :</label>
                   <input type="text" name="PartitionId" id="PartitionId" class="form-control" required>
                </div>
              </div>
            </div>  
            <div class="form-group">
              <div class="row">
                <div class="col-sm-12">
                  <label>recordingFlag :</label>
                   <textarea name="text" name="recordingFlag" id="recordingFlag" class="form-control"></textarea>
                </div>
              </div>
            </div>
            <div class="form-group">
              <div class="row">
                <div class="col-sm-12">
                  <label>recordingMediaSource :</label>
                   <input type="text" name="recordingMediaSource" id="recordingMediaSource" class="form-control">
                </div>
              </div>
            </div>
             <div class="form-group">
              <div class="row">
                <div class="col-sm-12">
                  <label>recordingProfileName :</label>
                   <input type="text" name="recordingProfileName" id="recordingProfileName" class="form-control">
                </div>
              </div>
            </div>
              <div class="form-group">
              <div class="row">
                <div class="col-sm-12">
                  <label>monitoringCssName :</label>
                   <input type="text" name="monitoringCssName" id="monitoringCssName" class="form-control">
                </div>
              </div>
            </div>
             <div class="form-group">
              <div class="row">
                <div class="col-sm-12">
                  <label>e164Mask :</label>
                   <input type="text" name="e164Mask" id="e164Mask" class="form-control">
                </div>
              </div>
            </div>
             <div class="form-group">
              <div class="row">
                <div class="col-sm-12">
                  <label>displayAscii :</label>
                   <input type="text" name="displayAscii" id="displayAscii" class="form-control">
                </div>
              </div>
            </div>  
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-warning" data-dismiss="modal">Cancel</button>
            <span id="add">
              <input type="hidden" name="id" value="" id="id">
              <button type="submit" name="form_data" class="btn btn-primary">Submit</button>
            </span>
          </div>
        </form>  
        </div>
      </div>
    </div>
      
     <div class="modal fade" id="modalDelete" tabindex="-1" role="dialog" aria-labelledby="modalDelete"
      aria-hidden="true">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header text-center">
            <h4 class="modal-title w-100 font-weight-bold ml-5 text-danger">Delete</h4>
            <button type="button" class="close text-danger" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body mx-3">
            <p class="text-center h4">Are you sure to delete selected row?</p>

          </div>
          <div class="modal-footer d-flex justify-content-center deleteButtonsWrapper">
            <button type="button" class="btn btn-danger btnYesClass" id="btnYes" data-dismiss="modal">Yes</button>
            <button type="button" class="btn btn-primary btnNoClass" id="btnNo" data-dismiss="modal">No</button>
          </div>
        </div>
      </div>
    </div>  
      
    <div class="text-center">
      <a href="" class="btn btn-success btn-rounded btn-sm" data-toggle="modal" data-target="#modalAdd">Add<i
          class="fas fa-plus-square ml-1"></i></a>
    </div>
  </div>
                        
                    <span class="counter pull-right"></span>
                    <div class="table-responsive-sm">
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
                        
                    <table id="DBtable2" class="table table-responsive table-hover table-active table-bordered  table-sm display small " style="width:100%">
                        <caption>List of user & phones</caption>
                        <thead class="thead-dark">
                            <tr>
                                <th class="th-sm">Delete Row</th>
                                <th class="th-sm">#</th>
                                <th class="th-sm">MachineId</th>
                                <th class="th-sm">Line</th>
                                 <th class="th-sm">Phone</th>
                                <th class="th-sm">Partition</th>
                                <th class="th-sm">recordingFlag</th>
                                <th class="th-sm">recordingMediaSource</th>
                                <th class="th-sm">recordingProfileName</th>
                                <th class="th-sm">MonitoringCSSName</th>
                                <th class="th-sm">e164Mask</th>
                                <th class="th-sm">displayAscii</th>
                            </tr>
                        </thead>
                  <tbody>
     <!--   for (Todo todo: todos) {  -->
                  <c:set var="count" value="${countervalue}" scope="page" /> 
                    <c:forEach var="todo" items="${List}">
                    <c:set var="count" value="${count + 1}" scope="page"/>
                    
                    <tr class="btnDelete" data-id=${todo.MachineId}>
                        <td><button class="btnDelete buttonDelete btn-danger" href=""><i class="fa fa-trash" aria-hidden="true"></i></button></td>
                        <th  scope="row">${count}</th>
                       <td><c:out value="${todo.MachineId}" /></td>
                        <td><c:out value="${todo.Line}" /></td>
                        <td><c:out value="${todo.Phone}" /></td>
                        <td><c:out value="${todo.PartitionId}" /></td>
                        <td><c:out value="${todo.recordingFlag}" /></td>
                        <td><c:out value="${todo.recordingMediaSource}" /></td>
                        <td><c:out value="${todo.recordingProfileName}" /></td>
                        <td><c:out value="${todo.MonitoringCSSName}" /></td>
                        <td><c:out value="${todo.e164Mask}" /></td>
                        <td><c:out value="${todo.displayAscii}" /></td>
                        
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
                            <a class="page-link" href="<%=request.getContextPath()%>/GetReport?page=${currentpage - 1}" id="previous" aria-label="Previous">
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
  $("#containerflag").load("<%=request.getContextPath()%>/GetMaxRows2?page=${currentpage + 1}" + "&maxrows=" + maxrows);
   evt.preventDefault();
});
}); 

$(function() {
 $("#previous").click(function(evt) {
      if (${maxrowsval}) {
        
        maxrows=${maxrowsval};
        
    }
     
  $("#containerflag").load("<%=request.getContextPath()%>/GetMaxRows2?page=${currentpage - 1}" + "&maxrows=" + maxrows);
   evt.preventDefault();
});
});



$(function() {
 $("[id^=varpage_]").click(function(evt) {
  var selected_id = evt.target.id.slice(8);
   if (${maxrowsval}) {
        
        maxrows=${maxrowsval};
        
    }
  
  $("#containerflag").load("<%=request.getContextPath()%>/GetMaxRows2?page=" + selected_id + "&maxrows=" + maxrows );
   evt.preventDefault();
});
});




$(function() {
 $("#current").click(function(evt) {
      if (${maxrowsval}) {
        
        maxrows=${maxrowsval};
        
    }
     
  $("#containerflag").load("<%=request.getContextPath()%>/GetMaxRows?page=" + $("#current").text() + "&maxrows=" + maxrows);
   evt.preventDefault();
});
});



                                        
$(function() {
 $("#maxRows").on('change',function(evt) {
     maxrows = parseInt($(this).val());
   $("#containerflag").load("<%=request.getContextPath()%>/GetMaxRows2?page=1&maxrows=" + maxrows);
   $('[name=state]').val( '' );
   evt.preventDefault();
});
});


</script> 

  
  <script>
         
  $(function(){
    $("#singleupload2").submit(function(evt){   
        var form = $('#singleupload2');
        var result=null;
        
        $.ajax({
        type: form.attr('method'),
        url: "<%=request.getContextPath()%>/SinglePhone2",
        data: form.serialize(),
        
        success: function (data) {
            result=data;
        $('#singlestatus2').text(result);

        },
                
         complete:function(){
            $('#singleupload2').each(function(){
                this.reset(); 
                $('#singlestatus2').html(result);//Here form fields will be cleared.
                $('#modalAdd').modal('hide');
            });
       }
        });
        return false;
    });
});

$(function() {
$('button.btnDelete').on('click', function (e) {
    e.preventDefault();
    var id = $(this).closest('tr').data('id');
    $('#modalDelete').data('id', id).modal('show');
});

});

  $(function(){
    $("#btnYes").click(function(evt){   
        var id =  $('#modalDelete').data('id');
        console.log(id);
         $('#singlestatus2').load("<%=request.getContextPath()%>/deletephone2?MachineId=" + id);
         evt.preventDefault();

        
    });
});



  </script>


</div>
</body>
</html>                
                  

