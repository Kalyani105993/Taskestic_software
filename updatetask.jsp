<%@ include file="/include/header.jsp"%>
<style>
#description {
	border-bottom: 1px solid gray;
	border-radius: 0px;
}

.msgError {
	font-size: 0.875rem;
	display: none;
	color: red;
}

#descriptionId {
	white-space: break-spaces;
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
						<div class="col-lg-8 col-md-8 col-sm-6 col-xs-12">
							<h6 class="font-weight-bolder mb-0">
								<span id="projectnameid"></span>
							</h6>
							<div class="sidenav-toggler sidenav-toggler-inner">
								<a href="javascript:;" class="nav-link text-body p-0">
									<div class="sidenav-toggler-inner">
										<i class="sidenav-toggler-line"></i> <i class="sidenav-toggler-line"></i> <i class="sidenav-toggler-line"></i>
									</div>
								</a>
							</div>
						</div>
					</div>
				</nav>
			</div>
		</nav>
		<div class="container-fluid">
			<div class="card">
				<div class="card-body">
					<div class="row">
						<div class="col-lg-12 col-md-8">
							<form name="taskform" id="taskformId">
								<input type="hidden" name="actionType" id="action_type_id" value="createtask" /> <input type="hidden" name="taskid" id="taskid_id" value="" />
								<div class="row">
									<div class="col-md-4">
										<div class="input-group input-group-static mb-4">
											<label>Type <sup><i class="fa fa-asterisk"></i></sup></label> <select class="required form-control" id="taskType_id" name="taskType">
												<option value="">Select Type</option>
											</select> <span class="msgError" id="msgError_taskType_id"></span>
										</div>
									</div>
									<div class="col-md-8">
										<div class="input-group input-group-static mb-4">
											<label>Task Name <sup><i class="fa fa-asterisk"></i></sup></label> <input type="text" class="required form-control" name="task_name" id="task_name_id"> <span
												class="msgError" id="msgError_task_name_id"></span>
										</div>
									</div>

								</div>

								<div class="row">
									<div class="col-md-12">
										<div class="input-group input-group-static mb-4">
											<label>Task Description </label>
											<textarea class="form-control" rows="2" placeholder="This is how others will learn about the task, so make it good!" spellcheck="false"
												name="task_description" id="task_description_id"></textarea>
											<span class="msgError" id="msgError_task_description_id"></span>

										</div>
									</div>

								</div>

								<div class="row">
									<div class="col-md-4">
										<div class="input-group input-group-static mb-4">
											<label>Priority <sup><i class="fa fa-asterisk"></i></sup></label> <select class="required form-control" id="taskPriority_id" name="taskPriority">
												<option value="">Select Priority</option>
											</select> <span class="msgError" id="msgError_taskPriority_id"></span>
										</div>
									</div>
									<div class="col-md-4">
										<div class="input-group input-group-static mb-4">
											<label>Status <sup><i class="fa fa-asterisk"></i></sup></label> <select class="required form-control" id="taskStatus_id" name="taskStatus">
												<option value="">Select Status</option>
											</select> <span class="msgError" id="msgError_taskStatus_id"></span>
										</div>
									</div>
									<div class="col-md-4">
										<div class="input-group input-group-static mb-4">
											<label>Select Assignee <sup><i class="fa fa-asterisk"></i></sup></label> <select class="required form-control" id="assignee_id" name="assignee">
												<option value="0">Select Assignee</option>
											</select>

										</div>
									</div>
								</div>

								<div class="row">
									<div class="col-md-3">
										<div class="input-group input-group-static mb-4">
											<label>Start Date</label> <input type="date" class="form-control" name="start_date" id="start_date_id" required="required">
										</div>
									</div>

									<div class="col-md-3">
										<div class="input-group input-group-static mb-4">
											<label>Due Date</label> <input type="datetime-local" class="form-control" name="due_date" id="due_date_id">
										</div>
									</div>

									<div class="col-md-3">
										<div class="input-group input-group-static mb-4">
											<label>Estimated time</label> <input type="number" class="form-control" id="estimeted_time_id" name="estimeted_time">(Hours)
										</div>
									</div>

									<div class="col-md-3">
										<div class="input-group input-group-static mb-4">
											<label>% Done</label> <select class="form-control" id="done_value_id" name="done_value" required="required">
												<option value="0">0%</option>
												<option value="10">10%</option>
												<option value="20">20%</option>
												<option value="30">30%</option>
												<option value="40">40%</option>
												<option value="50">50%</option>
												<option value="60">60%</option>
												<option value="70">70%</option>
												<option value="80">80%</option>
												<option value="90">90%</option>
												<option value="100">100%</option>
											</select>

										</div>
									</div>
								</div>
													<div class="card">
													<div class="card-body">
														<div class="row">
															<div class=" col-md-3 col-sm-12">
																<label class="form-check px-2 py-1 is-filled">Add Followers </label>
															</div>
															<div class=" col-md-6 col-sm-12">
																<div class="form-check lx-4 py-1">
																	<input class="form-check-input" type="checkbox" name="chkaddAllfollowers" value="1" id="addAllcheckboxId"  > <label
																		class="mb-0 position-relative text-sm">Add All</label>
																</div>
															</div>
															<div class="col-lg-3 col-md-3 col-sm-12 ">
																<div class="input-group input-group-static mb-4">
																	<select class="form-control p-2" id="searchdepartment_id" name="departmentfilter" onchange="loadFollowers(this.value);">
																		<option value="0">All Department</option>
																	</select> <span class="msgError" id="msgError_searchdepartment_id"></span>
																</div>
															</div>

															<div class=" mb-4">
																<div class="row" id="followerlistid"></div>
															</div>
														</div>
													</div>
												</div>
								<div class="d-flex justify-content-end mt-4 ">

									<div class="col-md-auto text-end px-1">
										<button type="button" class="btn bg-gradient-info" id="taskactionid" onclick="cearenewtask();">Create</button>
										&nbsp
										<button type="button" class="btn btn-link  ml-auto" id="cancelbtn" data-bs-dismiss="modal">Close</button>
									</div>
								</div>

							</form>


							<form action="tasks?actionType=uploadAttachment" enctype="multipart/form-data" method="post" id="attachForm_Id"
								onsubmit="return validateServiceDetails('attachForm_Id');">
								<input type="hidden" name="taskid" id="taskid" value="" />
								<div class="row" id="attachFormId">
									<div class="col-12 position-relative">
										<input type="hidden" name="taskid" id="taskid" value="" />
										<div class="card">
											<div class="card-body">
												<div class="row">
												<div class="text-start my-3"> <span id="" class="">(Max 5 files)</span></div>
													<div class="row" id="upFile">
														<div class="col-md-2">
															<label>Upload File</label>
														</div>
														<div class="col-md-2" id="btnFile">
															<input type="button" id="uploadFilebtnId" class="btn bg-gradient-info mt-2" value="Upload File" onclick="togglefunction();">
														</div>
													</div>
													
													<div class="row my-2" id="choosefileid" hidden>

														<div class="col-md-3">
															<input type="file" class="form-control form-control-sm" id="choosefile" name="firstAttachment" onchange="fileSizeValidation(this.id)"
																accept=".csv, application/vnd.ms-excel,text/plain, application/pdf, image/*">
														<span id="file_msgErrorId" class="msgError">File too Big, please select a file less than 10 Mb</span>
														</div>
														<div class="col-md-2">
															<input type="button" id="cancel_btn" class="btn btn-link ml-auto" value="Cancel" onclick="cancelbtn();">
														</div>
														<div class="card card-body p-3 pt-2" id="tableData" hidden>
															<div class="mx-2">
																<table class="table table-flush text-sm">
																	<thead>
																		<tr>
																			<th>Document</th>
																			<th></th>
																		</tr>
																	</thead>
																	<tbody id="tbodyid">
																		<tr class="row">
																			<td class="col-md-4 mx-2"><input type="text" id="discrip" class="form-control"></td>
																			<td class="col-md-4 mx-2"><textarea type="textarea" id="description" class="required form-control" rows="2" cols="50" name="description"
																					onfocus="focused(this)" placeholder="Description" onfocusout="defocused(this)"></textarea><span class="msgError" id="msgError_description"></span></td>
																		</tr>
																	</tbody>
																</table>
															</div>
															<div>
																<input type="button" class="btn bg-gradient-dark btn-sm float-end mt-2 mx-3 rounded-1 mb-0" id="savebtn" value="save">
															</div>
														</div>
													</div>
													<div class="row" id="docsListId" hidden>
														<div class="table-responsive">
															<table class="table table-flush text-sm">
																<thead class="thead-light">
																	<tr>
																		<th>Actions</th>
																		<th>Document Name</th>
																		<th>Description</th>
																		<th>Uploaded Date</th>
																	</tr>
																</thead>
																<tbody id="documentBody">
																</tbody>
															</table>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- Delete Modal -->
		<div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="deleteModalModalLabel" aria-hidden="true">
			<hidden name="deleteIDName" id="deleteID" />
			<div class="modal-dialog modal-dialog-centered" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title font-weight-normal" id="exampleModalLabel">Delete Confirmation</h5>
						<button type="button" class="btn-close text-dark" data-bs-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">Are you sure you want to delete this record?</div>
					<div class="modal-footer">
						<button type="button" class="btn bg-gradient-secondary" data-bs-dismiss="modal">Close</button>
						<button type="button" class="btn bg-gradient-primary" id="deleteBtnID" data-bs-dismiss="modal" onclick="deleteProjectEmployee();">Delete</button>
					</div>
				</div>
			</div>
		</div>
		<!-- Delete Modal End-->
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
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>

