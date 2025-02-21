<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.dakshabhi.pms.customers.dtos.CCustomerDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page isELIgnored="false"%>

<%
String deviceId = request.getParameter("deviceid")==null?"": request.getParameter("deviceid");
String sessionId = session.getId();
System.out.println("deviceId: " + deviceId + " sessionId: " + sessionId);
if(!"".equals(deviceId)){
	session.removeAttribute("deviceToken");
	session.setAttribute("deviceToken", deviceId);
}

%>
<%@ include file="/include/header.jsp"%>
  
<style>
#sandcdivid {
	margin-top: -5px
}

.msgError {
	font-size: 0.875rem;
	display: none;
	color: red;
}

#description {
	border-bottom: 1px solid gray;
	border-radius: 0px;
}

#descriptionId {
	white-space: break-spaces;
}
.raphael-group-zeUFfcGZ .raphael-group-DYZwyRVQ{
	display: none;
}
svg > g[class^='raphael-group-'] g {
     fill: none !important;
     width: auto;
     height: auto;
  
}
svg > g[class^='raphael-group-']:nth-child(4) > g {
    cursor: default;
    pointer-events: none;
}
 #chartobject-1 > svg > g > [class*="legend"]{
    position: absolute;
    transform: translate(0%,15%) ;
    }
.fusioncharts-container{
    overflow-x: auto !important;
    -webkit-overflow-scrolling: touch !important;
} 
td:nth-child(2) {
  white-space: normal;
}

</style>

<link rel="stylesheet" href="https://cdn.datatables.net/1.12.1/css/jquery.dataTables.min.css">

