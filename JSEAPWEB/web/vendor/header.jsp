<style>
    


    
    .custom-black {
        width: 250px;
	background: #444; color: #fff; box-shadow: 3px 3px 3px rgba(51, 51, 51, 0.5);
	text-align: left;
        
    
}
.custom-black.active { left: 0; }

.custom-black.to-top { padding: 20px; text-align: center; }


.overlay {
    display: none; position: fixed; width: 100vw; height: 100vh; 
    background: rgba(51, 51, 51, 0.7); z-index: 998; opacity: 0; transition: all .5s ease-in-out;
}

.overlay.active { display: block; opacity: 1; }


body { font-family: 'Roboto', sans-serif; font-size: 16px; font-weight: 300; color: #888; line-height: 30px; }

strong { font-weight: 500; }

a { color: #f35b3f; border-bottom: 1px; text-decoration: none; transition: all .3s; }
a:hover, a:focus { color: #f35b3f; border: 0; text-decoration: none; }




.sidebar-menu a[data-toggle="collapse"] {
    position: relative;
}

.sidebar-menu .dropdown-toggle::after {
    display: block;
    position: absolute;
    top: 50%;
    right: 20px;
    transform: translateY(-50%);
}

.sidebar-menu ul.menu-elements { padding: 10px 0; border-bottom: 0px solid #444; transition: all .3s; }

.sidebar-menu  ul li a {
	display: block; padding: 10px 20px;
	border: 0; color: #fff;
}
.sidebar-menu  ul li a:hover,
.sidebar-menu  ul li a:focus,
.sidebar-menu  ul li.active > a:hover,
.sidebar-menu  ul li.active > a:focus { outline: 0; background: #555; color: #fff; }

.sidebar-menu  ul li a i { margin-left: 0px; }

.sidebar-menu  ul li.active > a, a[aria-expanded="true"] {
	background: #444;
	color: #fff;
}

.sidebar-menu  ul ul a { background: #444; padding-left: 10px; font-size: 14px; }

.sidebar-menu  ul ul li.active > a { background: #555; }

.sidebar-wrapper.light { background: #fff; color: #888; }



h1,h2 { margin-top: 10px; font-size: 38px; font-weight: 100; color: #555; line-height: 50px; }
h3 { font-size: 22px; font-weight: 300; color: #555; line-height: 30px; }
h4 { font-size: 18px; font-weight: 300; color: #555; line-height: 26px; }
    

.section-container { margin: 0 auto; padding-bottom: 80px; }

.section-container-gray-bg { background: #f8f8f8; }

.section-container-image-bg, 
.section-container-image-bg h2, 
.section-container-image-bg h3 { color: #fff; }

.section-container-image-bg .divider-1 span { border-color: #fff; border-color: rgba(255, 255, 255, 0.8); }

.section-description { margin-top: 60px; padding-bottom: 10px; }

.section-description p { margin-top: 20px; padding: 0 120px; }
.section-container-image-bg .section-description p { opacity: 0.8; }

.section-bottom-button { padding-top: 20px; }


/***** Section 1 *****/

.section-1-box { padding-top: 30px; text-align: left; }

.section-1-box .section-1-box-icon {
	width: 80px; height: 80px; margin: 0 auto;
	border: 1px solid #f35b3f;
    font-size: 40px; color: #f35b3f; line-height: 78px; text-align: center;
    border-radius: 50%;
}

.section-1-box h2 { margin-top: 0; padding: 0 0 10px 0; }


/***** Section 2 *****/

.section-2-box { margin-top: 30px; text-align: left; }

.section-2-box .section-2-box-icon {
	width: 60px; height: 60px; margin: 0 auto;
	background: #f35b3f;
    font-size: 28px; color: #fff; line-height: 60px; text-align: center;
    border-radius: 50%;
}

.section-2-box h2 { margin-top: 10px; padding: 0 0 10px 0; }


input[readonly]{
  background-color:transparent;
  border: 0;
  font-size: 1em;
}

.search-box {
    position:absolute;
    float: right;
    
}
.search-box .input-group {
    min-width:300px;
    position: absolute;
    left:0;
}
.search-box .input-group-addon, .search-box input {
    border-color: #ddd;
    border-radius: 0;
}	
.search-box input {
    height: 34px;
    padding-right: 15px;
    background: #f4fcfd;
    border: none;
    border-radius: 2px 
}
.search-box input:focus {
    background: #fff;
}
.search-box input::placeholder {
    font-style: italic;
}
.search-box .input-group-addon {
    min-width: 15px;
    border: none;
    background: transparent;
    position: absolute;
    right: 0;
    z-index: 9;
    padding: 3px 0;
}
.search-box i {
    color: #a0a5b1;
    font-size: 19px;
    position: absolute;
    top: 2px;
}

.sub-header {
  padding-bottom: 10px;
  border-bottom: 1px solid #eee;
}


</style>
    <!-- Sidebar -->
    <div class="custom-black border-right-0" id="sidebar-wrapper" >
        <div class="sidebar-content">
       <div class="overlay"></div>        
        <nav class="sidebar-menu">
            <div class="sidebar-brand"> 
                <div class="sidebar-heading divider-1"> <i class="fas fa-cog"></i> Dashboard</div>
            </div>
            <ul class="list-unstyled menu-elements">
            <li class="active">
		<a href="#Config" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle divider-1" role="button" aria-controls="Config">
                    <i class="fas fa-folder"></i>  Configuration
		</a>
                    <ul class="collapse list-unstyled"  id="Config">
                        
                        <li>
                            <a class="scroll-link text-center" id="viewreport" href="#" > <i class="fas fa-mobile"></i> Phone Map</a>
                        </li>
                        
                        <li>
                            <a class="scroll-link text-center" id="viewreport2" href="#" > <i class="fas fa-desktop"></i> Machine Map</a>
                        </li>
                        
                        <li>
                            <a class="scroll-link text-center" id="addphone" href="#"><i class="fas fas fa-upload"></i>  Bulk Upload </a>
                            
			</li>
                    </ul>
	    </li>
            
            <li class="active">
		<a href="#Reports" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle divider-1" role="button" aria-controls="Reports">
                    <i class="fas fa-folder"></i>  Reports
		</a>
                    <ul class="collapse list-unstyled"  id="Reports">
                        
                        <li>
                            <a class="scroll-link text-center" id="realtimeview" href="#" > <i class="fas fa-database"></i>Current</a>
                        </li>
                    </ul>
	    </li>
            
            
              <li class="active">
		<a href="#Service" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle divider-1" role="button" aria-controls="Service">
                    <i class="fas fa-folder"></i>  Service Control
		</a>
                    <ul class="collapse list-unstyled"  id="Service">
                        
                        <li>
                            <a class="scroll-link text-center" id="serverstatus" href="#"><i class="fas fa-server"></i>  Status</a>
                        </li>
                    </ul>
	    </li>
            
            </ul>
        </nav>
      </div>
    </div>
         
    <!-- /#sidebar-wrapper -->

    <!-- Page Content -->
    
  
  