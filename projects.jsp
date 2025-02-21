<%@page import="com.dakshabhi.pms.masters.dtos.CProjectStatusDTO"%>
<%@page import="com.dakshabhi.pms.masters.dtos.CProjectSubGroupDTO"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.dakshabhi.pms.customers.dtos.CCustomerDTO"%>
<%@page
	import="com.dakshabhi.pms.masters.services.CMasterDetailsService"%>
<%@page import="com.dakshabhi.pms.masters.dtos.CProjectGroupDTO"%>
<%@page import="com.dakshabhi.pms.projects.dtos.CProjectInfoDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ include file="/include/header.jsp"%>
<%@ page isELIgnored="false"%>
 
<style>
.msgError {
	font-size: 0.875rem;
	display: none;
	color: red;
}
select {
	padding-left: 10px !important;
}

@media ( max-width : 640px) {
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
	button#searchbtn_id {
		display: block !important;
	}
	.collapsible {
		float: right;
	}
	.content {
		padding: 0 15px;
		display: none;
		overflow: hidden;
		/* background-color: #F1F1F1; */
		width: 100%;
	}
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

button#searchbtn_id {
	display: none;
}

#selectViewId {
	text-align: end;
	padding: 10px;
}

td:nth-child(4) {
  white-space: normal;
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
					     <h6 class="font-weight-bolder mb-0 breadcrumb-item active">Projects</h6>
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
						<div class="col-6" id="addbtbn" style="text-align: end">
							<button type="button" data-bs-toggle="modal" id="createNewbtnId"
								onclick = "CreateNewProject();"
								class="btn bg-gradient-dark mb-0 mt-0 mt-md-n9 mt-lg-0">
								<i
									class="material-icons text-white position-relative text-md pe-2"
									id="plusSignimgId">add</i>Create New
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
						<div class="col-lg-12 col-md-8">
							<form class="multisteps-form__form">
								<button class="collapsible btn btn-icon btn-2 btn-dark btn-dark"
									id="searchbtn_id" type="button">
									<span class="btn-inner--icon"> <i class="fas fa-filter"></i></span>
								</button>

								<div class="content">
									<div class="row">
										<div class="col-md-3">
											<div class="input-group input-group-dynamic">
												<input class="multisteps-form__input form-control"
													type="text" placeholder="Project Name" name="projectname"
													id="projectname" />
											</div>
										</div>
										<div class="col-md-3">
											<div class="input-group input-group-dynamic">
												<select class="form-control" id="customer" name="customer"
													required="required">
													<option value="">Select Customer</option>

												</select>
											</div>
										</div>
										<div class="col-md-3">
											<div class="input-group input-group-dynamic">
												<select class="form-control" id="project_status_id"
													name="project_status_id">
													<option value="0">Project Status</option>

												</select>
											</div>
										</div>
										<div class="col-md-3 rightalign">
											<button class="btn btn-icon btn-2 btn-dark" id="search"
												type="button">
												<span class="btn-inner--icon"><i
													class="material-icons">search</i></span>
											</button>
										</div>

									</div>

								</div>
							</form>
						</div>
						<div class="col-12 text-end">
							<input type="checkbox" data-size="small" data-toggle="toggle"
								id="tableviwid" onchange="showSelectedView();"
								data-off="<i class='fas fa-th'></i> Grid"
								data-on="<i class='fas fa-th-list'></i> List"
								data-onstyle="success" data-offstyle="info">
						</div>
					</div>
				</div>
				<div class="card card-body p-2 pt-2" id="list-view">
					<div class="table-responsive">
						<table class="table table-flush text-sm" id="tasktableId">
							<thead class="thead-light">
								<tr>
									<th></th>
									<th>Customer Name</th>
									<th>Project Name</th>
									<th>Project Description</th>
									<th>Project Status</th>
								</tr>
							</thead>
							<tbody id="projectlistid">
							</tbody>
						</table>
					</div>
				</div>
				<div class="card card-body " id="grid-view">
					<div class="row" id="projectGridViewid"></div>
				</div>

			</div>
		</div>
		<!-- Delete Modal -->
		<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title font-weight-normal" id="exampleModalLabel">Delete
							Confirmation</h5>
						<button type="button" class="btn-close text-dark"
							data-bs-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">Are you sure you want to delete this
						item?</div>
					<div class="modal-footer">
						<button type="button" class="btn bg-gradient-secondary"
							data-bs-dismiss="modal">Close</button>
						<button type="button" class="btn bg-gradient-primary"
							data-bs-dismiss="modal" onclick="deleteEmployee();">Delete</button>
					</div>
				</div>
			</div>
		</div>


		<!--  create new project model -->
		<div class="modal fade" id="mymodel" tabindex="-1" role="dialog"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog  modal-xl modal-dialog-centered"
				role="document">
				<div class="modal-content ">
					<!--Header-->
					<div class="modal-header ">
						<h4 class="modal-title" id="myModalLabel">New Project</h4>
						<button type="button" class="btn-close text-dark"
							data-bs-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<!--Body-->
					<div class="modal-body">
						<div class="container-fluid py-4">
							<div class="card mb-4 ">

								<div class="card-body">
									<div class="row">
										<div class="col-lg-12 col-md-12">
											<form name="projectform" id="createnewId">
												<input type="hidden" name="action_type" value="save" />

												<div class="row">
													<div class="col-md-4">
														<div class="input-group input-group-static mb-4">
															<label>Customer</label> <select class="required form-control p-2"
																id="createNewCustomer_id" name="createNewcustomer_id"
																required="required">
																<option value="">Select Customer</option>
															</select>
															<span class="msgError" Id ="msgError_createNewCustomer_id"></span>

														</div>
													</div>
													<div class="col-md-4">
														<div class="input-group input-group-static mb-4">
															<label>Project Name</label> <input type="text"
																class="required form-control" name="project_name"
																id="createNewProject_name_id">
																<span class="msgError" Id ="msgError_createNewProject_name_id"></span>
																
														</div>
													</div>
													<div class="col-md-4">
														<div class="input-group input-group-static mb-4">
															<label>Project Type</label> <select class="required form-control"
																id="createNewProject_Type_id" name="project_type">

															</select>
														</div>
													</div>
												</div>

												<div class="row">
													<div class="col-md-8">
														<div class="input-group input-group-static mb-4">
															<label>Project Description</label>
															<textarea class="form-control" rows="1"
																placeholder="This is how others will learn about the project, so make it good!"
																spellcheck="false" name="project_description"
																id="createNewProject_description_id"></textarea>
																<span class="msgError" Id ="msgError_createNewProject_description_id"></span>
																
														</div>
													</div>
													<div class="col-md-4">
														<div class="input-group input-group-static mb-4">
															<label>Project Code</label> <input type="text"
																class="form-control" name="project_code"
																id="createNewProject_code_id">
																<span class="msgError" Id ="msgError_createNewProject_code_id"></span>
														</div>
													</div>

												</div>

												<div class="row">
													<div class="col-md-4">
														<div class="input-group input-group-static mb-4">
															<label>Project Status</label> <select
																class="required form-control" id="createNewProject_status_id"
																name="project_status">

															</select>
														</div>
													</div>
													<div class="col-md-4">
														<div class="input-group input-group-static mb-4">
															<label>Start Date</label> <input type="date"
																class="required form-control" name="start_date"
																id="createNewStart_date_id" >
																
														</div>
													</div>
													<div class="col-md-4">
														<div class="input-group input-group-static mb-4">
															<label>End Date</label> <input type="date"
																class="required form-control" name="end_date"
																id="createNewEnd_date_id" >
														</div>
													</div>
												</div>

												<div class="row justify-content-md-end mt-4">
													<div class="col-md-auto px-1 text-end">
														<button type="button" class="btn bg-gradient-info"
															onclick="return saveInModelList();">Create
															Project</button>
														<button type="button" class="btn btn-link  ml-auto"
															data-bs-dismiss="modal">Close</button>
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

		<!-- update model -->
		<div class="modal fade" id="updateModal" tabindex="-1" role="dialog"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog  modal-xl modal-dialog-centered"
				role="document">
				<div class="modal-content">
					<!--Header-->
					<div class="modal-header">
						<h4 class="modal-title" id="myModalLabel">Update Project</h4>
						<button type="button" class="btn-close text-dark"
							data-bs-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<!--Body-->
					<div class="modal-body">
						<div class="container-fluid py-4">
							<div class="card mb-4 ">

								<div class="card-body">
									<div class="row">
										<div class="col-lg-12 col-md-12">
											<form name="projectform" id="updateModel">
												<input type="hidden" name="action_type" value="update" /> <input
													type="hidden" name="project_id"
													value="${objProjectInfoDTO.project_id}" />

												<div class="row">
													<div class="col-md-4">
														<div class="input-group input-group-static mb-4">
															<label>Customer</label> <select class="form-control"
																id="updateCustomer_id" name="customer_id"
																required="required">
																<option value="">Select Customer</option>

															</select>
														</div>
													</div>
													<div class="col-md-4">
														<div class="input-group input-group-static mb-4">
															<label>Project Name</label> <input type="text"
																class="form-control" name="project_name"
																id="updateProject_name_id" required="required"
																value="${objProjectInfoDTO.project_name}">
														</div>
													</div>
													<div class="col-md-4">
														<div class="input-group input-group-static mb-4">
															<label>Project Type</label> <select class="form-control"
																id="updateProject_Type_id" name="project_type"
																required="required">
																<option value="">Select Project Type</option>

															</select>
														</div>
													</div>
												</div>

												<div class="row">
													<div class="col-md-8">
														<div class="input-group input-group-static mb-4">
															<label>Project Description</label>
															<textarea class="form-control" rows="1"
																placeholder="This is how others will learn about the project, so make it good!"
																spellcheck="false" name="project_description"
																id="updateProject_description_id" required="required">${objProjectInfoDTO.project_description}</textarea>
														</div>
													</div>
													<div class="col-md-4">
														<div class="input-group input-group-static mb-4">
															<label>Project Code</label> <input type="text"
																class="form-control" name="project_code"
																id="updateProject_code_id" required="required">
														</div>
													</div>
												</div>
												<div class="row">
													<div class="col-md-4">
														<div class="input-group input-group-static mb-4">
															<label>Project Status</label> <select
																class="form-control" id="updateProject_status_id"
																name="project_status" required="required">
																<option value="">Select Project Status</option>

															</select>
														</div>
													</div>
													<div class="col-md-4">
														<div class="input-group input-group-static mb-4">
															<label>Start Date</label> <input type="date"
																class="form-control" name="start_date"
																id="updateStart_date_id"
																value="${objProjectInfoDTO.project_start_date}"
																required="required">
														</div>
													</div>
													<div class="col-md-4">
														<div class="input-group input-group-static mb-4">
															<label>End Date</label> <input type="date"
																class="form-control" name="end_date"
																id="updateEnd_date_id"
																value="${objProjectInfoDTO.project_end_date}"
																required="required">
														</div>
													</div>
												</div>

												<div class="row justify-content-md-end mt-4">

													<div class="col-md-auto px-1 text-end">
														<button type="button" name="button"
															class="btn bg-gradient-info"
															onclick="return updateModelFun();">Update
															Project</button>
														<button type="button" name="button"
															class="btn btn-link  ml-auto" data-bs-dismiss="modal">Close</button>
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
	<form name="projectform" action="projects" method="post" id="save">
		<input type="hidden" name="action_type" id="action_type" /> <input
			type="hidden" name="project_id" id="project_id" />
	</form>
</body>
<!--   Core JS Files   -->
<script src="assets/js/core/popper.min.js"></script>
<script src="assets/js/core/bootstrap.min.js"></script>
<script src="assets/js/plugins/perfect-scrollbar.min.js"></script>
<script src="assets/js/plugins/smooth-scrollbar.min.js"></script>
<script src="assets/js/plugins/datatables.js"></script>
<script src="assets/js/plugins/choices.min.js"></script>
<!-- Kanban scripts -->
<script src="assets/js/plugins/dragula/dragula.min.js"></script>
<script src="assets/js/plugins/jkanban/jkanban.js"></script>
<link
	href="https://gitcdn.github.io/bootstrap-toggle/2.2.2/css/bootstrap-toggle.min.css"
	rel="stylesheet">
<script
	src="https://gitcdn.github.io/bootstrap-toggle/2.2.2/js/bootstrap-toggle.min.js"></script>


<script type="text/javascript">
	var start_Index;
	var end_Index
	var action_type;
	var index = 1;
	var curPage = 0;
	var activePage = 0;
	$(document).ready(function() {
		checkSession();
		getProjectStatusList();
		getProjectGroupList();
		getProjectSubGroupList();
		getCustomerNameList();
		getProjectType();
		activePage = 0;
		action_type = "searchData";
		start_Index = 0;
		index = 1;
		end_Index = 10;
		loadProjectList();
		showSelectedView();
	})
	
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
		if ($('#tableviwid').is(":checked")) {
			$('#list-view').hide();
			$('#grid-view').show();

		} else {

			$('#list-view').show();
			$('#grid-view').hide();
		}
	}
	$("#search").click(function() {
		action_type = "searchData";
		index = 1;
		start_Index = 0;
		activePage = 0;
		end_Index = 10;
		loadProjectList();
	});

	function loadProjectList() {
		$("#projectGridViewid").empty();
		$("#projectlistid").empty();
		$
				.ajax({
					url : "projects",
					type : "post",
					async : false,
					data : {
						action_type : action_type,
						projectname : $("#projectname").val(),
						customer : $("#customer").val(),
						project_status_id : $("#project_status_id").val(),
					},
					success : function(resp) {
						console.log('Projects: ' + resp[0]);
						var DataViewSelected = $('#view-selector').val();
						if (resp[1] > 0 && resp[0] != null) {
							for (var i = 0; i < resp[0].length; i++) {
								newProjectRowContent = getRowDataGridView((resp[0])[i]);
								newProjectRowContentList = getRowDataListView((resp[0])[i]);
								$("#projectGridViewid").append(
										newProjectRowContent);
								$("#projectlistid").append(
										newProjectRowContentList);
							}
						} else {
							projectGridViewid.innerHTML = "<div><center><b style='color:red'>No records found....<b></center></div>";
							projectlistid.innerHTML = "<tr><td colspan='12'><center><b style='color:red'>No records found....<b></center></td></tr>";
						}

					}
				})
	}

	function getRowDataListView(data) {
		console.log(data);
		var rowData = "<tr>";
		rowData += "<td><a class='text-dark cursor-pointer'  data-bs-toggle='modal' data-bs-target='#updateModal' onclick='editProjectDetails("
				+ data.project_id
				+ ");'><i class='material-icons text-sm me-2'>edit</i></a><a class='text-danger cursor-pointer' data-bs-toggle='modal' data-bs-target='#exampleModal' onclick='deleteEmployeeById("
				+ data.project_id
				+ ");'><i class='material-icons text-sm me-2'>delete</i></a> <a href='javascript:;' class='text-info cursor-pointer' onclick=\"viewProject('"
				+ data.project_id
				+ "','"
				+ data.project_name
				+ "')\"><i class='material-icons text-sm me-2'>preview</i></a> </td>";
		rowData += "<td>" + data.customer_name + "</td>";
		rowData += "<td>" + data.project_name + "</td>";
		rowData += "<td>" + data.project_description + "</td>";
		rowData += "<td>"
				+ createStatusElement(data.project_status_id,
						data.project_status) + "</td>";
		rowData += "</tr>";
		return rowData;
	}
	function getRowDataGridView(data) {
		var rowData = "<div class='col-xl-3 col-md-6 mb-xl-0 mb-4'>";
		rowData += "<div class='card card-blog card-plain'>";
		rowData += "<div class='card-header p-0'>";
		rowData += "<a class='d-block shadow-xl' style='border-radius: 0.75rem;'> <img src='assets/img/project-demo.jpg' alt='img-blur-shadow' class='img-fluid shadow' style='border-radius: 0.75rem;'></a>";
		rowData += "</div>";
		rowData += "<div class='card-body p-3'><p class='mb-0 text-sm'>"
				+ data.customer_name + "</p><a href='javascript:;'><h5>"
				+ data.project_name + "</h5></a>";
		rowData += "<p class='mb-4 text-sm'>" + data.project_description
				+ "</p>";
		rowData += "<p class='text-sm'>"
				+ createStatusElement(data.project_status_id,
						data.project_status) + "</p>";
		rowData += "<div class='d-flex align-items-center justify-content-between'>";
		rowData += "<button type='button' class='btn btn-outline-primary btn-sm mb-0' onclick=\"viewProject('"
				+ data.project_id
				+ "','"
				+ data.project_name
				+ "')\">View 	Project</button>";
		rowData += "<div><a class='btn btn-link text-dark px-1 mb-0' data-bs-toggle='modal' data-bs-target='#updateModal' onclick='editProjectDetails("
				+ data.project_id
				+ ");'><i class='material-icons text-sm me-2'>edit</i></a><a class='btn btn-link text-danger text-gradient px-1 mb-0' data-bs-toggle='modal' data-bs-target='#exampleModal' onclick='deleteEmployeeById("
				+ data.project_id
				+ ");'><i class='material-icons text-sm me-2'>delete</i></a></div>";
		rowData += "</div>";
		rowData += "</div>";
		rowData += "</div>";
		rowData += "</div>";
		rowData += "</div>";
		return rowData;
	}

	function createStatusElement(id, status) {
		switch (id) {
		case 1:
			return '<span class="badge badge-warning">' + status + '</span>';
			break;
		case 2:
			return '<span class="badge badge-info">' + status + '</span>';
			break;
		case 3:
			return '<span class="badge badge-success">' + status + '</span>';
			break;
		case 4:
			return '<span class="badge badge-danger">' + status + '</span>';
			break;
		case 5:
			return '<span class="badge badge-primary">' + status + '</span>';
			break;
		case 6:
			return '<span class="badge badge-secondary">' + status + '</span>';
			break;

		default:
			return '<span class="badge badge-secondary">' + status + '</span>';
		}
	}
	function viewProject(projectid, projectname) {
		sessionStorage.removeItem("projectid");
		sessionStorage.removeItem("projectname");
		sessionStorage.setItem("projectid", projectid);
		sessionStorage.setItem("projectname", projectname);
		window.location = 'projectview.jsp';
	}

	function saveInModelList() {
		console.log($("#createNewProject_Type_id").val());
		if(validateServiceDetails("createnewId")){
		$.ajax({
			url : "projects",
			type : "POST",
			data : {
				action_type : "save",
				customer_id : $("#createNewCustomer_id").val(),
				project_name : $("#createNewProject_name_id").val(),
				project_description : $("#createNewProject_description_id")
						.val(),
				start_date : $("#createNewStart_date_id").val(),
				end_date : $("#createNewEnd_date_id").val(),
				/* project_group : $('#createNewProject_group_id').val(),
				project_sub_group : $("#createNewProject_sub_group_id")
						.val(),
				project_inp_number : $(
						"#createNewProject_inp_number_id").val(), */
				project_status : $("#createNewProject_status_id").val(),
				/* customer_order_no : $("#createNewCustomer_order_no")
						.val(),
				customer_order_date : $("#createNewCustomer_order_date")
						.val(), */
				project_code : $("#createNewProject_code_id").val(),
				project_type : $("#createNewProject_Type_id").val()

			},
			success : function(resp) {
				console.log(resp);
				$("#createNewCustomer_id").val("");
				$("#createNewProject_name_id").val("");
				$("#createNewProject_description_id").val("");
				$("#createNewStart_date_id").val("");
				$("#createNewEnd_date_id").val("");

				$("#createNewProject_status_id").val("");

				$("#createNewProject_code_id").val("");
				$("#createNewProject_Type_id").val("");

				loadProjectList();

				$("#mymodel").modal("hide");
			}
		})
		}
	}

	var projectid;
	function deleteEmployeeById(id) {
		this.projectid = id;
	}

	function deleteEmployee() {
		document.getElementById('action_type').value = 'delete';
		document.getElementById('project_id').value = projectid;
		document.getElementById('save').submit();
		loadProjectList();

	}

	function editProjectDetails(projectid) {
		console.log(projectid);
		this.projectid = projectid;
		$.ajax({
			url : "projects",
			type : "POST",
			data : {
				action_type : "infoforedit",
				project_id : projectid
			},
			success : function(resp) {
				console.log("edit data",resp);
				$("#updateCustomer_id").val(resp.customer_id);
				$("#updateProject_name_id").val(resp.project_name);
				$("#updateProject_description_id")
						.val(resp.project_description);
				$("#updateStart_date_id").val(resp.project_start_date);
				$("#updateEnd_date_id").val(resp.project_end_date);
				/* $("#updateProject_group_id").val(resp.project_group_id);
				$("#updateProject_sub_group_id").val(
						resp.project_sub_group_id);
				$("#updateProject_inp_number_id").val(
						resp.project_inp_number); */
				$("#updateProject_status_id").val(resp.project_status_id);
				/* $("#updateCustomer_order_no").val(
						resp.customer_order_no);
				$("#updateCustomer_order_date").val(
						resp.customer_order_date); */
				$("#updateProject_code_id").val(resp.project_code);
				$("#updateProject_Type_id").val(resp.project_type_id);
			}
		})

	}

	function updateModelFun() {
		console.log($("#updateProject_Type_id").val());
		console.log($("#updateProject_code_id").val());
		console.log(projectid);
		$.ajax({
			url : "projects",
			type : "POST",
			data : {
				action_type : "update",
				project_id : projectid,
				customer_id : $("#updateCustomer_id").val(),
				project_name : $("#updateProject_name_id").val(),
				project_description : $("#updateProject_description_id").val(),
				start_date : $("#updateStart_date_id").val(),
				end_date : $("#updateEnd_date_id").val(),
				/* project_group : $('#updateProject_group_id').val(),
				project_sub_group : $("#updateProject_sub_group_id").val(),
				project_inp_number : $("#updateProject_inp_number_id").val(), */
				project_status : $("#updateProject_status_id").val(),
				/* customer_order_no : $("#updateCustomer_order_no").val(),
				customer_order_date : $("#updateCustomer_order_date").val() */
				project_code : $("#updateProject_code_id").val(),
				project_type : $("#updateProject_Type_id").val()
			},
			success : function(resp) {
				console.log(resp);
				loadProjectList();
				$("#updateModal").modal("hide");
			}
		})
	}

	function getProjectStatusList() {
		$
				.ajax({
					url : "masterDetails?actionType=projectStatusList",
					type : 'post',
					data : {
						company_id : "1",
					},
					success : function(data) {
						console.log(data);
						if (data != null) {
							for (let i = 0; i < data.length; i++) {
								var htmlData = '<option value="' + data[i].project_status_id + '">'
										+ data[i].project_status + '</option>'
								$('#updateProject_status_id').append(htmlData);//
								$('#createNewProject_status_id').append(
										htmlData);
								$('#project_status_id').append(htmlData);
							}
						}
					},
					error : function(error) {
						alert(error);
					}
				});
	}

	function getProjectGroupList() {
		$
				.ajax({
					url : "masterDetails?actionType=projectGroupList",
					type : 'post',
					data : {
						company_id : "1",
					},
					success : function(data) {
						console.log(data);
						if (data != null) {
							for (let i = 0; i < data.length; i++) {
								var htmlData = '<option value="' + data[i].project_group_id + '">'
										+ data[i].project_group_name
										+ '</option>'
								$('#updateProject_group_id').append(htmlData);//
								$('#createNewProject_group_id')
										.append(htmlData);
								$('#project_group_id').append(htmlData);
							}
						}
					},
					error : function(error) {
						alert(error);
					}
				});
	}

	function getProjectSubGroupList() {
		$
				.ajax({
					url : "masterDetails?actionType=projectSubGroupList",
					type : 'post',
					data : {
						company_id : "1",
					},
					success : function(data) {
						console.log(data);
						if (data != null) {
							for (let i = 0; i < data.length; i++) {
								var htmlData = '<option value="' + data[i].project_sub_group_id + '">'
										+ data[i].project_sub_group
										+ '</option>'
								$('#updateProject_sub_group_id').append(
										htmlData);//
								$('#createNewProject_sub_group_id').append(
										htmlData);
								$('#project_sub_group_id').append(htmlData);
							}
						}
					},
					error : function(error) {
						alert(error);
					}
				});

	}

	function getCustomerNameList() {
		$
				.ajax({
					url : "projects",
					type : "POST",
					async : false,
					data : {
						action_type : "getCustomerNameList",
					},
					success : function(resp) {
						console.log(resp);
						if (resp != null) {
							for (let i = 0; i < resp.length; i++) {
								var htmlData = '<option value="' + resp[i].customer_id + '">'
										+ resp[i].customer_name + '</option>'

								$('#customer').append(htmlData);
								$('#createNewCustomer_id').append(htmlData);//
								$('#updateCustomer_id').append(htmlData);

							}
							var customerid = sessionStorage
									.getItem("customerid");
							console.log("customerid: " + customerid);
							$("#customer").val(customerid);
							sessionStorage.removeItem("customerid");
						}

					},
					error : function(error) {
						alert(error);
					}
				});

	}

	function getProjectType() {
		$
				.ajax({
					url : "masterDetails",
					type : "POST",
					data : {
						actionType : "projectType",
						company_id : "1"
					},
					success : function(resp) {
						console.log("projectType", resp);
						if (resp != null) {
							for (let i = 0; i < resp.length; i++) {
								var htmlData = '<option value="' + resp[i].project_type_id + '" >'
										+ resp[i].project_type + '</option>'

								$('#createNewProject_Type_id').append(htmlData);
								$('#updateProject_Type_id').append(htmlData);

							}
						}

					},
					error : function(error) {
						alert(error);
					}
				});
	}

	var coll = document.getElementsByClassName("collapsible");
	var i;
	for (i = 0; i < coll.length; i++) {
		coll[i].addEventListener("click", function() {
			this.classList.toggle("active");
			var content = this.nextElementSibling;
			if (content.style.display === "block") {
				content.style.display = "none";
			} else {
				content.style.display = "block";
			}
		});
	}
	function CreateNewProject() {
		 $("#createNewStart_date_id").val( today());
		 $("#createNewEnd_date_id").val( today());
		 $("#mymodel").modal("show");
		
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
	function validateServiceDetails(form_id) {
		var formObj = $('#' + form_id);
		var inputObj;

		for (var i = 0; i <= formObj.get(0).length - 1; i++) {
			inputObj = formObj.get(0)[i];
			if (inputObj.type == 'select-one'
					&& inputObj.className === 'required form-control p-2'
					&& inputObj.value == '') {
				$("#msgError_" + inputObj.id).show();
				$("#msgError_" + inputObj.id).text(
						'Please select at least one option.');
				return false;
			} else if (inputObj.type === 'text'
					&& inputObj.className === 'required form-control'
					&& inputObj.value === '') {
				$("#msgError_" + inputObj.id).show();
				$("#msgError_" + inputObj.id).text("Please fill this field.");
				return false;
			} else if (inputObj.type === 'textarea'
					&& inputObj.className === 'required form-control'
					&& inputObj.value === '') {
				$("#msgError_" + inputObj.id).show();
				$("#msgError_" + inputObj.id).text("Please fill this field.");
				return false;
			}
			if (inputObj.className === 'required form-control') {
				$("#msgError_" + inputObj.id).hide();
			}else if(inputObj.className === 'required form-control p-2'){
				$("#msgError_" + inputObj.id).hide();
			}
		}
		return true;
	}
</script>

<!-- Control Center for Material Dashboard: parallax effects, scripts for the example pages etc -->
<script src="assets/js/material-dashboard.min.js?v=3.0.6"></script>
<%@ include file="/include/footer.jsp"%>