<body class="g-sidenav-show  bg-gray-100 g-sidenav-hidden">
	<%@ include file="/include/leftnav.jsp"%>
	<!-- Main -->
	<main class="main-content position-relative max-height-vh-100 h-100 border-radius-lg ">
		<!-- Navbar -->
		<nav class="navbar navbar-main navbar-expand-lg position-sticky top-0 px-0 shadow-none border-radius-xl z-index-sticky" id="navbarBlur" data-scroll="true">
			<div class="container-fluid py-1 px-3" style="display: block !important">
				<nav aria-label="breadcrumb">

					<div class="row">
						<div class="col-lg-2 col-md-3 col-sm-12 col-xs-12">
							<h6 class="font-weight-bolder mb-0">
								<span>${userLogin.user_full_name}'s workspace</span>
							</h6>
							<div class="sidenav-toggler sidenav-toggler-inner">
								<a href="javascript:;" class="nav-link text-body p-0">
									<div class="sidenav-toggler-inner">
										<i class="sidenav-toggler-line"></i> <i class="sidenav-toggler-line"></i> <i class="sidenav-toggler-line"></i>
									</div>
								</a>
							</div>
						</div>
						<div class="col-lg-2 col-md-3 col-sm-12 col-xs-12">



							<div class="input-group input-group-static mb-2">
								<select class="required form-control p-2" id="projectfiler_id" name="projectfilter" onchange="loadMyTaskListByDate();">
									<option value="">All Projects</option>
								</select>
							</div>
						</div>

						<div class="col-lg-2 col-md-3 col-sm-12 col-xs-12">
							<div class="input-group input-group-static mb-2">
								<select class="required form-control p-2" name="" id="searchbyId" onchange="loadMyTaskListByDate();">
									<!-- 	<option value="">Search_By</option> -->
									<option value="last_3_months" <%=(equals("last_3_months") ? "selected='selected'" : "")%>>Last 3 Months</option>
									<option value="this_month" <%=(equals("this_month") ? "selected='selected'" : "")%>>This Month</option>
									<option value="this_week" <%=(equals("this_week") ? "selected='selected'" : "")%>>This Week</option>
									<option value="yesterday" <%=(equals("yesterday") ? "selected='selected'" : "")%>>Yesterday</option>
									<option value="today" <%=(equals("today") ? "selected='selected'" : "")%>>Today</option>
									<option value="custom_dates" <%=(equals("custom_dates") ? "selected='selected'" : "")%>>Custom Dates</option>

								</select>

							</div>
						</div>


						<span id="errormessageforsearch_By" style="display: none; color: red">Please select to search !</span>

						<div class="col-md-2" id="activitystartDateColid">
							<div class="input-group input-group-dynamic">
								<input class="multisteps-form__input form-control" type="date" placeholder="" name="filterStartDate" id="activityFilterStartDateid" />
							</div>
						<span id="errormessageforfromdateId" class="err-msg" style="display: none; color: red;">Please select a date..!</span> 
						<span id="errMsgDateCompare" class="err-msg" style="display: none; color: red">From date is greater than to date..! </span>
					   <span id="errormessagefordiffDaysId" class="err-msg" style="display: none; color: red">Date difference should be in 90 days..! </span>
					
						</div>

						
						<div class="col-md-2" id="activityendDateColid">
							<div class="input-group input-group-dynamic">
								<input class="multisteps-form__input form-control" type="date" placeholder="" name="filterEndDate" id="activityFilterEndDateid" />
							</div>
							<span id="errormessagefortodateId" class="err-msg" style="display: none; color: red">Please select a date..!</span>
						</div>
						<div class="col-md-1 rightalign">
							<button class="btn btn-icon btn-2 btn-dark" id="searchId" type="button" onclick="loadMyTaskListByDate('search');">
								<span class="btn-inner--icon"><i class="material-icons">search</i></span>
							</button>
						</div>

						<div class="col-md-0 col-lg-1 col-sm-12  rightalign">
					
						<a href="kanban.jsp" class="rightalign col-sm-6 col-md-6 col-lg-6">
					    <i class="material-icons fixed-plugin-button-nav cursor-pointer text-info" 
					       data-bs-toggle="tooltip" 
					       data-bs-placement="bottom" 
					       data-bs-original-title="kanban board">dashboard</i>
					</a>
						<i class="fa-duotone fa-chart-kanban"></i>		
						</a>
					
						<a href="alllog.jsp" class=" rightalign col-sm-6 col-md-6 col-lg-6">
						<i class="material-icons fixed-plugin-button-nav cursor-pointer text-info" data-bs-toggle="tooltip"  data-bs-placement="bottom" data-bs-original-title="Messages" > forum </i>
									</a>
						
						<a href="activity.jsp" class=" rightalign col-sm-6 col-md-6 col-lg-6">
						<i class="material-icons position-relative text-lg pe-2 text-info" data-bs-toggle="tooltip"  data-bs-placement="bottom" data-bs-original-title="Activities">splitscreen</i>
						</a>
					</div>
				</div>
			</nav>
		</div>
	</nav>


		<!--End Navbar -->
		<div class="container-fluid py-1">
			<div class="row">
				<div class="col-lg-6 col-sm-12 mt-3">
					<div class="card">
						<div class="card-header p-0">
							<div class="row">
								<div class="col-7">
									<h6 class="mb-0 p-2">Summary by status</h6>
								</div>
								<div class="col-5 text-end p-0">
									<button data-bs-toggle="modal" data-bs-target="#newTask" onclick="showNewTaskModel()" class="btn btn-link text-info  mb-0 border-0" data-bs-toggle="tooltip"
										data-bs-placement="bottom" data-bs-original-title="New Task">
										<i class="material-icons text-lg">add_box</i> Task
									</button>
								</div>
							</div>
						</div>
						<div class="card-body p-2 height-auto">
						<div class="row">
						
							<div class="table-responsive col-lg-4 col-md-4 col-sm-12">
								<table class="table table-flush" id="mytasktableId">
									<thead class="thead-light text-sm">
										<tr>
											<th>Status</th>
											<th><a href="#" class="text-md btn-link font-weight-bold" onclick="loadtasklistbystatus('')" data-bs-toggle="tooltip" data-bs-placement="bottom"
												data-bs-original-title="View All">All</a></th>
										</tr>
									</thead>
									<tbody id="mysummarybodyId">
										<tr>
											<td class="text-center" colspan="2"><div class="spinner-border"></div></td>
										</tr>
									</tbody>
								</table>
								 
							</div>
				<div  class="table-responsive col-lg-8 col-md-8 col-sm-12 text-center"><strong>Task Status Summary</strong>
			       <div  class="table-responsive text-center" id="taskStatuschartId">
			       </div>
			   </div>	
							
						</div>
						</div>
					</div>  
				</div>
				
				<div class="col-lg-6 col-sm-12 mt-3">
				<div class="card">
						<div class="card-header p-0">
							<div class="row">
								<div class="col-12">
									<h6 class="mb-0 p-2">Summary by priority</h6>
								</div>

							</div>
						</div>
						<div class="card-body p-2 height-auto">
						<div class="row">
							<div class="table-responsive col-lg-4 col-md-4 col-sm-12">
								<table class="table table-flush" id="mytasktableId">
									<thead class="thead-light text-sm">
										<tr>
											<th>Priority</th>
											<th><a href="#" class="text-md btn-link font-weight-bold" onclick="loadtasklistbypriority('')" data-bs-toggle="tooltip" data-bs-placement="bottom"
												data-bs-original-title="View All">All</a></th>
										</tr>
									</thead>
									<tbody id="mysummarybyprioritybodyId">
										<tr>
											<td class="text-center" colspan="2"><div class="spinner-border"></div></td>
										</tr>
									</tbody>
								</table>
							</div>
							<div  class="table-responsive col-lg-8 col-md-8 col-sm-12 text-center"><strong>Task Priority Summary</strong>
					<div class="table-responsive text-center" id="taskPrioritychartId"></div></div>
							
						  </div>	
						</div>
					</div>
				</div>
			</div>	
		</div>
				<div class="col-lg-12 col-sm-12">
					<div class="card mt-3">
						<div class="card-header p-0">
							<div class="row">
								<div class="col-md-6 col-sm-6 col-xs-6">
									<h6 class="mb-0 p-2">
										Tasks associate with me
										<spam id="mytaskcount" class="badge bg-gradient-info">0</spam>
									</h6>
								</div>
								<div class="col-md-3 col-sm-3 col-xs-3">
									<select class="form-control mb-0 p-2" id="filtertaskstatusid" name="status" onchange="loadtasklistbystatus(this.value);">
										<option value="">Filter by status</option>
									</select>
								</div>
								<div class="col-md-3 col-sm-3 col-xs-3">
									<select class="form-control mb-0 p-2" id="filtertaskpriorityid" name="priority" onchange="loadtasklistbypriority(this.value);">
										<option value="">Filter by priority</option>
									</select>
								</div>
							</div>
						</div>
						<input type="hidden" id="cPageNo" value="1" />
						<div class="card-body p-2 height-auto">
							<div class="table-responsive d-none d-md-block d-sm-none d-lg-block d-xl-block">
								<table class="table table-flush" id="mytasktableId">
									<thead class="thead-light text-sm">
										<tr>
											<th></th>
											<th>Task</th>
											<th>Assignee</th>
											<th>Project</th>
											<th>Start Date</th>
											<th>Due Date</th>
											<th>Status</th>
											<th>Priority</th>
										</tr>
									</thead>
									<tbody id="mytasktbodyId">
										<tr>
											<td class="text-center" colspan="6"><div class="spinner-border"></div></td>
										</tr>

									</tbody>

								</table>
								<div class="text-center">
									<span class="msgError" id="showMsgId"></span>
								</div>
                              <div class="text-center">
								<a  id="loadmoreid" href="#" onclick="loadMoreTaskList()"> <strong>Load More...</strong></a>
                              </div>
							</div>

							<div class="row  d-sm-block d-md-none d-lg-none d-xl-none" id="mytasktgridbodyId"></div>

						</div>
					</div>
				

			</div>
		
		<!-- Modal For Add Time Log -->
		<div class="modal fade" id="taskTimeLog" tabindex="-1" role="dialog" aria-labelledby="taskTimeLogLabel" aria-hidden="true">
			<div class="modal-dialog  modal-lg modal-dialog-centered" role="document">
				<div class="modal-content model-content-css">
					<!--Header-->
					<div class="modal-header ">
						<h6 class="modal-title">Add Time</h6>
						<button type="button" class="btn-close text-dark" data-bs-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<!--Body-->
					<div class="modal-body">
						<div class="container-fluid">
							<div class="card">
								<div class="card-body">
									<div class="row">
										<div class="col-lg-12 col-md-12">
											<form name="taskform" id="tasklogformId">
												<input type="hidden" name="taskId" id="taskid_id" value="" /> <input type="hidden" name="actionType" id="actionType" value="" />
												<div class="row">
													<div class="col-md-6">
														<div class="input-group input-group-static mb-4">
															<label>Date <sup><i class="fa fa-asterisk"></i></sup></label> <input type="date" class="form-control" name="task_log_date" id="task_log_date_id"
																required="required"> <span class="msgError" id="msgError_task_log_date_id"></span>
														</div>
													</div>

													<div class="col-md-6">
														<div class="input-group input-group-static mb-4">
															<label>Hours <sup><i class="fa fa-asterisk"></i></sup></label> <input type="number" class="form-control" id="task_log_hours_id" name="task_log_hours"
																required="required"> <span class="msgError" id="msgError_task_log_hours_id"></span>
														</div>
													</div>
												</div>
												<div class="row">
													<div class="col-md-12">
														<div class="input-group input-group-static mb-4">
															<label>Comments <sup><i class="fa fa-asterisk"></i></sup></label>
															<textarea class="required form-control" rows="2" placeholder="Add details about task related activity.." spellcheck="false" name="task_comments"
																id="task_comments_id"></textarea>
															<span class="msgError" id="msgError_task_comments_id"></span>

														</div>
													</div>
												</div>

												<div class="row">
													<div class="col-md-4">
														<div class="input-group input-group-static mb-4">
															<label>Activity <sup><i class="fa fa-asterisk"></i></sup></label> <select class="required form-control p-2" id="taskActivity_id" name="taskActivity">

															</select> <span class="msgError" id="msgError_taskActivity_id"></span>
														</div>
													</div>

												</div>
											</form>
											<form enctype="multipart/form-data" method="post" id="updateAttachForm_Id" onsubmit="return validateServiceDetails('updateAttachForm_Id');">
												<input type="hidden" name="task_id" id="taskidforfile_id" value="" />
												<div class="row" id="attachFormId">
													<div class="col-12 position-relative">
														<div class="card">
															<div class="card-body">
																<div class="row">
																	<div class="row" id="uploadbtn_div">
																		<div class="col-md-2">
																			<label>Upload File</label>
																		</div>
																		<div class="col-md-2" id="btnFile">
																			<input type="button" id="uploadbtn_Id" class="btn bg-gradient-info mt-2" value="Upload File" onclick="showFileInput();">
																		</div>
																	</div>
																	<div class="row my-2" id="logfilerow_id" hidden>

																		<div class="col-md-6">
																			<input type="file" class="form-control form-control-sm" id="updateAttachment_id" name="updateAttachment"
																				accept=".csv, application/vnd.ms-excel,text/plain, application/pdf, image/*"> <span id="logfile_msgErrorId" class="msgError">File too Big,
																				please select a file less than 10 Mb</span>
																		</div>
																		<div class="col-md-2">
																			<input type="button" id="cancelbtn_id" class="btn btn-link ml-auto" value="Cancel" onclick="removeFileInput();">
																		</div>
																		<div class="p-3 pt-2" id="logfileTableData" hidden>
																			<div class="mx-2">
																				<table class="table table-flush text-sm">
																					<thead>
																						<tr>
																							<th>Document</th>
																							<th></th>
																						</tr>
																					</thead>
																					<tbody id="logFileTbodyid">
																						<tr class="row">
																							<td class="col-md-6 "><input type="text" id="logFilechossedid" class="form-control"></td>
																							<td class="col-md-6 "><textarea type="textarea" id="logFileDescriptionid" class="required form-control" rows="2" cols="50" name="descriptionforfile"
																									onfocus="focused(this)" placeholder="Description" onfocusout="defocused(this)"></textarea><span class="msgError" id="msgError_logFileDescriptionid"></span></td>
																						</tr>
																					</tbody>
																				</table>
																			</div>
																			<div>
																				<input type="button" class="btn bg-gradient-dark btn-sm float-end mt-2 mx-3 rounded-1 mb-0" id="logFileSavebtn_id" value="save">
																			</div>
																		</div>
																	</div>
																	<div class="row" id="logFilesListId" hidden>
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
																				<tbody id="logFiletBody">
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
											<div class="row justify-content-md-end mt-4 text-end">
												<div class="justify-content-end px-1">
													<button type="button" class="btn bg-gradient-info" onclick=" savetasklog();" id="tasklogid">Save</button>

													<button type="button" class="btn btn-link  ml-auto" data-bs-dismiss="modal">Close</button>
												</div>
											</div>
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

		<!-- Modal For Add New Task -->
		<div class="modal fade" id="newTask" tabindex="-1" role="dialog" aria-labelledby="newTaskLabel" aria-hidden="true">
			<div class="modal-dialog  modal-xl modal-dialog-centered" role="document">
				<div class="modal-content model-content-css">
					<!--Header-->
					<div class="modal-header p-2">
						<h5 class="modal-title" id="newTaskLabel">New Task</h5>
						<button type="button" class="btn-close text-dark" data-bs-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<!--Body-->
					<div class="modal-body p-0">
						<div class="container-fluid">
							<div class="card">
								<div class="card-body">
									<div class="row">
										<div class="col-lg-12 col-md-12">
											<form name="taskform" method="post" id="taskformId" onsubmit="">
												<input type="hidden" name="actionType" id="action_type_id" value="createtask" /> <input type="hidden" name="taskid" id="taskid_id" value="" />
												<div class="row">
													<div class="col-md-6 col-sm-12">
														<div class="input-group input-group-static mb-4">
															<label>Project <sup><i class="fa fa-asterisk"></i></sup></label> <select class="required form-control p-2" id="project_id" name="project"
																onchange="loadAssignee(this.value)">
																<option value="">Select Project</option>
															</select> <span class="msgError" id="msgError_project_id"></span>
														</div>
													</div>
												
													
													<div class="col-md-6 col-sm-12">
													<div class="input-group input-group-static mb-4">
														<label>Task Name <sup><i class="fa fa-asterisk"></i></sup></label> <input type="text" class="required form-control" name="task_name" id="task_name_id">
														<span class="msgError" id="msgError_task_name_id"></span>
													</div>
												</div>
												
												
												</div>
												<div class="row">
												<div class="col-md-12 col-sm-12">
												<div class="input-group input-group-static mb-4">
													<label>Task Description </label>
													<textarea class=" form-control" rows="2" placeholder="This is how others will learn about the task, so make it good!" spellcheck="false"
														name="task_description" id="task_description_id"></textarea>
													<span class="msgError" id="msgError_task_description_id"></span>

												</div>
											</div>
												
												
												</div>
												
												
												
                                                	<div class="row">
												<div class="col-md-3 col-sm-12">
												<div class="input-group input-group-static mb-4">
													<label>Type <sup><i class="fa fa-asterisk"></i></sup></label> <select class="required form-control p-2" id="taskType_id" name="taskType">
													</select> <span class="msgError" id="msgError_taskType_id"></span>
												</div>
											</div>
													<div class="col-md-3 col-sm-12">
														<div class="input-group input-group-static mb-4">
															<label>Priority <sup><i class="fa fa-asterisk"></i></sup></label> <select class="required form-control p-2" id="taskPriority_id" name="taskPriority">
															</select> <span class="msgError" id="msgError_taskPriority_id"></span>
														</div>
													</div>
													<div class="col-md-3 col-sm-12">
														<div class="input-group input-group-static mb-4">
															<label>Status <sup><i class="fa fa-asterisk"></i></sup></label> <select class="required form-control p-2" id="taskStatus_id" name="taskStatus">
															</select> <span class="msgError" id="msgError_taskStatus_id"></span>
														</div>
													</div>
													<div class="col-md-3 col-sm-12">
														<div class="input-group input-group-static mb-4">
															<label>Assignee<sup><i class="fa fa-asterisk"></i></sup></label> <select class="required form-control p-2" id="assignee_id" name="assignee">
																																<option value="">Select Assignee</option>
															</select> <span class="msgError" id="msgError_assignee_id"></span>

														</div>
													</div>
												</div>

												<div class="row">
													<div class="col-md-3 col-sm-12">
														<div class="input-group input-group-static mb-4">
															<label>Start Date</label> <input type="date" class="form-control" name="start_date" id="start_date_id" required="required">
														</div>
													</div>

													<div class="col-md-3 col-sm-12">
														<div class="input-group input-group-static mb-4">
															<label>Due Date</label> <input type="datetime-local" class="form-control" name="due_date" id="due_date_id">
														</div>
													</div>

													<div class="col-md-3 col-sm-12">
														<div class="input-group input-group-static mb-4">
															<label>Estimated time (Hours)</label> <input type="number" class="form-control" id="estimeted_time_id" name="estimeted_time">
														</div>
													</div>
													<div class="col-md-3 col-sm-12">
														<div class="input-group input-group-static mb-4">
															<label>% Done</label> <select class="form-control p-2" id="done_value_id" name="done_value" required="required">
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
																	<select class="form-control p-2" id="searchdepartment_id" name="departmentfilter" onchange="loadFollowers($('#project_id').val(),this.value);">
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
												<div class="row justify-content-md-end mt-4">
													<div class="col-md-auto text-end px-1 d-none d-lg-block">
														<button type="button" class="btn bg-gradient-info" id="save&createid" onclick="cearenewtask();" onblur="showNewTaskModalAgain();">Save &amp Create</button>
													</div>
													<div class="col-md-auto text-end px-1">
														<button type="button" class="btn bg-gradient-info" id="taskactionid" onclick="cearenewtask();">Save</button>
														<button type="button" class="btn btn-link ml-auto" data-bs-dismiss="modal">Close</button>
													</div>
												</div>
												<div id="sandcdivid" class="col-md-auto text-end d-block d-lg-none">
													<button type="button" class="btn bg-gradient-info" id="save&createid" onclick="cearenewtask();" onblur="showNewTaskModalAgain();">Save &amp Create</button>

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

