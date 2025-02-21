<%@page import="java.util.Iterator"%>
<%@page import="com.dakshabhi.pms.customers.dtos.CCustomerDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ include file="/include/header.jsp"%>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<link rel="stylesheet"
	href="https://cdn.datatables.net/1.12.1/css/jquery.dataTables.min.css">

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
						     <h6 class="font-weight-bolder mb-0 breadcrumb-item active">All Activity</h6>
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
						<div class="col-6" id="addbtbn" style="text-align: end"></div>
					</div>
				</nav>
			</div>
		</nav>
		<!--End Navbar -->
		<div class="container-fluid py-1">
			<div class="row">
				<div class="col-lg-12 col-sm-12">
					<div class="card">
						<div class="card-header p-0">
							<div class="row">
								<div class="col-12">
									<form class="multisteps-form__form m-0">
										<div class="row p-2">
											<div class="col-md-3 col-sm-6">
												<div class="input-group input-group-dynamic">
													<select class="form-control p-2" id="activityselect_filter_id"
														name="filterDate" required="required">													
														<option value="today">Today</option>
														<option value="yesterday">Yesterday</option>
														<option value="last_sevenDays" selected >Last 7 days</option>
														<option value="this_week">This week</option>
														<option value="last_week">Last week</option>
														<option value="this_month">This Month</option>
														<option value="last_month">Last Month</option>
														<option value="custom_dates">Custom Date</option>
													</select>
												</div>
											</div>
											<div class="col-md-3 col-sm-6" id="activitystartDateColid">
												<div class="input-group input-group-dynamic">
													<input class="multisteps-form__input form-control"
														type="date" placeholder="" name="filterStartDate"
														id="activityFilterStartDateid" />
												</div>
												<span id="errormessageforfromdateIdall" class="err-msg" 
													  style="display : none ; color: red;">Please select a date !</span>
											    <span
													id="errMsgDateCompareall" class="err-msg"
													style="display: none; color: red ">From date is greater than to
													date..!
											</span>
							                  <span id="errormessagefordiffDaysId" class="err-msg" 
							                        style="display: none; color: red">Date difference should be in 90 days..! 
							                  </span>
											
											</div>
											<div class="col-md-3 col-sm-6" id="activityendDateColid">
												<div class="input-group input-group-dynamic">
													<input class="multisteps-form__input form-control"
														type="date" placeholder="" name="filterEndDate"
														id="activityFilterEndDateid" />
												</div>
												<span id="errormessagefortodateIdall" class="err-msg"
												style="display: none; color: red">Please select a date!...</span>
						
											</div>
											<div class="col-md-3 col-sm-6 text-end">
												<button class="btn btn-icon btn-2 btn-dark" id="search"
													type="button" onclick="loadTaskMessages()">
													<span class="btn-inner--icon"><i
														class="material-icons">search</i></span>
												</button>
											</div>
										</div>
									</form>
								</div>
							</div>
						</div>
						<div class="card-body p-2 height-auto">
							<div>
								<div class="mb-1 " id="activityLogbodyId"></div>

							</div>
						</div>
					</div>
				</div>

			</div>
		</div>
		<!-- Modal For Add Time Log -->
		<div class="modal fade" id="taskTimeLog" tabindex="-1" role="dialog"
			aria-labelledby="taskTimeLogLabel" aria-hidden="true">
			<div class="modal-dialog  modal-lg modal-dialog-centered"
				role="document">
				<div class="modal-content model-content-css">
					<!--Header-->
					<div class="modal-header ">
						<h6 class="modal-title" id="newTaskLabel">Add Time</h6>
						<button type="button" class="btn-close text-dark"
							data-bs-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<!--Body-->
					<div class="modal-body">
						<div class="container-fluid">
							<div class="card">
								<div class="card-body">
									<div class="row">
										<div class="col-lg-12 col-md-8">
											<form name="taskform" method="post" id="tasklogformId">
												<input type="hidden" name="taskid" id="taskid_id" value="" />

												<div class="row">
													<div class="col-md-6">
														<div class="input-group input-group-static mb-4">
															<label>Date <sup><i class="fa fa-asterisk"></i></sup></label>
															<input type="date" class="form-control"
																name="task_log_date" id="task_log_date_id"
																required="required"> <span class="msgError"
																id="msgError_task_log_date_id"></span>
														</div>
													</div>

													<div class="col-md-6">
														<div class="input-group input-group-static mb-4">
															<label>Hours <sup><i class="fa fa-asterisk"></i></sup></label>
															<input type="number" class="form-control"
																id="task_log_hours_id" name="task_log_hours"
																required="required"> <span class="msgError"
																id="msgError_task_log_hours_id"></span>
														</div>
													</div>
												</div>
												<div class="row">
													<div class="col-md-12">
														<div class="input-group input-group-static mb-4">
															<label>Comments <sup><i
																	class="fa fa-asterisk"></i></sup></label>
															<textarea class="required form-control" rows="2"
																placeholder="Add details about task related activity.."
																spellcheck="false" name="task_comments"
																id="task_comments_id"></textarea>
															<span class="msgError" id="msgError_task_comments_id"></span>

														</div>
													</div>
												</div>

												<div class="row">
													<div class="col-md-4">
														<div class="input-group input-group-static mb-4">
															<label>Activity <sup><i
																	class="fa fa-asterisk"></i></sup></label> <select
																class="required form-control" id="taskActivity_id"
																name="taskActivity">
																<option value="">Select Activity</option>
															</select> <span class="msgError" id="msgError_taskActivity_id"></span>
														</div>
													</div>

												</div>
												<div class="d-flex justify-content-end mt-4">
													<button type="button" class="btn bg-gradient-info"
														id="tasklogid" onclick="savetasklog();">Save</button>
													<button type="button" class="btn btn-link  ml-auto"
														data-bs-dismiss="modal">Close</button>
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
		<!-- End Modal For Add Time Log -->

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
	src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>

