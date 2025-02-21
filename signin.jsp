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
<%@page import="java.util.List"%>
<%@page import="com.dakshabhi.common.constants.ConfigConstants"%>
<%@page import="com.dakshabhi.pms.companies.daos.CCompanyDAO"%>
<%@page import="com.dakshabhi.pms.companies.dtos.CCompanyDTO"%>
<%
String url = request.getServerName().toString();
System.out.println("url: " + url);
String companyID = session.getAttribute("companyID") == null ? "" : (String) session.getAttribute("companyID");
String companyName =  session.getAttribute("companyName") == null ? "" : (String) session.getAttribute("companyName");
if (companyID.equals("")) {
	
	 companyID = CCompanyDAO.getCompanyIDByURL(url);
	 CCompanyDTO cCompanyDTO = CCompanyDAO.getCompanyInfoByUrl(url);
	 companyName = cCompanyDTO.getCompany_name();
	 
	if (!companyID.equals("") && !companyName.equals("")) {
		session.setAttribute("companyID", companyID);
		session.setAttribute("companyName", companyName);
	}
}
String deviceToken = session.getAttribute("deviceToken") == null ? "" : (String) session.getAttribute("deviceToken");
System.out.println("Company ID: " + companyID + " deviceToken: " + deviceToken);
System.out.println("Company Name: " + companyName + " deviceToken: " + deviceToken);
%>

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
			<span class="bg-gradient-dark"></span>
			 
			<div class="container my-auto">

				<div class="row">

					<div class="col-lg-4 col-md-8 mx-auto">
						<div class="card z-index-0">

							<div
								class="card-header p-0 position-relative mt-n4 mx-3 z-index-2">
								<div
									class="shadow-info border-radius-lg py-3 pe-1 text-center py-3">
									<img src="./assets/img/main-logo.png" class="navbar-brand-img h-100" alt="main_logo">
								 	<div><%=companyName%></div>
								</div>
							</div>
							<%
							Cookie[] cookies = request.getCookies();
							String userName = "", password = "", rememberVal = "";
							if (cookies != null) {
								for (Cookie cookie : cookies) {
									if (cookie.getName().equals("cookusername")) {
								userName = cookie.getValue();
									}
									if (cookie.getName().equals("cookpass")) {
								password = cookie.getValue();
									}
									if (cookie.getName().equals("cookrem")) {
								rememberVal = cookie.getValue();
									}
								}
							}
							%>
							<div class="card-body">
								<%
								if (request.getSession().getAttribute("errorMessage") != null) {
								%>
								<span class="text-center" style="color: red;"> <%=request.getSession().getAttribute("errorMessage")%></span>
								<%
								request.getSession().removeAttribute("errorMessage");
								request.getSession().removeAttribute("loginerrorMessage");
								}
								%>
								<%
								if (request.getSession().getAttribute("loginerrorMessage") != null) {
								%>
								<span class="text-center" style="color: red;"> <%=request.getSession().getAttribute("loginerrorMessage")%></span>
								<%
								request.getSession().removeAttribute("loginerrorMessage");
								request.getSession().removeAttribute("errorMessage");
								}
								%>
								
								
								<form role="form" class="text-start" action="userlogin"
									method="post">
									<div class="input-group input-group-static mb-4">
										<input type="hidden" name="deviceTokenName" id="deviceTokenId" value="<%=deviceToken%>">
									</div>
									<div class="input-group input-group-static mb-4">
										<label>Email Or Phone Number</label> <input
											class="form-control" name="username"
											placeholder="abc@example.com /123-45-678"
											value="<%=userName%>" id="email"> <span
											style="color: red; display: none;" id="showError"></span>
									</div>
									<div class="input-group input-group-static mb-2">
										<label>Password</label> <input type="password"
											class="form-control" name="password" value="<%=password%>"
											placeholder="*************" required="required"
											id="passwordId"> <span id="passErrorId"
											style="display: none; color: red;"></span>
									</div>
									<div
										class="form-check form-switch d-flex align-items-center mb-3">
										<input class="form-check-input" type="checkbox"
											id="rememberMe" class="mt-1" name="rememberme"
											value="Rememberme" <%=rememberVal != "" ? "checked" : ""%>>
										<label class="form-check-label mb-0 ms-3" for="rememberMe">Remember
											me</label>
									</div>

									<div class="text-center">
										<button type="submit"
											class="btn bg-gradient-dark w-100 mt-3 mb-0"
											onclick=" return validate()">Sign in</button>
									</div>
								</form>
							</div>
							<div class="card-footer text-center pt-0 px-lg-2 px-1">
								<p class="mb-4 text-sm mx-auto">
									Forgot password? <a href="forgotpassword.jsp"
										class="text-success text-gradient font-weight-bold">Click
										here</a>
								</p>
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
		var win = navigator.platform.indexOf('Win') > -1;
		if (win && document.querySelector('#sidenav-scrollbar')) {
			var options = {
				damping : '0.5'
			}
			Scrollbar.init(document.querySelector('#sidenav-scrollbar'),
					options);
		}
				
	</script>
	<!-- Github buttons -->
	<script async defer src="https://buttons.github.io/buttons.js"></script>
	<!-- Control Center for Material Dashboard: parallax effects, scripts for the example pages etc -->
	<script src="./assets/js/material-dashboard.min.js?v=3.0.6"></script>
	<script type="text/javascript">
	function validate(){
		
		var regex = /^\w+[\+\.\w-]*@([\w-]+\.)*\w+[\w-]*\.([a-z]{2,4}|\d+)$/i;
		var email = $('#email').val();
		var password = $('#passwordId').val(); 
			if (email == '') {
				$("#showError")
						.text("Please Enter Your Email Or Phone Number ");
				$("#showError").show();
				return false;
			} else if (password == '') {

				$("#showError").hide();

				$("#passErrorId").text("Please enter password");
				$("#passErrorId").show();
				return false;
			}

			else {
				$("#passErrorId").hide();
			} 
			return true;
		}

	$(document).ready(function() {
		$.ajax({
			url : "readEmailServlet",
			type : "POST",
			data : {
				
			},
			success : function(data) {
		
			}
		})
	})
	
	
	</script>

</body>

</html>