</body>
<!--   Core JS Files   -->
<script src="assets/js/core/popper.min.js"></script>
<script src="assets/js/core/bootstrap.min.js"></script>
<script src="assets/js/plugins/perfect-scrollbar.min.js"></script>
<script src="assets/js/plugins/smooth-scrollbar.min.js"></script>
<script src="assets/js/plugins/datatables.js"></script>
<script src="assets/js/plugins/choices.min.js"></script>
<script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>

<!-- Kanban scripts -->
<script src="assets/js/plugins/dragula/dragula.min.js"></script>
<script src="assets/js/plugins/jkanban/jkanban.js"></script>
<script src="assets/js/material-dashboard.js?v=3.0.6"></script>
<!-- <script src="assets/js/plugins/chartjs.min.js"></script> -->

<!--   Include the fusioncharts core library for piecharts -->
    <script type="text/javascript" src="https://cdn.fusioncharts.com/fusioncharts/latest/fusioncharts.js"></script>
    <!--   Include the fusion theme -->
    <script type="text/javascript" src="https://cdn.fusioncharts.com/fusioncharts/latest/themes/fusioncharts.theme.fusion.js"></script>
<script type="text/javascript">
	var totalListCount = 0;
	var prevRows;
	var array = [];
	
	
	 $("#activityFilterStartDateid").hide();
	 $("#activityFilterEndDateid").hide();
	 $("#searchId").hide();
	 
	$(function() {
		checkSession();
		loadMyTaskListByDate();
		loadTaskStatusList();
		loadTaskPriorityList();
		loadTaskTypeList();
		loadTaskActivityList();
		loadProjectList();
		loadDepartmentList();
		$($('#taskStatuschartId').children().children().children()[3]).attr('display', 'none');	  

	});
	function showFileInput() {
		$("#uploadbtn_div").prop("hidden", true);
		$("#logfilerow_id").prop("hidden", false);
		$("#cancelbtn_id").prop("hidden", false);
		$("#updateAttachment_id").prop("hidden", false);
	}

	$("#updateAttachment_id").change(function(e) {
		$("#logfile_msgErrorId").css("display", "none");
		if( fileSizeValidation(updateAttachment_id)){
			$("#logfileTableData").prop("hidden", false);
			let val1 = e.target.files[0].name;
			$("#logFilechossedid").val(val1);
			$("#file1").val(val1);
			$("#filediv1").prop("hidden", false);
			$("#filename").prop("hidden", false);
		}

	})
		$("#logFileSavebtn_id").click(function() {
		if (validateServiceDetails('updateAttachment_id')) {
			$("#uploadbtn_div").prop("hidden", false);
			$("#logfileTableData").prop("hidden", true);
// 			$("#btnFile1").prop("hidden", false);
			$("#updateAttachment_id").prop("hidden", true);
			$("#cancelbtn_id").prop("hidden", true);
			$("#logfilerow_id").prop("hidden", true);
			uploadLogFile();
		}
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
	function removeFileInput() {
		$("#updateAttachment_id").prop("hidden", true);
		$("#updateAttachment_id").val("");
		$("#uploadbtn_div").prop("hidden", false);
		$("#cancelbtn_id").prop("hidden", true);
		$("#logfileTableData").prop("hidden", true);
		$("#logFileDescriptionid").val("");
		$("#msgError_logFileDescriptionid").css("display", "none");
		$("#logfile_msgErrorId").css("display", "none");
	}
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

	
	
	/***** function use for default filter *****/ 	
	function loadMyTaskListByDate(search) {
		$('#errormessageforfromdateId').hide();			
		$('#errormessagefortodateId').hide();
		$('#errMsgDateCompare').hide();	
		$('#errormessagefordiffDaysId').hide();	
		
		if(search != undefined){
			var from_date = $("#activityFilterStartDateid").val();
			var to_date = $("#activityFilterEndDateid").val();

			
			var startdate = new Date(from_date);
			var endDate = new Date(to_date);
			var diffTime = Math.abs(endDate - startdate);
			var diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24)); 
		
			if (from_date == ""){
				$('#errormessageforfromdateId').show();						
			}
			else if (to_date == ""){
				$('#errormessageforfromdateId').hide();		
				$('#errormessagefortodateId').show();
			}
			else if (from_date > to_date ){
				$('#errormessageforfromdateId').hide();	
				$('#errormessagefortodateId').hide();
				
				$('#errMsgDateCompare').show();		
			}
			else if (diffDays > 90){
				$('#errormessageforfromdateId').hide();			
				$('#errormessagefortodateId').hide();
				$('#errMsgDateCompare').hide();	
				
				$('#errormessagefordiffDaysId').show();	
				return;
			}
			else {
				$('#errormessageforfromdateId').hide();			
				$('#errormessagefortodateId').hide();
				$('#errMsgDateCompare').hide();	
				$('#errormessagefordiffDaysId').hide();	
			}
		}
	
		if ($('#searchbyId').val() != 'custom_dates'){
			
			$("#activityFilterStartDateid").val("");
			$("#activityFilterEndDateid").val("");
			
	 		$("#activityFilterStartDateid").hide();
	 		$("#activityFilterEndDateid").hide();
	 		$("#searchId").hide();
		}
	
		$('#cPageNo').val(1);
		if ($('#projectfiler_id').val() == "") {
			loadSummaryOnReady();
			loadSummaryByPriorityOnReady();
		} else {
			loadSummary();
			loadSummaryByPriority();
		}

		$("#showMsgId").hide();
		$('#mytasktbodyId').empty();
		$('#mytasktgridbodyId').empty();
		$('#mytaskcount').empty();
		
		if($("#activityFilterStartDateid").val()==''){
			if($('#searchbyId').val() == "custom_dates"){
			 	$("#activityFilterStartDateid").show();
			 	$("#activityFilterEndDateid").show();
			 	 $("#searchId").show();
 			 	 $("#loadmoreid").hide();
			 	return;
			}
		else {
				$("#activityFilterStartDateid").val("");
			    $("#activityFilterEndDateid").val("");				
				$("#activityFilterStartDateid").hide();
				$("#activityFilterEndDateid").hide();
				$("#searchId").hide();
		    }				
		}
	 else{
			 $("#loadmoreid").show();
		}
		jQuery.ajax({
			type : "POST",
			url : "workspace",
			data : {
				actionType : 'mytasklist',
				statusid : $('#filtertaskstatusid').val(),
				priorityid : $('#filtertaskpriorityid').val(),
				projectid : $('#projectfiler_id').val(),
				searchBy : $('#searchbyId').val(),
				from_date : from_date,
				to_date : to_date,
				startIndex : 0,
				endIndex : 10
			},
			async : true,
			success : function(data) {
				$('#loadmoreid').show();
				if(data == "" || data == null ){
					$('#mysummarybodyId').empty();
					$('#mysummarybyprioritybodyId').empty();
				}
				console.log("list", data);
				var jsonData = eval(data);
				if (jsonData.length > 0) {
					totalListCount = jsonData[0].count;
					for (var i = 0; i < jsonData.length; i++) {
						var rowdata = jsonData[i];
						var newtaskrow = createtaskrow(rowdata);
						$('#mytasktbodyId').append(newtaskrow);

						var newtaskgridrow = createtaskgridrow(rowdata);
						$('#mytasktgridbodyId').append(newtaskgridrow);
					}
				}
				if(totalListCount <= 10){
					$('#loadmoreid').hide();
				}
			 prevRows = 10;
			},
			error : function(data) {
				alert("Error in process. Please try again.");
			}
		});	
	}
	
