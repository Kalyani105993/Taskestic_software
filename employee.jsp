<%@page import="com.dakshabhi.pms.masters.services.CMasterDetailsService"%>
<%@page import="com.dakshabhi.pms.masters.dtos.CDepartmentDTO"%>
<%@page import="com.dakshabhi.pms.masters.dtos.CEmployeeRoleDTO"%>
<%@page import="com.dakshabhi.pms.employees.daos.CEmployeeDAO"%>
<%@page import="com.dakshabhi.pms.employees.dtos.CEmployeeInfoDTO"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.dakshabhi.pms.employees.dtos.CEmployeeDTO"%>
<%@ include file="/include/header.jsp"%>
<style>
@media ( max-width : 640px) {
	.dataTables_wrapper .dataTables_length, .dataTables_wrapper .dataTables_filter
		{
		float: left !important;
		text-align: center;
	}
	#plusSignimgId {
		margin-bottom: 2px;
		padding-right: 3px !important;
	}
	#createNewbtnId {
		font-size: 11px !important;
		padding: 9px !important;
	}
	.newModalbtns {
		font-size: 12px;
		padding: 10px;
	}
	.updateModalbtns {
		font-size: 11px;
		padding: 10px;
	}
	#searchbtn_id {
		display: block !important;
	}
	.collapsible {
		float: right;
	}
	#searchCardId {
		display: none;
	}
	.content {
		padding: 0 15px;
		overflow: hidden;
		width: 100%;
	}
	.searchbtn {
		margin-right: 28px;
		margin-bottom: 60px;
	}
}

@media ( min-width : 768px) {
	.mt-md-n9 {
		margin-top: 0px !important;
	}
}

.padding20 {
	padding: 20px;
}

.col-md-3 {
	padding: 10px;
}

#tableId_wrapper {
	padding: 20px !important;
}

select {
	padding-left: 10px !important;
}

#search {
	margin-top: 5px;
}

.userIcon {
	margin-top: 4px !important;
	padding-bottom: 10px !important;
	width: 40px;
	height: 40px;
}

#searchbtn_id {
	display: none;
}

#pagination {
	position: sticky;
	float: right;
	display: flex;
	align-items: center;
	padding: 10px 40px;
	border-radius: 10px;
}

.page.btn {
	display: inline-block;
	margin: 0px 5px;
	text-align: center;
	cursor: pointer;
}

.activebtn {
	background-color: #fff;
	color: #000;
}

.modal-title {
	font-weight: 400;
}

.msgError {
	font-size: 0.875rem;
	display: none;
	color: red;
}

#loadnextid {
  padding: 10px 20px;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  position: absolute;
  bottom: -40;
  width: 100%; /* Button width set to 100% */
  text-align: center;
}

