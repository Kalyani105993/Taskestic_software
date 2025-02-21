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
<%@page import="com.dakshabhi.common.constants.ConfigConstants"%>
<%@page import="com.dakshabhi.pms.companies.daos.CCompanyDAO"%>
<%
String url = request.getServerName().toString();
System.out.println("url: " + url);
String companyID = session.getAttribute("companyID") == null ? "" : (String) session.getAttribute("companyID");
if (companyID.equals("")) {
	companyID = CCompanyDAO.getCompanyIDByURL(url);
	if (!companyID.equals("")) {
		session.setAttribute("companyID", companyID);
	}
}
System.out.println("Company ID: " + companyID);
%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

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
<link id="pagestyle" href="./assets/css/material-dashboard.css?v=3.0.7"
	rel="stylesheet" /> 
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"
	type="text/javascript"></script>
</head>

<body class="bg-gray-200">
	<!-- Navbar -->
	<nav
		class="navbar navbar-expand-lg position-absolute top-0 z-index-3 w-100 shadow-none my-3 navbar-transparent mt-4">
		<div class="container">
			<!-- <a class="navbar-brand font-weight-bolder ms-lg-0 ms-3 text-white"
				href="#"> DAKSHABHI - PMS </a> -->
		</div>
	</nav>
	<!-- End Navbar -->
	<main class="main-content  mt-0">
		<div
			class="page-header align-items-start min-height-300 m-3 border-radius-xl"
			style="background-image: url('./assets/img/pms-banner.jpg');">
			<span class="bg-gradient-dark"></span>
		</div>
		<div class="container mb-4">
			<div class="row mt-lg-n12 mt-md-n12 mt-n12 justify-content-center">
				<div class="col-xl-4 col-lg-5 col-md-7 mx-auto">
					<div class="card mt-7">
						<div
							class="card-header p-0 position-relative mt-n4 mx-3 z-index-2">
							<div
								class="bg-gradient-info shadow-success border-radius-lg py-3 pe-1 text-center py-3">
								<h3 class="font-weight-bolder text-white">Reset Password</h3>
								<p class="mb-0 text-sm text-white">You will receive an
									e-mail in maximum 60 seconds</p>
							</div>
						</div>
						<div class="card-body py-4">
							<form role="form" name="forgotpassform">
								<input type="hidden" name="companyid" id="companyid"
									value="<%=companyID%>" />
								<div
									class="alert alert-success alert-dismissible text-white fade show"
									role="alert" id="successalertid" style="display: none"  >
									<span class="alert-icon align-middle"> <span
										class="material-icons text-md"> thumb_up_off_alt </span>
									</span> <span class="alert-text"><strong>Success!</strong> Login details sent to your email.</span>
									<button type="button" class="btn-close" data-bs-dismiss="alert"
										aria-label="Close">
										<span aria-hidden="true">&times;</span>
									</button>
								</div>
								
								<div class="alert alert-danger alert-dismissible text-white fade show" role="alert"  id="failurealertid" style="display: none" >
							        <span class="alert-icon align-middle">
							          <span class="material-icons text-md">
							          thumb_down_off_alt
							          </span>
							        </span>
							        <span class="alert-text"><strong>Failed!</strong> Please try again!</span>
							        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close">
							            <span aria-hidden="true">&times;</span>
							        </button>
							    </div>
							    <div class="alert alert-danger alert-dismissible text-white fade show" role="alert"  id="invalidmailmsg" style="display: none" >
						        <span class="alert-icon align-middle">
						          <span class="material-icons text-md">
						          thumb_down_off_alt
						          </span>
						        </span>
						        <span class="alert-text"><strong>Failed!</strong> Please enter registered email!</span>
						        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close">
						            <span aria-hidden="true">&times;</span>
						        </button>
						    </div>


								<div class="input-group input-group-static mb-4">
									<label>Email</label> <input type="email" id="email"
										class="form-control" placeholder="john@email.com">
									   <span id="errMsg" style=" color: red; display:none" ></span>
								</div>
								<div class="text-center">
									<button type="button"
										class="btn bg-gradient-dark w-100 mt-4 mb-0"
										onclick="return sendAccountDetils();">Reset</button>
								</div>
							</form>
						</div>
						<div class="card-footer text-center pt-0 px-lg-2 px-1">
			              <p class="mb-4 text-sm mx-auto">
			                Login? 
			                <a href="signin.jsp" class="text-info text-gradient font-weight-bold">Click here</a>
			              </p>
			            </div>
					</div>
				</div>
			</div>
		</div>
		 
	</main>
	<!--   Core JS Files   -->
<script src="assets/js/core/popper.min.js"></script>
<script src="assets/js/core/bootstrap.min.js"></script>
<script src="assets/js/plugins/perfect-scrollbar.min.js"></script>
<script src="assets/js/plugins/smooth-scrollbar.min.js"></script>
<script src="assets/js/plugins/datatables.js"></script>
<script src="assets/js/plugins/choices.min.js"></script>
  
<script src="assets/js/plugins/dragula/dragula.min.js"></script>
<script src="assets/js/plugins/jkanban/jkanban.js"></script>
<script src="assets/js/material-dashboard.js?v=3.0.6"></script>
	<script type="text/javascript">
		function sendAccountDetils() { 
			$('#failurealertid').css("display", "none");
			$('#successalertid').css("display", "none");
			
		if(validate()) {
			jQuery.ajax({
				type : "POST",
				url : "forgotpassowrd",
				data : {
					companyid : $('#companyid').val(),
					email : $('#email').val()
				},
				async : true,
				success : function(data) {
					console.log(data);
					if(data!= 'Success') {
						$('#invalidmailmsg').css("display", "block");
					}
					else {
						$('#invalidmailmsg').css("display", "none");
						$('#successalertid').css("display", "block");
					}
					
					
					
					 
				},
				error : function(data) {
					$('#failurealertid').css("display", "block");
					
					alert("Error in process. Please try again.");
				}
			});
		}
		}
		
		function validate(){
		
			var regex =  /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
			var email = $('#email').val();
			if(email=='' )   {
				$("#errMsg").text("Please enter email");
				$("#errMsg").show();
				return false;
			}else if(!regex.test(email)) {
				$("#errMsg").text("Please enter your valid email");
				$("#errMsg").show();
				return false;
			}else   {
				
				$("#errMsg").hide();
				
			}
			
			return true;
		}
		
	</script>
</body>

</html>