/*** function use for loadmore tasklist ***/

	function loadMoreTaskList() {
		if ($('#projectfiler_id').val() == "") {
			loadSummaryOnReady();
			loadSummaryByPriorityOnReady();
		} else {
			loadSummary();
			loadSummaryByPriority();
		}

		if ($('#cPageNo').val() != '') {
			var cpage = parseInt($('#cPageNo').val()) + 1;
			$('#cPageNo').val(cpage)
			jQuery.ajax({
				type : "POST",
				url : "workspace",
				data : {
					actionType : 'mytasklist',
					statusid : $('#filtertaskstatusid').val(),
					priorityid : $('#filtertaskpriorityid').val(),
					projectid : $('#projectfiler_id').val(),
					searchBy : $('#searchbyId').val(),
					from_date : $("#activityFilterStartDateid").val(),
					to_date : $("#activityFilterEndDateid").val(),
					startIndex : 0,
					endIndex : 10,
					pageNo : cpage
				},
				async : true,
				success : function(data) {

					console.log("loadmorelist", data)
					var jsonData = eval(data);
				
					if (jsonData.length > 0) {
						prevRows = prevRows + jsonData.length;
						for (var i = 0; i < jsonData.length; i++) {
							var rowdata = jsonData[i];
							var newtaskrow = createtaskrow(rowdata);
							$('#mytasktbodyId').append(newtaskrow);

							var newtaskgridrow = createtaskgridrow(rowdata);
							$('#mytasktgridbodyId').append(newtaskgridrow);
						}
					}
					if(totalListCount == prevRows){
						$('#loadmoreid').hide();
					}

				},
				error : function(data) {
					alert("Error in process. Please try again.");
				}
			});
		}
	}

