<%@page import="java.util.ArrayList"%>
<%@ include file="/include/header.jsp"%>
<%@ page isELIgnored="false"%>

<style>
/* @media only screen and ( max-width : 640px) {
	#profilePhoto {
		text-align: center;
		margin: 2px;
	}
	#fileInput {
		width: 250px;
		margin: auto;
	}
	#fileButton {
		text-align: center;
		margin-top: 2px;
	}
	#alertId {
		text-align: center;
	}
} */

@media screen and (min-device-width: 575px) {
	#avatar {
		display: flex;
		flex-direction: row;
	}
	
	p {
		font-size: 14px; 
	}
}

@media screen and (max-device-width: 574px) {
	#avatar {
		display: inline-block;
		width: 55%;
	}
	#uploadfile {
		display: inline-block;
		width: 45%;
		max-width: 45%;
	}
	h5 {
		font-size: 1.031rem;
	}
	p {
		font-size: 12px; /* 0.718rem */
	}
	#profileavatar {
		display: flex;
		flex-direction: row;
	}
}

.msgError {
	font-size: 0.875rem;
	display: none;
	color: red;
}
</style>

<body class="g-sidenav-show  bg-gray-100 g-sidenav-hidden">
	<%@ include file="/include/leftnav.jsp"%>
	<!-- Main -->
	<main
		class="main-content position-relative max-height-vh-100 h-100 border-radius-lg ">
		<!-- Navbar -->
		<nav
			class="navbar navbar-main navbar-expand-lg position-sticky px-0 shadow-none border-radius-xl z-index-sticky"
			id="navbarBlur" data-scroll="true">
			<div class="container-fluid py-1 px-3"
				style="display: block !important">
				<nav aria-label="breadcrumb">
					<div class="row">
						<div class="col-6">
						 <ol class="breadcrumb" >
						    <li class="breadcrumb-item"><a i class="material-icons fixed-plugin-button-nav cursor-pointer " href='workspace.jsp'> home </i></a></li>
						     <h6 class=" breadcrumb-item active">User Profile</h6>
						  </ol>						
							<div class="sidenav-toggler sidenav-toggler-inner">
								<a href="javascript:;" class="nav-link text-body p-0">
									<div class="sidenav-toggler-inner">
										<i class="sidenav-toggler-line"></i> <i
											class="sidenav-toggler-line"></i> <i
											class="sidenav-toggler-line"></i>
									</div>
								</a>
							</div>
						</div>
						<div class="col-6" id="addbtbn"></div>
					</div>
				</nav>
			</div>
		</nav>
		<!--End Navbar -->
		<div class="container-fluid">
			<div class="row">
				<div class="col-lg-9 col-md-10 col-sm-12 mt-lg-0 mt-4">
					<!-- Card Profile -->
					<div class="card card-body">
						<div class="row " id="profileavatar">
							<div class="col-md-6 col-sm-6 col-xs-6" id="avatar">
								<div class="col-md-4 col-sm-4 col-xs-4">
									<div class="avatar avatar-xl position-relative"
										id="profilePhoto"></div>
								</div>
								<div class="col-md-8 col-sm-8 col-xs-8">
									<h5 class="mb-1 font-weight-bolder" id="username"></h5>
									<p class="mb-0 font-weight-normal " id="userrole"></p>
								</div>
							</div>



							<!-- <div class="col-md-2 col-sm-2 col-xs-2">
								<div class="avatar avatar-xl position-relative"
									id="profilePhoto"></div>
							</div>
							<div class="col-md-4 col-sm-4 col-xs-4 p-2">
								<h5 class="mb-1 font-weight-bolder" id="username"></h5>
								<p class="mb-0 font-weight-normal text-sm" id="userrole"></p>
							</div> -->

							<div class="col-md-6 col-sm-6 col-xs-6 my-auto text-end"
								id="uploadfile">
								<form action="profile?actionType=profilePhoto" method="post"
									enctype="multipart/form-data" id="imageForm">
									<div class="row mt-2">
										<div class="col-md-8 text-end" id="fileInput">
											<input type="file"
												class="form-control form-control-sm m-0 ms-0" name="image"
												id="image" accept="image/png,image/jpg,image/jpeg"
												onchange="validate_fileupload(this);">
										</div>
										<input type="hidden" name="Id"
											value="${userLogin.user_login_id}">
										<div class="col-md-4 p-0" id="fileButton">
											<input type="button"
												onclick="return profilePhotoValidation('image');"
												class="btn bg-gradient-dark btn-sm float-end mt-2 mx-3 rounded-1 mb-0"
												value="upload">
										</div>
										<div class="col-md-3 p-0" id="alertId"></div>
									</div>
								</form>
							</div>
						</div>
					</div>
					<!-- Card Basic Info -->
					<div class="card mt-4" id="basic-info">
						<div class="card-header p-2 mb-0">
							<h5>Basic Info</h5>
						</div>
						<div class="card-body pt-0">
							<form id="formId" method="post">
								<div class="row">
									<div class="col-12">
										<div class="input-group input-group-static">
											<label> Name</label> <input type="text" id="name"
												class="form-control" onfocus="focused(this)"
												onfocusout="defocused(this)"><br> <span
												class="msgError" id="msgError_name"></span>
										</div>
									</div>

								</div>

								<div class="row mt-4">
									<div class="col-md-6 col-sm-12">
										<div class="input-group input-group-static">
											<label>Email</label> <input type="email" id="email"
												class="form-control" placeholder="example@email.com"
												onfocus="focused(this)" onfocusout="defocused(this)"><br>
											<span class="msgError" id="msgError_email"></span>
										</div>
									</div>
									<div class="col-md-6 col-sm-12">
										<div class="input-group input-group-static">
											<label>Phone No.</label> <input type="number"
												id="employeePhone" class="form-control"
												placeholder="xxxxxxxxxx" onfocus="focused(this)"
												onfocusout="defocused(this)"><br> <span
												class="msgError" id="msgError_employeePhone"></span>
										</div>
									</div>
								</div>

								<div class="row mt-4">
									<div class="col-md-4 col-sm-12">
										<div class="input-group input-group-static">
											<label>Aadhaar Card No.</label> <input type="text"
												id="employeeAadhaar" class="form-control"
												onfocus="focused(this)" onfocusout="defocused(this)"><br>
											<span class="msgError" id="msgError_employeeAadhaar"></span>
										</div>
									</div>


									<div class="col-md-4 col-sm-12">
										<div class="input-group input-group-static">
											<label>PAN No.</label> <input type="text" id="employeePAN"
												class="form-control" onfocus="focused(this)"
												onfocusout="defocused(this)"><br> <span
												class="msgError" id="msgError_employeePAN"></span>
										</div>
									</div>

									<div class="col-md-4 col-sm-12">
										<div class="input-group input-group-static">
											<label>Passport No.</label> <input type="text"
												id=employeePassport class="form-control"
												onfocus="focused(this)" onfocusout="defocused(this)"><br>
											<span class="msgError" id="msgError_employeePassport"></span>
										</div>
									</div>
								</div>

								<div class="row mt-4">
									<div class="col-md-6 col-sm-12">
										<div class="input-group input-group-static">
											<label>Permanent Address</label> <input type="text"
												id="employeePermanent" class="form-control"
												onfocus="focused(this)" onfocusout="defocused(this)"><br>
											<span class="msgError" id="msgError_employeePermanent"></span>
										</div>
									</div>
									<div class="col-md-6 col-sm-12">
										<div class="input-group input-group-static">
											<label>Current Address</label> <input type="text"
												id="employeeCurrent" class="form-control"
												onfocus="focused(this)" onfocusout="defocused(this)"><br>
											<span class="msgError" id="msgError_employeeCurrent"></span>
										</div>
									</div>
								</div>

								<div class="row mt-4">
									<div class="col-md-6 col-sm-12">
										<div class="input-group input-group-static">
											<label>Date Of Birth</label> <input type="date"
												class="required form-control" id="employeeDOB"
												name="date_of_birth" onfocus="focused(this)"
												onfocusout="defocused(this)"> <br> <span
												class="msgError" id="msgError_employeeDOB"></span>
										</div>
									</div>
									<div class="col-md-6 col-sm-12">
										<div class="input-group input-group-static">
											<label>Gender</label> <select class="required form-control"
												id="employeeGender" name="gender">
												<option value="0">Select Gender</option>
												<option value="Male">Male</option>
												<option value="Female">Female</option>
												<option value="Other">Other</option>
											</select><br> <span class="msgError" id="msgError_employeeGender"></span>
										</div>
									</div>
								</div>
								<div class="row mt-4">
									<div class="col-12 text-end">
										<button type="submit"
											class="btn bg-gradient-dark btn-sm float-end mt-4 mb-0"
											onclick="return validateServiceDetails('formId');"
											id="updateProfileDetails">Save</button>
									</div>
								</div>
							</form>
						</div>
					</div>

					<!-- Card Change Password -->
					<div class="card mt-4 mb-4">
						<div class="card-header card-header p-2 mb-0">
							<h5>Change Password</h5>
						</div>

						<div class="card-body pt-0">
							<form id="user_profile_form" action="profile" method="post"
								id="userPasswordChange">
								<input type="hidden" name="actionType" value="updatepassword">
								<input type="hidden" name="userid"
									value="${userLogin.user_login_id}">

								<div class="input-group input-group-static my-4">
									<label class="form-label">New password</label> <input
										type="password" id="newPassword" name="newPassword"
										class="form-control" onfocus="focused(this)"
										onfocusout="defocused(this)" required="required">
								</div>
								<div class="input-group input-group-static">
									<label class="form-label">Confirm New password</label> <input
										type="password" id="confirmPassword" name="confirmPassword"
										class="form-control" onfocus="focused(this)"
										onfocusout="defocused(this)" required="required">
								</div>

								<button type="submit" data-bs-toggle="modal"
									data-bs-target="#exampleModal"
									class="btn bg-gradient-dark btn-sm float-end mt-4 mb-0"
									onclick="return updatePassword();">Change Password</button>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!-- Card Change Password End -->

		<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title font-weight-normal" id="exampleModalLabel">Oops!
						</h5>
						<button type="button" class="btn-close text-dark"
							data-bs-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">The Password Confirmation does not
						match.</div>
					<div class="modal-footer">
						<button type="button" class="btn bg-gradient-danger"
							data-bs-dismiss="modal">Try Again</button>
					</div>
				</div>
			</div>
		</div>


	</main>
	<!-- End Main -->