<script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>

<!-- Kanban scripts -->
<script src="assets/js/plugins/dragula/dragula.min.js"></script>
<script src="assets/js/plugins/jkanban/jkanban.js"></script>
<script src="assets/js/material-dashboard.js?v=3.0.6"></script>
<link href="https://gitcdn.github.io/bootstrap-toggle/2.2.2/css/bootstrap-toggle.min.css" rel="stylesheet">
<script src="https://gitcdn.github.io/bootstrap-toggle/2.2.2/js/bootstrap-toggle.min.js"></script>

<script type="text/javascript">



	function checkSession() {
		jQuery.ajax({
			type : "POST",
			url : "checksession",
			data : {},
			async : true,
			success : function(data) {
				if (data == 'Failure') {
					window.location = 'signin.jsp';
				}

			},
			error : function(data) {
				window.location = 'signin.jsp';
			}
		});
	}

var taskId = "";

	$(function() {
		checkSession();
		projectid = sessionStorage.getItem("projectid");
	    taskid = sessionStorage.getItem("taskId"); 
	 
	    $("#taskid_id").val(taskid);
	    console.log(taskid, "taskid");
		var projectname = sessionStorage.getItem("projectname");
		$("#projectnameid").text(projectname);
		loadAssigneeList();
		loadTaskTypeList();
		loadTaskPriorityList();
		loadTaskStatusList();
		loadProjectList();
// 		loadDocumentList();
		loadDepartmentList();
		loadFollowers($('#searchdepartment_id').val());
		editTaskDetails(taskid);
		
		$("#projectId").val(projectid);

		$("#projectfilter_id").val(projectid);
		$("#startDateColid").hide();
		$("#endDateColid").hide();
		$("#activitystartDateColid").hide();
		$("#activityendDateColid").hide();

		$("#activityselect_filter_id").change(function() {
			var custom_date = $("#activityselect_filter_id").val();
			if (custom_date == "custom_dates") {
				$("#activitystartDateColid").show();
				$("#activityendDateColid").show();
			} else {
				$("#activityFilterStartDateid").val('');
				$("#activityFilterEndDateid").val('');
				$("#activitystartDateColid").hide();
				$("#activityendDateColid").hide();
			}
		});
		$("#timeLogselect_filter_id").change(function() {
			var custom_date = $("#timeLogselect_filter_id").val();
			if (custom_date == "custom_dates") {
				$("#startDateColid").show();
				$("#endDateColid").show();

			} else {
				$("#timeLogFilterStartDateid").val('');
				$("#timeLogFilterEndDateid").val('');
				$("#startDateColid").hide();
				$("#endDateColid").hide();
			}
		});
		
	});
	// When Add All checkbox is clicked
    $("#addAllcheckboxId").click(function(){
        $(".followers").prop("checked", this.checked);
    });
 	// When any followers checkbox is clicked
	function checkfollowers(){
        if($('.followers:checked').length == $('.followers').length){
            $('#addAllcheckboxId').prop('checked',true);
        }else{
            $('#addAllcheckboxId').prop('checked',false);
        }
	}
	function togglefunction(){
		$("#upFile").prop("hidden", true);
		$("#choosefileid").prop("hidden", false);
		 $("#cancel_btn").prop("hidden", false);
		 $("#choosefile").prop("hidden", false);
	} 

	$("#choosefile").change(function(e){
		$("#file_msgErrorId").css("display", "none");
		if( fileSizeValidation(choosefile)){
			$("#tableData").prop("hidden", false);
			let val1 = e.target.files[0].name;
			$("#discrip").val(val1);
			$("#file1").val(val1);
			$("#filediv1").prop("hidden", false);
			$("#filename").prop("hidden", false);
		}
	})

	$("#savebtn").click(function(){
		if(validateServiceDetails('attachForm_Id')){
// 		$("#attachForm_Id").submit();
		$("#upFile").prop("hidden", false);
// 		$("#btnFile").prop("hidden", true);
		$("#tableData").prop("hidden", true);
// 		$("#btnFile1").prop("hidden", false);
		$("#choosefile").prop("hidden", true);
		$("#cancel_btn").prop("hidden", true);
		$("#choosefileid").prop("hidden", true);
		uploadFile();
		}
	})

 	
		function cancelbtn(){
		 	$("#choosefile").prop("hidden", true);
	 		$("#choosefile").val("");
	 		$("#upFile").prop("hidden", false);
	 		$("#cancel_btn").prop("hidden", true);
	 		$("#tableData").prop("hidden", true);
	 		$("#description").val("");
	 		$("#msgError_description").css("display", "none");
	 		$("#file_msgErrorId").css("display", "none");
		}
	
	function uploadFile(){
		
		   let formData = new FormData(); 
		   formData.append("firstAttachment", choosefile.files[0]);
		   formData.append("taskid", taskid);
		   formData.append("description", $('#description').val());
						console.log("Form Data");
						  for (let obj of formData) {
						    console.log(obj);
						  }
							$
							.ajax({
								url : "tasks?actionType=uploadAttachment",
								type : 'post',
								data : formData,
								success : function(data) {
									$("#choosefile").prop("hidden", true);
							 		$("#choosefile").val("");
							 		$("#upFile").prop("hidden", false);
							 		$("#cancel_btn").prop("hidden", true);
							 		$("#tableData").prop("hidden", true);
							 		$("#description").val("");
							 		$("#msgError_description").css("display", "none");
							 		$("#file_msgErrorId").css("display", "none");
									loadDocumentList(); 
								},
								error : function(error) {
									alert(data);
								},
								processData : false,
								contentType : false,
							});  
			}
	function loadDocumentList(){
		$.ajax({
			url:"tasks",
			type:"post",
			data:{
				actionType : "documentList",
				taskid : $('#taskid_id').val(),
			},success : function(data){ 
				console.log(data, "DocumentsList");
				if(data != ""){
					 $("#docsListId").prop("hidden", false);
					 $("#uploadFilebtnId").prop("disabled", false);
				}
				if(data.length == "5"){
					$("#choosefile").prop("hidden", true);
			 		$("#choosefile").val("");
			 		$("#uploadFilebtnId").prop("disabled", true);
			 		$("#cancel_btn").prop("hidden", true);
				}
				
				var DName = document.getElementById("documentBody");
				$("#documentBody").empty();
				var row = "";
					for(var i = 0; i<data.length; i++){ 
						row += '<tr><td><a href="#" onclick="deleteAttachmentById('+data[i].document_id+');"class="text-danger cursor-pointer"><i class="material-icons text-sm me-2">cancel</i></a><a href="#" class="text-info cursor-pointer" id="viewAttachment" onclick="viewAttachment('+ $('#taskid_id').val() +', '+data[i].document_id+');"><i class="material-icons text-sm me-2">preview</i></a><a href="tasks?actionType=downloadAttachment&taskid='+taskid+'&document_name='+data[i].document_name+'" target="_top" class="text-info cursor-pointer" id="downloadAttachmentId" ><i class="material-icons text-sm me-2">download</i></a></td><td id="docNameFordwnId">'+data[i].document_name+'</td><td id="descriptionId">'+data[i].documentDiscription+'</td><td>'+data[i].created_on+'</td></tr>';					 } 
					DName.innerHTML = row;
			}
		})
	} 
	
	
	function viewAttachment(taskId, documentId){
		$.ajax({
			url:"tasks",
			type:"post",
			data:{
				actionType:"viewAttachment",
				taskid : taskId,
				documentId : documentId
			},success:function(resp){
				console.log(resp);
				if(resp!=null){
// 					//for local
// 					var b = resp.split('dakshabhipms-qa/')
// 					console.log(b[1]);
// 					var attachmentFile = b[1];
					//for server
					 var attachmentFile = resp;
					 window.open(attachmentFile, "Preview", "width=800,height=500"); 
				}
			}
		})
	}
	function deleteAttachmentById(documentId) {
		$('#deleteModal').modal("show");
		$("#deleteBtnID").attr("onclick", "deleteAttachment("+documentId+")");
	}
	function deleteAttachment(documentId){
		$.ajax({
			url:"tasks",
			type:"post",
			data:{
				actionType:"deleteAttachment",
				document_id : documentId,
				taskid : $('#taskid_id').val(),
			},success:function(resp){
				loadDocumentList();
			}
		})
	}
	

	function loadProjectList() {
		$.ajax({
			url : "projects",
			type : "post",
			async : false,
			data : {
				action_type : "searchData"
			},
			success : function(resp) {
				console.log('Projects: ' + resp[0]);
				if (resp[1] > 0 && resp[0] != null) {
					for (var i = 0; i < resp[0].length; i++) {
						var htmlData = '<option value="'
								+ (resp[0])[i].project_id + '">'
								+ (resp[0])[i].project_name + '</option>'
						 
						$("#projectfilter_id").append(htmlData);

					}
				}
			}
		})
	}
	function loadMembers() {

		$('#memberstbodyforListId').empty();
		jQuery
				.ajax({
					type : "POST",
					url : "projectsemployee",
					data : {
						actionType : 'getprojectmembers',
						projectid : projectid,
						startIndex : 0,
						endIndex : 10,
					},
					async : true,
					success : function(data) {
						console.log(data);
						var jsonData = eval(data);
						if (jsonData.length > 0) {
							for (var i = 0; i < jsonData.length; i++) {
								var rowdata = jsonData[i];
								newRowContentforListView = getEmployeeRowforListView(rowdata);
								$("#memberstbodyforListId").append(
										newRowContentforListView);
							}
						} else {
							$("#memberstbodyforListId")
									.append(
											"<tr><td colspan='8'><center><b style='color:red'>No Task Found....<b></center></td></tr>");

						}
					},
					error : function(data) {
						alert("Error in process. Please try again.");
					}
				});
	}

	
	function loadTaskTypeList() {
		$
				.ajax({
					url : "masterDetails",
					type : 'post',
					data : {
						actionType : 'taskTypeList',
						company_id : "1"
					},
					success : function(data) {
						console.log(data);
						if (data != null) {
							for (let i = 0; i < data.length; i++) {
								var htmlData = '<option value="' + data[i].tasktypeID + '">'
										+ data[i].taskType + '</option>'
								$('#taskType_id').append(htmlData);
								$('#taskType_id1').append(htmlData);
							}
						}
					},
					error : function(error) {
						alert(error);
					}
				});
	}

	function loadTaskPriorityList() {
		$
				.ajax({
					url : "masterDetails",
					type : 'post',
					data : {
						actionType : 'taskPriorityList',
						company_id : "1"
					},
					success : function(data) {
						console.log(data);
						if (data != null) {
							for (let i = 0; i < data.length; i++) {
								var htmlData = '<option value="' + data[i].taskPriorityId + '">'
										+ data[i].taskPriority + '</option>'
								$('#taskPriority_id').append(htmlData);
								$('#taskPriority_id1').append(htmlData);
							}
						}
					},
					error : function(error) {
						alert(error);
					}
				});
	}

	function loadTaskStatusList() {
		$
				.ajax({
					url : "masterDetails",
					type : 'post',
					data : {
						actionType : 'taskStatusList',
						company_id : "1"
					},
					success : function(data) {
						console.log(data);
						if (data != null) {
							for (let i = 0; i < data.length; i++) {
								var htmlData = '<option value="' + data[i].taskStatusID + '">'
										+ data[i].taskStatus + '</option>'
								$('#taskStatus_id').append(htmlData);
								$('#filtertaskstatusid').append(htmlData);

							}
						}
					},
					error : function(error) {
						alert(error);
					}
				});
	}

	

	function loadAssigneeList() {
		$('#assignee_id').empty();
		$('#filterassigneeid').empty();
		jQuery
				.ajax({
					type : "POST",
					url : "projectsemployee",
					data : {
						actionType : 'getprojectmembers',
						projectid : projectid,
						startIndex : 0,
						endIndex : 10,
					},
					async : true,
					success : function(data) {
						console.log("assignee list", data);
						var jsonData = eval(data);
						if (jsonData.length > 0) {
							var htmlData = '<option value="0">Assignee</option>';
							$('#assignee_id').append(htmlData);
							$('#filterassigneeid').append(htmlData);
							for (var i = 0; i < jsonData.length; i++) {
								var rowdata = jsonData[i];
								var htmlData = '<option value="' + rowdata.employee_id + '">'
										+ rowdata.employee_name + '</option>'
								$('#assignee_id').append(htmlData);
								$('#filterassigneeid').append(htmlData);
							}
						}
					},
					error : function(data) {
						alert("Error in process. Please try again.");
					}
				});
	}

	function updatetask() {
		if (validateServiceDetails('taskformId')) {
			var taskfollowers = [];
			$("#followerlistid input[type=checkbox]:checked").each(function() {
				taskfollowers.push($(this).val());
			});
			console.log("taskfollowers: " + taskfollowers.join(','));
			$.ajax({
				type : "POST",
				url : "tasks",
				data : {
					actionType : $('#action_type_id').val(),
					taskId : $('#taskid_id').val(),
					taskName : $('#task_name_id').val(),
					taskDescription : $('#task_description_id').val(),
					taskStatusId : $('#taskStatus_id').val(),
					taskTypeId : $('#taskType_id').val(),
					taskPriorityId : $('#taskPriority_id').val(),
					assigneeId : $('#assignee_id').val(),
					startDate : $('#start_date_id').val(),
					dueDateTime : $('#due_date_id').val(),
					taskEstimatedTime : $('#estimeted_time_id').val(),
					taskCompletionValue : $('#done_value_id').val(),
					taskfollowers : taskfollowers.join(','),
				},
				success : function(data) {
					console.log(data);
					console.log("task Details updated");
					editTaskDetails(taskid);
				},
				error : function(data) {
					alert("Error in process. Please try again.");
				}
			});
		}
	}
	