function loadSummaryOnReady() {
		
		$('#mysummarybodyId').empty();
		jQuery.ajax({
			type : "POST",
			url : "workspace",
			data : {
				projectfiler_id : $('#projectfiler_id').val(),
				search_by : $('#searchbyId').val(),
				actionType : 'tasksummaryonready',
				from_date : $("#activityFilterStartDateid").val(),
				to_date : $("#activityFilterEndDateid").val()

			},
			async : true,
			success : function(data) {
				var jsonData = eval(data);
				var taskassociate = 0;
				array = [];
				if (jsonData.length > 0) {
					for (var i = 0; i < jsonData.length; i++) {
						var rowdata = jsonData[i];
						taskassociate += rowdata.taskCount
						var newsummaryrow = createsummaryrow(rowdata);
						$('#mysummarybodyId').append(newsummaryrow);
						
				var StatusColours = createStatusElementColors(rowdata.taskStatus, rowdata.taskStatusType);

				array.push({ value: rowdata.taskCount , label: rowdata.taskStatus ,color:StatusColours },);
					}
				}
				$('#mytaskcount').empty();
				$('#mytaskcount').append(taskassociate);
				loadPiechartSummary('taskStatuschartId');
				
			},
			error : function(data) {
				alert("Error in process. Please try again.");
			}
		});
	}

	function loadSummary() {
		$('#mysummarybodyId').empty();
		jQuery.ajax({
			type : "POST",
			url : "workspace",
			data : {
				actionType : 'tasksummary',
				projectfiler_id : $('#projectfiler_id').val(),
				search_by : $('#searchbyId').val(),
				projectID : $('#projectfiler_id').val(),
				from_date : $("#activityFilterStartDateid").val(),
				to_date : $("#activityFilterEndDateid").val()

			},
			async : true,
			success : function(data) {
				var jsonData = eval(data);
				var taskassociate = 0;
				array = [];
				if (jsonData.length > 0) {
					for (var i = 0; i < jsonData.length; i++) {
						var rowdata = jsonData[i];
						taskassociate += rowdata.taskCount
						var newsummaryrow = createsummaryrow(rowdata);
						$('#mysummarybodyId').append(newsummaryrow);
					
				var	StatusColours = createStatusElementColors(rowdata.taskStatus, rowdata.taskStatusType);
					
				array.push({ value: rowdata.taskCount , label: rowdata.taskStatus ,color:StatusColours },);
					}
				}
				$('#mytaskcount').empty();
				$('#mytaskcount').append(taskassociate);
				loadPiechartSummary('taskStatuschartId');
			},
			error : function(data) {
				alert("Error in process. Please try again.");
			}
		});
	}
	
	/**** This Function Use for Pie-chart colors ***/	
	function createStatusElementColors(status, type) {
		switch (type) {
			case 1:	
				return '#f44335';
				break;
			case 2:
				return '#03a9f4';
				break;
			case 3:
				return '#03a9f4';
				break;
			case 4:
				return '#7b809a';
				break;
			case 5:
				return '#4caf50';
				break;
			case 6:
				return '#e91e63';
				break;
			case 7:
				return '#fb8c00';
				break;
			default:
				return '#7b809a';
		}
	}
	

	function loadSummaryByPriorityOnReady() {
		
		$('#mysummarybyprioritybodyId').empty();
		jQuery.ajax({
			type : "POST",
			url : "workspace",
			data : {
				projectfiler_id : $('#projectfiler_id').val(),
				search_by : $('#searchbyId').val(),
				actionType : 'tasksummarybypriorityonready',
				from_date : $("#activityFilterStartDateid").val(),
				to_date : $("#activityFilterEndDateid").val()
			},
			async : true,
			success : function(data) {
				var jsonData = eval(data);
				array = [];
       
				if (jsonData.length > 0) {
					for (var i = 0; i < jsonData.length; i++) {
						var rowdata = jsonData[i];
						var newsummaryrow = createprioritysummaryrow(rowdata);
						$('#mysummarybyprioritybodyId').append(newsummaryrow);
						
						var	StatusColours = createPriorityElementColors(rowdata.taskPriority, rowdata.taskPriorityType);

						array.push({ value: rowdata.taskCount , label: rowdata.taskPriority, color:StatusColours },);
					}
				}
				loadPiechartSummary('taskPrioritychartId');
			},
			error : function(data) {
				alert("Error in process. Please try again.");
			}
		});
	}

	function loadSummaryByPriority() {
		$('#mysummarybyprioritybodyId').empty();
		jQuery.ajax({
			type : "POST",
			url : "workspace",
			data : {          
				actionType : 'tasksummarybypriority',
				projectfiler_id : $('#projectfiler_id').val(),
				search_by : $('#searchbyId').val(),
				projectID : $('#projectfiler_id').val(),
				from_date : $("#activityFilterStartDateid").val(),
				to_date : $("#activityFilterEndDateid").val()
			},
			async : true,
			success : function(data) {
				var jsonData = eval(data);
				if (jsonData.length > 0) {
					array = [];
					for (var i = 0; i < jsonData.length; i++) {
						var rowdata = jsonData[i];
						var newsummaryrow = createprioritysummaryrow(rowdata);
						$('#mysummarybyprioritybodyId').append(newsummaryrow);
						
					var	StatusColours = createPriorityElementColors(rowdata.taskPriority, rowdata.taskPriorityType);

					array.push({ value: rowdata.taskCount , label: rowdata.taskPriority , color:StatusColours},);
					}
				}
				loadPiechartSummary('taskPrioritychartId');
			},
			error : function(data) {
				alert("Error in process. Please try again.");
			}
		});
	}

	/**** This Function Use for Pie-chart colors ***/	
	function createPriorityElementColors(status, type) {
		switch (type) {
			case 1:	
				return '#7b809a';
				break;
			case 2:
				return '#03a9f4';
				break;
			case 3:
				return '#fb8c00';
				break;
			case 4:
				return '#e91e63';
				break;
			case 5:
				return '#f44335';
				break;
			case 6:
				return '#EF5350 ';
				break;
			default:
				return '#7b809a';
		}
	}

	function loadCreatedTaskList() {
		$('#createdtasktbodyId').empty();
		jQuery.ajax({
			type : "POST",
			url : "workspace",
			data : {
				actionType : 'createdtasklist'
			},
			async : true,
			success : function(data) {
				var jsonData = eval(data);
				$('#createdtaskcount').text(jsonData.length);
				if (jsonData.length > 0) {
					for (var i = 0; i < jsonData.length; i++) {
						var rowdata = jsonData[i];
						var newtaskrow = createtaskrow(rowdata);
						$('#createdtasktbodyId').append(newtaskrow);
					}
				}
			},
			error : function(data) {
				alert("Error in process. Please try again.");
			}
		});
	}

	function createsummaryrow(data) {
		var rowData = "<tr class='text-sm'>";
		rowData += "<td>"
				+ createStatusElement(parseInt(data.taskStatusID),
						data.taskStatus, data.taskStatusType) + "</td>";
		rowData += "<td> <a href='#' class='text-md font-weight-bold' onclick='loadtasklistbystatus("
				+ data.taskStatusID + ")'>" + data.taskCount + "</a></td>";

		rowData += "<tr/>";
		return rowData;
	}

	function createprioritysummaryrow(data) {
		var rowData = "<tr class='text-sm'>";
		rowData += "<td>"
				+ createPriorityElement(parseInt(data.taskPriorityId),
						data.taskPriority, data.taskPriorityType) + "</td>";
		rowData += "<td> <a href='#' class='text-md font-weight-bold' onclick='loadtasklistbypriority("
				+ data.taskPriorityId + ")'>" + data.taskCount + "</a></td>";

		rowData += "<tr/>";
		return rowData;
	}
	function loadtasklistbystatus(statusid) {
		$('#filtertaskstatusid').val(statusid);
		$('#filtertaskpriorityid').val('');
// 		loadMyTaskList();
		loadMyTaskListByDate();
	}

	function loadtasklistbypriority(priorityid) {
		$('#filtertaskstatusid').val('');
		$('#filtertaskpriorityid').val(priorityid);
// 		loadMyTaskList();
		loadMyTaskListByDate();
	}
	function createtaskrow(data) {
		var rowData = "<tr class='text-sm'>";
		rowData += "<td>" + getMenuItem(data.taskId) + "</td>";
		rowData += "<td>#" + data.taskId + ": " + data.taskName + "</td>";
		rowData += "<td>" + data.assigneeName + "</td>";
		rowData += "<td>" + data.projectName + "</td>";
		rowData += "<td>" + data.startDate + "</td>";
		rowData += "<td>" + data.dueDate + "</td>";
		rowData += "<td>"
				+ createStatusElement(data.taskStatusId, data.taskStatus,
						data.taskStatusType) + "</td>";
		rowData += "<td>"
				+ createPriorityElement(data.taskPriorityId, data.taskPriority,
						data.taskPriorityType) + "</td>";

		rowData += "<tr/>";
		return rowData;
	}

	function createtaskgridrow(data) {
		var rowData = '<div class="col-lg-6 col-md-6 col-sm-12 mb-1">';
		rowData += '<div class="card card-blog">';
		rowData += '<div class="card-body p-3 ">';
		rowData += '<div class="d-flex flex-column">';
		rowData += '<h6 class="mb-3 text-sm">#' + data.taskId + ': '
				+ data.taskName + '</h6>';
		rowData += '<span class="mb-2 text-xs">Assignee: <span class="text-color-black font-weight-bold ms-sm-2">'
				+ data.assigneeName + '</span></span>';
		rowData += '<span class="mb-2 text-xs">Project: <span class="text-color-black ms-sm-2 font-weight-bold">'
				+ data.projectName + '</span></span>';
		rowData += '<span class="text-xs">Due on: <span class="text-color-black ms-sm-2 font-weight-bold">'
				+ data.dueDate + '</span></span>';
		rowData += '</div>';

		rowData += '<div class="ms-auto text-end">' + getMenuItem(data.taskId)
				+ '</div>';
		rowData += '</div>';
		rowData += '</div>';
		rowData += '</div>';
		return rowData;
	}

	function createStatusElement(id, status, type) {
		switch (type) {
		case 1:
			return '<span class="badge badge-danger">' + status + '</span>';
			break;
		case 2:
			return '<span class="badge badge-info">' + status + '</span>';
			break;
		case 3:
			return '<span class="badge badge-info">' + status + '</span>';
			break;
		case 4:
			return '<span class="badge badge-secondary">' + status + '</span>';
			break;
		case 5:
			return '<span class="badge badge-success">' + status + '</span>';
			break;
		case 6:
			return '<span class="badge badge-primary">' + status + '</span>';
			break;
		case 7:
			return '<span class="badge badge-warning">' + status + '</span>';
			break;
		default:
			return '<span class="badge badge-secondary">' + status + '</span>';
		}
	}

	function createPriorityElement(id, prioirty, type) {
		switch (type) {
		case 1:
			return '<span class="badge bg-gradient-secondary">' + prioirty
					+ '</span>';
			break;
		case 2:
			return '<span class="badge bg-gradient-info">' + prioirty
					+ '</span>';
			break;
		case 3:
			return '<span class="badge bg-gradient-warning">' + prioirty
					+ '</span>';
			break;
		case 4:
			return '<span class="badge bg-gradient-primary">' + prioirty
					+ '</span>';
			break;
		case 5:
			return '<span class="badge bg-gradient-danger">' + prioirty
					+ '</span>';
			break;
		case 6:
			return '<span class="badge bg-gradient-danger">' + prioirty
					+ '</span>';
			break;
		default:
			return '<span class="badge bg-gradient-secondary">' + prioirty
					+ '</span>';
		}
	}

	function getMenuItem(taskid, taskname) {
		var rowData = '<a href="#" class="cursor-pointer btn-link  text-color-primary"  onclick="viewTask('
				+ taskid + ');">';
		rowData += '<i class="material-icons text-xl me-2" >display_settings</i></a>';

		rowData += '<a href="#" class="cursor-pointer btn-link text-color-primary"  onclick="addTimeLog('
				+ taskid + ');">';
		rowData += '<i class="material-icons text-xl me-2">more_time</i></a>';
		return rowData;
	}

	function viewProject(projectid, projectname) {
		sessionStorage.removeItem("projectid");
		sessionStorage.removeItem("projectname");
		sessionStorage.setItem("projectid", projectid);
		sessionStorage.setItem("projectname", projectname);
		window.location = 'projectview.jsp';
	}

	function viewTask(taskid) {
		sessionStorage.removeItem("taskid");
		sessionStorage.setItem("taskid", taskid);
		window.location = 'taskview.jsp';
	}
	function addTimeLog(taskid) {
		$('#taskid_id').val(taskid);
		$('#taskidforfile_id').val(taskid);
		$('#task_log_date_id').val(today());
		$('#task_log_hours_id').val('');
		$('#taskActivity_id').val('');
		$('#task_comments_id').val('');
		$("#msgError_task_log_date_id").css("display", "none");
		$("#msgError_log_hours_id").css("display", "none");
		$("#msgError_taskActivity_id").css("display", "none");
		$("#msgError_task_comments_id").css("display", "none");
		$("#logfilerow_id").prop("hidden", true);
		$("#updateAttachment_id").prop("hidden", true);
		$("#updateAttachment_id").val("");
		$("#uploadbtn_div").prop("hidden", false);
		$("#cancelbtn_id").prop("hidden", true);
		$("#logfileTableData").prop("hidden", true);
		$("#logFileDescriptionid").val("");
		$("#logfile_msgErrorId").css("display", "none");
		$("#msgError_logFileDescriptionid").css("display", "none");
		$("#uploadbtn_Id").prop("disabled", false);
		$("#logFilesListId").prop("hidden", true);
		$("#logFiletBody").empty();
		$('#taskTimeLog').modal("show");
	}

	function savetasklog() {
		if (validateServiceDetails('tasklogformId')) {
			jQuery.ajax({
				type : "POST",
				url : "workspace",
				data : {
					actionType : 'savetasklog',
					taskId : $('#taskid_id').val(),
					logDate : $('#task_log_date_id').val(),
					logHours : $('#task_log_hours_id').val(),
					taskActivityId : $('#taskActivity_id').val(),
					taskComment : $('#task_comments_id').val()
				},
				async : true,
				success : function(data) {
					 $('#taskTimeLog').modal("hide");
					 loadTaskList();

				},
				error : function(data) {

				}
			});
		}
	}

	function deleteTaskById(taskid) {
		$("#deleteID").val(taskid);
		$('#deleteModal').modal("show");
		$("#deleteBtnID").attr("onclick", "deleteTask()");
	}

	function deleteTask() {
		jQuery.ajax({
			type : "POST",
			url : "tasks",
			data : {
				actionType : 'deletetask',
				taskId : $('#deleteID').val()
			},
			async : true,
			success : function(data) {
				$('#deleteModal').modal("hide");
				loadMyTaskListByDate();
				loadCreatedTaskList();
			},
			error : function(data) {

			}
		});
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

	function showNewTaskModel() {
		$("#newTaskLabel").text("Create Task");
		$('#action_type_id').val('createtask');
		$("#taskactionid").html("Save");
		$("#taskactionid").attr("onclick", "cearenewtask()");
		$('#task_name_id').val('');
		$('#task_description_id').val('');
		$('#taskStatus_id').val('');
		$('#taskType_id').val('');
		$('#taskPriority_id').val('');
		$('#assignee_id').val('');
		$('#start_date_id').val(today());
		$('#due_date_id').val(currdateTime());
		$('#estimeted_time_id').val('');
		$('#project_id').val('');
		$('#done_value_id').val('0');
		$('#searchdepartment_id').val('0');
		$('#followerlistid').empty();
		$('#msgError_project_id').hide();
		$('#msgError_assignee_id').hide();
		$('#msgError_task_name_id').hide();
		$('#msgError_task_description_id').hide();
		$('#addAllcheckboxId').prop('checked' , false);
		
	}

	function showNewTaskModalAgain() {
		$("#newTaskLabel").text("Create Task");
		$('#action_type_id').val('createtask');
		$("#taskactionid").html("Save");
		$("#taskactionid").attr("onclick", "cearenewtask()");
		$('#project_id').val('');
		$('#task_name_id').val('');
		$('#task_description_id').val('');
		$('#taskStatus_id').val('');
		$('#taskType_id').val('');
		$('#taskPriority_id').val('');
		$('#assignee_id').val('');
		$('#start_date_id').val(today());
		$('#due_date_id').val(currdateTime());
		$('#estimeted_time_id').val('');
		$('#done_value_id').val('0');
		$('#searchdepartment_id').val('0');
		$('#followerlistid').empty();
		$('#addAllcheckboxId').prop('checked' , false);
		$('.follower').prop("checked", false);
		$('#msgError_project_id').hide();
		$('#msgError_task_name_id').hide();
		$('#msgError_task_description_id').hide();
		$("#newTask").modal('show');
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
				if (resp[1] > 0 && resp[0] != null) {
					for (var i = 0; i < resp[0].length; i++) {
						var htmlData = '<option value="'
								+ (resp[0])[i].project_id + '">'
								+ (resp[0])[i].project_name + '</option>'
						$("#project_id").append(htmlData);
						$("#projectfiler_id").append(htmlData);

					}
				}
			}
		})
	}
	function loadAssignee(projectid) {
		$('#assignee_id').empty();
		$('#followerlistid').empty();
		$('#searchdepartment_id').val("0");
		$('#msgError_project_id').hide();
		jQuery
				.ajax({
					type : "POST",
					url : "projectsemployee",
					data : {
						actionType : 'getprojectmembers',
						projectid : projectid,
					},
					async : true,
					success : function(data) {
						var jsonData = eval(data);
						if (jsonData.length > 0) {
						    var htmlData = '<option value="">Select Assignee</option>';
						    $('#assignee_id').append(htmlData);

						    for (var i = 0; i < jsonData.length; i++) {
						        var rowdata = jsonData[i];
						        // Check if isactive is not "0" before creating an option
						        if (rowdata.is_active !== "0") {
						            var htmlData = '<option value="' + rowdata.employee_id + '">' + rowdata.employee_name + '</option>';
						            $('#assignee_id').append(htmlData);
						        }
						    }
						    loadFollowers(projectid, $('#searchdepartment_id').val());
						}
					},
					error : function(data) {
						
					}
				});
	}
	function loadFollowers(projectid,departmentid) {
		$('#addAllcheckboxId').prop('checked' , false);
		$('#followerlistid').empty();
		if(projectid != ""){
		jQuery.ajax({
			type : "POST",
			url : "projectsemployee",
			data : {
				actionType : 'getprojectmembers',
				projectid : projectid,
				departmentid : departmentid,
				listType : "getFollowers"
			},
			async : true,
			success : function(data) {
				var jsonData = eval(data);
				if (jsonData.length > 0) {
					for (var i = 0; i < jsonData.length; i++) {
						var rowdata = jsonData[i];
						console.log(rowdata);
						 // Check if isactive is not "0" before creating followers
						if (rowdata.is_active !== "0") {
							newRowContent = getFollowerRowData(rowdata);
							$("#followerlistid").append(newRowContent);
						
						}
					}
				}
			},
			error : function(data) {

			}
		});
		}else{
			$('#searchdepartment_id').val("0");
			$('#msgError_project_id').text('Please select at least one option.');
			$('#msgError_project_id').show();
			$('#msgError_project_id').focus();
		}
	}

	function getFollowerRowData(data) {
		var rowData = "<div class=\"col-lg-3 col-md-6 col-sm-12\">";
		rowData += "<div class=\"d-flex px-2 py-1\">";
		rowData += "<div class=\"form-check px-2 py-1\">";
		rowData += "<input class=\"followers form-check-input\" type=\"checkbox\" onchange = \"checkfollowers();\"  name='chkfollowmember' value='"+data.employee_id+"' id='fmemberid_"+data.employee_id+"' ></div>";
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
	
	function cearenewtask() {
		if (validateServiceDetails('taskformId')) {
			var taskfollowers = [];
			$("#followerlistid input[type=checkbox]:checked").each(function() {
				taskfollowers.push($(this).val());
			});
			jQuery.ajax({
				type : "POST",
				url : "tasks",
				data : {
					actionType : $('#action_type_id').val(),
					projectId : $('#project_id').val(),
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
					taskfollowers : taskfollowers.join(',')
				},
				async : true,
				success : function(data) {
					$('#newTask').modal("hide");
// 					loadMyTaskList();
					loadMyTaskListByDate();
					loadSummary();
				},
				error : function(data) {
					alert(data);
				}
			});
		}

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
						if (data != null) {
							for (let i = 0; i < data.length; i++) {
								var htmlData = '<option value="' + data[i].taskActivityId + '">'
										+ data[i].taskActivity + '</option>'
								$('#taskActivity_id').append(htmlData);
							}
						}
					},
					error : function(error) {
						alert(data);
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
						if (data != null) {
							for (let i = 0; i < data.length; i++) {
								var htmlData = '<option value="' + data[i].taskStatusID + '">'
										+ data[i].taskStatus + '</option>';
								$('#filtertaskstatusid').append(htmlData);
								$('#taskStatus_id').append(htmlData);

							}
						}
					},
					error : function(error) {
						alert(data);
					}
				});
	}
	function loadTaskPriorityList() {
		$.ajax({
					url : "masterDetails",
					type : 'post',
					data : {
						actionType : 'taskPriorityList',
						company_id : "1"
					},
					success : function(data) {
						if (data != null) {
							for (let i = 0; i < data.length; i++) {
								var htmlData = '<option value="' + data[i].taskPriorityId + '">'
										+ data[i].taskPriority + '</option>';
								$('#filtertaskpriorityid').append(htmlData);
								$('#taskPriority_id').append(htmlData);
							}
						}
					},
					error : function(error) {
						alert(data);
					}
				});
	}
	function loadTaskTypeList() {
		$.ajax({
					url : "masterDetails",
					type : 'post',
					data : {
						actionType : 'taskTypeList',
						company_id : "1"
					},
					success : function(data) {
						if (data != null) {
							for (let i = 0; i < data.length; i++) {
								var htmlData = '<option value="' + data[i].tasktypeID + '">'
										+ data[i].taskType + '</option>'
								$('#taskType_id').append(htmlData);
							}
						}
					},
					error : function(error) {
						alert(data);
					}
				});
	}
	function uploadLogFile(){
		
	let formData = new FormData(); 
   formData.append("updateAttachment", updateAttachment_id.files[0]);
   formData.append("task_id", $('#taskidforfile_id').val());
   formData.append("discription", $('#logFileDescriptionid').val());
				console.log("Form Data");
				  for (let obj of formData) {
				    console.log(obj);
				  }
					$
					.ajax({
						url : "workspace?actionType=updateAttachment",
						type : 'post',
						data : formData,
						success : function(data) {
							console.log(data, "DocumentsList");
							var DName = document.getElementById("logFiletBody");
							$("#logFiletBody").empty();
							if (data != null) {
								$("#updateAttachment_id").prop("hidden", true);
								$("#updateAttachment_id").val("");
								$("#uploadbtn_Id").prop("disabled", true);
								$("#cancelbtn_id").prop("hidden", true);
								$("#logFilesListId").prop("hidden", false);
								var row = "";
								row += '<tr><td><a href="#" onclick="deleteLogAttachmentById('
										+ data.document_id
										+ ');"class="text-danger cursor-pointer"><i class="material-icons text-sm me-2">cancel</i></a><a href="#" class="text-info cursor-pointer" id="viewAttachment" onclick="viewLogAttachment('
										+ $('#taskid_id').val()
										+ ', '
										+ data.document_id
										+ ');"><i class="material-icons text-sm me-2">preview</i></a><a href="tasks?actionType=downloadAttachment&taskid='
										+ data.task_id
										+ '&document_name='
										+ data.document_name
										+ '&isadditional=1" target="_top" class="text-info cursor-pointer" id="downloadAttachmentId" ><i class="material-icons text-sm me-2">download</i></a></td><td id="docNameFordwnId">'
										+ data.document_name
										+ '</td><td id="descriptionId">'
										+ data.documentDiscription
										+ '</td><td>'
										+ today() + '</td></tr>';
								DName.innerHTML = row;
								sessionStorage.setItem("fileName",data.document_name);
							}else{
								$("#updateAttachment_id").prop("hidden", false);
								$("#updateAttachment_id").val("");
								$("#uploadbtn_Id").prop("disabled", false);
								$("#logFilesListId").prop("hidden", true);
							}
						},
						error : function(error) {
							alert(data);
						},
						processData : false,
						contentType : false,
					});  
				  
	}
	function loadLogDocumentList() {
		
				$.ajax({
					url : "tasks",
					type : "post",
					data : {
						actionType : "documentList",
						taskid : $('#taskid_id').val(),
						isadditional : "1"
					},
					success : function(data) {
						console.log(data, "DocumentsList");
						var DName = document.getElementById("logFiletBody");
						$("#logFiletBody").empty();
						if (data != null) {
							$("#updateAttachment_id").prop("hidden", true);
							$("#updateAttachment_id").val("");
							$("#uploadbtn_Id").prop("disabled", true);
							$("#cancelbtn_id").prop("hidden", true);
							$("#logFilesListId").prop("hidden", false);

							var row = "";
							row += '<tr><td><a href="#" onclick="deleteLogAttachmentById('
									+ data.document_id
									+ ');"class="text-danger cursor-pointer"><i class="material-icons text-sm me-2">cancel</i></a><a href="#" class="text-info cursor-pointer" id="viewLogAttachment" onclick="viewLogAttachment('
									+ $('#taskid_id').val()
									+ ', '
									+ data.document_id
									+ ');"><i class="material-icons text-sm me-2">preview</i></a><a href="tasks?actionType=downloadAttachment&taskid='
									+ data.task_id
									+ '&document_name='
									+ data.document_name
									+ '&isadditional=1" target="_top" class="text-info cursor-pointer" id="downloadAttachmentId" ><i class="material-icons text-sm me-2">download</i></a></td><td id="docNameFordwnId">'
									+ data.document_name
									+ '</td><td id="descriptionId">'
									+ data.documentDiscription
									+ '</td><td>'
									+ data.created_on + '</td></tr>';
							DName.innerHTML = row;
						}else{
							$("#updateAttachment_id").prop("hidden", false);
							$("#updateAttachment_id").val("");
							$("#uploadbtn_Id").prop("disabled", false);
							$("#logFilesListId").prop("hidden", true);
						}
					}
				})
	}
	function viewLogAttachment(taskId, documentId) {
		var fileName = sessionStorage.getItem("fileName");
		$.ajax({
			url : "tasks",
			type : "post",
			data : {
				actionType : "viewAttachment",
				taskid : taskId,
				documentId : documentId,
				isadditional:"1",
				filename:fileName
			},
			success : function(resp) {
				console.log(resp);
				if (resp != null) {
					//for local
					// var b = resp.split('dakshabhipms-qa/')
					// console.log(b[1]);
					// var attachmentFile = b[1];
					//for server
					var attachmentFile = resp;
					window.open(attachmentFile, "Preview","width=800,height=500");
				}
			}
		})
	}
	function deleteLogAttachmentById(documentId) {
		$('#deleteModal').modal("show");
		$("#deleteBtnID").attr("onclick",
				"deleteLogAttachment(" + documentId + ")");
	}
	function deleteLogAttachment(documentId) {
		$.ajax({
			url : "tasks",
			type : "post",
			data : {
				actionType : "deleteAttachment",
				document_id : documentId,
				taskid : $('#taskid_id').val(),
				isadditional:"1",
			},
			success : function(resp) {
				console.log("file deleted..!");
				$("#uploadbtn_Id").prop("disabled", false);
				$("#logFileDescriptionid").val("");
				$("#logFilesListId").prop("hidden", true);
				$("#logFiletBody").empty();
			}
		})
	}

