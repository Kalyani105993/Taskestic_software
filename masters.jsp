<%@page import="java.util.Iterator"%>
<%@page import="com.dakshabhi.pms.customers.dtos.CCustomerDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ include file="/include/header.jsp"%>
<link rel="stylesheet"
	href="https://cdn.datatables.net/1.12.1/css/jquery.dataTables.min.css">
<style>
#createNewbtnId {
	margin-bottom: 1rem;
	letter-spacing: 0;
	text-transform: uppercase;
	background-size: 150%;
	background-position-x: 25%;
	position: relative;
	overflow: hidden;
	-webkit-appearance: none;
	width: max-content;
}

.col-md-3 {
	padding: 20px;
}

.icon-sm {
	width: 40px;
	height: 40px;
	margin-top: 4px !important;
	padding-top: 5px;
}

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
    .g-sidenav-show .navbar:not(.sidenav).navbar-main .navbar-nav {
        flex-direction :column !important; 
    }

    .col-10 {
    flex: 0 0 auto;
    width: 62.333333% !important;
    margin-left: 65px !important;
}
}

.col-md-3 {
	padding: 10px;
}

#searchErrorId {
	display: none;
	color: red;
	text-align: end;
}

.button.btn.bg-gradient-dark.m-0.ms-2 {
	width: fit-content;
	width: min-content;
}

.msgError {
	font-size: 0.875rem;
	display: none;
	color: red;
}

i.fa.fa-asterisk {
	color: #ff0000;
	font-size: xx-small;
}

.groupDate {
	padding: 5px;
	background-color: #eeee;
}

.hours-totals {
	margin-top: initial;
	text-align: right;
}

.hours-totals .value {
	font-weight: bold;
}

.linebreak {
	white-space: normal !important;
}

@media ( min-width :768px) {
	.linebreak {
		width: 50% !important;
	}
}

.inputhide {
	border: 0px solid;
	text-decoration: none;
	background-color: #fff;
}


@media (min-width: 768px){
	.mt-md-n9 {
		margin-top: 0px !important;
	}
}
ol.breadcrumb {
        width: fit-content !important;
    } 
    div#breadcrumbItems {
        display: -webkit-box;
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
						<div class="col-2">
						<ol class="breadcrumb" >
						<div id="breadcrumbItems">
					    <li class="breadcrumb-item"><a i class="material-icons fixed-plugin-button-nav cursor-pointer " href='workspace.jsp'> home </i></a></li>
					     <h6 class="font-weight-bolder mb-0 breadcrumb-item active">Masters</h6>
					</div>
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
						<div class="col-10 ">
							<div class="collapse navbar-collapse text-end" id="navbarSupportedContent">
								<ul class="navbar-nav me-auto mb-0 mb-lg-0 text-end">
									<li class="nav-item dropdown"><a
										class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
										role="button" data-bs-toggle="dropdown" aria-expanded="false">
											Customer Masters</a>
										<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
											<li><a class="dropdown-item" href="#"
												onclick="loadCustomerType();">Customer Type</a></li>
											<li><a class="dropdown-item" href="#"
												onclick="loadDepartment();">Department</a></li>
										</ul></li>

									<li class="nav-item dropdown"><a
										class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
										role="button" data-bs-toggle="dropdown" aria-expanded="false">
											Employee Masters</a>
										<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
											<li><a class="dropdown-item" href="#"
												onclick="loadEmpRole()">Employee Role</a></li>
											<li><a class="dropdown-item" href="#"
												onclick="loadEmpStatus();">Employee Status</a></li>
											<li><a class="dropdown-item" href="#"
												onclick="loadEmpType();">Employee Type</a></li>
										</ul></li>

									<li class="nav-item dropdown"><a
										class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
										role="button" data-bs-toggle="dropdown" aria-expanded="false">
											Project Masters</a>
										<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
											<li><a class="dropdown-item" href="#"
												onclick="loadProjectStatus()">Project Status</a></li>
											<li><a class="dropdown-item" href="#"
												onclick="loadProjectType();">Project Type</a></li>
											<li><a class="dropdown-item" href="#"
												onclick="loadEmpType();">Employee Type</a></li>
										</ul></li>

									<li class="nav-item dropdown"><a
										class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
										role="button" data-bs-toggle="dropdown" aria-expanded="false">
											Task Masters</a>
										<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
											<li><a class="dropdown-item" href="#"
												onclick="loadTaskActivity();">Task Activity</a></li>
											<li><a class="dropdown-item" href="#"
												onclick="loadTaskPriority();">Task Priority</a></li>
											<li><a class="dropdown-item" href="#"
												onclick="loadTaskStatus();">Task Status</a></li>
											<li><a class="dropdown-item" href="#"
												onclick="loadTaskType();">Task Type</a></li>
										</ul></li>

								</ul>
							</div>
						</div>

					</div>
				</nav>
				
			</div>
			<div class="col-1">
		</nav>
	
		<!--End Navbar -->
		<div class="container-fluid py-1">
			<div class="card ">
				<div class="card-body p-2 height-auto">
					<div class="table-responsive">
					<h3 class="font-weight-bolder mb-0 breadcrumb-item active">Note :-</h3>
					 Task Assignment and tracking and Read time progress update
						<div class="text-end p-2" id="createbtnid"></div>
						
						<table class="table table-flush" id="tableid">
						
							<thead id="theadid"  class="thead-light text-sm">
							</thead>
			
							<tbody id="tbodyid">
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
		 
		<!-- Delete Modal -->
		<div class="modal fade" id="deleteModal" tabindex="-1" role="dialog"
			aria-labelledby="deleteModalLabel" aria-hidden="true">
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
						record?</div>
					<div class="modal-footer">
						<button type="button" class="btn bg-gradient-secondary"
							data-bs-dismiss="modal">Close</button>
						<button type="button" class="btn bg-gradient-primary"
							data-bs-dismiss="modal" onclick="performDelete();">Delete</button>
					</div>
				</div>
			</div>
		</div>

		<!--  create new modal -->
		<div class="modal fade" id="createmodal" tabindex="-1" role="dialog"
			aria-labelledby="createModalLabel" aria-hidden="true">
			<div class="modal-dialog  modal-lg modal-dialog-centered"
				role="document">
				<div class="modal-content ">
					<!--Header-->
					<div class="modal-header ">
						<h4 class="modal-title" id="myModalLabel"></h4>
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
												<div id="modalbodyid"></div>

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

		<!--  Edit modal -->
		<div class="modal fade" id="updateModal" tabindex="-1" role="dialog"
			aria-labelledby="updateModalLabel" aria-hidden="true">
			<div class="modal-dialog  modal-lg modal-dialog-centered"
				role="document">
				<div class="modal-content ">
					<!--Header-->
					<div class="modal-header ">
						<h4 class="modal-title" id="editModalLabel"></h4>
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
												<div id="modalbodyforeditid"></div>

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

</body>
<!--   Core JS Files   -->
<script src="assets/js/core/popper.min.js"></script>
<script src="assets/js/core/bootstrap.min.js"></script>
<script src="assets/js/plugins/perfect-scrollbar.min.js"></script>
<script src="assets/js/plugins/smooth-scrollbar.min.js"></script>
<script src="assets/js/plugins/datatables.js"></script>
<script src="assets/js/plugins/choices.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>

<script
	src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>

<!-- Kanban scripts -->
<script src="assets/js/plugins/dragula/dragula.min.js"></script>
<script src="assets/js/plugins/jkanban/jkanban.js"></script>
<script src="assets/js/material-dashboard.min.js?v=3.0.6"></script>