function editTaskDetails(taskid) {
		$("#msgError_taskType_id").css("display", "none");
		$("#msgError_task_name_id").css("display", "none");
		$("#msgError_task_description_id").css("display", "none");
		$("#msgError_taskPriority_id").css("display", "none");
		$("#msgError_taskStatus_id").css("display", "none");
		$("#newTaskLabel").text("Update Task");
		$("#taskactionid").html("Update");
		$("#cancelbtn").html("Back");
		$("#taskactionid").attr("onclick", "updatetask()");
		$("#attachFormId").prop("hidden", false);
		$("#taskid").val(taskid);
		$("#cancelbtn").attr("onclick", "history.back();")
		$("#action_type_id").val("updatetask"); 
		
		loadFollowers($('#searchdepartment_id').val());
		jQuery.ajax({
			type : "POST",
			url : "tasks",
			data : {
				actionType : 'taskdetails',
				taskId : taskid
			},
			async : true,
			success : function(data) {
				console.log("edit data",data);
				var jsonData = eval(data);
				$('#action_type_id').val('updatetask');
				$('#taskid_id').val(taskid);
				$('#task_name_id').val(jsonData.taskName);
				$('#task_description_id').val(jsonData.taskDescription);
				$('#taskStatus_id').val(jsonData.taskStatusId);
				$('#taskType_id').val(jsonData.taskTypeId);
				$('#taskPriority_id').val(jsonData.taskPriorityId);
				$('#assignee_id').val(jsonData.assigneeId);
				$('#start_date_id').val(jsonData.startDate);
				$('#due_date_id').val(jsonData.dueDateTime);
				$('#estimeted_time_id').val(jsonData.taskEstimatedTime);
				$('#done_value_id').val(jsonData.taskCompletionValue);
				let ids_split= jsonData.followers.split(',');
 				var followersCheckbox = document.getElementsByName('chkfollowmember');
        			for (let i = 0; i < ids_split.length; i++) {
          				for (var checkbox of followersCheckbox) {
            				if (checkbox.value === ids_split[i]) {
                				$('input:checkbox[name="chkfollowmember"][value="' + ids_split[i] + '"]').attr('checked', true);
                				
            				}
						}
        			}
        			if($('.followers:checked').length === $('.followers').length){
        	            $('#addAllcheckboxId').prop('checked',true);
        	        }else{
        	            $('#addAllcheckboxId').prop('checked',false);
        	        }
        		loadDocumentList(); 
        	 },
			error : function(data) {
				alert("Error in process. Please try again.");
			}
		}); 
	}
	