#loadnextgridid{
  padding: 10px 20px;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  position: absolute;
  bottom: -40;
  width: 100%; /* Button width set to 100% */
  text-align: center;
}
</style>
<body class="g-sidenav-show  bg-gray-100 g-sidenav-hidden">
	<%@ include file="/include/leftnav.jsp"%>
	<!-- Main -->
	<main class="main-content position-relative max-height-vh-100 h-100 border-radius-lg ">
		<!-- Navbar -->
		<nav class="navbar navbar-main navbar-expand-lg position-sticky px-0 shadow-none border-radius-xl z-index-sticky" id="navbarBlur" data-scroll="true">
			<div class="container-fluid py-1 px-3" style="display: block !important">
				<nav aria-label="breadcrumb">
					<div class="row">
						<div class="col-6">
						 <ol class="breadcrumb" >
						    <li class="breadcrumb-item"><a i class="material-icons fixed-plugin-button-nav cursor-pointer " href='workspace.jsp'> home </i></a></li>
						     <h6 class="font-weight-bolder mb-0 breadcrumb-item active">Employee</h6>
						  </ol>
							<div class="sidenav-toggler sidenav-toggler-inner">
								<a href="javascript:;" class="nav-link text-body p-0">
									<div class="sidenav-toggler-inner">
										<i class="sidenav-toggler-line"></i> <i class="sidenav-toggler-line"></i> <i class="sidenav-toggler-line"></i>
									</div>
								</a>
							</div>
						</div>

						<div class="col-6" id="addbtbn" style="text-align: end">
						 	<button id="createNewbtnId" type="button" data-bs-toggle="modal" data-bs-target="#newEmployee" onclick="showNewEmployeeModal()"
								class="btn bg-gradient-dark mb-0 mt-0 mt-md-n9 mt-lg-0">
								<i id="plusSignimgId" class="material-icons text-white position-relative text-md pe-2">add</i>Create New
							</button>
						</div>
					</div>
				</nav>
			</div>
		</nav>
		<!--End Navbar -->
		<div class="container-fluid">
			<div class="card mb-0">
				<div class="card-header p-2">
					<div class="row">
						<div class="col-12 ">
							<form class="multisteps-form__form mb-0">
								<div class="content">
									<div class="row">
										<div class="col-md-3">
											<div class="input-group input-group-dynamic">
												<input class="multisteps-form__input form-control" type="text" placeholder="Employee code" name="searchEmployee_code" id="searchEmployee_code_id" />
											</div>
										</div>
										<div class="col-md-3">
											<div class="input-group input-group-dynamic">
												<input class="multisteps-form__input form-control" type="text" placeholder="Employee Name" name="searchEmployee_name" id="searchEmployee_name_id" />
											</div>
										</div>
										<div class="col-md-3">
											<div class="input-group input-group-dynamic">
												<input class="multisteps-form__input form-control" type="email" placeholder="Employee Email" name="searchEemployee_email" id="searchEmployee_email_id" />
											</div>
										</div>
										<div class="col-md-3">
											<div class="input-group input-group-dynamic">
												<input class="multisteps-form__input form-control" type="text" placeholder="Employee Phone" name="searchEmployee_phone" id="searchEmployee_phone_id" />
											</div>
										</div>
									</div>
									<input type="hidden" id="CPageNo" value="1" />
									<div class="row ">
										<div class="col-md-3">
											<div class="input-group input-group-dynamic">
												<select class="form-control" id="searchDepartment_id" name="department_id" required="required">
													<option value="0">Select Department Name</option>
												</select>
											</div>
										</div>
										<div class="col-md-3">
											<div class="input-group input-group-dynamic">
												<select class="form-control" id="searchEmployee_role_id" name="searchEmployee_role" required="required">
													<option value="0">Select Employee Role</option>
												</select>
											</div>
										</div>
										<div class="col-md-3">
											<div class="input-group input-group-dynamic">
												<select class="form-control" id="searchStatus" name="searchStatus" required="required">
													<option value="0">Select Status</option>
												</select>
											</div>
										</div>
										<div class="col-md-3 rightalign">
											<button class="btn btn-icon btn-2 btn-dark" id="search" type="button">
												<span class="btn-inner--icon"><i class="material-icons">search</i></span>
											</button>
										</div>
									</div>
								</div>
							</form>
						</div>

						<div class="col-12 text-end">
							<input type="checkbox" data-size="small" data-toggle="toggle" id="tableviwid" onchange="showSelectedView();" data-off="<i class='fas fa-th'></i> Grid"
								data-on="<i class='fas fa-th-list'></i> List" data-onstyle="success" data-offstyle="info">
						</div>
					</div>
				</div>
				<div class="card-body p-2 height-auto" id="gridview">
					<div class="row" id="employeelistid"></div>
					<input type="hidden" id="cPageNo" value="1" /> <a id="loadnextgridid" href="#" onclick="loadNextEmployeeList()"> <strong>Load
							More...</strong></a>
				</div>
				<input type="hidden" id="cpageno" value="1" />
				<div class="card-body p-2 pt-2" id="tableview">
					<div class="table-responsive">
						<table class="table table-flush text-sm" id="employeelistidbylist">
							<!-- 						<input type="hidden" id="cpageno" value="1"/>  -->
							<thead class="thead-light">
								<tr>
									<th></th>
									<th>Employee Name</th>
									<th>Employee Code</th>
									<th>Role</th>
									<th>Department</th>
									<th>Email</th>
									<th>Phone</th>
									<th>Status</th>
								</tr>
							</thead>
							<tbody id="tbodyId"></tbody>
							<!-- 							<tr> -->
							<!-- 								<td id="loadnextid" colspan="7" class="text-center"><a -->
							<!-- 									href="#" onclick="loadNextEmployeeList1()"> <strong>Load -->
							<!-- 											Next</strong></a></td> -->
							<!-- 							</tr> -->
						</table>
						<a id="loadnextid" href="#" onclick="loadNextEmployeeList1()"> <strong>Load More...</strong></a>
					</div>

				</div>
			</div>
		</div>
		<!-- Modal -->
		<div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title font-weight-normal" id="deleteModalLabel">Delete Confirmation</h5>
						<button type="button" class="btn-close text-dark" data-bs-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">Are you sure you want to delete this item?</div>
					<div class="modal-footer">
						<button type="button" class="btn bg-gradient-secondary" data-bs-dismiss="modal">Close</button>
						<button type="button" class="btn bg-gradient-primary" data-bs-dismiss="modal" onclick="deleteEmployeeById();">Delete</button>
					</div>
				</div>
			</div>
		</div>
		<!-- modal for new employee -->

		<div class="modal fade" id="newEmployee" tabindex="-1" role="dialog" aria-labelledby="employeeModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-xl modal-dialog-centered" role="document">
				<div class="modal-content">
					<!--Header-->
					<div class="modal-header">
						<h5 class="modal-title" id="myModalLabel">New Employee</h5>
						<button type="button" class="btn-close text-dark" data-bs-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<!--Body-->
					<div class="modal-body">
						<div class="container-fluid">
							<div class="row">
								<div class="col-lg-12 col-12 mx-auto position-relative">
									<div class="card">
										<div class="card-body pt-2">
											<form id="employee_formId" name="employee_form" onsubmit="saveEmployee();">
												<div class="row">
													<div class="col-lg-3 p-1">
														<div class="input-group input-group-dynamic mb-1">
															<label class="form-label">Employee Code</label> <input type="text" id="employee_code" name="employee_code" class="required form-control">
														</div>
														<span class="msgError" id="msgError_employee_code"></span>
													</div>
													<div class="col-lg-9 p-1">
														<div class="input-group input-group-dynamic mb-1">
															<label class="form-label">Employee Name</label> <input type="text" id="employee_name" name="employee_name" class="required form-control">
														</div>
														<span class="msgError" id="msgError_employee_name"></span>
													</div>
												</div>
												<div class="row">
													<div class="col-lg-3 col-md-6 col-sm-6 p-1">
														<div class="input-group input-group-static mb-1">
															<label>Type</label> <select class="required form-control" id="employee_type" name="employee_type">
															</select>
														</div>
														<span class="msgError" id="msgError_employee_type"> </span>
													</div>
													<div class="col-lg-3 col-md-6 col-sm-6  p-1">
														<div class="input-group input-group-static mb-1">
															<label>Department</label> <select class="required form-control" id="department_id" name="department_id" required="required">
															</select>
														</div>
														<span class="msgError" id="msgError_department_id"></span>
													</div>
													<div class="col-lg-3 col-md-6 col-sm-6 p-1">
														<div class="input-group input-group-static mb-1">
															<label>Role</label> <select class="required form-control" id="employee_role" name="employee_role" onchange="disableReportingToList(this);"
																required="required">
															</select>
														</div>
														<span class="msgError" id="msgError_employee_role"></span>
													</div>
													<div class="col-lg-3 col-md-6 col-sm-6 p-1">
														<div class="input-group input-group-static mb-1">
															<label>Status</label> <select class="required form-control" id="employee_status" name="employee_status">
															</select>
														</div>
														<span class="msgError" id="msgError_employee_status"> </span>
													</div>
												</div>
												<div class="row">
													<div class="col-md-6  p-1">
														<div class="input-group input-group-dynamic mb-1">
															<label class="form-label">Email</label> <input type="email" id="employee_email" name="employee_email" class="required form-control"
																onchange="is_alreadyexits(this.value,this.name);">
														</div>
														<span class="msgError" id="msgError_employee_email"> </span> 

													</div>
													<div class="col-md-6  p-1">
														<div class="input-group input-group-dynamic mb-1">
															<label class="form-label">Phone</label> <input type="text" class="required form-control" id="employee_phone" maxlength="10" name="employee_phone"
																onchange="is_alreadyexits(this.value,this.name);">
														</div>
														<span class="msgError" id="msgError_employee_phone"></span>
													</div>
												</div>
												<div class="row">
													<div class="col-md-6  p-1">
														<div class="input-group input-group-dynamic mb-1">
															<label class="form-label">Current Address</label> <input type="text" class="optional form-control" id="current_address" name="current_address">
														</div>
													</div>
													<div class="col-md-6  p-1">
														<div class="input-group input-group-dynamic mb-1">
															<label class="form-label">Permanent Address</label> <input type="text" class="optional form-control" id="permanant_address" name="permanant_address">
														</div>
													</div>
												</div>
												<div class="row">
													<div class="col-lg-4 col-md-4 col-sm-4  p-1">
														<div class="input-group input-group-dynamic mb-1">
															<label class="form-label">PAN No.</label> <input type="text" maxlength="10" class="optional form-control" id="pan_no" name="pan_no">
														</div>
													</div>
													<div class="col-lg-4 col-md-4 col-sm-4  p-1">
														<div class="input-group input-group-dynamic mb-1">
															<label class="form-label">Aadhar Card No.</label> <input type="text" class="optional form-control" id="aadhar_card_no" name="aadhar_card_no"> <span
																class="msgError" id="msgError_aadhar_card_no"></span>
														</div>
													</div>
													<div class="col-lg-4 col-md-4 col-sm-4  p-1">
														<div class="input-group input-group-dynamic mb-1">
															<label class="form-label">Passport No.</label> <input type="text" maxlength="10" class="optional form-control" id="passport_no" name="passport_no">
														</div>
													</div>
												</div>
												<div class="row">
													<div class="col-lg-3 col-md-6 col-sm-6  p-1">
														<div class="input-group input-group-static mb-1">
															<label>Date Of Birth</label> <input type="date" class="optional form-control" id="date_of_birth" name="date_of_birth" value="">
														</div>
														<span class="msgError" id="msgError_date_of_birth"></span>
													</div>
													<div class="col-lg-3 col-md-6 col-sm-6  p-1">
														<div class="input-group input-group-static mb-1">
															<label>Date Of Joining</label> <input type="date" class="required form-control" id="date_joining" name="date_joining" value="">
														</div>
														<span class="msgError" id="msgError_date_joining"></span>
													</div>
													<div class="col-lg-3 col-md-6 col-sm-6  p-1">
														<div class="input-group input-group-static mb-1">
															<label>Gender</label> <select class="required form-control" id="gender" name="gender" required>
																<!-- 																<option value="0">Select Gender</option> -->
																<option value="Male">Male</option>
																<option value="Female">Female</option>
																<option value="Other">Other</option>
															</select>
														</div>
														<span class="msgError" id="msgError_gender"></span>
													</div>
													<div class="col-lg-3 col-md-6 col-sm-6  p-1">
														<div class="input-group input-group-static mb-1">
															<label>Reporting To </label> <select class="required form-control" id="reporting_to" name="remporting_to">
																<option value="0">Select Reporting To</option>
															</select>
														</div>
														<span class="msgError" id="msgError_reporting_to"> </span>
													</div>
												</div>

												<div class="row justify-content-md-end mt-4">

													<div class="col-md-auto px-1 text-end">
														<button type="button" class="btn bg-gradient-info" onclick="saveEmployeeDetails('employee_formId');">Add Employee</button>
														<button type="button" name="button" class="btn btn-link  ml-auto" data-bs-dismiss="modal">Close</button>
													</div>

												</div>

											</form>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!-- 		modal for Edit employee Details -->

		<div class="modal fade" id="updateEmployeeModal" tabindex="-1" role="dialog" aria-labelledby="updateEmployeeLabel" aria-hidden="true">
			<div class="modal-dialog modal-xl modal-dialog-centered" role="document">
				<div class="modal-content">
					<!--Header-->
					<div class="modal-header">
						<h5 class="modal-title" id="myModalLabel">Update Employee</h5>
						<button type="button" class="btn-close text-dark" data-bs-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<!--Body-->
					<div class="modal-body">
						<div class="container-fluid">
							<div class="row">
								<div class="col-lg-12 col-12 mx-auto position-relative">
									<div class="card">
										<div class="card-body pt-2">
											<form id="updateEmployee_formId" name="employeeform" onsubmit="updateEmployee();">
												<input type="hidden" id="editEmployee_Id" name="editEmployee" value="" />

												<div class="row">
													<div class="col-lg-3 p-1">
														<div class="input-group input-group-dynamic mb-1">
															<label class="form-label">Employee Code</label> <input type="text" id="editEmployee_code_id" name="employee_code" class="required form-control" value="" readonly>
														</div>
														<span class="msgError" id="msgError_editEmployee_code_id"></span>
													</div>
													<div class="col-lg-9 p-1">
														<div class="input-group input-group-dynamic mb-1">
															<label class="form-label">Employee Name</label> <input type="text" id="editEmployee_name_id" name="employee_name" class="required form-control" value="" readonly>
														</div>
														<span class="msgError" id="msgError_editEmployee_name_id"></span>
													</div>
												</div>

												<div class="row">
													<div class="col-lg-3 col-md-6 col-sm-6 p-1">
														<div class="input-group input-group-static mb-1">
															<label>Type</label> <select class="required form-control" id="editEmployee_type_id" name="employee_type" required="required">
																<option value="0">Select Type</option>
															</select>
														</div>
														<span class="msgError" id="msgError_editEmployee_type_id"> </span>
													</div>
													<div class="col-lg-3 col-md-6 col-sm-6  p-1">
														<div class="input-group input-group-static mb-1">
															<label>Department</label> <select class="required form-control" id="editDepartment_id" name="department_id">
																<option value="0">Select Department</option>
															</select>
														</div>
														<span class="msgError" id="msgError_editDepartment_id"></span>
													</div>
													<div class="col-lg-3 col-md-6 col-sm-6 p-1">
														<div class="input-group input-group-static mb-1">
															<label>Role</label> <select class="required form-control" id="editEmployee_role_id" name="employee_role" onchange="disableReportingToList(this);">
																<option value="0">Select Role</option>
															</select>
														</div>
														<span class="msgError" id="msgError_editEmployee_role_id"></span>
													</div>
													<div class="col-lg-3 col-md-6 col-sm-6 p-1">
														<div class="input-group input-group-static mb-1">
															<label>Status</label> <select class="required form-control" id="editEmployee_status_id" name="employee_status">
																<option value="0">Select Status</option>
															</select>
														</div>
														<span class="msgError" id="msgError_editEmployee_status_id"></span>
													</div>
												</div>

												<div class="row">
													<div class="col-md-6  p-1">
														<div class="input-group input-group-dynamic mb-1">
															<label class="form-label">Email</label> <input type="email" id="editEmployee_email_id" name="employee_email" class="required form-control" value="">
														</div>
														<span class="msgError" id="msgError_editEmployee_email_id"></span>
													</div>
													<div class="col-md-6  p-1">
														<div class="input-group input-group-dynamic mb-1">
															<label class="form-label">Phone</label> <input type="text" class="required form-control" id="editEmployee_phone_id" name="employee_phone" value="">
														</div>
														<span class="msgError" id="msgError_editEmployee_phone_id"></span>
													</div>
												</div>

												<div class="row">
													<div class="col-md-6  p-1">
														<div class="input-group input-group-dynamic mb-1">
															<label class="form-label">Current Address</label> <input type="text" class="form-control" id="editCurrent_address_id" name="current_address" value="">
														</div>
													</div>
													<div class="col-md-6  p-1">
														<div class="input-group input-group-dynamic mb-1">
															<label class="form-label">Permanent Address</label> <input type="text" class="form-control" id="editPermanant_address_id" name="permanant_address" value="">
														</div>
													</div>
												</div>

												<div class="row">
													<div class="col-lg-4 col-md-4 col-sm-4  p-1">
														<div class="input-group input-group-dynamic mb-1">
															<label class="form-label">PAN No.</label> <input type="text" class="form-control" id="editPan_no_id" name="pan_no" value="">
														</div>
													</div>
													<div class="col-lg-4 col-md-4 col-sm-4  p-1">
														<div class="input-group input-group-dynamic mb-1">
															<label class="form-label">Aadhar Card No.</label> <input type="text" class="form-control" id="editAadhar_card_no_id" name="aadhar_card_no" value=""
																maxlength="12">
														</div>
													</div>
													<div class="col-lg-4 col-md-4 col-sm-4  p-1">
														<div class="input-group input-group-dynamic mb-1">
															<label class="form-label">Passport No.</label> <input type="text" maxlength="10" class="form-control" id="editPassport_no_id" name="passport_no" value="">
														</div>
													</div>
												</div>

												<div class="row">
													<div class="col-lg-3 col-md-6 col-sm-6  p-1">
														<div class="input-group input-group-static mb-1">
															<label>Date Of Birth</label> <input type="date" class="form-control" id="editDate_of_birth_id" name="date_of_birth" value="">
														</div>
														<span class="msgError" id="msgError_editDate_of_birth_id"></span>
													</div>
													<div class="col-lg-3 col-md-6 col-sm-6  p-1">
														<div class="input-group input-group-static mb-1">
															<label>Date Of Joining</label> <input type="date" class="required form-control" id="editDate_joining_id" name="date_joining" value="">
														</div>
														<span class="msgError" id="msgError_editDate_joining_id"></span>
													</div>
													<div class="col-lg-3 col-md-6 col-sm-6  p-1">
														<div class="input-group input-group-static mb-1">
															<label>Gender</label> <select class="required form-control" id="editGender_id" name="gender" required>
																<!-- 																<option value="0">Select Gender</option> -->
																<option value="Male">Male</option>
																<option value="Female">Female</option>
																<option value="Other">Other</option>
															</select> <span class="msgError" id="msgError_editGender_id"></span>
														</div>
													</div>
													<div class="col-lg-3 col-md-6 col-sm-6  p-1">
														<div class="input-group input-group-static mb-1">
															<label>Reporting To </label> <select class="required form-control" id="editReporting_to_id" name="remporting_to">
																<option value="0">Select reporting to</option>
															</select> <span class="msgError" id="msgError_editReporting_to_id"></span>

														</div>
													</div>
												</div>

												<div class="row justify-content-md-end mt-4">

													<div class="col-md-auto px-1 text-end">
														<button type="button" class="btn bg-gradient-info" onclick="updateEmployeeDetails('updateEmployee_formId');">Update Employee</button>
														<button type="button" name="button" class="btn btn-link  ml-auto" data-bs-dismiss="modal">Close</button>
													</div>

												</div>

											</form>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</main>
	<!-- End Main -->
	<form name="employeeform" action="employee" method="post">
		<input type="hidden" name="actionType" /> <input type="hidden" name="employee_id" />
	</form>