<script type="text/javascript">
	var pkid;
	var masterTypeValue;
	var thead = document.getElementById('theadid');
	var tbody = document.getElementById('tbodyid');
	var createbutton = document.getElementById('createbtnid');
	var modalheading = document.getElementById('myModalLabel');
	var modalbody = document.getElementById('modalbodyid');
	var editModalHead = document.getElementById('editModalLabel');
	var editModalBody = document.getElementById('modalbodyforeditid');
	var company_id = '<%= session.getAttribute("companyID") %>';
	 
	$(document).ready(function() {
		loadCustomerType();
	})

	function performDelete() {
		var pk_id = pkid;

		$.ajax({
			url : 'masterDetails',
			type : 'POST',
			data : {
				actionType : 'delete',
				masterType : masterTypeValue,
				id : pk_id
			},
			success : function(resp) {
				console.log(masterTypeValue)
				if (masterTypeValue == "customertype") {
					loadCustomerType();
				} else if (masterTypeValue == "department") {
					loadDepartment();

				} else if (masterTypeValue == "employeerole") {
					loadEmpRole();

				} else if (masterTypeValue == "employeestatus") {
					loadEmpStatus();

				} else if (masterTypeValue == "employeetype") {
					loadEmpType();

				} else if (masterTypeValue == "projectgroup") {
					loadProjectGroups();

				} else if (masterTypeValue == "projectstatus") {
					loadProjectStatus();

				} else if (masterTypeValue == "projectsubgroup") {
					loadProjectSubGroups();

				} else if (masterTypeValue == "projecttype") {
					loadProjectType();

				} else if (masterTypeValue == "taskactivity") {
					loadTaskActivity();

				} else if (masterTypeValue == "taskpriority") {
					loadTaskPriority();

				} else if (masterTypeValue == "taskstatus") {
					loadTaskStatus();

				} else if (masterTypeValue == "tasktype") {
					loadTaskType();

				}
			},
			error : function(error) {
				console.log(error)
			}

		})
	}

	function createNew() {
		$.ajax({
			url : 'masterDetails',
			type : 'POST',
			data : {
				actionType : 'createnew',
				masterType : masterTypeValue,
				company_id : company_id,
				cxType : $('#cxtypeid').val(),
				department : $('#departmentid').val(),
				empRole : $('#emproleid').val(),
				empStatus : $('#empstatusid').val(),
				empType : $('#emptypeid').val(),
				projectGroup : $('#projectgroupid').val(),
				projectStatus : $('#projectstatusid').val(),
				projectSubGroup : $('#projectsubgroupid').val(),
				groupid : $('#groupIdForNewSubGroup').val(),
				projectType : $('#projecttypeid').val(),
				taskActivity : $('#taskactivityid').val(),
				taskPriority : $('#taskpriorityid').val(),
				taskStatus : $('#taskstatusid').val(),
				taskType : $('#tasktypeid').val()

			},
			success : function(data) {
				console.log(data)
				if (masterTypeValue == "customertype") {
					loadCustomerType();

				} else if (masterTypeValue == "department") {
					loadDepartment();

				} else if (masterTypeValue == "employeerole") {
					loadEmpRole();

				} else if (masterTypeValue == "employeestatus") {
					loadEmpStatus();

				} else if (masterTypeValue == "employeetype") {
					loadEmpType();

				} else if (masterTypeValue == "projectgroup") {
					loadProjectGroups();

				} else if (masterTypeValue == "projectstatus") {
					loadProjectStatus();

				} else if (masterTypeValue == "projectsubgroup") {
					loadProjectSubGroups();

				} else if (masterTypeValue == "projecttype") {
					loadProjectType();

				} else if (masterTypeValue == "taskactivity") {
					loadTaskActivity();

				} else if (masterTypeValue == "taskpriority") {
					loadTaskPriority();

				} else if (masterTypeValue == "taskstatus") {
					loadTaskStatus();

				} else if (masterTypeValue == "tasktype") {
					loadTaskType();
				}
			},
			error : function(error) {
				console.log(error)
			}
		})
	}

	function updateExisting() {
		var pk_id = pkid;
		$.ajax({
			url : 'masterDetails',
			type : 'POST',
			data : {
				actionType : 'update',
				masterType : masterTypeValue,
				id : pk_id,
				company_id : company_id,
				cxType : $('#cxtypeidforedit').val(),
				department : $('#departmentidforedit').val(),
				empRole : $('#emproleidforedit').val(),
				empStatus : $('#empstatusidforedit').val(),
				empType : $('#emptypeidforedit').val(),
				projectGroup : $('#projectgroupidforedit').val(),
				projectStatus : $('#projectstatusidforedit').val(),
				projectSubGroup : $('#projectsubgroupidforedit').val(),
				groupid : $('#groupIdForUpdate').val(),
				projectType : $('#projecttypeidforedit').val(),
				taskActivity : $('#taskactivityidforedit').val(),
				taskPriority : $('#taskpriorityidforedit').val(),
				taskStatus : $('#taskstatusidforedit').val(),
				taskType : $('#tasktypeidforedit').val()

			},
			success : function(data) {
				console.log(data)
				if (masterTypeValue == "customertype") {
					loadCustomerType();

				} else if (masterTypeValue == "department") {
					loadDepartment();

				} else if (masterTypeValue == "employeerole") {
					loadEmpRole();

				} else if (masterTypeValue == "employeestatus") {
					loadEmpStatus();

				} else if (masterTypeValue == "employeetype") {
					loadEmpType();

				} else if (masterTypeValue == "projectgroup") {
					loadProjectGroups();

				} else if (masterTypeValue == "projectstatus") {
					loadProjectStatus();

				} else if (masterTypeValue == "projectsubgroup") {
					loadProjectSubGroups();

				} else if (masterTypeValue == "projecttype") {
					loadProjectType();

				} else if (masterTypeValue == "taskactivity") {
					loadTaskActivity();

				} else if (masterTypeValue == "taskpriority") {
					loadTaskPriority();

				} else if (masterTypeValue == "taskstatus") {
					loadTaskStatus();

				} else if (masterTypeValue == "tasktype") {
					loadTaskType();
				}
			},
			error : function(error) {
				console.log(error)
			}
		})

	}

	function loadTaskType() {

		$
				.ajax({
					url : 'masterDetails',
					type : 'POST',
					data : {
						actionType : 'taskTypeList',

					},
					success : function(resp) {
						console.log(resp)

						$('#theadid').empty();
						$('#tbodyid').empty();

						masterTypeValue = "tasktype";
						modalheading.innerHTML = "New Task Type";
						editModalHead.innerHTML = "Edit Task Type";

						editModalBody.innerHTML = '<div class="row">'
								+ '<div class="col-md-4">'
								+ '	<div class="input-group input-group-static mb-4">'
								+ '<label>Task Type</label> <input id="tasktypeidforedit" type="text" class="form-control" required="required">'
								+ '	</div> '
								+ '</div>'
								+ '</div>'
								+ '<div class="row justify-content-md-end mt-4">'
								+ '<div class="col-md-auto px-1 text-end">'
								+ '<button type="button" data-bs-dismiss="modal"'
								+ '	class="btn bg-gradient-info" '
								+ 'onclick="return updateExisting();">Update Task Type</button>'
								+ '	<button type="button" '
								+ '	class="btn btn-link  ml-auto" '
								+ '	data-bs-dismiss="modal">Close</button>'
								+ '</div>'
								+ '</div>'
								

						modalbody.innerHTML = '<div class="row">'
								+ '<div class="col-md-4">'
								+ '	<div class="input-group input-group-static mb-4">'
								+ '<label>Task Type</label> <input id="tasktypeid" type="text" class="form-control" required="required" id="">'
								+ '	</div> '
								+ '</div>'
								+ '</div>'
								+ '<div class="row justify-content-md-end mt-4">'
								+ '<div class="col-md-auto px-1 text-end">'
								+ '<button type="button" data-bs-dismiss="modal"'
								+ '	class="btn bg-gradient-info" '
								+ 'onclick="return createNew();">Create Task Type</button>'
								+ '	<button type="button" '
								+ '	class="btn btn-link  ml-auto" '
								+ '	data-bs-dismiss="modal">Close</button>'
								+ '</div>'
								+ '</div>'
								

						createbutton.innerHTML = '<button type="button" data-bs-toggle="modal" id="createNewbtnId" '
										+'data-bs-target="#createmodal" '
										+'class="btn bg-gradient-dark mb-0 mt-0 mt-md-n9 mt-lg-0"> '
								+ '<i '
										+'class="material-icons text-white position-relative text-md pe-2" '
										+'id="plusSignimgId">add</i>Create New '
								+ '</button> '
						thead.innerHTML = '<tr>'
								+ '<th width="50%" style="padding-bottom:10px">Task Type</th>'
								+ '<th colspan=2 style="padding-bottom:10px">Actions</th>'
								+ '</tr>'

						for (var i = 0; i < resp.length; i++) {

							tbody.innerHTML += ' <tr class="text-sm">'
									+ '<td><input type="text" value="'+resp[i].taskType+'" id="ttype'+resp[i].tasktypeID+'" class="inputhide" disabled> </td>'
									+ '<td><a class="btn btn-link text-dark p-0 mb-0" data-bs-toggle="modal" data-bs-target="#updateModal" onclick="editById('
									+ resp[i].tasktypeID
									+ ');"><i class="material-icons text-sm me-2">edit</i></a>&nbsp&nbsp'
									+ '<a class="btn btn-link text-danger text-gradient p-0 mb-0" data-bs-toggle="modal" data-bs-target="#deleteModal" onclick="deleteByID('
									+ resp[i].tasktypeID
									+ ');"><i class="material-icons text-sm me-2">delete</i></a></td>'
									+ '</tr>'
						}

					},
					error : function(error) {
						console.log(error)
					}
				})
	}

	function loadTaskStatus() {

		$
				.ajax({
					url : 'masterDetails',
					type : 'POST',
					data : {
						actionType : 'taskStatusList',

					},
					success : function(resp) {
						console.log(resp)
						$('#theadid').empty();
						$('#tbodyid').empty();

						masterTypeValue = "taskstatus";
						modalheading.innerHTML = "New Task Status";
						editModalHead.innerHTML = "Edit Task Status";

						editModalBody.innerHTML = '<div class="row">'
								+ '<div class="col-md-4">'
								+ '	<div class="input-group input-group-static mb-4">'
								+ '<label>Task Status</label> <input id="taskstatusidforedit" type="text" class="form-control" required="required">'
								+ '	</div> '
								+ '</div>'
								+ '</div>'
								+ '<div class="row justify-content-md-end mt-4">'
								+ '<div class="col-md-auto px-1 text-end">'
								+ '<button type="button" data-bs-dismiss="modal"'
								+ '	class="btn bg-gradient-info" '
								+ 'onclick="return updateExisting();">Update Task Status</button>'
								+ '	<button type="button" '
								+ '	class="btn btn-link  ml-auto" '
								+ '	data-bs-dismiss="modal">Close</button>'
								+ '</div>'
								+ '</div>'
								

						modalbody.innerHTML = '<div class="row">'
								+ '<div class="col-md-4">'
								+ '	<div class="input-group input-group-static mb-4">'
								+ '<label>Task Status</label> <input id="taskstatusid" type="text" class="form-control" required="required">'
								+ '	</div> '
								+ '</div>'
								+ '</div>'
								+ '<div class="row justify-content-md-end mt-4">'
								+ '<div class="col-md-auto px-1 text-end">'
								+ '<button type="button" data-bs-dismiss="modal"'
								+ '	class="btn bg-gradient-info" '
								+ 'onclick="return createNew();">Create Task Status</button>'
								+ '	<button type="button" '
								+ '	class="btn btn-link  ml-auto" '
								+ '	data-bs-dismiss="modal">Close</button>'
								+ '</div>'
								+ '</div>'
								

						createbutton.innerHTML = '<button type="button" data-bs-toggle="modal" id="createNewbtnId" '
										+'data-bs-target="#createmodal" '
										+'class="btn bg-gradient-dark mb-0 mt-0 mt-md-n9 mt-lg-0"> '
								+ '<i '
										+'class="material-icons text-white position-relative text-md pe-2" '
										+'	id="plusSignimgId">add</i>Create New '
								+ '</button> '
						thead.innerHTML = '<tr>'
								+ '<th width="50%" style="padding-bottom:10px">Task Status</th>'
								+ '<th colspan=1 style="padding-bottom:10px">Actions</th>'
								 + '<th colspan=1 style="padding-bottom:10px">Description</th>'
								+ '</tr>'

						for (var i = 0; i < resp.length; i++) {

							tbody.innerHTML += ' <tr class="text-sm">'
									+ '<td><input type="text" value="'+resp[i].taskStatus+'" id="tstatus'+resp[i].taskStatusID+'" class="inputhide" disabled> </td>'
									+ '<td><a class="btn btn-link text-dark p-0 mb-0" data-bs-toggle="modal" data-bs-target="#updateModal" onclick="editById('
									+ resp[i].taskStatusID
									+ ');"><i class="material-icons text-sm me-2">edit</i></a>&nbsp&nbsp'
									+ '<a class="btn btn-link text-danger text-gradient p-0 mb-0" data-bs-toggle="modal" data-bs-target="#deleteModal" onclick="deleteByID('
									+ resp[i].taskStatusID
									+ ');"><i class="material-icons text-sm me-2">delete</i></a></td>'
									+ '<td><input type="text" value="'+resp[i].taskRoleDesc+'" id="erole'+resp[i].taskRoleDesc+'" class="inputhide" disabled> </td>'	

									+ '</tr>'
						}

					},
					error : function(error) {
						console.log(error)
					}
				})
	}

	function loadTaskPriority() {

		$
				.ajax({
					url : 'masterDetails',
					type : 'POST',
					data : {
						actionType : 'taskPriorityList',

					},
					success : function(resp) {
						console.log(resp)
						$('#theadid').empty();
						$('#tbodyid').empty();

						masterTypeValue = "taskpriority";
						modalheading.innerHTML = "New Task Priority";
						editModalHead.innerHTML = "Edit Task Priority";

						editModalBody.innerHTML = '<div class="row">'
								+ '<div class="col-md-4">'
								+ '	<div class="input-group input-group-static mb-4">'
								+ '<label>Task Priority</label> <input id="taskpriorityidforedit" type="text" class="form-control" required="required">'
								+ '	</div> '
								+ '</div>'
								+ '</div>'
								+ '<div class="row justify-content-md-end mt-4">'
								+ '<div class="col-md-auto px-1 text-end">'
								+ '<button type="button" data-bs-dismiss="modal"'
								+ '	class="btn bg-gradient-info" '
								+ 'onclick="return updateExisting();">Update Task Priority</button>'
								+ '	<button type="button" '
								+ '	class="btn btn-link  ml-auto" '
								+ '	data-bs-dismiss="modal">Close</button>'
								+ '</div>'
								+ '</div>'
								

						modalbody.innerHTML = '<div class="row">'
								+ '<div class="col-md-4">'
								+ '	<div class="input-group input-group-static mb-4">'
								+ '<label>Task Priority</label> <input id="taskpriorityid" type="text" class="form-control" required="required">'
								+ '	</div> '
								+ '</div>'
								+ '</div>'
								+ '<div class="row justify-content-md-end mt-4">'
								+ '<div class="col-md-auto px-1 text-end">'
								+ '<button type="button" data-bs-dismiss="modal"'
								+ '	class="btn bg-gradient-info" '
								+ 'onclick="return createNew();">Create Task Priority</button>'
								+ '	<button type="button" '
								+ '	class="btn btn-link  ml-auto" '
							 	+ '	data-bs-dismiss="modal">Close</button>'
								+ '</div>'
								+ '</div>'
							

						createbutton.innerHTML = '<button type="button" data-bs-toggle="modal" id="createNewbtnId" '
										+'data-bs-target="#createmodal" '
										+'class="btn bg-gradient-dark mb-0 mt-0 mt-md-n9 mt-lg-0"> '
								+ '<i '
										+'class="material-icons text-white position-relative text-md pe-2" '
										+'	id="plusSignimgId">add</i>Create New '
								+ '</button> '
						thead.innerHTML = '<tr>'
								+ '<th width="50%" style="padding-bottom:10px">Task Priority</th>'
								+ '<th colspan=2 style="padding-bottom:10px">Actions</th>'
								+ '</tr>'

						for (var i = 0; i < resp.length; i++) {

							tbody.innerHTML += ' <tr class="text-sm">'
									+ '<td><input type="text" value="'+resp[i].taskPriority+'" id="tpriority'+resp[i].taskPriorityId+'" class="inputhide" disabled> </td>'
									+ '<td><a class="btn btn-link text-dark p-0 mb-0" data-bs-toggle="modal" data-bs-target="#updateModal" onclick="editById('
									+ resp[i].taskPriorityId
									+ ');"><i class="material-icons text-sm me-2">edit</i></a>&nbsp&nbsp'
									+ '<a class="btn btn-link text-danger text-gradient p-0 mb-0" data-bs-toggle="modal" data-bs-target="#deleteModal" onclick="deleteByID('
									+ resp[i].taskPriorityId
									+ ');"><i class="material-icons text-sm me-2">delete</i></a></td>'
									+ '</tr>'
						}

					},
					error : function(error) {
						console.log(error)
					}
				})
	}

	function loadTaskActivity() {

		$
				.ajax({
					url : 'masterDetails',
					type : 'POST',
					data : {
						actionType : 'taskActivityList',

					},
					success : function(resp) {
						console.log(resp)
						$('#theadid').empty();
						$('#tbodyid').empty();

						masterTypeValue = "taskactivity";
						modalheading.innerHTML = "New Task Activity";
						editModalHead.innerHTML = "Edit Task Activity";

						editModalBody.innerHTML = '<div class="row">'
								+ '<div class="col-md-4">'
								+ '	<div class="input-group input-group-static mb-4">'
								+ '<label>Task Activity</label> <input id="taskactivityidforedit" type="text" class="form-control" required="required">'
								+ '	</div> '
								+ '</div>'
								+ '</div>'
								+ '<div class="row justify-content-md-end mt-4">'
								+ '<div class="col-md-auto px-1 text-end">'
								+ '<button type="button" data-bs-dismiss="modal"'
								+ '	class="btn bg-gradient-info" '
								+ 'onclick="return updateExisting();">Update Task Activity</button>'
								+ '	<button type="button" '
								+ '	class="btn btn-link  ml-auto" '
								+ '	data-bs-dismiss="modal">Close</button>'
								+ '</div>'
								+ '</div>'
						

						modalbody.innerHTML = '<div class="row">'
								+ '<div class="col-md-4">'
								+ '	<div class="input-group input-group-static mb-4">'
								+ '<label>Task Activity</label> <input id="taskactivityid" type="text" class="form-control" required="required">'
								+ '	</div> '
								+ '</div>'
								+ '</div>'
								+ '<div class="row justify-content-md-end mt-4">'
								+ '<div class="col-md-auto px-1 text-end">'
								+ '<button type="button" data-bs-dismiss="modal"'
								+ '	class="btn bg-gradient-info" '
								+ 'onclick="return createNew();">Create Task Activity</button>'
								+ '	<button type="button" '
								+ '	class="btn btn-link  ml-auto" '
								+ '	data-bs-dismiss="modal">Close</button>'
								+ '</div>'
								+ '</div>'
								

						createbutton.innerHTML = '<button type="button" data-bs-toggle="modal" id="createNewbtnId" '
										+'data-bs-target="#createmodal" '
										+'class="btn bg-gradient-dark mb-0 mt-0 mt-md-n9 mt-lg-0"> '
								+ '<i '
										+'class="material-icons text-white position-relative text-md pe-2" '
										+'	id="plusSignimgId">add</i>Create New '
								+ '</button> '
						thead.innerHTML = '<tr>'
								+ '<th width="50%" style="padding-bottom:10px">Task Activity</th>'
								+ '<th colspan=2 style="padding-bottom:10px">Actions</th>'
								+ '</tr>'

						for (var i = 0; i < resp.length; i++) {

							tbody.innerHTML += ' <tr class="text-sm">'
									+ '<td><input type="text" value="'+resp[i].taskActivity+'" id="tactivity'+resp[i].taskActivityId+'" class="inputhide" disabled> </td>'
									+ '<td><a class="btn btn-link text-dark p-0 mb-0" data-bs-toggle="modal" data-bs-target="#updateModal" onclick="editById('
									+ resp[i].taskActivityId
									+ ');"><i class="material-icons text-sm me-2">edit</i></a>&nbsp&nbsp'
									+ '<a class="btn btn-link text-danger text-gradient p-0 mb-0" data-bs-toggle="modal" data-bs-target="#deleteModal" onclick="deleteByID('
									+ resp[i].taskActivityId
									+ ');"><i class="material-icons text-sm me-2">delete</i></a></td>'
									+ '</tr>'
						}

					},
					error : function(error) {
						console.log(error)
					}
				})
	}

	function loadProjectType() {

		$
				.ajax({
					url : 'masterDetails',
					type : 'POST',
					data : {
						actionType : 'projectType',

					},
					success : function(resp) {
						console.log(resp)
						$('#theadid').empty();
						$('#tbodyid').empty();

						masterTypeValue = "projecttype";
						modalheading.innerHTML = "New Project Type";
						editModalHead.innerHTML = "Edit Project Type";

						editModalBody.innerHTML = '<div class="row">'
								+ '<div class="col-md-4">'
								+ '	<div class="input-group input-group-static mb-4">'
								+ '<label>Project Type</label> <input id="projecttypeidforedit" type="text" class="form-control" required="required">'
								+ '	</div> '
								+ '</div>'
								+ '</div>'
								+ '<div class="row justify-content-md-end mt-4">'
								+ '<div class="col-md-auto px-1 text-end">'
								+ '<button type="button" data-bs-dismiss="modal"'
								+ '	class="btn bg-gradient-info" '
								+ 'onclick="return updateExisting();">Update Project Type</button>'
								+ '	<button type="button" '
								+'	class="btn btn-link  ml-auto" '
								+'	data-bs-dismiss="modal">Close</button>'
								+ '</div>'
								+ '</div>'
								

						modalbody.innerHTML = '<div class="row">'
								+ '<div class="col-md-4">'
								+ '	<div class="input-group input-group-static mb-4">'
								+ '<label>Project Type</label> <input id="projecttypeid" type="text" class="form-control" required="required">'
								+ '	</div> '
								+ '</div>'
								+ '</div>'
								+ '<div class="row justify-content-md-end mt-4">'
								+ '<div class="col-md-auto px-1 text-end">'
								+ '<button type="button" data-bs-dismiss="modal"'
								+ '	class="btn bg-gradient-info" '
								+ 'onclick="return createNew();">Create Project Type</button>'
								+ '	<button type="button" '
								+ '	class="btn btn-link  ml-auto" '
								+ '	data-bs-dismiss="modal">Close</button>'
								+ '</div>'
								+ '</div>'
								

						createbutton.innerHTML = '<button type="button" data-bs-toggle="modal" id="createNewbtnId" '
										+'data-bs-target="#createmodal" '
										+'class="btn bg-gradient-dark mb-0 mt-0 mt-md-n9 mt-lg-0"> '
								+ '<i '
										+'class="material-icons text-white position-relative text-md pe-2" '
										+'	id="plusSignimgId">add</i>Create New '
								+ '</button> '
						thead.innerHTML = '<tr>'
								+ '<th width="50%" style="padding-bottom:10px">Project Type</th>'
								+ '<th colspan=2 style="padding-bottom:10px">Actions</th>'
								+ '</tr>'

						for (var i = 0; i < resp.length; i++) {

							tbody.innerHTML += ' <tr class="text-sm">'
									+ '<td><input type="text" value="'+resp[i].project_type+'" id="ptype'+resp[i].project_type_id+'" class="inputhide" disabled> </td>'
									+ '<td><a class="btn btn-link text-dark p-0 mb-0" data-bs-toggle="modal" data-bs-target="#updateModal" onclick="editById('
									+ resp[i].project_type_id
									+ ');"><i class="material-icons text-sm me-2">edit</i></a>&nbsp&nbsp'
									+ '<a class="btn btn-link text-danger text-gradient p-0 mb-0" data-bs-toggle="modal" data-bs-target="#deleteModal" onclick="deleteByID('
									+ resp[i].project_type_id
									+ ');"><i class="material-icons text-sm me-2">delete</i></a></td>'
									+ '</tr>'

						}

					},
					error : function(error) {
						console.log(error)
					}
				})
	}

	function loadProjectSubGroups() {
		$
				.ajax({
					url : 'masterDetails',
					type : 'POST',
					data : {
						actionType : 'projectSubGroupList',

					},
					success : function(resp) {
						console.log(resp)
						$('#theadid').empty();
						$('#tbodyid').empty();

						masterTypeValue = "projectsubgroup";
						modalheading.innerHTML = "New Project Sub Group";
						editModalHead.innerHTML = "Edit Project Sub Group";

						editModalBody.innerHTML = '<div class="row">'
								+ '<div class="col-md-4">'
								+ '	<div class="input-group input-group-static mb-4">'
								+ '<label>Project Group</label> <select class="form-control" '
							+ 'id="groupIdForUpdate" name="project_group" '
							+ 'required="required">'
								+ '<option id="xyz" value="">Select Project Group</option>'
								+ '</select>'
								+ '	</div> '
								+ '</div>'
								+ '<div class="col-md-4">'
								+ '<div class="input-group input-group-static mb-4">'
								+ '<label>Project Sub Group</label> <input id="projectsubgroupidforedit" type="text" class="form-control" required="required">'
								+ '	</div> '
								+ '</div>'
								+ '</div>'
								+ '<div class="row justify-content-md-end mt-4">'
								+ '<div class="col-md-auto px-1 text-end">'
								+ '<button type="button" data-bs-dismiss="modal"'
								+ '	class="btn bg-gradient-info" '
								+ 'onclick="return updateExisting();">Update Project Sub Group</button>'
								+ '	<button type="button" '
								+ '	<button type="button" '
								+'	class="btn btn-link  ml-auto" '
								+'	data-bs-dismiss="modal">Close</button>'
								+ '</div>'
								+ '</div>'
								

						modalbody.innerHTML = '<div class="row">'
								+ '<div class="col-md-4">'
								+ '	<div class="input-group input-group-static mb-4">'
								+ '<label>Project Group</label> <select class="form-control" '
							+ 'id="groupIdForNewSubGroup" name="project_group" '
							+ 'required="required">'
								+ '<option value="">Select Project Group</option>'
								+ '</select>'
								+ '	</div> '
								+ '</div>'
								+ '<div class="col-md-4">'
								+ '<div class="input-group input-group-static mb-4">'
								+ '<label>Project Sub-Group</label> <input id="projectsubgroupid" type="text" class="form-control" required="required">'
								+ '</div>'
								+ '</div>'
								+ '</div>'
								+ '<div class="row justify-content-md-end mt-4">'
								+ '<div class="col-md-auto px-1 text-end">'
								+ '<button type="button" data-bs-dismiss="modal" '
								+ '	class="btn bg-gradient-info" '
								+ 'onclick="return createNew();">Create Project Sub-Group</button>'
								+ '	<button type="button" '
								+ '	class="btn btn-link  ml-auto" '
								+ '	data-bs-dismiss="modal">Close</button>'
								+ '</div>'
								+ '</div>'
						

						createbutton.innerHTML = '<button type="button" data-bs-toggle="modal" id="createNewbtnId" '
										+'data-bs-target="#createmodal" '
										+'class="btn bg-gradient-dark mb-0 mt-0 mt-md-n9 mt-lg-0"> '
								+ '<i '
										+'class="material-icons text-white position-relative text-md pe-2" '
										+'	id="plusSignimgId">add</i>Create New '
								+ '</button> '
						thead.innerHTML = '<tr>'
								+ '<th width="50%" style="padding-bottom:10px">Project Sub Group</th>'
								+ '<th colspan=2 style="padding-bottom:10px">Actions</th>'
								+ '</tr>'

						for (var i = 0; i < resp.length; i++) {

							tbody.innerHTML += ' <tr class="text-sm">'
									+ '<td><input type="text" value="'+resp[i].project_sub_group+'" id="psubgroup'+resp[i].project_sub_group_id+'" class="inputhide" disabled> </td>'
									+ '<td><a class="btn btn-link text-dark p-0 mb-0" data-bs-toggle="modal" data-bs-target="#updateModal" onclick="editById('
									+ resp[i].project_sub_group_id
									+ ');"><i class="material-icons text-sm me-2">edit</i></a>&nbsp&nbsp'
									+ '<a class="btn btn-link text-danger text-gradient p-0 mb-0" data-bs-toggle="modal" data-bs-target="#deleteModal" onclick="deleteByID('
									+ resp[i].project_sub_group_id
									+ ');"><i class="material-icons text-sm me-2">delete</i></a></td>'
									+ '</tr>'
						}
						getProjectGroup();

					},
					error : function(error) {
						console.log(error)
					}
				})
	}

	function getProjectGroup() {
		$
				.ajax({
					url : "masterDetails",
					type : "POST",
					data : {
						actionType : "projectGroupID",
						company_id : company_id
					},
					success : function(resp) {
						console.log("data for group ", resp);
						if (resp != null) {
							for (let i = 0; i < resp.length; i++) {
								console.log("group name ",
										resp[i].project_group_name);

								var htmlData = '<option value="' + resp[i].project_group_id + '">'
										+ resp[i].project_group_name
										+ '</option>'

								$('#groupIdForNewSubGroup').append(htmlData);
								$('#groupIdForUpdate').append(htmlData);

							}
						}

					},
					error : function(error) {
						alert(error);
					}
				});
	}

	function loadProjectStatus() {

		$
				.ajax({
					url : 'masterDetails',
					type : 'POST',
					data : {
						actionType : 'projectStatusList',

					},
					success : function(resp) {
						console.log(resp)
						$('#theadid').empty();
						$('#tbodyid').empty();

						masterTypeValue = "projectstatus";
						modalheading.innerHTML = "New Project Status";
						editModalHead.innerHTML = "Edit Project Status";

						editModalBody.innerHTML = '<div class="row">'
								+ '<div class="col-md-4">'
								+ '	<div class="input-group input-group-static mb-4">'
								+ '<label>Project Status</label> <input id="projectstatusidforedit" type="text" class="form-control" required="required">'
								+ '	</div> '
								+ '</div>'
								+ '</div>'
								+ '<div class="row justify-content-md-end mt-4">'
								+ '<div class="col-md-auto px-1 text-end">'
								+ '<button type="button" data-bs-dismiss="modal"'
								+ '	class="btn bg-gradient-info" '
								+ 'onclick="return updateExisting();">Update Project Status</button>'
								+ '	<button type="button" '
								+ '	class="btn btn-link  ml-auto" '
								+ '	data-bs-dismiss="modal">Close</button>'
								+ '</div>'
								+ '</div>'
						

						modalbody.innerHTML = '<div class="row">'
								+ '<div class="col-md-4">'
								+ '	<div class="input-group input-group-static mb-4">'
								+ '<label>Project Status</label> <input id="projectstatusid" type="text" class="form-control" required="required">'
								+ '	</div> '
								+ '</div>'
								+ '</div>'
								+ '<div class="row justify-content-md-end mt-4">'
								+ '<div class="col-md-auto px-1 text-end">'
								+ '<button type="button" data-bs-dismiss="modal"'
								+ '	class="btn bg-gradient-info" '
								+ 'onclick="return createNew();">Create Project Status</button>'
								+ '	<button type="button" '
								+ '	class="btn btn-link  ml-auto" '
								+ '	data-bs-dismiss="modal">Close</button>'
								+ '</div>'
								+ '</div>'
							

						createbutton.innerHTML = '<button type="button" data-bs-toggle="modal" id="createNewbtnId" '
										+'data-bs-target="#createmodal" '
										+'class="btn bg-gradient-dark mb-0 mt-0 mt-md-n9 mt-lg-0"> '
								+ '<i '
										+'class="material-icons text-white position-relative text-md pe-2" '
										+'	id="plusSignimgId">add</i>Create New '
								+ '</button> '
						thead.innerHTML = '<tr>'
								+ '<th width="50%" style="padding-bottom:10px">Project Status</th>'
								+ '<th colspan=1 style="padding-bottom:10px">Actions</th>'
								 + '<th colspan=1 style="padding-bottom:10px">Description</th>'
								+ '</tr>'

						for (var i = 0; i < resp.length; i++) {

							tbody.innerHTML += ' <tr class="text-sm">'
									+ '<td><input type="text" value="'+resp[i].project_status+'" id="pgstatus'+resp[i].project_status_id+'" class="inputhide" disabled> </td>'
									+ '<td><a class="btn btn-link text-dark p-0 mb-0" data-bs-toggle="modal" data-bs-target="#updateModal" onclick="editById('
									+ resp[i].project_status_id
									+ ');"><i class="material-icons text-sm me-2">edit</i></a>&nbsp&nbsp'
									+ '<a class="btn btn-link text-danger text-gradient p-0 mb-0" data-bs-toggle="modal" data-bs-target="#deleteModal" onclick="deleteByID('
									+ resp[i].project_status_id
									+ ');"><i class="material-icons text-sm me-2">delete</i></a></td>'
									+ '<td><input type="text" value="'+resp[i].project_role_desc+'" id="erole'+resp[i].project_role_desc+'" class="inputhide" disabled> </td>'
									+ '</tr>'
						}

					},
					error : function(error) {
						console.log(error)
					}
				})
	}

	function loadProjectGroups() {

		$
				.ajax({
					url : 'masterDetails',
					type : 'POST',
					data : {
						actionType : 'projectGroupList',

					},
					success : function(resp) {
						console.log(resp)
						$('#theadid').empty();
						$('#tbodyid').empty();

						masterTypeValue = "projectgroup";
						modalheading.innerHTML = "New Project Group";
						editModalHead.innerHTML = "Edit Project Group";

						editModalBody.innerHTML = '<div class="row">'
								+ '<div class="col-md-4">'
								+ '	<div class="input-group input-group-static mb-4">'
								+ '<label>Project Group</label> <input id="projectgroupidforedit" type="text" class="form-control" required="required">'
								+ '	</div> '
								+ '</div>'
								+ '</div>'
								+ '<div class="row justify-content-md-end mt-4">'
								+ '<div class="col-md-auto px-1 text-end">'
								+ '<button type="button" data-bs-dismiss="modal"'
								+ '	class="btn bg-gradient-info" '
								+ 'onclick="return updateExisting();">Update Project Group</button>'
								+ '	<button type="button" '
								+ '	class="btn btn-link  ml-auto" '
								+ '	data-bs-dismiss="modal">Close</button>'
								+ '</div>'
								+ '</div>'


						modalbody.innerHTML = '<div class="row">'
								+ '<div class="col-md-4">'
								+ '	<div class="input-group input-group-static mb-4">'
								+ '<label>Project Group</label> <input id="projectgroupid" type="text" class="form-control" required="required">'
								+ '	</div> '
								+ '</div>'
								+ '</div>'
								+ '<div class="row justify-content-md-end mt-4">'
								+ '<div class="col-md-auto px-1 text-end">'
								+ '<button type="button" data-bs-dismiss="modal"'
								+ '	class="btn bg-gradient-info" '
								+ 'onclick="return createNew();">Create Project Group</button>'
								+ '	<button type="button" '
								+ '	class="btn btn-link  ml-auto" '
								+ '	data-bs-dismiss="modal">Close</button>'
								+ '</div>'
								+ '</div>'
						

						createbutton.innerHTML = '<button type="button" data-bs-toggle="modal" id="createNewbtnId" '
										+'data-bs-target="#createmodal" '
										+'class="btn bg-gradient-dark mb-0 mt-0 mt-md-n9 mt-lg-0"> '
								+ '<i '
										+'class="material-icons text-white position-relative text-md pe-2" '
										+'	id="plusSignimgId">add</i>Create New '
								+ '</button> '
						thead.innerHTML = '<tr>'
								+ '<th width="50%" style="padding-bottom:10px">Project Group</th>'
								+ '<th colspan=2 style="padding-bottom:10px">Actions</th>'
								+ '</tr>'

						for (var i = 0; i < resp.length; i++) {

							tbody.innerHTML += ' <tr class="text-sm">'
									+ '<td><input type="text" value="'+resp[i].project_group_name+'" id="pgroup'+resp[i].project_group_id+'" class="inputhide" disabled> </td>'
									+ '<td><a class="btn btn-link text-dark p-0 mb-0" data-bs-toggle="modal" data-bs-target="#updateModal" onclick="editById('
									+ resp[i].project_group_id
									+ ');"><i class="material-icons text-sm me-2">edit</i></a>&nbsp&nbsp'
									+ '<a class="btn btn-link text-danger text-gradient p-0 mb-0" data-bs-toggle="modal" data-bs-target="#deleteModal" onclick="deleteByID('
									+ resp[i].project_group_id
									+ ');"><i class="material-icons text-sm me-2">delete</i></a></td>'
									+ '</tr>'
						}

					},
					error : function(error) {
						console.log(error)
					}
				})
	}

	function loadEmpType() {

		$
				.ajax({
					url : 'masterDetails',
					type : 'POST',
					data : {
						actionType : 'getEmployeeTypeList',

					},
					success : function(resp) {
						console.log(resp)
						$('#theadid').empty();
						$('#tbodyid').empty();

						masterTypeValue = "employeetype";
						modalheading.innerHTML = "New Employee Type";
						editModalHead.innerHTML = "Edit Employee Type";

						editModalBody.innerHTML = '<div class="row">'
								+ '<div class="col-md-4">'
								+ '	<div class="input-group input-group-static mb-4">'
								+ '<label>Employee Type</label> <input id="emptypeidforedit" type="text" class="form-control" required="required">'
								+ '	</div> '
								+ '</div>'
								+ '</div>'
								+ '<div class="row justify-content-md-end mt-4">'
								+ '<div class="col-md-auto px-1 text-end">'
								+ '<button type="button" data-bs-dismiss="modal"'
								+ '	class="btn bg-gradient-info" '
								+ 'onclick="return updateExisting();">Update Employee Type</button>'
								+ '	<button type="button" '
								+ '	class="btn btn-link  ml-auto" '
								+ '	data-bs-dismiss="modal">Close</button>'
								+ '</div>'
								+ '</div>'
						

						modalbody.innerHTML = '<div class="row">'
								+ '<div class="col-md-4">'
								+ '	<div class="input-group input-group-static mb-4">'
								+ '<label>Employee Type</label> <input id="emptypeid" type="text" class="form-control" required="required">'
								+ '	</div> '
								+ '</div>'
								+ '</div>'
								+ '<div class="row justify-content-md-end mt-4">'
								+ '<div class="col-md-auto px-1 text-end">'
								+ '<button type="button" data-bs-dismiss="modal"'
								+ '	class="btn bg-gradient-info" '
								+ 'onclick="return createNew();">Create Employee Type</button>'
								+ '	<button type="button" '
								+ '	class="btn btn-link  ml-auto" '
								+ '	data-bs-dismiss="modal">Close</button>'
								+ '</div>'
								+ '</div>'
						

						createbutton.innerHTML = '<button type="button" data-bs-toggle="modal" id="createNewbtnId" '
										+'data-bs-target="#createmodal" '
										+'class="btn bg-gradient-dark mb-0 mt-0 mt-md-n9 mt-lg-0"> '
								+ '<i '
										+'class="material-icons text-white position-relative text-md pe-2" '
										+'	id="plusSignimgId">add</i>Create New '
								+ '</button> '
						thead.innerHTML = '<tr>'
								+ '<th width="50%" style="padding-bottom:10px">Employee Type</th>'
								+ '<th colspan=2 style="padding-bottom:10px">Actions</th>'
								+ '</tr>'

						for (var i = 0; i < resp.length; i++) {

							tbody.innerHTML += ' <tr class="text-sm">'
									+ '<td><input type="text" value="'+resp[i].employee_type_name+'" id="etype'+resp[i].employee_type_id+'" class="inputhide" disabled> </td>'
									+ '<td><a class="btn btn-link text-dark p-0 mb-0" data-bs-toggle="modal" data-bs-target="#updateModal" onclick="editById('
									+ resp[i].employee_type_id
									+ ');"><i class="material-icons text-sm me-2">edit</i></a>&nbsp&nbsp'
									+ '<a class="btn btn-link text-danger text-gradient p-0 mb-0" data-bs-toggle="modal" data-bs-target="#deleteModal" onclick="deleteByID('
									+ resp[i].employee_type_id
									+ ');"><i class="material-icons text-sm me-2">delete</i></a></td>'
									+ '</tr>'
						}

					},
					error : function(error) {
						console.log(error)
					}
				})
	}

	function loadEmpStatus() {

		$
				.ajax({
					url : 'masterDetails',
					type : 'POST',
					data : {
						actionType : 'getEmployeeStatusList',

					},
					success : function(resp) {
						console.log(resp)
						$('#theadid').empty();
						$('#tbodyid').empty();

						masterTypeValue = "employeestatus";
						modalheading.innerHTML = "New Employee Status";
						editModalHead.innerHTML = "Edit Employee Status";

						editModalBody.innerHTML = '<div class="row">'
								+ '<div class="col-md-4">'
								+ '	<div class="input-group input-group-static mb-4">'
								+ '<label>Employee Status</label> <input id="empstatusidforedit" type="text" class="form-control" required="required">'
								+ '	</div> '
								+ '</div>'
								+ '</div>'
								+ '<div class="row justify-content-md-end mt-4">'
								+ '<div class="col-md-auto px-1 text-end">'
								+ '<button type="button" data-bs-dismiss="modal"'
								+ '	class="btn bg-gradient-info" '
								+ 'onclick="return updateExisting();">Update Employee Status</button>'
								+ '	<button type="button" '
								+ '	class="btn btn-link  ml-auto" '
								+ '	data-bs-dismiss="modal">Close</button>'
								+ '</div>'
								+ '</div>'
						

						modalbody.innerHTML = '<div class="row">'
								+ '<div class="col-md-4">'
								+ '	<div class="input-group input-group-static mb-4">'
								+ '<label>Employee Status</label> <input id="empstatusid" type="text" class="form-control" required="required">'
								+ '	</div> '
								+ '</div>'
								+ '</div>'
								+ '<div class="row justify-content-md-end mt-4">'
								+ '<div class="col-md-auto px-1 text-end">'
								+ '<button type="button" data-bs-dismiss="modal"'
								+ '	class="btn bg-gradient-info" '
								+ 'onclick="return createNew();">Create Employee Status</button>'
								+ '	<button type="button" '
								+ '	class="btn btn-link  ml-auto" '
								+ '	data-bs-dismiss="modal">Close</button>'
								+ '</div>'
								+ '</div>'
							

						createbutton.innerHTML = '<button type="button" data-bs-toggle="modal" id="createNewbtnId" '
										+'data-bs-target="#createmodal" '
										+'class="btn bg-gradient-dark mb-0 mt-0 mt-md-n9 mt-lg-0"> '
								+ '<i '
										+'class="material-icons text-white position-relative text-md pe-2" '
										+'	id="plusSignimgId">add</i>Create New '
								+ '</button> '
						thead.innerHTML = '<tr>'
								+ '<th width="50%" style="padding-bottom:10px">Employee Status</th>'
								+ '<th colspan=1 style="padding-bottom:10px">Actions</th>'
								 + '<th colspan=1 style="padding-bottom:10px">Description</th>'
								+ '</tr>'

						for (var i = 0; i < resp.length; i++) {

							tbody.innerHTML += ' <tr class="text-sm">'
									+ '<td><input type="text" value="'+resp[i].employee_status_name+'" id="estatus'+resp[i].employee_status_id+'" class="inputhide" disabled> </td>'
									+ '<td><a class="btn btn-link text-dark p-0 mb-0" data-bs-toggle="modal" data-bs-target="#updateModal" onclick="editById('
									+ resp[i].employee_status_id
									+ ');"><i class="material-icons text-sm me-2">edit</i></a>&nbsp&nbsp'
									+ '<a class="btn btn-link text-danger text-gradient p-0 mb-0" data-bs-toggle="modal" data-bs-target="#deleteModal" onclick="deleteByID('
									+ resp[i].employee_status_id
									+ ');"><i class="material-icons text-sm me-2">delete</i></a></td>'
									+ '<td><input type="text" value="'+resp[i].employe_role_desc+'" id="erole'+resp[i].employe_role_desc+'" class="inputhide" disabled> </td>'	

									+ '</tr>'
						}

					},
					error : function(error) {
						console.log(error)
					}
				})
	}

	function loadEmpRole() {

		$
				.ajax({
					url : 'masterDetails',
					type : 'POST',
					data : {
						actionType : 'employeeRoleList',

					},
					success : function(resp) {
						console.log(resp)
						$('#theadid').empty();
						$('#tbodyid').empty();

						masterTypeValue = "employeerole";
						modalheading.innerHTML = "New Employee Role";
						editModalHead.innerHTML = "Edit Employee Role";

						editModalBody.innerHTML = '<div class="row">'
								+ '<div class="col-md-4">'
								+ '	<div class="input-group input-group-static mb-4">'
								+ '<label>Employee Role</label> <input id="emproleidforedit" type="text" class="form-control" required="required">'
								+ '	</div> '
								+ '</div>'
								+ '</div>'
								+ '<div class="row justify-content-md-end mt-4">'
								+ '<div class="col-md-auto px-1 text-end">'
								+ '<button type="button" data-bs-dismiss="modal"'
								+ '	class="btn bg-gradient-info" '
								+ 'onclick="return updateExisting();">Update Employee Role</button>'
								+ '	<button type="button" '
								+ '	class="btn btn-link  ml-auto" '
								+ '	data-bs-dismiss="modal">Close</button>'
								+ '</div>'
								+ '</div>'
							

						modalbody.innerHTML = '<div class="row">'
								+ '<div class="col-md-4">'
								+ '	<div class="input-group input-group-static mb-4">'
								+ '<label>Employee Role</label> <input id="emproleid" type="text" class="form-control" required="required">'
								+ '	</div> '
								+ '</div>'
								+ '</div>'
								+ '<div class="row justify-content-md-end mt-4">'
								+ '<div class="col-md-auto px-1 text-end">'
								+ '<button type="button" data-bs-dismiss="modal"'
								+ '	class="btn bg-gradient-info" '
								+ 'onclick="return createNew();">Create Employee Role</button>'
								+ '	<button type="button" '
								+ '	class="btn btn-link  ml-auto" '
								+ '	data-bs-dismiss="modal">Close</button>'
								+ '</div>'
								+ '</div>'
						

						createbutton.innerHTML = '<button type="button" data-bs-toggle="modal" id="createNewbtnId" '
										+'data-bs-target="#createmodal" '
										+'class="btn bg-gradient-dark mb-0 mt-0 mt-md-n9 mt-lg-0"> '
								+ '<i '
										+'class="material-icons text-white position-relative text-md pe-2" '
										+'	id="plusSignimgId">add</i>Create New '
								+ '</button> '
								
						
						thead.innerHTML = '<tr>'
								+ '<th width="50%" style="padding-bottom:10px">Employee Role</th>'
								+ '<th colspan=1 style="padding-bottom:10px">Actions</th>'
								 + '<th colspan=1 style="padding-bottom:10px">Description</th>'
								+ '</tr>'

						for (var i = 0; i < resp.length; i++) {

							tbody.innerHTML += ' <tr class="text-sm">'
									+ '<td><input type="text" value="'+resp[i].employe_role_name+'" id="erole'+resp[i].employee_role_id+'" class="inputhide" disabled> </td>'
									+ '<td><a class="btn btn-link text-dark p-0 mb-0" data-bs-toggle="modal" data-bs-target="#updateModal" onclick="editById('
									+ resp[i].employee_role_id
									+ ');"><i class="material-icons text-sm me-2">edit</i></a>&nbsp&nbsp'
									+ '<a class="btn btn-link text-danger text-gradient p-0 mb-0" data-bs-toggle="modal" data-bs-target="#deleteModal" onclick="deleteByID('
									+ resp[i].employee_role_id
									+ ');"><i class="material-icons text-sm me-2">delete</i></a></td>'
									+ '<td><input type="text" value="'+resp[i].employe_role_desc+'" id="erole'+resp[i].employe_role_desc+'" class="inputhide" disabled> </td>'	

									+ '</tr>'
						}

					},
					error : function(error) {
						console.log(error)
					}
				})
	}

	function loadDepartment() {

		$
				.ajax({
					url : 'masterDetails',
					type : 'POST',
					data : {
						actionType : 'departmentList',

					},
					success : function(resp) {
						console.log(resp)
						$('#theadid').empty();
						$('#tbodyid').empty();

						masterTypeValue = "department";
						modalheading.innerHTML = "New Department";
						editModalHead.innerHTML = "Edit Department";

						editModalBody.innerHTML = '<div class="row">'
								+ '<div class="col-md-4">'
								+ '	<div class="input-group input-group-static mb-4">'
								+ '<label>Department Name</label> <input id="departmentidforedit" type="text" class="form-control" required="required">'
								+ '	</div> '
								+ '</div>'
								+ '</div>'
								+ '<div class="row justify-content-md-end mt-4">'
								+ '<div class="col-md-auto px-1 text-end">'
								+ '<button type="button" data-bs-dismiss="modal"'
								+ '	class="btn bg-gradient-info" '
								+ 'onclick="return updateExisting();">Update Department</button>'
								+ '	<button type="button" '
								+ '	class="btn btn-link  ml-auto" '
								+ '	data-bs-dismiss="modal">Close</button>'
								+ '</div>'
								+ '</div>'
						

						modalbody.innerHTML = '<div class="row">'
								+ '<div class="col-md-4">'
								+ '	<div class="input-group input-group-static mb-4">'
								+ '<label>Department Name</label> <input id="departmentid" type="text" class="form-control" required="required">'
								+ '	</div> '
								+ '</div>'
								+ '</div>'
								+ '<div class="row justify-content-md-end mt-4">'
								+ '<div class="col-md-auto px-1 text-end">'
								+ '<button type="button" data-bs-dismiss="modal"'
								+ '	class="btn bg-gradient-info" '
								+ 'onclick="return createNew();">Create Department</button>'
								+ '	<button type="button" '
								+ '	class="btn btn-link  ml-auto" '
								+ '	data-bs-dismiss="modal">Close</button>'
								+ '</div>'
								+ '</div>'
							

						createbutton.innerHTML = '<button type="button" data-bs-toggle="modal" id="createNewbtnId" '
										+'data-bs-target="#createmodal" '
										+'class="btn bg-gradient-dark mb-0 mt-0 mt-md-n9 mt-lg-0"> '
								+ '<i '
										+'class="material-icons text-white position-relative text-md pe-2" '
										+'	id="plusSignimgId">add</i>Create New '
								+ '</button> '
						thead.innerHTML = '<tr>'
								+ '<th width="50%" style="padding-bottom:10px">Department Name</th>'
								+ '<th colspan=2 style="padding-bottom:10px">Actions</th>'
								+ '</tr>'

						for (var i = 0; i < resp.length; i++) {

							tbody.innerHTML += ' <tr class="text-sm">'
									+ '<td><input type="text" value="'+resp[i].department_name+'" id="dname'+resp[i].department_id+'" class="inputhide" disabled> </td>'
									+ '<td><a class="btn btn-link text-dark p-0 mb-0" data-bs-toggle="modal" data-bs-target="#updateModal" onclick="editById('
									+ resp[i].department_id
									+ ');"><i class="material-icons text-sm me-2">edit</i></a>&nbsp&nbsp'
									+ '<a class="btn btn-link text-danger text-gradient p-0 mb-0" data-bs-toggle="modal" data-bs-target="#deleteModal" onclick="deleteByID('
									+ resp[i].department_id
									+ ');"><i class="material-icons text-sm me-2">delete</i></a></td>'
									+ '</tr>'
						}

					},
					error : function(error) {
						console.log(error)
					}
				})
	}

	function loadCustomerType() {

		$
				.ajax({
					url : 'masterDetails',
					type : 'POST',
					data : {
						actionType : 'customertypelist',

					},
					success : function(resp) {
						console.log(resp)

						$('#theadid').empty();
						$('#tbodyid').empty();

						masterTypeValue = "customertype";
						modalheading.innerHTML = "New Customer Type";
						editModalHead.innerHTML = "Edit Customer Type";

						editModalBody.innerHTML = '<div class="row">'
								+ '<div class="col-md-4">'
								+ '	<div class="input-group input-group-static mb-4">'
								+ '<label>Customer Type</label> <input id="cxtypeidforedit" type="text" class="form-control" required="required">'
								+ '	</div> '
								+ '</div>'
								+ '</div>'
								+ '<div class="row justify-content-md-end mt-4">'
								+ '<div class="col-md-auto px-1 text-end">'
								+ '<button type="button" data-bs-dismiss="modal"'
								+ '	class="btn bg-gradient-info" '
								+ 'onclick="return updateExisting();">Update Customer Type</button>'
								+ '	<button type="button" '
								+ '	class="btn btn-link  ml-auto" '
								+ '	data-bs-dismiss="modal">Close</button>'
								+ '</div>'
								+ '</div>'
							

						modalbody.innerHTML = '<div class="row">'
								+ '<div class="col-md-4">'
								+ '	<div class="input-group input-group-static mb-4">'
								+ '<label>Customer Type</label> <input id="cxtypeid" type="text" class="form-control" required="required">'
								+ '	</div> '
								+ '</div>'
								+ '</div>'
								+ '<div class="row justify-content-md-end mt-4">'
								+ '<div class="col-md-auto px-1 text-end">'
								+ '<button type="button" data-bs-dismiss="modal"'
								+ '	class="btn bg-gradient-info" '
								+ 'onclick="return createNew();">Create Customer Type</button>'
								+ '	<button type="button" '
								+'	class="btn btn-link  ml-auto" '
								+'	data-bs-dismiss="modal">Close</button>'
								+ '</div>'
								+ '</div>'
								

						createbutton.innerHTML = '<button type="button" data-bs-toggle="modal" id="createNewbtnId" '
										+'data-bs-target="#createmodal" '
										+'class="btn bg-gradient-dark mb-0 mt-0 mt-md-n9 mt-lg-0"> '
								+ '<i '
										+'class="material-icons text-white position-relative text-md pe-2" '
										+'	id="plusSignimgId">add</i>Create New '
								+ '</button> '

						thead.innerHTML = '</tr>'
								+ '<tr>'
								+ '<th width="50%" style="padding-bottom:10px">Customer Type</th>'
								+ '<th colspan=2 style="padding-bottom:10px">Actions</th>'
								+ '</tr>'

						for (var i = 0; i < resp.length; i++) {

							tbody.innerHTML += '<tr class="text-sm">'
									+ '<td><input type="text" value="'+resp[i].customer_type+'" id="ctype'+resp[i].customer_type_id+'" class="inputhide" disabled> </td>'
									+ '<td><a class="btn btn-link text-dark p-0 mb-0" data-bs-toggle="modal" data-bs-target="#updateModal" onclick="editById('
									+ resp[i].customer_type_id
									+ ');"><i class="material-icons text-sm me-2">edit</i></a>&nbsp&nbsp'
									+ '<a class="btn btn-link text-danger text-gradient p-0 mb-0" data-bs-toggle="modal" data-bs-target="#deleteModal" onclick="deleteByID('
									+ resp[i].customer_type_id
									+ ');"><i class="material-icons text-sm me-2">delete</i></a></td>'
									+ '</tr>'
						}

					},
					error : function(error) {
						console.log(error)
					}
				})
	}

	function deleteByID(id) {
		this.pkid = id;
		console.log(id);
	}

	function editById(id) {
		this.pkid = id;
		$.ajax({

			url : 'masterDetails',
			type : 'POST',
			data : {
				actionType : 'populateData',
				pkid : id,
				masterType : masterTypeValue,
				company_id : company_id

			},
			success : function(resp) {
				console.log("populated data", resp)
				$('#cxtypeidforedit').val(resp[0].customer_type);
				$('#departmentidforedit').val(resp[0].department_name);
				$('#emproleidforedit').val(resp[0].employe_role_name);
				$('#empstatusidforedit').val(resp[0].employee_status_name);
				$('#emptypeidforedit').val(resp[0].employee_type_name);
				$('#projectgroupidforedit').val(resp[0].project_group_name);
				$('#projectstatusidforedit').val(resp[0].project_status);
				$('#projectsubgroupidforedit').val(resp[0].project_sub_group);
				$('#groupIdForUpdate').val(resp[0].project_group_id);
				$('#projecttypeidforedit').val(resp[0].project_type);
				$('#taskactivityidforedit').val(resp[0].taskActivity);
				$('#taskpriorityidforedit').val(resp[0].taskPriority);
				$('#taskstatusidforedit').val(resp[0].taskStatus);
				$('#tasktypeidforedit').val(resp[0].taskType);

			},
			error : function(error) {
				alert(error)
			}

		})

	}
</script>

<%@ include file="/include/footer.jsp"%>

