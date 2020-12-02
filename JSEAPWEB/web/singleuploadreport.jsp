 <%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<script>
   
$(document).ready(function(){
	// Activate tooltips
	
       $('#DBTable1').dataTable({
       
       "order": [[ 1, "asc" ]],
      "bPaginate": true,
      "select":true,
      "bInfo" : true,
      "processing": true,
      "searching":true
      
    });    

    
});




</script> 


  <script>
      
      $(document).ready(function() {
    var table = $('#DBTable1').DataTable();
 
    $('#DBTable1 tbody').on( 'click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            $(this).removeClass('selected');
        }
        else {
            table.$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
    } );
 
    $('#btnYes').click( function () {
        
        table.row('.selected').remove().draw( false );
    } );
} );
      
  </script>


<div id="tablecontainer">
  <table id="DBTable1" class="table table-striped table-bordered" cellspacing="0" width="100%">
    <thead>
     <tr>
         <th class="th-sm">#</th>
          <th class="th-sm">MachineId</th>
           <th class="th-sm">UserId</th>
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
     <c:set var="count" value="${countervalue}" scope="page" /> 
                    <c:forEach var="todo" items="${List}">
                    <c:set var="count" value="${count + 1}" scope="page"/>
                    
                    <tr>
                        <th  scope="row">${count}</th>
                       <td><c:out value="${todo.MachineId}" /></td>
                        <td><c:out value="${todo.UserId}" /></td>
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
    <tfoot>
      <tr>
        <th>
        </th>
        <th>
        </th>
        <th>
        </th>
        <th>
        </th>
        <th>
        </th>
        <th>
        </th>
        <th>
        </th>
        <th>
        </th>
        <th>
        </th>
        <th>
        </th>
        <th>
        </th>
        <th>
        </th>
      </tr>
    </tfoot>
  </table>
</div> 