 <%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <META HTTP-EQUIV="PRAGMA" CONTENT="NO-CACHE"> 
    <META HTTP-EQUIV="Expires" CONTENT="-1">
    <meta name="viewport" content="minimum-scale=1">
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

-webkit-transform: translateZ(0);
z-index: 1000;

 .progressbar {
  width:300px;
  height:21px;
}
.progressbarlabel {
  width:300px;
  height:21px;
  position:absolute;
  text-align:center;
  font-size:small;
}

.ui-progressbar {
  height: 2em;
  text-align: left;
  overflow: hidden;
}
.ui-progressbar .ui-progressbar-value {
  margin: -1px;
  height: 100%;
  background-color: #ccc;
}

</style>
<script>
   
$(document).ready(function(){
	// Activate tooltips
	
       $('#DBTable1').dataTable({
       
       "order": [[ 1, "asc" ]],
      "bPaginate": true,
      "bInfo" : true,
      "processing": true,
      "searching":true
      
    });    

    
});




</script> 
</head>
<body>    
        
        
        <div class="container-fluid" id="containerflag">
            
            
                <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">    
                 <h2 class="sub-header"> Bulk Phones</h2>   
                  <div>
                      <a href="#" class="downloadlink-info">Get Phone Templates</a>
                  </div>
                 <div>
                       <span><input type="button" class="downloadButton" id="usertemplate" value="UserId Template" /></span>
                       <span><input type="button" class="downloadButton" id="machinetemplate" value="MachineId Template" /></span>
                        
                  </div>
                 <div class="row placeholders">
                    
                <form action="#" id="uploadfile" method="post" enctype="multipart/form-data" class="modal-body"> 
                           <div id=status class="alert">${status}</div>
                                <div class="col-md-12 section-1-box wow fadeInLeft">
                                    <div class="col-md-12">
                                           <div class="input-group mb-4">
                                           <div class="custom-file">
                                               <input type="file" name="file" class="custom-file-input" id="inputGroupFile03">
                                               <label class="custom-file-label" for="inputGroupFile03">Choose file...</label>
                                           </div> 
                                           </div>     
                                    
                                    <div class="input-group">    
                                       <button type="submit" class="btn btn-primary btn-block">Upload File</button>

                                    </div>
                                    </div>
                                </div>                          

                </form>
                                
                 </div>
                     
                                <div id="progressbar" class="progressbar">
                    <div id="progresslabel" class="progressbarlabel"></div>
                </div>
                 </div>
                  
              

    <script>
      var flag = 0;
      $('.custom-file-input').on('change', function() {
        let fileName = $(this).val().split('\\').pop(); 
        $(this).next('.custom-file-label').addClass("selected").html(fileName);
         if (flag>0) {
            var progress = Math.round(0);
            $("#progressbar").progressbar("value", progress);
            $("#progresslabel").text($("#progressbar").progressbar("value") + "%");
            
        }
        flag=1;
});
  </script> 
  
  <script>
      
   $(function(){
    $("#uploadfile").submit(function(evt){   
        evt.preventDefault();
        var result;
        var percentComplete;
        $.ajax({
            xhr: function() {
            var xhr = new window.XMLHttpRequest();
            xhr.upload.addEventListener("progress", function(evt) {
                   if (evt.lengthComputable) {
                         var progress = Math.round(evt.loaded * 100 / evt.total);
                        $("#progressbar").progressbar("value", progress);
                    } 
                }, false);
            return xhr;
            },
            
            
            url: '<%=request.getContextPath()%>/UpdatePhone',
            type: "POST",
            data: new FormData(document.getElementById("uploadfile")),
            enctype: 'multipart/form-data',
            processData: false,
            contentType: false,
            success: function (data) {
                
                var result = data;
                $('#status').text(result);
                
                 
            },error : function(data) {
                var result = data;
                $('#status').text(result);
                 
               
            },
              complete:function(){
            $('#uploadfile').each(function(){
                $('#status').html(result);//Here form fields will be cleared.
                
            });
       }
            
            
          });
        

            $("#progressbar").progressbar({
                max: 100,
                change: function (evt, ui) {
                $("#progresslabel").text($("#progressbar").progressbar("value") + "%");
            },
               complete: function (evt, ui) {
                   $('#status').html(result);//Here form fields will be cleared.
                    
                
            }
           });
          
    });
});

  </script> 
  <script>
   
        $("#usertemplate").click(function(){
            var href ="vendor/Files/User_Template.csv"
            window.location.href = href;
});

$("#machinetemplate").click(function(){
            var href = "vendor/Files/Machine_Template.csv";
            window.location.href = href;
});

  </script>
        </div>
</body>
</html>
  