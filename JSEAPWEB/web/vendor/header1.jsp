 
<style>
    
    
 .custom-blue {
    background-color: #60a3bc;
    
}
 
.affix {
    top:50px;
    position:fixed;
}




</style>

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

      <nav class="navbar navbar-expand-lg navbar-light custom-blue border-bottom">
           <button class="btn btn-primary" id="menu-toggle"> <i class="fas fa-th-list "></i> Toggle Menu</button>

        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse navbar-text " id="navbarSupportedContent">
          <ul class="navbar-nav ml-auto mt-2 mt-lg-0">
            <li class="nav-item">
                <a class="nav-link" href="#" id="home"><i class="fas fa-home"></i>  Home <span class="sr-only">(current)</span></a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#" id="help"><i class="fas fa-info-circle"></i> Help</a>
            </li>
            <li class="nav-item  dropdown">
              <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
               <i class="fas fa-user-circle"></i> MyAccount
              </a>
                
              <div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdown">
                  
                <a class="dropdown-item" href="#" id="viewprofile"><i class="fas fa-user-times"></i>    Profile</a>
                <a class="dropdown-item" href="#" id="editprofile"><i class="fas fa-edit"></i>  Edit Profile</a>
                <div class="dropdown-divider"></div>
                <a class="dropdown-item " href="#" id="logout"><i class="fas fa-sign-out-alt"></i>  Logout</a>
              </div>
            </li>
          </ul>
        </div>
      </nav>