</body>

<!--   Core JS Files   -->

<script src="assets/js/core/popper.min.js"></script>
<script src="assets/js/core/bootstrap.min.js"></script>
<script src="assets/js/plugins/perfect-scrollbar.min.js"></script>
<script src="assets/js/plugins/smooth-scrollbar.min.js"></script>
<!-- <script src="assets/js/plugins/datatables.js"></script> -->
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
<link rel="stylesheet" href="https://cdn.datatables.net/1.12.1/css/jquery.dataTables.min.css">
<!-- Kanban scripts -->
<script src="assets/js/plugins/dragula/dragula.min.js"></script>
<script src="assets/js/plugins/jkanban/jkanban.js"></script>
<script src="assets/js/material-dashboard.js?v=3.0.6"></script>
<link href="https://gitcdn.github.io/bootstrap-toggle/2.2.2/css/bootstrap-toggle.min.css" rel="stylesheet">
<script src="https://gitcdn.github.io/bootstrap-toggle/2.2.2/js/bootstrap-toggle.min.js"></script>
<script>
	var start_Index;
	var end_Index
	var action_type;
	var index = 1;
	var curPage = 0;
	var activePage = 0;

	$(document).ready(function() {
		checkSession();
		getDepartmentList();
		getemployeeRoleList();
		getReportingToList();
		getEmployeeTypeList();
		getEmployeeStatusList();
		actiontype = "getAllEmployees";
		loadEmployeeList1();
		start_Index = 0;
		index = 1;
		end_Index = 10;
		loadEmployeeList();
		showSelectedView();
		$('#search').click(function() {
			if($('#CPageNo').val() != ''){
				var cpage = parseInt($('#CPageNo').val()) +1; 
				$('#CPageNo').val(cpage)
			actiontype = "searchData";
			index = 1;
			start_Index = 0;
			end_Index = 10;
			pageNo = cpage;
			loadEmployeeList();
			loadEmployeeList1();
			}
		});

		$("#records").change(function() {
			actiontype = "getAllEmployees";
			index = 1;
			start_Index = 0;
			end_Index = 10;
			loadEmployeeList();
			loadEmployeeList1();
			
		});
		$('#searchbtn_id').click(function() {
			if ($('#searchCardId').is(':visible')) {
				console.log('yes');
				$('#searchCardId').css('display', 'none');
			} else {
				console.log('no');
				$('#searchCardId').css('display', 'block');
			}
		});
	});
	function checkSession(){
		jQuery.ajax({
			type : "POST",
			url : "checksession",
			data : { 
			},
			async : true,
			success : function(data) { 
				if(data == 'Failure'){
					window.location = 'signin.jsp';
				}
				 
			},
			error : function(data) {
				window.location = 'signin.jsp';
			}
		});
	}
	function showSelectedView() {
		console.log($('#tableviwid').is(":checked"), "djsfn");
		if ($('#tableviwid').is(":checked") == false) {
			$('#tableview').show();
			$('#gridview').hide();

		} else {
			$('#tableview').hide();
			$('#gridview').show();
		}
	}
	function showNewEmployeeModal() {
		$('#newEmployee').modal("show");

		$('#employee_code').val('');
		$('#employee_name').val('');
// 		$('#reporting_to').val('');
		$('#employee_email').val('');
		$('#employee_phone').val('');
		$('#date_joining').val( today());
		$('#aadhar_card_no').val('');
		$('#passport_no').val('');
		$('#pan_no').val('');
		$('#current_address').val('');
		$('#permanant_address').val('');
		$('#date_of_birth').val('');
// 		$('#gender').val('');
		$('#msgError_employee_email').hide();
		$('#msgError_employee_phone').hide();
	}
	var employeeId;
	function deleteEmployee(id) {
		this.employeeId = id;
		
		console.log("employ id is: ", this.employeeId)
	}

	function deleteEmployeeById() {
		console.log("id is: ", employeeId)
		$.ajax({
			url : "employee?actionType=deleteEmployeeById",
			type : 'post',
			async: false,
			data : {
				id : employeeId,
			},
			success : function(data) {
				$('#employee-row-'+employeeId).remove();
	
			},
			error : function(error) {
				alert(error);
			}
		})
	}
	function loadEmployeeList() {
		$('#cPageNo').val(1);
		$.ajax({
			url : "employee",
			type : "POST",
			data : {
				actionType : actiontype,
				searchEmployee_code_id : $('#searchEmployee_code_id').val(),
				searchEmployee_name_id : $('#searchEmployee_name_id').val(),
				searchDepartment_id : $('#searchDepartment_id').val(),
				searchEmployee_role_id : $('#searchEmployee_role_id').val(),
				searchEmployee_email_id : $('#searchEmployee_email_id').val(),
				searchEmployee_phone_id : $('#searchEmployee_phone_id').val(),
				searchStatus : $('#searchStatus').val(),
				startIndex : 0,
				endIndex : 10,
			},
			success : function(resp) {
// 				$('#loadnextgridid').prop('hidden', false)
				console.log("emplist 0:",resp[0]);
				$("#employeelistid").empty();
				

				if (resp[0].length % 2 == 0) {
					$('#loadnextgridid').prop('hidden', true);
					$('#loadnextgridid').prop('hidden', true);
				}
				if (resp[0].length < 10) {
					$('#loadnextgridid').prop('hidden', true);
					$('#loadnextgridid').prop('hidden', true);
					
				}else {
					$('#loadnextgridid').prop('hidden', false);
					$('#loadnextgridid').prop('hidden', false);
				}
				
				if (resp[1] > 0) {
					var jsonData = eval(resp[0]);
					if (jsonData.length > 0) {
						for (var i = 0; i < jsonData.length; i++) {
							var rowdata = jsonData[i];

							var newemployeerow = createemplpyeerow(rowdata);
							$('#employeelistid').append(newemployeerow);
							

						}
						

					}
				}
				

			},
			error : function(error) {
				alert(error);
			}
		});
	}
	
	//Load More(GRID)
	function loadNextEmployeeList() {
		if($('#cPageNo').val() != ''){
			var cpage = parseInt($('#cPageNo').val()) +1; 
			$('#cPageNo').val(cpage)
		$.ajax({
			url : "employee",
			type : "POST",
			data : {
				actionType : actiontype,
				searchEmployee_code_id : $('#searchEmployee_code_id').val(),
				searchEmployee_name_id : $('#searchEmployee_name_id').val(),
				searchDepartment_id : $('#searchDepartment_id').val(),
				searchEmployee_role_id : $('#searchEmployee_role_id').val(),
				searchEmployee_email_id : $('#searchEmployee_email_id').val(),
				searchEmployee_phone_id : $('#searchEmployee_phone_id').val(),
				searchStatus : $('#searchStatus').val(),
				startIndex : 0,
				endIndex : 10,
				pageNo: cpage 
			},
			success : function(resp) {
				console.log("emplist 0:",resp[0]);
			//	$("#employeelistid").empty();
			
				if (resp[0].length % 2 == 0) {
					$('#loadnextgridid').prop('hidden', true);
					$('#loadnextgridid').prop('hidden', true);
				}
				if (resp[0].length < 10) {
					$('#loadnextgridid').prop('hidden', true);
					$('#loadnextgridid').prop('hidden', true);
					
				}else {
					$('#loadnextgridid').prop('hidden', false);
					$('#loadnextgridid').prop('hidden', false);
				}
// 				else{
				if (resp[1] > 0) {
					var jsonData = eval(resp[0]);
					if (jsonData.length > 0) {
						for (var i = 0; i < jsonData.length; i++) {
							var rowdata = jsonData[i];

							var newemployeerow = createemplpyeerow(rowdata);
							$('#employeelistid').append(newemployeerow);

						}

					}
				}
// 				}

			},
			error : function(error) {
				alert(error);
			}
		});
	}
	}
	
	
	function createemplpyeerow(data) {
		var rowData = '<div class="col-lg-6 col-sm-12 col-md-6 mb-2" id="employee-row-'+ data.employee_id +'" >';
		rowData += '<div class="card">';
		rowData += '<div class="card-body p-3 position-relative">';

		rowData += '<div class="row">';
		rowData += '<div class="col-2 text-start"> <img src="uploads/avatar/'+ data.employee_profile_avatar +'" class="avatar avatar-sm me-3" alt="'+ data.employee_name +'">';
		rowData += '</div>';

		rowData += '<div class="col-7 text-start">';
		rowData += '<h6 class="font-weight-bolder mb-0">';
		rowData += '' + data.employee_name + '';
		rowData += '</h6>';
		rowData += '<p class="text-sm mb-1 text-capitalize ">#'
				+ data.employee_code + '</p>';
		rowData += '</div>';

		rowData += '<div class="col-3 text-end  mb-2">';
		rowData += '<a class="cursor-pointer text-color-primary" onclick="editEmployeeDetails('
				+ data.employee_id + ');">';
		rowData += '<i class="material-icons text-sm me-2">edit</i></a>';
		rowData += '<a class="cursor-pointer text-danger" data-bs-toggle="modal" data-bs-target="#deleteModal" onclick="deleteEmployee('
				+ data.employee_id + ');">';
		rowData += '<i class="material-icons text-sm me-2">delete</i></a>';
		rowData += '</div>';
		rowData += '</div>';

		rowData += '<div class="row mb-2">';
		rowData += '<div class="col-6 text-start">';
		rowData += '<span class="text-sm font-weight-normal text-color-black">'
				+ data.employee_role_name + '</span>';
		rowData += '</div>';
		rowData += '<div class="col-6 text-start">';
		rowData += '<span class="text-sm font-weight-normal text-color-black">'
				+ data.department_name + '</span>';
		rowData += '</div>';
		rowData += '</div>';

		rowData += '<div class="row">';
		rowData += '<div class="col-md-6 col-sm-12 text-start  mb-2">';
		rowData += '<span class="p-0 mb-0 text-sm text-color-black"><i class="fas fa-envelope text-info text-sm" aria-hidden="true"></i> '
				+ data.employee_email + '</span>';
		rowData += '</div>';
		rowData += '<div class="col-md-6 col-sm-12 text-start  mb-2">';
		rowData += '<span class="p-0 mb-0 text-sm text-color-black"><i class="fas fa-phone-square-alt text-info text-sm"></i> '
				+ data.employee_phone + '</span>';
		rowData += '</div>';
		rowData += '</div>';
		rowData += '</div>';
		rowData += '</div>';
		rowData += '</div>';
		rowData += '</div>';
		return rowData;
	}

	function loadEmployeeList1() {
		$('#cpageno').val(1);
		$
				.ajax({
					url : "employee",
					type : "POST",
					data : {
						actionType : actiontype,
						searchEmployee_code_id : $('#searchEmployee_code_id')
								.val(),
						searchEmployee_name_id : $('#searchEmployee_name_id')
								.val(),
						searchDepartment_id : $('#searchDepartment_id').val(),
						searchEmployee_role_id : $('#searchEmployee_role_id')
								.val(),
						searchEmployee_email_id : $('#searchEmployee_email_id')
								.val(),
						searchEmployee_phone_id : $('#searchEmployee_phone_id')
								.val(),
						searchStatus : $('#searchStatus').val(),
						startIndex : 0,
						endIndex : 10,
					},
					success : function(resp) {
						console.log("emplist 1 : ",resp[0]);
						$("#tbodyId").empty();
						
						if (resp[0].length % 2 == 0) {
							$('#loadnextid').prop('hidden', true);
							$('#loadnextid').prop('hidden', true);
						}
						if (resp[0].length < 10) {
							$('#loadnextid').prop('hidden', true);
							$('#loadnextid').prop('hidden', true);
							
						}else {
							$('#loadnextid').prop('hidden', false);
							$('#loadnextid').prop('hidden', false);
						}
						
						
						
						var tbo = document.getElementById("tbodyId");
						for (var i = 0; i < resp[0].length; i++) {
							var row = '<tr><td style="padding-left: 20px;"><a class="cursor-pointer text-color-primary" onclick="editEmployeeDetails('
									+ resp[0][i].employee_id
									+ ');"><i class="material-icons text-sm me-2">edit</i></a>'
									+ '<a class="cursor-pointer text-danger" data-bs-toggle="modal" data-bs-target="#deleteModal" onclick="deleteEmployee('
									+ resp[0][i].employee_id
									+ ');"><i class="material-icons text-sm me-2">delete</i></a></td><td><img src="uploads/avatar/'+ resp[0][i].employee_profile_avatar +'" class="avatar avatar-sm me-3" alt="'+ resp[0][i].employee_name +'">'
									+ resp[0][i].employee_name
									+ '</td><td>'
									+ resp[0][i].employee_code
									+ '</td><td>'
									+ resp[0][i].employee_role_name
									+ '</td><td>'
									+ resp[0][i].department_name
									+ '</td><td>'
									+ resp[0][i].employee_email
									+ '</td><td>'
									+ resp[0][i].employee_phone
									+ '</td><td>'
									+ resp[0][i].employee_status
									+ '</td></tr>';
							tbo.innerHTML += row;
						}
					},
					error : function(error) {
						alert(error);
					}
				});
	}

	//Load Next Employees list
	function loadNextEmployeeList1() {
		if($('#cpageno').val() != ''){
			var cpage = parseInt($('#cpageno').val()) +1; 
			$('#cpageno').val(cpage)
			console.log("next page is: ",cpage)
		$
				.ajax({
					url : "employee",
					type : "POST",
					data : {
						actionType : actiontype,
						searchEmployee_code_id : $('#searchEmployee_code_id')
								.val(),
						searchEmployee_name_id : $('#searchEmployee_name_id')
								.val(),
						searchDepartment_id : $('#searchDepartment_id').val(),
						searchEmployee_role_id : $('#searchEmployee_role_id')
								.val(),
						searchEmployee_email_id : $('#searchEmployee_email_id')
								.val(),
						searchEmployee_phone_id : $('#searchEmployee_phone_id')
								.val(),
						searchStatus : $('#searchStatus').val(),
						startIndex : 0,
						endIndex : 10,
						pageNo: cpage 
						
					},
					success : function(resp) {
						console.log("emplist 1 more: ",resp);
						if (resp[0].length % 2 == 0) {
							$('#loadnextid').prop('hidden', true);
							$('#loadnextid').prop('hidden', true);
						}
						if (resp[0].length < 10) {
							$('#loadnextid').prop('hidden', true);
							$('#loadnextid').prop('hidden', true);
							
						}else {
							$('#loadnextid').prop('hidden', false);
							$('#loadnextid').prop('hidden', false);
						}
						
							var tbo = document.getElementById("tbodyId");
							for (var i = 0; i < resp[0].length; i++) {
								var row = '<tr id ="employee-row-'+resp[0][i].employee_id+'"><td style="padding-left: 20px;"><a class="cursor-pointer text-color-primary" onclick="editEmployeeDetails('
										+ resp[0][i].employee_id
										+ ');"><i class="material-icons text-sm me-2">edit</i></a>'
										+ '<a class="cursor-pointer text-danger" data-bs-toggle="modal" data-bs-target="#deleteModal" onclick="deleteEmployee('
										+ resp[0][i].employee_id
										+ ');"><i class="material-icons text-sm me-2">delete</i></a></td><td><img src="uploads/avatar/'+ resp[0][i].employee_profile_avatar +'" class="avatar avatar-sm me-3" alt="'+ resp[0][i].employee_name +'">'
										+ resp[0][i].employee_name
										+ '</td><td>'
										+ resp[0][i].employee_code
										+ '</td><td>'
										+ resp[0][i].employee_role_name
										+ '</td><td>'
										+ resp[0][i].department_name
										+ '</td><td>'
										+ resp[0][i].employee_email
										+ '</td><td>'
										+ resp[0][i].employee_phone
										+ '</td><td>'
										+ resp[0][i].employee_status
										+ '</td></tr>';
								tbo.innerHTML += row;	
						}
						//$("#tbodyId").empty();
						
					},
					error : function(error) {
						alert(error);
					}
				});
		}
	}
	
	function updateStartIndex(page) {
		$('#tbodyId').empty();
		curPage = page;
		console.log(page + "page");
		index = page;
		activePage = page;
		start_Index = (page * end_Index);
		loadEmployeeList();
	}

	async function saveEmployeeDetails(form_id) {
		if (validateServiceDetails(form_id)) {
		 var is_emailExist = await is_alreadyexits($('#employee_email').val(),$('#employee_email').attr("name"));
		 if(!is_emailExist){
			 var is_phoneExist = await is_alreadyexits($('#employee_phone').val(),$('#employee_phone').attr("name"));
			if(!is_phoneExist){
				saveEmployee();
				}
			}
		}
	}
	function saveEmployee() {
		$.ajax({
			url : "employee?actionType=save",
			type : 'post',
			data : {
				employee_code : $('#employee_code').val(),
				employee_name : $('#employee_name').val(),
				department_id : $('#department_id').val(),
				remporting_to : $('#reporting_to').val(),
				employee_role : $('#employee_role').val(),
				employee_email : $('#employee_email').val(),
				employee_phone : $('#employee_phone').val(),
				employee_status : $('#employee_status').val(),
				employee_type : $('#employee_type').val(),
				date_joining : $('#date_joining').val(),
				aadhar_card_no : $('#aadhar_card_no').val(),
				passport_no : $('#passport_no').val(),
				pan_no : $('#pan_no').val(),
				current_address : $('#current_address').val(),
				permanant_address : $('#permanant_address').val(),
				date_of_birth : $('#date_of_birth').val(),
				gender : $('#gender').val(),
			},
			success : function(data) {
				if (data == 0) {
					alert("Something wrong please try again ")
				}
				$('#newEmployee').modal("hide");
				loadEmployeeList();
				loadEmployeeList1();
				
			},
			error : function(error) {
				alert(error);
			}
		})
	}

	function editEmployeeDetails(employeeId) {
		console.log("id is: ", employeeId)
		$.ajax({
			url : "employee",
			type : 'post',
			data : {
				employee_id : employeeId,
				actionType : "infoforedit"
			},
			success : function(data) {
				console.log(data);
				if (data != null) {
					$('#updateEmployeeModal').modal("show");
					$('#editEmployee_Id').val(data.employee_id);
					$('#editEmployee_code_id').val(data.employee_code);
					$('#editEmployee_name_id').val(data.employee_name);
					$('#editDepartment_id').val(data.department_id);
					$('#editEmployee_role_id').val(data.employee_role);
					$('#editEmployee_email_id').val(data.employee_email);
					$('#editEmployee_phone_id').val(data.employee_phone);
					$('#editReporting_to_id').val(data.remporting_to);
					$('#editEmployee_status_id').val(data.employee_status);
					$('#editEmployee_type_id').val(data.employee_type);
					$('#editDate_joining_id').val(data.date_joining);
					$('#editAadhar_card_no_id').val(data.aadhar_card_no);
					$('#editPassport_no_id').val(data.passport_no);
					$('#editPan_no_id').val(data.pan_no);
					$('#editCurrent_address_id').val(data.current_address);
					$('#editPermanant_address_id').val(data.permanant_address);
					$('#editDate_of_birth_id').val(data.date_of_birth);
					$('#editGender_id').val(data.gender);
				}
			},
			error : function(error) {
				alert(error);
			}
		})
	}
	 function updateEmployeeDetails(form_id) {
		if (validateServiceDetails(form_id)) {
			console.log("update page")
				updateEmployee();
		}
	}
	function updateEmployee() {
		console.log("Reporting to id", $('#editReporting_to_id').val());
		$.ajax({
			url : "employee",
			type : "post",
			data : {
				actionType : "update",
				employeeId : $('#editEmployee_Id').val(),
				employee_code : $('#editEmployee_code_id').val(),
				employee_name : $('#editEmployee_name_id').val(),
				department_id : $('#editDepartment_id').val(),
				employee_role : $('#editEmployee_role_id').val(),
				employee_email : $('#editEmployee_email_id').val(),
				employee_phone : $('#editEmployee_phone_id').val(),
				remporting_to : $('#editReporting_to_id').val(),
				employee_status : $('#editEmployee_status_id').val(),
				employee_type : $('#editEmployee_type_id').val(),
				date_joining : $('#editDate_joining_id').val(),
				aadhar_card_no : $('#editAadhar_card_no_id').val(),
				passport_no : $('#editPassport_no_id').val(),
				pan_no : $('#editPan_no_id').val(),
				current_address : $('#editCurrent_address_id').val(),
				permanant_address : $('#editPermanant_address_id').val(),
				date_of_birth : $('#editDate_of_birth_id').val(),
				gender : $('#editGender_id').val(),
			},
			success : function(data) {
				if (data == 0) {
					alert("Something wrong please try again ")
				}
				console.log("updated successfully...")
				$('#updateEmployeeModal').modal("hide");
				loadEmployeeList();
				loadEmployeeList1();
				$('#employee-row-'+employeeId).remove();
			},
			error : function(error) {
				alert(error);
			}
		})
	}

	function getDepartmentList() {
		$
				.ajax({
					url : "masterDetails?actionType=departmentList",
					type : 'post',
					data : {
						company_id : "1",
					},
					success : function(data) {
						console.log(data);
						if (data != null) {

							for (let i = 0; i < data.length; i++) {
								var htmlData = '<option value="' + data[i].department_id + '">'
										+ data[i].department_name + '</option>'
								$('#searchDepartment_id').append(htmlData);
								$('#editDepartment_id').append(htmlData);
								$('#department_id').append(htmlData);
							}
						}
					},
					error : function(error) {
						alert(error);

					}
				});
	}
	function getemployeeRoleList() {
		$
				.ajax({
					url : "masterDetails?actionType=employeeRoleList",
					type : 'post',
					data : {
						company_id : "1",
					},
					success : function(data) {
						console.log(data);
						if (data != null) {
							for (let i = 0; i < data.length; i++) {
								var htmlData = '<option value="' + data[i].employee_role_id + '">'
										+ data[i].employe_role_name
										+ '</option>'
								$('#searchEmployee_role_id').append(htmlData);
								$('#editEmployee_role_id').append(htmlData);
								$('#employee_role').append(htmlData);
							}
						}
					},
					error : function(error) {
						alert(error);
					}
				});
	}
	function getReportingToList() {
		$
				.ajax({
					url : "masterDetails?actionType=reportingToList",
					type : 'post',

					success : function(data) {
						console.log(data);
						if (data != null) {
							for (let i = 0; i < data.length; i++) {
								var htmlData = '<option value="' + data[i].employee_id + '">'
										+ data[i].employee_name + '</option>'
								$('#searchReporting_to_id').append(htmlData);
								$('#editReporting_to_id').append(htmlData);
								$('#reporting_to').append(htmlData);
							}
						}
					},
					error : function(error) {
						alert(error);
					}
				});
	}
	function getEmployeeTypeList() {
		$
				.ajax({
					url : "masterDetails?actionType=getEmployeeTypeList",
					type : 'post',
					data : {
						company_id : "1",
					},
					success : function(data) {
						console.log(data);
						if (data != null) {
							for (let i = 0; i < data.length; i++) {
								var htmlData = '<option value="' + data[i].employee_type_id + '">'
										+ data[i].employee_type_name
										+ '</option>'
								$('#searchEmployee_type_id').append(htmlData);
								$('#editEmployee_type_id').append(htmlData);
								$('#employee_type').append(htmlData);
							}
						}
					},
					error : function(error) {
						alert(error);
					}
				});
	}
	function getEmployeeStatusList() {
		$
				.ajax({
					url : "masterDetails?actionType=getEmployeeStatusList",
					type : 'post',
					data : {
						company_id : "1",
					},
					success : function(data) {
						console.log(data);
						if (data != null) {
							for (let i = 0; i < data.length; i++) {
								var htmlData = '<option value="' + data[i].employee_status_id + '">'
										+ data[i].employee_status_name
										+ '</option>'
								$('#editEmployee_status_id').append(htmlData);
								$('#employee_status').append(htmlData);
								$('#searchStatus').append(htmlData);
							}
						}
					},
					error : function(error) {
						alert(error);
					}
				});
	}

	function validateServiceDetails(form_id) {
		var Employee_role = $("#employee_role").val();
		var editEmployee_role = $("#editEmployee_role_id").val()
		var validEmail = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;

		var formObj = $('#' + form_id);
		var inputObj;

		for (var i = 0; i <= formObj.get(0).length - 1; i++) {
			inputObj = formObj.get(0)[i];
			if (inputObj.type === 'text'
					&& inputObj.className === 'required form-control'
					&& inputObj.value === '') {
				$("#msgError_" + inputObj.id).show();
				$("#msgError_" + inputObj.id).text("Please fill this field.");
				return false;
			} else if (inputObj.type == 'select-one'
					&& inputObj.className === 'required form-control'
					&& inputObj.value == '0') {
				if (inputObj.id === 'reporting_to' && Employee_role == '1') {
					$("#msgError_" + inputObj.id).hide();
				} else if (inputObj.id === 'editReporting_to_id'
						&& editEmployee_role == '1') {
					$("#msgError_" + inputObj.id).hide();
				} else {
					$("#msgError_" + inputObj.id).show();
					$("#msgError_" + inputObj.id).text(
							'Please select at least one option.');
					return false;
				}
			} else if (inputObj.type === 'date'
					&& inputObj.className === 'required form-control'
					&& inputObj.value === '') {
				$("#msgError_" + inputObj.id).show();
				$("#msgError_" + inputObj.id).text("Please fill this field.");
				return false;
			} else if (inputObj.type === 'email' && inputObj.className === 'required form-control' ) {
				if(inputObj.value === ''){
					$("#msgError_" + inputObj.id).show();
					$("#msgError_" + inputObj.id).text("Please enter email.");
					$("#" + inputObj.id).focus();
					return false;
				}
				if(!validEmail.test(inputObj.value)){
					$("#msgError_" + inputObj.id).show();
					$("#msgError_" + inputObj.id).text("Please enter valid email.");
					$("#" + inputObj.id).focus();
				}
			}
			if (inputObj.className === 'required form-control') {
				$("#msgError_" + inputObj.id).hide();
			}
		}
		return true;
	}

	function disableReportingToList(obj) {

		if (obj.id == 'employee_role') {
			if (obj.value == '1') {
				$("#reporting_to").prop("disabled", true);
			} else {
				$("#reporting_to").prop("disabled", false);
			}
		}
		if (obj.id == 'editEmployee_role_id') {
			if (obj.value == '1') {
				$("#editReporting_to_id").val('0').prop("selected", "true");
				$("#editReporting_to_id").prop("disabled", true);
			} else {
				$("#editReporting_to_id").prop("disabled", false);
			}
		}
	}
	function today() {
		var d = new Date();
		var gethour = d.getHours() + 2;
		var getminute = d.getMinutes();
		var currDate = d.getDate();
		var currMonth = d.getMonth() + 1;
		var currYear = d.getFullYear();
		return currYear + "-"
				+ ((currMonth < 10) ? '0' + currMonth : currMonth) + "-"
				+ ((currDate < 10) ? '0' + currDate : currDate);
	}
	// Check email and phone is already exists
	async function is_alreadyexits(isexistvalue,checkfor){
		return $.ajax({
			url : "employee",
			method : "POST",
			data : {
				actionType : "checkalreadyexists",
				isexistvalue : isexistvalue,
				checkfor : checkfor
			},
			async : true,
			success : await function(data){
				if(checkfor == 'employee_email'){
					if(data != false){
						$('#msgError_employee_email').text("Email already exists.");
						$('#msgError_employee_email').show();
						$('#employee_email').focus();
					}else{
						$('#msgError_employee_email').hide();
						return true;
					}
				}else if(checkfor == 'employee_phone'){
					if(data != false){
						$('#msgError_employee_phone').text("Phone already exists.");
						$('#msgError_employee_phone').show();
						$('#employee_phone').focus();
					}else{
						$('#msgError_employee_phone').hide();
						return true;
					}
				}
			},
			error : function(error){
				alert(error);
			}
			
		});
	}
	
	