// select all followers checkBox
	function addAllFollowers(chkId){
		      if(chkId.id == 'addAllcheckboxId'){
		    	  var isChecked = $(chkId).prop("checked");
			      if (isChecked) {
			        console.log("Add AllCheckbox is checked.");
			        $(".followers").prop("checked", true);
			      } else {
			        console.log("Add All Checkbox is not checked.");
			        $(".followers").prop("checked", false);
			      }
		      }else{
		 		 var isChecked = $(chkId).prop("checked");	
		 		if (isChecked) {
			        console.log(chkId.id +" Checkbox is checked.");
			        $("#addAllcheckboxId").prop("checked", true);
			      } else {
			        console.log(chkId.id +" Checkbox is not checked.");
			        $("#addAllcheckboxId").prop("checked", false);
			      }
		      }
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
				+ ((currDate < 10) ? '0' + currDate : currDate)+" "+ gethour+ ":"+ ((getminute < 10) ? '0'+getminute : getminute);
	}
	function fileSizeValidation() {
		var filesId = document.getElementById("updateAttachment_id");
		const isFilePresent = filesId.files;
		if (isFilePresent.length != 0) {
			const fsize = filesId.files[0].size;
			console.log(fsize);
			const file = Math.round((fsize / 1024));
			if (file >= 10240) {
				$("#logfile_msgErrorId").show();
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
	function loadPiechartSummary(piechartId) {
		
		 var captionValue = '';
		 if(piechartId == 'taskStatuschartId'){
			 captionValue = 'Task Status Summary'; 
		 }else{
			 captionValue = 'Task Priority Summary'; 
		 }
		 
		 var revenueChart = new FusionCharts({
		    type: 'doughnut2d',
		    renderAt: piechartId,
		    width:"100%",
//		    heigth:"75%",		   
		    dataFormat: 'json',
		    dataSource: {
		      "chart": {
		      //"caption": captionValue,
		        "bgColor": "#FFFFFF",		    
		        "startingAngle": "180",
		        "enableRotation" : "0",
		        "enableMultiSlicing":"0",
		        "showLegend": "1",
		        "showLabels": "1",
		        "enableSmartLabels":"0",
		        "showPercentValues":"0",
		        "showValues":"0",
		        "showTooltip": "0",
		        "showPercentInToolTip":"0",
//		        "slicingDistance":"5",
//		        "labelFontColor":"#fffff",
//		        "pieradius":"70",
// 		        "centerLabel": "Status from label: value",
// 		        "centerLabelBold": "1",
		"showBorder":"0",
		"chartTopMargin":"",
//		"chartRightMargin":"140",
	
		        "decimals": "0",
		        "theme": "fusion",
		        "legendWidth": "50%",
		        "legendNumRows": "3",
		        "legendItemFontSize": "14",
		        "legendIconScale": "0.7",
		        "legendNumColumns": "3",
		       // "legendPosition": "absolute",
		        //"legendXPosition": "50",
		       // "legendYPosition": "50",
		        "legendPosition":"bottom"
		      },
		      "data": array,
		    }
		  }).render();
	}

</script>

<%@ include file="/include/footer.jsp"%>

