 <%@page import="com.dakshabhi.pms.projectsemployee.dtos.CProjectEmployeeInfoDTO"%>
<%@page
	import="com.dakshabhi.pms.projectworkpacks.dtos.CProjectworkpacksInfoDTO"%>
<%@page import="com.dakshabhi.pms.workpaks.dtos.CWorkpackDTO"%>
<%@page import="com.dakshabhi.pms.employees.dtos.CEmployeeInfoDTO"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.dakshabhi.pms.employees.dtos.CEmployeeDTO"%>
<%@ include file="/include/header.jsp"%>
 
<body class="g-sidenav-show  bg-gray-100">
	<%@ include file="/include/leftnav.jsp"%>
	<!-- Main -->
	<main
		class="main-content position-relative max-height-vh-100 h-100 border-radius-lg ">
		<!-- Navbar -->
		<nav
			class="navbar navbar-main navbar-expand-lg position-sticky px-0 mx-4 shadow-none border-radius-xl z-index-sticky"
			id="navbarBlur" data-scroll="true">
			<div class="container-fluid py-1 px-3"
				style="display: block !important">
				<nav aria-label="breadcrumb">
					<div class="row">
						<div class="col-6">
							<h6 class="font-weight-bolder mb-0">Project Employee</h6>
							<div class="sidenav-toggler sidenav-toggler-inner">
						      <a href="javascript:;" class="nav-link text-body p-0">
						        <div class="sidenav-toggler-inner">
						          <i class="sidenav-toggler-line"></i>
						          <i class="sidenav-toggler-line"></i>
						          <i class="sidenav-toggler-line"></i>
						        </div>
						      </a>
						    </div>
						</div>
						<div class="col-6" id="addbtbn" style="text-align: end">
							<a type="button" onclick="createNew();" class="btn bg-gradient-dark mb-0 mt-0 mt-md-n9 mt-lg-0"> 
								<i class="material-icons text-white position-relative text-md pe-2">add</i>CREATE
								NEW
							</a>
						</div>
					</div>


				</nav>
			</div>
		</nav>
		<!--End Navbar -->

		<div class="container-fluid py-4">
			<div class="row mt-4">
				<div class="col-12">
					<div class="card">

						<div class="table-responsive">
							<table class="table table-flush recordTable"
								id="datatable-search">
								<thead class="thead-light">
									<tr>
										<th>Action</th>
										<th>Project Name</th>
										<th>Employee Name</th>
									</tr>
								</thead>
								<tbody>
									<%
									ArrayList<CProjectEmployeeInfoDTO> projectEmployeeList = (ArrayList) session.getAttribute("projectEmployeeList");
									if (projectEmployeeList != null) // Null check for the object
									{
										Iterator<CProjectEmployeeInfoDTO> iterator = projectEmployeeList.iterator(); // Iterator interface
										while (iterator.hasNext()) // iterate through all the data until the last record
										{
											CProjectEmployeeInfoDTO projectEmployeeDetails = iterator.next(); //assign individual employee record to the employee class object
									%>

									<tr>
										<td class="text-sm font-weight-normal"><a
											class="btn btn-link text-dark px-1 mb-0"> <i
												class="material-icons text-sm me-2 edit-button"
												onclick="editProjectWorkpackDetails(<%=projectEmployeeDetails.getProject_employee_id()%>)">edit</i></a>
											<a class="btn btn-link text-danger text-gradient px-1 mb-0"
											data-bs-toggle="modal" data-bs-target="#exampleModal"> <i
												class="material-icons text-sm me-2"
												onclick="deleteProjectEmployeeById(<%=projectEmployeeDetails.getProject_employee_id()%>)">delete</i></a></td>
										<td class="text-sm font-weight-normal"><%=projectEmployeeDetails.getProject_name()%></td>
										<td class="text-sm font-weight-normal"><%=projectEmployeeDetails.getEmployee_name()%></td>
										
										

									</tr>
									<%
									}
									}
									%>

									<!-- Create New  -->

									<tr id="new_record_id" style="display: none;">
										<td>
											<div style="display:flex;">
												<div>
													<button type="submit" name="submit"
														class="btn bg-gradient-dark m-0 ms-2" onclick="save();">Save</button>
												</div>
												<div style="margin-left: 10px;">
													<button type="submit" name="submit"
														class="btn bg-gradient-light m-0 cancelBtn ">&times;</button>
												</div>
											</div>
										</td>
										<td><select class="form-control" id="projectlist_id"
											name="project_list" required="required">
												<option value="">Select Project</option>
										</select></td>

										<td>
										    <select class="form-control" id="employeelist_id" name="employee_list" required="required">
												<option value="">Select Employee</option>
											</select>
										</td>

										
									</tr>

								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>


		<!-- Modal -->
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
							data-bs-dismiss="modal" onclick="deleteProjectEmployee();">Delete</button>
					</div>
				</div>
			</div>
		</div>

	</main>
	<!-- End Main -->
	<form name="projectEmployeeform" action="projectsemployee" method="post">
		<input type="hidden" name="actionType" />
	    <input type="hidden" name="project_id" /> 
	    <input type="hidden" name="employee_id" />
	    

		<!-- This Project WorkpackId for delete -->
		<input type="hidden" name="project_employee_id" />

	</form>

	<form name="updateProjectEmployeeform" action="projectsemployee" method="post">
		<input type="hidden" name="actionType" /> 
		<input type="hidden" name="project_employee_id" /> 
		<input type="hidden" name="project_id" />
		<input type="hidden" name="employee_id" />
		
		

	</form>

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
<script>
	const dataTableSearch = new simpleDatatables.DataTable("#datatable-search",
			{
				searchable : true,
				fixedHeight : true
			});
	
	/*Create New Project Employee   */

	function createNew() {

		$("#new_record_id").css("display", "");
		$(".dataTable-bottom").css("display", "none"); 
		$(".dataTable-container").css("height", "100%");
 	
		
		$.ajax({
			url : 'projectsemployee',
			method : 'POST',
			data : {
				actionType : "getProjectName"
			},
			success : function(data) {
				console.log("project names: ", data);
				for (var i = 0; i < data.length; i++) {
					var counter = data[i];
					$('#projectlist_id').append($('<option>', {
						value : counter.project_id
					}).text(counter.project_name));

				}
			},
			error : function(jqXHR, exception) {
				console.log('Error occured!!');
			}
		});

		$.ajax({
			url : 'projectsemployee',
			method : 'POST',
			data : {
				actionType : "getEmployeeName"
			},
			success : function(data) {
				console.log("Employee names: ", data);
				var counter = data[i];
				for (var i = 0; i < data.length; i++) {
					var counter = data[i];
					$('#employeelist_id').append($('<option>', {
						value : counter.employee_id
					}).text(counter.employee_name));
				}
			},
			error : function(jqXHR, exception) {
				console.log('Error occured!!');
			}
		});

	}
   
	/* Save Project Employee */
	
	
	function save() {
        
		selectElement = document.querySelector('#projectlist_id');
		projectId = selectElement.value;

		selectElement = document.querySelector('#employeelist_id');
		employeeId = selectElement.value;

		document.projectEmployeeform.actionType.value = 'save';
		document.projectEmployeeform.project_id.value = projectId;
		document.projectEmployeeform.employee_id.value = employeeId;
		document.projectEmployeeform.submit();

		console.log("projectId: ", projectId);
		console.log("employeeId:  ", employeeId);

	}
	
	
	
	/*Delete ProjectEmployee  */

	var projectEmployeeId;

	function deleteProjectEmployeeById(id) {
		this.projectEmployeeId = id;
		console.log("Project Workpack id is: ", this.projectEmployeeId)
	}

	function deleteProjectEmployee(){
		document.projectEmployeeform.actionType.value= 'delete';
		document.projectEmployeeform.project_employee_id.value = projectEmployeeId; 
		document.projectEmployeeform.submit();
	}
	
	
	
	
	/*Edit Project Employee  */
	
	function editProjectWorkpackDetails(id) {
		this.projectEmployeeId =id;
	}  
	
	$(document).on("click",".edit-button",function(e){
		 var projectId;
		 var employeeId;
		 console.log("projectEmployeeid: ", projectEmployeeId);
		
		 var currentRowIndex = $(e.currentTarget).closest('td').parent()[0].sectionRowIndex ;
		  $('.edit-button').prop("disabled", true); 
		 console.log('clicked update btn id is: ', currentRowIndex);
		 
		 var currentRow = $(this).closest("tr");
		 var originalHtmlCode = currentRow.html();
		 console.log('Html code:  ', originalHtmlCode);
		 
		 $.ajax({
				url : 'projectsemployee',
				method : 'POST',
				data : {
					actionType : "infoforedit",
					projectEmployeeId : projectEmployeeId
				},
				success : function(data) {
					console.log("data info for edit: ", data)
					projectId = data['project_id'];
					employeeId = data['employee_id'];
					
				},
				error : function(jqXHR, exception) {
					console.log('Error occured!!');
				}
			});
		 
		 var projectName = currentRow.find("td:eq(1)").text();
		 var employeeName = currentRow.find("td:eq(2)").html();
		 
		 
		 $.ajax({
				url : 'projectsemployee',
				method : 'POST',
				data : {
					actionType : "getProjectName"
				},
				success : function(data) {
					console.log("project names: ", data);
					for (var i = 0; i < data.length; i++) {
						var counter = data[i];
						$('#projectlist_id').append($('<option>', {
							value : counter.project_id
						}).text(counter.project_name));

					}
				},
				error : function(jqXHR, exception) {
					console.log('Error occured!!');
				}
			});

			$.ajax({
				url : 'projectsemployee',
				method : 'POST',
				data : {
					actionType : "getEmployeeName"
				},
				success : function(data) {
					console.log("Employee names: ", data);
					var counter = data[i];
					for (var i = 0; i < data.length; i++) {
						var counter = data[i];
						$('#employeelist_id').append($('<option>', {
							value : counter.employee_id
						}).text(counter.employee_name));
					}
				},
				error : function(jqXHR, exception) {
					console.log('Error occured!!');
				}
			});
		 
		 
		 
		var setHtmlData = 	'<td class="text-sm font-weight-normal"><div style="display:flex;"><div><button type="submit" name="submit" id="saveChangesBtn" class="btn bg-gradient-dark m-0 saveChangesBtn ">Save</button></div><div style="margin-left:10px;"><button type="submit" name="submit"  class="btn bg-gradient-light m-0 cancelBtn ">&times;</button></div></div></td>';
		 setHtmlData += '<td class="text-sm font-weight-normal"> <select class="form-control" id="projectlist_id"  name="updated_project_list" required="required"><option >'+projectName+'</option></select></td>';
		 setHtmlData += '<td class="text-sm font-weight-normal"> <select class="form-control" id="employeelist_id" name="updated_employee_list" required="required"><option >'+employeeName+'</option> </select></td>';
		
		  $('#datatable-search tr').eq(currentRowIndex+ 1).html(setHtmlData);
		 
		 $(document).on("click",".saveChangesBtn",function() {
			  	console.log("save button clicked")
				var projEmployeeId = projectEmployeeId;
				var updatedProjectName = $("#projectlist_id").val();
				var updatedEmployeeName = $("#employeelist_id").val();
				
				
 			    if(updatedProjectName == projectName || updatedProjectName == ''){updatedProjectName = projectId};
 				if(updatedEmployeeName == employeeName || updatedEmployeeName == ''){updatedEmployeeName =  employeeId}; 
				

				
				document.updateProjectEmployeeform.actionType.value = 'update';
				document.updateProjectEmployeeform.project_employee_id.value = projEmployeeId ;
				document.updateProjectEmployeeform.project_id.value = parseInt(updatedProjectName) ;
				document.updateProjectEmployeeform.employee_id.value = parseInt(updatedEmployeeName) ;
		
				document.updateProjectEmployeeform.submit(); 
				
		});
		 
		 
		 
		 $(".cancelBtn").click(function() {
				$('#datatable-search tr').eq(currentRowIndex + 1).html(originalHtmlCode);
				$('.saveChangesBtn').prop("disabled", false);
			}); 
		
		 
	});
	
	 $(".cancelBtn").click(function() {
		 location.reload();
		 
	 }); 
	
	
</script>

<%@ include file="/include/footer.jsp"%>