// var is_emailExist = await edit_is_alreadyexits($('#employee_email').val(),$('#employee_email').attr("name"));
// 			 if(!is_emailExist){
// 				 var is_phoneExist = await edit_is_alreadyexits($('#employee_phone').val(),$('#employee_phone').attr("name"));
// 				if(!is_phoneExist){
	async function edit_is_alreadyexits(isexistvalue,checkfor){
		return $.ajax({
			url : "employee",
			method : "POST",
			data : {
				actionType : "checkalreadyexists",
				isexistvalue : isexistvalue,
				checkfor : checkfor
			},
			async : true,
			success : await function(data){
				if(checkfor == 'employee_email'){
					if(data != false){
						$('#msgError_editEmployee_email_id').text("Email already exists.");
						$('#msgError_editEmployee_email_id').show();
						$('#editEmployee_email_id').focus();
					}else{
						$('#msgError_editEmployee_email_id').hide();
						return true;
					}
				}else if(checkfor == 'employee_phone'){
					if(data != false){
						$('#msgError_editEmployee_phone_id').text("Phone already exists.");
						$('#msgError_editEmployee_phone_id').show();
						$('#editEmployee_phone_id').focus();
					}else{
						$('#msgError_editEmployee_phone_id').hide();
						return true;
					}
				}
			},
			error : function(error){
				alert(error);
			}
			
		});
	}
</script>

<%@ include file="/include/footer.jsp"%>