<!-- Kanban scripts -->
<script src="assets/js/plugins/dragula/dragula.min.js"></script>
<script src="assets/js/plugins/jkanban/jkanban.js"></script>
<script src="assets/js/material-dashboard.js?v=3.0.6"></script>

<script type="text/javascript">
	$(function() {
		loadTaskMessages();
		$("#startDateColid").hide();
		$("#endDateColid").hide();
		$("#activitystartDateColid").hide();
		$("#activityendDateColid").hide(); 
		
		$("#activityselect_filter_id").change(function(){
			var custom_date = $("#activityselect_filter_id").val();
			if(custom_date == "custom_dates"){
				$("#activitystartDateColid").show();
				$("#activityendDateColid").show();
			}else{
					$("#activityFilterStartDateid").val('');
					$("#activityFilterEndDateid").val('');
					$("#activitystartDateColid").hide();
					$("#activityendDateColid").hide();
			}
		});
	});
	
	
	function loadTaskMessages(){
		
		$('#errormessageforfromdateIdall').hide();			
		$('#errormessagefortodateIdall').hide();
		$('#errMsgDateCompareall').hide();	
		$('#errormessagefordiffDaysId').hide();	
		
		if($('#activityselect_filter_id').val() == "custom_dates"){
			var from_date = $("#activityFilterStartDateid").val();
			var to_date = $("#activityFilterEndDateid").val();
			
			var date1 = new Date(from_date);
			var date2 = new Date(to_date);
			var diffTime = Math.abs(date2 - date1);
			var diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24)); 
			
			if (from_date == ""){
				$('#errormessageforfromdateIdall').show();		

			}
			else if (to_date == ""){
				$('#errormessageforfromdateIdall').hide();		
				$('#errormessagefortodateIdall').show();
			}
			else if (from_date > to_date ){
				$('#errormessageforfromdateIdall').hide();	
				$('#errormessagefortodateIdall').hide();
				
				$('#errMsgDateCompareall').show();		
			}
			else if (diffDays > 90){
				$('#errormessageforfromdateId').hide();			
				$('#errormessagefortodateId').hide();
				$('#errMsgDateCompare').hide();	
				
				$('#errormessagefordiffDaysId').show();	
				return;
			}
			else {
				$('#errormessageforfromdateIdall').hide();			
				$('#errormessagefortodateIdall').hide();
				$('#errMsgDateCompareall').hide();	
			}
		}
		
		$("#activityLogbodyId").empty();
		jQuery.ajax({
			type : "POST",
			url : "tasks",
			data : {
				actionType : 'mymessagelist', 
				searchBy : $("#activityselect_filter_id").val(),
				filterStartDateid : $("#activityFilterStartDateid").val(),
				filterEndDate : $("#activityFilterEndDateid").val()
			},
			async : true,
			success : function(data) {
				console.log(data); 
				console.log($('#userLogin_Id').val());
				var jsonData = eval(data);
				if (jsonData.length > 0) {
					for (var i = 0; i < jsonData.length; i++) {
						var rowdata = jsonData[i];
						newRowContent = getRowData(rowdata);
						$("#activityLogbodyId").append(newRowContent);
					}
				}else{
					var htmlMsg = "<center><b style='color:red'>No details Found....<b></center>";
					$("#activityLogbodyId").append(htmlMsg);
				}
				 
			},
			error : function(data) {
				alert("Error in process. Please try again.");
			}
		});
	}
	function getRowData(data) { 
		var userLoginid = $('#userLogin_Id').val();
		var rowData = "<div class=\"d-flex\">";
		rowData += "<div class=\"flex-shrink-0\">";
		rowData += "<img alt=\"Image placeholder\" class=\"avatar border-radius-profile\" src='uploads/avatar/"+ data.employee_profile_avatar +"'>";
		rowData += "</div>";
		rowData += "<div class=\"flex-grow-1  ms-2 my-auto\">";
		rowData += "<div class=\"col-md-12 col-sm-12 col-xs-12 d-flex\">";
		rowData += "<h6 class=\"text-sm mt-0 mb-0\">"+data.employeeName+" </h6>"; 
		rowData += "</div>";
		 
		rowData += "<span class=\"text-sm text-color-gray\">"+data.messageDateTime+"<span>";
		rowData += "<p class=\"text-sm text-info m-0 mb-1\"><a href='#' onclick='viewTask("+ data.taskId +");'>"+data.taskName+"</a><span>";
		rowData += "<p contentEditable ='false' class=\"text-sm text-color-black\" id=\"msgId_"+data.taskMessageId+"\">"+data.taskMessage+"</p>"; 
		rowData += "</div>";
		rowData += "</div>";
		return rowData;
	}
	
	function viewTask(taskid) {
		sessionStorage.removeItem("taskid");
		sessionStorage.setItem("taskid", taskid);
		window.location = 'taskview.jsp';
	}
	
	function loadActivity(){
		console.log('loading taskLog Activity.....'); 
		jQuery.ajax({
			type : "POST",
			url : "workspace",
			data : {
				actionType : 'getMyActivityLogList', 
				searchBy : $("#activityselect_filter_id").val(),
				filterStartDateid : $("#activityFilterStartDateid").val(),
				filterEndDate : $("#activityFilterEndDateid").val()
			},
			async : true,
			success : function(data) {
				console.log(data);
				var jsonData = eval(data);
				$("#activityLogbodyId").empty();
				if(jsonData == null){
					var htmlMsg = "<center><b style='color:red'>No Activity Found....<b></center>";
					$("#activityLogbodyId").append(htmlMsg);
				}
				else 
				 {
					var dateGroup = jsonData[0].groupDate.split(' ')[0];
						for (var i = 0; i < jsonData.length; i++) {
							if(i == 0 || dateGroup != jsonData[i].groupDate.split(' ')[0]){
								var headingDate = jsonData[i].groupDate.split(' ')[0];
								var dateRow = "<h6 class=\"groupDate \">"+moment(headingDate).format('DD MMM YYYY');+"</h6>";
								$("#activityLogbodyId").append(dateRow);
								dateGroup = jsonData[i].task_log_created_on.split(' ')[0];
							}
							var rowdata = jsonData[i];
							newRowContent = createActivityLogrow(rowdata);
							$("#activityLogbodyId").append(newRowContent);
						}
				}
			},
			error : function(data) {
				alert("Error in process. Please try again.");
			}
		}); 
	}
	function createActivityLogrow(data) { 
		var rowData = "<div class=\"d-flex\">";
		rowData += "<div class=\"flex-shrink-0\">";
		rowData += "<img alt=\"Image placeholder\" class=\"avatar rounded-circle\" src='uploads/avatar/"+ data.employee_profile_avatar +"'>";
		rowData += "</div>";
		rowData += "<div class=\"flex-grow-1 ms-3\">";
		rowData += "<h6 class=\"h6 mt-0 mb-0\">"+data.createdBy_employee_name+" </h6> <span class=\"text-sm text-color-gray\"> On: "+data.task_log_created_on+"<span>";
		rowData += "<p class=\"text-sm text-info linebreak mb-0\">"+ data.task_name +"</p>"; 
		rowData += "<p class=\"text-sm text-color-black linebreak\" style='white-space:break-spaces'>"  +"Time Log: "+ data.log_hours + " hours On "+ data.log_date + ". "+data.taskComments+"</p>"; 
		rowData += "</div>";
		rowData += "</div>";
		return rowData;
	}
</script>

<%@ include file="/include/footer.jsp"%>

