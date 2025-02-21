<!--
=========================================================
* Material Dashboard 2 PRO - v3.0.6
=========================================================

* Product Page:  https://www.creative-tim.com/product/material-dashboard-pro 
* Copyright 2022 Creative Tim (https://www.creative-tim.com)
* Coded by Creative Tim

=========================================================

* The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
-->

<!DOCTYPE html>
<html lang="en">
<%@ page isELIgnored="false"%>
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- J query Cdn  -->
<script src="https://code.jquery.com/jquery-3.7.0.min.js"
	integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g="
	crossorigin="anonymous"></script>



<link rel="icon" type="image/png" href="./assets/img/favicon.ico">
<title>DAKSHABHI-Project Management System</title>
<!--     Fonts and icons     -->
<link rel="stylesheet" type="text/css"
	href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700,900|Roboto+Slab:400,700" />
<!-- Nucleo Icons -->
<link href="./assets/css/nucleo-icons.css" rel="stylesheet" />
<link href="./assets/css/nucleo-svg.css" rel="stylesheet" />
<!-- Font Awesome Icons -->
<script src="https://kit.fontawesome.com/42d5adcbca.js"
	crossorigin="anonymous"></script>
<!-- Material Icons -->
<link
	href="https://fonts.googleapis.com/icon?family=Material+Icons+Round"
	rel="stylesheet">
<!-- CSS Files -->
<link id="pagestyle" href="./assets/css/material-dashboard.css?v=3.0.6"
	rel="stylesheet" />
</head>

<body class="bg-gray-200">
	<!-- Navbar -->
	<nav
		class="navbar navbar-expand-lg position-absolute top-0 z-index-3 w-100 shadow-none my-3 navbar-transparent mt-4">
		<div class="container"></div>
	</nav>
	<!-- End Navbar -->
	<main class="main-content  mt-0">
		<div class="page-header align-items-start min-vh-100"
			style="background-image: url('./assets/img/pms-banner.jpg?v=1');">
			<span class="mask bg-gradient-dark opacity-6"></span>
			<div class="container my-auto">
				<div class="row">
					<div class="col-lg-4 col-md-8 mx-auto">
						<div class="card z-index-0">
							<div
								class="card-header p-0 position-relative mt-n4 mx-3 z-index-2">
								<div
									class="bg-gradient-info shadow-success border-radius-lg py-3 pe-1">
									<h5 class="text-white font-weight-bolder text-center mt-2 mb-0">Register your company
										with Taskistic</h5>
									 
								</div>
							</div>
							 
							<div class="card-body">
								<form role="form" autocomplete="off">
									<div class="input-group input-group-dynamic mb-3">
										<label class="form-label"> Company Name</label> <input type="text"
											class="form-control" id="companyNameId" aria-label="Name" autocomplete="off">
									</div>
									
									<div class="input-group input-group-dynamic mb-3">
										<label class="form-label"> URL</label> <input type="text"
											class="form-control" aria-label="url" id="companyURLId" autocomplete="off">.taskistic.com
										<span class="msgError" id="msgError_companyUrlid"></span>	
									</div>
									<div class="input-group input-group-dynamic mb-3">
										<label class="form-label">Email</label> <input type="email"
											class="form-control" aria-label="Email" id="emailId" autocomplete="off">
									</div>
									<div class="input-group input-group-dynamic mb-3">
										<label class="form-label">Phone</label> <input
											type="tel" class="form-control" aria-label="phone" id="phoneId" autocomplete="off">
									</div>
									<div class="form-check text-start ps-0">
										<input class="form-check-input bg-dark border-dark"
											type="checkbox" value="" id="flexCheckDefault" checked>
										<label class="form-check-label" for="flexCheckDefault">
											I agree the <a href="javascript:;"
											class="text-dark font-weight-bolder">Terms and Conditions</a>
										</label>
									</div>
									<div class="text-center">
										<button type="button" onclick="doRegister()"
											class="btn bg-gradient-dark w-100 my-4 mb-2">Sign up</button>
									</div>
									 
								</form>
							</div>
						</div>
					</div>
				</div>
			</div> 

		</div>


	</main>
	<!--   Core JS Files   -->


	<script src="./assets/js/core/popper.min.js"></script>
	<script src="./assets/js/core/bootstrap.min.js"></script>
	<script src="./assets/js/plugins/perfect-scrollbar.min.js"></script>
	<script src="./assets/js/plugins/smooth-scrollbar.min.js"></script>
	<!-- Kanban scripts -->
	<script src="./assets/js/plugins/dragula/dragula.min.js"></script>
	<script src="./assets/js/plugins/jkanban/jkanban.js"></script>
	<script> 
		 
		function updateCompanyURL(){
			console.log($("#companyNameId").val().replace(/ /g,'').toLowerCase());
			$("#companyURLId").val($("#companyNameId").val().replace(/ /g,'').toLowerCase());
		}
		$("#companyNameId").change(function(){
			updateCompanyURL();
		});
		
		$("#companyNameId").blur(function(){
			updateCompanyURL();
		});
		
		
		function doRegister(){
			$("#msgError_companyUrlid").text("");
			
			updateCompanyURL(); 
			if(!iscompanyurlexist()){ 
				
			}else{ 
				
			}
		}
		
		function iscompanyurlexist(){
			$("#companyURLId").val();
			$.ajax({
				url : "cregistration",
				type : "POST",
				data : {
					actionType : "checkCompanyURL",
					companyUrl : $("#companyURLId").val() 
				},
				success : function(resp) {
					console.log(resp =='true');
					if(resp =='true'){
						$("#msgError_companyUrlid").text("Company URL already regustered. Please use different company url.");
						return true;
					} 
					else
						return false;
				}
			})
			
		}
		
	</script>
	<!-- Github buttons -->
	<script async defer src="https://buttons.github.io/buttons.js"></script>
	<!-- Control Center for Material Dashboard: parallax effects, scripts for the example pages etc -->
	<script src="./assets/js/material-dashboard.min.js?v=3.0.6"></script>

</body>

</html>