function validateServiceDetails(form_id) {
		var formObj = $('#' + form_id);
		var inputObj;

		for (var i = 0; i <= formObj.get(0).length - 1; i++) {
			inputObj = formObj.get(0)[i];
			if (inputObj.type == 'select-one'
					&& inputObj.className === 'required form-control'
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
			} else if (inputObj.type === 'date'
					&& inputObj.className === 'required form-control'
					&& inputObj.value === '') {
				$("#msgError_" + inputObj.id).show();
				$("#msgError_" + inputObj.id).text("Please choose date.");
				return false;
			} else if (inputObj.type === 'number'
					&& inputObj.className === 'required form-control'
					&& inputObj.value === '') {
				$("#msgError_" + inputObj.id).show();
				$("#msgError_" + inputObj.id).text("Please fill this field.");
				return false;
			}
			if (inputObj.className === 'required form-control') {
				$("#msgError_" + inputObj.id).hide();
			}
		}
		return true;
	}

	function loadFollowers(departmentid) {
		$('#addAllcheckboxId').prop('checked' , false);
		$('#followerlistid').empty();
		jQuery.ajax({
			type : "POST",
			url : "projectsemployee",
			data : {
				actionType : 'getprojectmembers',
				projectid : projectid,
				departmentid : departmentid,
                startIndex : 0,
				endIndex : 10,
				listType : "getFollowers"
			},
			async : true,
			success : function(data) {
				console.log("Project Members: ",data);
				var jsonData = eval(data);
				if (jsonData.length > 0) {
					for (var i = 0; i < jsonData.length; i++) {
						var rowdata = jsonData[i];
						newRowContent = getFollowerRowData(rowdata);
						$("#followerlistid").append(newRowContent);
					}
				}
			},
			error : function(data) {
				alert("Error in process. Please try again.");
			}
		});
	}
	
	function getFollowerRowData(data) {
		var rowData = "<div class=\"col-lg-4 col-md-6 col-sm-12\">";
		rowData += "<div class=\"d-flex px-2 py-1\">";
		rowData += "<div class=\"form-check px-2 py-1\">";
		rowData += "<input class=\"form-check-input followers\" type=\"checkbox\" onchange = \"checkfollowers();\" name='chkfollowmember' value='"+data.employee_id+"' id='fmemberid_"+data.employee_id+"'></div>";
		rowData += "<div><img src='uploads/avatar/"+data.employee_profile_avatar+"' class=\"avatar avatar-sm me-3\" alt=\"avatar image\">";
		rowData += "</div>";
		rowData += "<div class=\"d-flex flex-column justify-content-center\">";
		rowData += "<h6 class=\"mb-0 font-weight-normal text-sm\">"
				+ data.employee_name + "</h6>";
		rowData += "</div>";
		rowData += "</div>";
		rowData += "</div>";
		return rowData;
	}
	function loadTaskActivityList() {
		$
				.ajax({
					url : "masterDetails",
					type : 'post',
					data : {
						actionType : 'taskActivityList',
						company_id : "1"
					},
					success : function(data) {
						console.log(data);
						if (data != null) {
							for (let i = 0; i < data.length; i++) {
								var htmlData = '<option value="' + data[i].taskActivityId + '">'
										+ data[i].taskActivity + '</option>'
								$('#taskActivity_id').append(htmlData);
							}
						}
					},
					error : function(error) {
						alert(error);
					}
				});
	}
	
	function today() {
		var d = new Date();
		var currDate = d.getDate();
		var currMonth = d.getMonth() + 1;
		var currYear = d.getFullYear();
		return currYear + "-"
				+ ((currMonth < 10) ? '0' + currMonth : currMonth) + "-"
				+ ((currDate < 10) ? '0' + currDate : currDate);
	}
	function currdateTime() {
		var d = new Date();
		var gethour = d.getHours() + 2;
		var getminute = d.getMinutes();
		var currDate = d.getDate();
		var currMonth = d.getMonth() + 1;
		var currYear = d.getFullYear();
		return currYear + "-"
				+ ((currMonth < 10) ? '0' + currMonth : currMonth) + "-"
				+ ((currDate < 10) ? '0' + currDate : currDate)+" "+ gethour+ ":"+ getminute;
	}
	function fileSizeValidation() {
		var filesId = document.getElementById("choosefile");
		const isFilePresent = filesId.files;
		if (isFilePresent.length != 0) {
			const fsize = filesId.files[0].size;
			console.log(fsize);
			const file = Math.round((fsize / 1024));
			if (file >= 10240) {
				$("#file_msgErrorId").show();
				filesId.focus();
				return false;
			} else {
				return true;
			}
		}
	}
	function loadDepartmentList() {
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
								$('#searchdepartment_id').append(htmlData);
							}
						}
					},
					error : function(error) {
						alert(error);

					}
				});
	}
</script>

<%@ include file="/include/footer.jsp"%>