</body>
<!--   Core JS Files   -->
<script src="assets/js/core/popper.min.js"></script>
<script src="assets/js/core/bootstrap.min.js"></script>
<script src="assets/js/plugins/perfect-scrollbar.min.js"></script>
<script src="assets/js/plugins/smooth-scrollbar.min.js"></script>
<script src="assets/js/plugins/datatables.js"></script>
<!-- Kanban scripts -->
<script src="assets/js/plugins/dragula/dragula.min.js"></script>
<script src="assets/js/plugins/jkanban/jkanban.js"></script>
<script src="assets/js/material-dashboard.min.js?v=3.0.6"></script>
<script type="text/javascript">
	var inputObj;
	$(document).ready(function() {
		defaultData();
		getProfilePhoto();
	})

	function defaultData() {
		$.ajax({
			type : "post",
			url : "profile",
			data : {
				actionType : "getData",
				employee_id : $("input[name=userid]").val()
			},
			success : function(resp) {
				/* console.log(resp);
				console.log(resp.DOB) */
				$("#username").html(resp.employee_name);
				$("#userrole").html(resp.employee_email);
				$("#name").val(resp.employee_name);
				$("#email").val(resp.employee_email);
				$("#employeePhone").val(resp.employee_phone);
				$("#employeeAadhaar").val(resp.aadhaar_card_no);
				$("#employeePAN").val(resp.pan_no);
				$("#employeePassport").val(resp.passport_no);
				$("#employeePermanent").val(resp.permanent_address);
				$("#employeeCurrent").val(resp.current_address);
				$("#employeeDOB").val(resp.DOB);
				$("#employeeGender").val(resp.gender);

			}
		})
	}

	$("#formId").submit(function() {
		console.log($("#name").val())
		console.log($("#email").val())
		console.log($("#employeePhone").val())
		console.log($("#employeeAadhaar").val())
		console.log($("#employeePAN").val())
		console.log($("#employeePassport").val())
		console.log($("#employeePermanent").val())
		console.log($("#employeeCurrent").val())
		console.log($("#employeeDOB").val())
		console.log($("#employeeGender").val())

		$.ajax({
			type : "post",
			url : "profile",
			data : {
				actionType : "update",
				employee_id : $("input[name=userid]").val(),
				employee_name : $("#name").val(),
				employee_email : $("#email").val(),
				employee_phone : $("#employeePhone").val(),
				aadhar_card_no : $("#employeeAadhaar").val(),
				pan_no : $("#employeePAN").val(),
				passport_no : $("#employeePassport").val(),
				permanant_address : $("#employeePermanent").val(),
				current_address : $("#employeeCurrent").val(),
				date_of_birth : $("#employeeDOB").val(),
				gender : $("#employeeGender").val()
			},
			success : function(data) {
				console.log(data);
				defaultData();
			}
		})
	});

	function getProfilePhoto() {
		console.log($("input[name=userid]").val())
		$
				.ajax({
					type : "post",
					url : "profile",
					data : {
						actionType : "getProfilePhoto",
						employee_id : $("input[name=userid]").val(),
					},
					success : function(resp) {
						console.log(resp);
						var div = document.getElementById("profilePhoto");
						if (resp.profilePhoto != ""
								&& resp.profilePhoto != null
								&& resp.profilePhoto != "default.jpg") {
							div.innerHTML = ' <img src="uploads/avatar/'+resp.employee_id+'/'+resp.profilePhoto+'"  class="w-100 h-100 rounded-circle shadow-sm" alt="Avatar">';
						} else {
							div.innerHTML = ' <img src="uploads/avatar/default.jpg"  class="w-100 rounded-circle shadow-sm" alt="Avatar">';
						}
					}
				})
	}

	function updatePassword() {
		/* $("#exampleModal").css('visibility', 'hidden'); */
		if ($("#newPassword").val() == $("#confirmPassword").val()) {
			$("#exampleModal").css('visibility', 'hidden');
			return true;
		} else {
			$("#exampleModal").css('visibility', 'visible');
			return false;
		}
	}

	function validateServiceDetails(form_id) {
		var formObj = $('#' + form_id);

		for (var i = 0; i <= formObj.get(0).length - 1; i++) {
			inputObj = formObj.get(0)[i];
			if (inputObj.type == 'select-one'
					&& inputObj.className === 'required form-control'
					&& inputObj.value == '0') {
				$("#msgError_" + inputObj.id).show();
				$("#msgError_" + inputObj.id).text(
						'Please select at least one option.');
				return false;
			} else if (inputObj.type === 'number'
					&& inputObj.className === 'form-control'
					&& inputObj.value === '') {
				$("#msgError_" + inputObj.id).show();
				$("#msgError_" + inputObj.id).text("Please fill this field.");
				return false;
			} else if (inputObj.type === 'text'
					&& inputObj.className === 'form-control'
					&& inputObj.value === '') {
				$("#msgError_" + inputObj.id).show();
				$("#msgError_" + inputObj.id).text("Please fill this field.");
				return false;
			} else if (inputObj.type === 'textarea'
					&& inputObj.className === 'form-control'
					&& inputObj.value === '') {
				$("#msgError_" + inputObj.id).show();
				$("#msgError_" + inputObj.id).text("Please fill this field.");
				return false;
			} else if (inputObj.type === 'email'
					&& inputObj.className === 'form-control'
					&& inputObj.value === '') {
				$("#msgError_" + inputObj.id).show();
				$("#msgError_" + inputObj.id).text("Please fill this field.");
				return false;
			} else if (inputObj.type === 'date'
					&& inputObj.className === 'required form-control'
					&& inputObj.value === '') {
				$("#msgError_" + inputObj.id).show();
				$("#msgError_" + inputObj.id).text("Please fill this field.");
				return false;
			}
			if (inputObj.className === 'form-control') {
				$("#msgError_" + inputObj.id).hide();
			}
		}
		return true;
	}

	var valid = false;
	function profilePhotoValidation(id) {
		var filesId = document.getElementById(id);
		var el = document.getElementById("alertId");
		const isFilePresent = filesId.files;
		if (isFilePresent.length != 0) {
			const fsize = filesId.files[0].size;
			console.log(fsize);
			const file = Math.round((fsize / 1024));
			if (id == "image") {
				if (file >= 2048) {
					/* alert("File too Big, please select a file less than 2 Mb"); */
					el.innerHTML = "please select a file less than 2 Mb";
					filesId.focus();
					return valid && false;
				} else {
					if (valid) {
						$("#imageForm").submit();
					}

					return valid && true;
				}
			}

		}
	}

	function validate_fileupload(input_element) {
		var el = document.getElementById("alertId");
		var fileName = input_element.value;
		var allowed_extensions = new Array("jpg", "png", "jpeg");
		var file_extension = fileName.split('.').pop();
		for (var i = 0; i < allowed_extensions.length; i++) {
			if (allowed_extensions[i] == file_extension) {
				valid = true;
				el.innerHTML = "";
				return;
			}
		}
		el.innerHTML = "Invalid file";
		valid = false;
	}
</script>
<%@ include file="/include/footer.jsp"%>







