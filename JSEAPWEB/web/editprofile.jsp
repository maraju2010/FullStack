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

</head>
<body>


           <div class="container" id="containerflag">
    <h1 class="page-header">Edit Profile</h1>
  	<hr>
	<div class="row">
      <!-- left column -->
      <div class="col-md-3">
        <div class="text-center">
          <img src="" class="avatar img-circle" alt="avatar">
          <h6>Upload a different photo...</h6>
          
          <input type="file" class="form-control">
        </div>
      </div>
      
      <!-- edit form column -->
      <div class="col-md-9 personal-info">
        <div class="alert alert-info alert-dismissable">
          <a class="panel-close close" data-dismiss="alert">×</a> 
          <i class="fa fa-coffee"></i>
          <div id="status"> This is an <strong>.alert</strong>. Use this to show important messages to the user.</div>
        </div>
        <h3>Personal info</h3>
        
        <form class="form-horizontal" role="form" id="save" action="#"  method="post">
          <div class="form-group">
            <label class="col-lg-3 control-label">First name:</label>
            <div class="col-lg-8">
              <input class="form-control" type="text" name="FirstName" value="${List.get(0).FirstName}">
            </div>
          </div>
          <div class="form-group">
            <label class="col-lg-3 control-label">Last name:</label>
            <div class="col-lg-8">
              <input class="form-control" type="text" name="LastName" value="${List.get(0).LastName}">
            </div>
          </div>
          <div class="form-group">
            <label class="col-lg-3 control-label">Company:</label>
            <div class="col-lg-8">
              <input class="form-control" type="text" name="Company" value="${List.get(0).Company}">
            </div>
          </div>
          <div class="form-group">
            <label class="col-lg-3 control-label">Email:</label>
            <div class="col-lg-8">
              <input class="form-control" type="text" name="EmailAddress" value="${List.get(0).EmailAddress}">
            </div>
          </div>
          <div class="form-group">
            <label class="col-lg-3 control-label">Time Zone:</label>
            <div class="col-lg-8">
              
              <div class="ui-select">
                <select id="user_time_zone" name="TimeZone" class="form-control">
                    
                  <option  value="Current">${List.get(0).TimeZone} </option>  
                  <option value="IST">(GMT-5:30) IST</option>
                  <option  value="PST">(GMT-08:00) Pacific Time (US &amp; Canada)</option>
                   </select>
              </div>
            </div>
          </div>
          <div class="form-group">
            <label class="col-md-3 control-label">Username:</label>
            <div class="col-md-8">
                <input readonly class="form-control" name="UserName" type="text" value="${List.get(0).UserName}">
            </div>
          </div>
          <div class="form-group">
            <label class="col-md-3 control-label">Password:</label>
            <div class="col-md-8">
              <input class="form-control" type="password" name="Password" value="${List.get(0).Password}">
            </div>
          </div>
          <div class="form-group">
            <label class="col-md-3 control-label">Confirm password:</label>
            <div class="col-md-8">
              <input class="form-control" type="password" value="${List.get(0).Password}">
            </div>
          </div>
          <div class="form-group">
            <label class="col-md-3 control-label"></label>
            <div class="col-md-8">
              <input type="button" id="savechange" class="btn btn-primary" value="Save Changes">
              <span></span>
              <input type="reset" id="reset" class="btn btn-default" value="Cancel">
            </div>
          </div>
        </form>
      </div>
  </div>
            <script>
      $(function(){
    $("#savechange").click(function(evt){   
        var form = $('#save');
        var result=null;
        
        $.ajax({
        type: form.attr('method'),
        url: "<%=request.getContextPath()%>/SaveChange",
        data: form.serialize(),
        
        success: function (data) {
            result=data;
        $('#status').text(result);

        },
                
         complete:function(){
            $('#save').each(function(){
                this.reset(); 
                $('#status').html(result);//Here form fields will be cleared.
            });
       }
        });
         
        return false;
    });
});   
               


</script>
            
</div>
        
</body>
</html>