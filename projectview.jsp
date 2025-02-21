<%@page import="java.util.Iterator"%>
<%@page import="com.dakshabhi.pms.customers.dtos.CCustomerDTO"%>
<%@page import="java.util.ArrayList"%>
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

#sandcdivid {
	margin-top: -5px
}

#memberCardId {
	overflow: scroll;
	height: 300px;
}

#loadmoreactivityid {
  padding: 10px 20px;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  position: absolute;
  bottom: -10;
  width: 100%; /* Button width set to 100% */
  text-align: center;
}

#loadmorelogid {
  padding: 10px 20px;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  position: absolute;
  bottom: 0;
  width: 100%; /* Button width set to 100% */
  text-align: center;
}

#loadmoreloggridid{
  padding: 10px 20px;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  position: absolute;
  bottom: -20;
  width: 100%; /* Button width set to 100% */
  text-align: center;
}

#loadmoreid {
  padding: 10px 20px;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  position: absolute;
  bottom: -10;
  width: 100%; /* Button width set to 100% */
  text-align: center;
}

#loadmoregridid {
  padding: 10px 20px;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  position: absolute;
  bottom: -13;
  width: 100%; /* Button width set to 100% */
  text-align: center;
}

#loadmorememberlistid {
  padding: 10px 20px;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  position: absolute;
  bottom: -13;
  width: 100%; /* Button width set to 100% */
  text-align: center;
}

#loadmoremembersgridid {
  padding: 10px 20px;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  position: absolute;
  bottom: -13;
  width: 100%; /* Button width set to 100% */
  text-align: center;
}

#newTaskBtnId{
 width: 30%;
  text-align: center;
  font-size: 12px;
  height: 30px;
  margin-left: 10px;
}
td:nth-child(4) {
  white-space: normal;
}
td:nth-child(6) {
  white-space: normal;
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
						<div class="col-lg-4 col-md-4 col-sm-6 col-xs-12" id="addbtbn" style="text-align: end">
							<div class="input-group input-group-static mb-2">
								<select class="required form-control p-2" id="projectfilter_id" name="projectfilter" onchange="viewProject(this.value)">

								</select>
							</div>
						</div>
					</div>
				</nav>
			</div>
		</nav>
		<!--End Navbar -->
			<div class="container-fluid py-1">
			<div class="card">
				<div class="nav-wrapper position-relative end-0">
					<ul class="nav nav-pills nav-fill p-1" role="tablist">
						<li class="nav-item" onclick="loadActivity();"><a class="nav-link mb-0 px-0 py-1 active" data-bs-toggle="tab" id="tablist" href="#cam1" role="tab"
							aria-controls="code" aria-selected="true"> <span class="material-icons align-middle mb-1"> view_week </span> Activity
						</a></li>
						<li class="nav-item" onclick="loadTimeLogList();"><a class="nav-link mb-0 px-0 py-1 " data-bs-toggle="tab" href="#cam2" role="tab" aria-controls="preview"
							aria-selected="false"><span class="material-icons align-middle mb-1">more_time</span> Time Log </a></li>
						<li class="nav-item" onclick="loadTaskList()"><a class="nav-link mb-0 px-0 py-1" data-bs-toggle="tab" href="#task" role="tab" aria-controls="code"
							aria-selected="false"> <span id="loadTask" class="material-icons align-middle mb-1"> task </span> Tasks
						</a></li>
						<li class="nav-item" onclick="loadMembers();"><a class="nav-link mb-0 px-0 py-1" data-bs-toggle="tab" href="#members" role="tab" aria-controls="code"
							aria-selected="false"> <span class="material-icons align-middle mb-1"> group </span> Members
						</a></li>

					</ul>
				</div>

				<div class="tab-content shadow-dark border-radius-lg" id="v-pills-tabContent">
					<div class="tab-pane fade show position-relative active height-auto border-radius-lg" id="cam1" role="tabpanel" aria-labelledby="cam1" loading="lazy">
						<div class="position-absolute d-flex top-0 w-100">
							<div class="col-12">
								<div class="card">
									<div class="card-header p-0">
										<div class="row">
											<div class="col-12">
												<form class="multisteps-form__form m-0">
													<div class="row p-2">
														<div class="col-md-3">
															<div class="input-group input-group-dynamic">
																<select class="form-control" id="activityselect_filter_id" name="filterDate" required="required">
										                            <option value="today">Today</option>
																	<option value="yesterday">Yesterday</option>
																	<option value="last_sevenDays" selected>Last 7 days</option>
																	<option value="this_week">This week</option>
																	<option value="last_week">Last week</option>
																	<option value="this_month">This Month</option>
																	<option value="last_month">Last Month</option>
																	<option value="custom_dates">Custom Date</option>
																</select>
															</div>
														</div>
														<div class="col-md-3" id="activitystartDateColid">
															<div class="input-group input-group-dynamic">
																<input class="multisteps-form__input form-control" type="date" placeholder="" name="filterStartDate" id="activityFilterStartDateid" />
															</div>
															<span id="errormessageforfromdateId" class="err-msg" 
																		style="display : none; color: red;">Please select a date..!
															</span>
															<span id="errMsgDateCompare" class="err-msg"																		
																		style="display: none; color: red ">From date is greater than to date..! 
														   </span>															
														   	<span id="errormessagefordiffDaysId" class="err-msg" 
							                                         style="display: none; color: red">Date difference should be in 90 days..! 
							                                </span>
 
														</div>
														<div class="col-md-3" id="activityendDateColid">
															<div class="input-group input-group-dynamic">
																<input class="multisteps-form__input form-control" type="date" placeholder="" name="filterEndDate" id="activityFilterEndDateid" />
															</div>
															<span id="errormessagefortodateId" class="err-msg" style="display: none; color: red">Please select a date..!</span>
														</div>
														<div class="col-md-3 rightalign">
															<button class="btn btn-icon btn-2 btn-dark" id="search" type="button" onclick="loadActivity()">
																<span class="btn-inner--icon"><i class="material-icons">search</i></span>
															</button>
														</div>
													</div>
												</form>
											</div>
										</div>
									</div>
									<input type="hidden" id="currentPageNumber" value="1" />
									<div class="card-body p-2 pt-2" id="taskmsgmainid">
										<div>
											<div class="mb-1 " id="activityLogbodyId"></div>

										</div>
										<a id="loadmoreactivityid" href="#" onclick="loadMoreActivity()"> <strong>Load More...</strong></a>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="tab-pane fade position-relative height-auto border-radius-lg" id="cam2" role="tabpanel" aria-labelledby="cam2" loading="lazy">
						<div class="position-absolute d-flex top-0 w-100">

							<div class="col-12">
								<div class="card">
									<div class="card-header p-0">
										<div class="row">
											<div class="col-12">
												<form class="multisteps-form__form m-0">
													<div class="row p-2">
														<div class="col-md-10 col-sm-6">
															<div class="row p-0">
																<div class="col-md-3">
																	<div class="input-group input-group-dynamic">
																		<select class="form-control" id="timeLogselect_filter_id" name="filterDate" required="required">
																		
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
																<div class="col-md-3" id="startDateColid">
																	<div class="input-group input-group-dynamic">
																		<input class="multisteps-form__input form-control" type="date" placeholder="" name="filterStartDate" id="timeLogFilterStartDateid" />
																	</div>
																	<span id="errormessageforfromdateIdTime" class="err-msg" style="display: none; color: red;">Please select a date..!</span> <span id="errMsgDateCompareTime"
																		class="err-msg" style="display: none; color: red">From date is greater than to date..! </span>
																
																<span id="errormessageforloaddiffDaysId" class="err-msg" 
							                                           style="display: none; color: red">Date difference should be in 90 days..! 
							                                    </span>
																</div>
																<div class="col-md-3" id="endDateColid">
																	<div class="input-group input-group-dynamic">
																		<input class="multisteps-form__input form-control" type="date" placeholder="" name="filterEndDate" id="timeLogFilterEndDateid" />
																	</div>
																	<span id="errormessagefortodateIdTime" class="err-msg" style="display: none; color: red">Please select a date..!</span>
																</div>
																<div class="col-md-3 text-end">
																	<button class="btn btn-icon btn-2 btn-dark" id="search" type="button" onclick="loadTimeLogList()">
																		<span class="btn-inner--icon"><i class="material-icons">search</i></span>
																	</button>
																</div>
															</div>
														</div>
														<div class="col-md-2 col-sm-6 text-end">
															<p class="hours-totals">
																<span class="total-for-hours"><span>Hours:</span> <span class="value"></span></span>
															</p>
														</div>
													</div>
												</form>
											</div>
										</div>
									</div>
								</div>
								<input type="hidden" id="currentPageNo" value="1" />
								<div class="card card-body p-2 pt-2" id="taskLog_list-view">
									<div class="table-responsive d-none d-md-block d-sm-none d-lg-block d-xl-block">
										<table class="table table-flush text-sm" id="tasktableId">
											<thead class="thead-light">
												<tr>
													<th></th>
													<th>Log Date</th>
													<th>User</th>
													<th>Tasks</th>
													<th>Est. Hours</th>
													<th>Hours</th>
													<th>Comments</th>
													<th>Date</th>
													<th>Activity</th>
												</tr>
											</thead>
											<tbody id="taskLogbodyforListId">
											</tbody>
										</table>
										<a id="loadmorelogid" href="#" onclick="loadMoreTimeLogList()"> <strong>Load More...</strong></a>
									</div>
								</div>
								<div class="row  d-sm-block d-md-none d-lg-none d-xl-none" id="taskLogbodyforGridId"></div>
								<div >
								<a class="row  d-sm-block d-md-none d-lg-none d-xl-none" id="loadmoreloggridid" href="#" onclick="loadMoreTimeLogList()"> <strong>Load More...</strong></a>
								</div>
							</div>
						</div>
					</div>
					<div class="tab-pane fade position-relative height-auto border-radius-lg" id="task" role="tabpanel" aria-labelledby="tasks" loading="lazy">
						<div class="position-absolute d-flex top-0 w-100">
							<div class="col-12">
								<div class="card">
									<div class="card-header p-2">
										<div class="row">
											<div class="col-12">
												<form class="multisteps-form__form m-0">
													<div class="row p-2">
														<div class="col-md-3">
															<div class="input-group input-group-dynamic">
																<input class="multisteps-form__input form-control" type="text" placeholder="Task Name" name="filtertaskname" id="filtertasknameid" />
															</div>
														</div>
														<div class="col-md-3">
															<div class="input-group input-group-dynamic">
																<select class="form-control" id="filtertaskstatusid" name="filtertaskstatus" required="required">
																	<option value="">Task Status</option>

																</select>
															</div>
														</div>
														<div class="col-md-3">
															<div class="input-group input-group-dynamic">
																<select class="form-control" id="filterassigneeid" name="filterassignee">
																	<option value="0">Assignee</option>
																</select>
															</div>
														</div>
														<div class="col-md-3 rightalign">
															<button class="btn btn-icon btn-2 btn-dark" id="search" type="button" onclick="loadTaskList()">
																<span class="btn-inner--icon"><i class="material-icons">search</i></span>
															</button>
														</div>
													</div>
												</form>
											</div>
										</div>
									</div>
									<input type="hidden" id="cPageNo" value="1" />
									<div class="card-body p-2 pt-2" id="taskList-view">
										<div class="table-responsive d-none d-md-block d-sm-none d-lg-block d-xl-block">
											<table class="table table-flush text-sm" id="tasktableId">
												<thead class="thead-light">
													<tr>
														<th><button type="button" data-bs-toggle="modal" data-bs-target="#newTask" onclick="showNewTaskModel()" class="btn btn-sm bg-gradient-info mb-0">
																<i class="material-icons text-white pe-2">add</i> New
															</button></th>
														<th>ID</th>
														<th>Type</th>
														<th>Status</th>
														<th>Priority</th>
														<th>Task</th>
														<th>Assignee</th>
														<th>Updated</th>
													</tr>
												</thead>
												<tbody id="taskbodyforListId">
												</tbody>
											</table>
											<a id="loadmoreid" href="#" onclick="loadMoreTasks()"> <strong>Load More...</strong></a>
										</div>
									</div>
									<div class="container">
									<div class="row  d-sm-block d-md-none d-lg-none d-xl-none" >
									<button id="newTaskBtnId" type="button" data-bs-toggle="modal" data-bs-target="#newTask" onclick="showNewTaskModel()" class="btn btn-sm bg-gradient-info col-4 mb-3">
																<i class="material-icons text-white pe-2">add</i> New
															</button>
									</div>
									<div class="row  d-sm-block d-md-none d-lg-none d-xl-none" id="taskbodyforGridId"></div>
									<div>
									<a class="row  d-sm-block d-md-none d-lg-none d-xl-none" id="loadmoregridid" href="#" onclick="loadMoreTasks()"> <strong>Load More...</strong></a>
									</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="tab-pane fade position-relative" id="members" role="tabpanel" aria-labelledby="members" loading="lazy">
						<div class="position-absolute d-flex top-0 w-100">
							<div class="col-12 ">
								<div class="card">
								<input type="hidden" id="cPageNumber" value="1" />
									<div class="card-body p-2 pt-2" id="memberList-view">
										<div class="table-responsive d-none d-md-block d-sm-none d-lg-block d-xl-block">
											<table class="table table-flush text-sm" id="memberstableId">
												<thead class="thead-light">
													<tr>
														<th><button type="button" data-bs-toggle="modal" data-bs-target="#newMember" onclick="showNewMemberModel()" class="btn btn-sm bg-gradient-info mb-0">
																<i class="material-icons text-white pe-2">add</i> New
															</button></th>
														<th>Name</th>
														<th>Email</th>
														<th>Department</th>
														<th>Role</th>
													</tr>
												</thead>
												<tbody id="memberstbodyforListId">
												</tbody>
											</table>
											<a id="loadmorememberlistid" href="#" onclick="loadMoreMembers()"> <strong>Load More...</strong></a>
											</div>
									</div>

									<div class="container">
										<div class="row  d-sm-block d-md-none d-lg-none d-xl-none">
											<button id="newTaskBtnId" type="button"
												data-bs-toggle="modal" data-bs-target="#newMember"
												onclick="showNewMemberModel()"
												class="btn btn-sm bg-gradient-info col-4 mb-3">
												<i class="material-icons text-white pe-2">add</i> New
											</button>
										</div>
										<div class="row  d-sm-block d-md-none d-lg-none d-xl-none"
											id="membersbodyforGridId"></div>
										<div>
											<a class="row  d-sm-block d-md-none d-lg-none d-xl-none"
												id="loadmoremembersgridid" href="#" onclick="loadMoreMembers()">
												<strong>Load More...</strong>
											</a>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!-- Modal For Add New Member -->
		<div class="modal fade" id="newmemberModal" tabindex="-1" role="dialog" aria-labelledby="newmemberModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-xl modal-dialog-centered" role="document">
				<div class="modal-content">
				<!-- <div class="modal-header"> -->
		           <div class="row px-3 mt-3 ">
		           <div class="col-lg-0 col-md-0 col-sm-12 text-end mb-3">
					  <button type="button" class="btn-close text-dark col-1" data-bs-dismiss="modal" aria-label="Close">
									<span aria-hidden="true">&times;</span>
					  </button>
					</div>
		           		<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
								<div class="input-group input-group-outline">
									<label class="form-label">Employee Name</label> <input type="text" class="form-control" name="searchEmployee_name" id="searchEmployee_name_id"
										oninput="searchForNewMember(this.value)">
								</div>
							</div>
	                 <div class="col-lg-3  col-md-4 col-sm-4 mt-2">
						<div class="form-check">
						  <input class="form-check-input" type="checkbox" name="chkaddAllemployees" value="1" id="addAllEmployeesId"> <label
							class="mb-0 position-relative text-sm">Add All</label>
					    </div>
					</div>
					<div class="col-lg-3  col-md-3 col-sm-5 ">
					  <div class="input-group input-group-static">
						<select class="form-control" id="searchMemberDept_id" name="departmentfilter" onchange="getNewMembers();">
							<option value="0">All Department</option>
						</select> <span class="msgError" id="msgError_searchdepartment_id"></span>
					  </div>
				   </div>
				   </div>
				   <span class="border-bottom mt-3"></span>
			
	<!-- Add New Member Modal End -->
	
		<div class="container-fluid">
						<div class="row mt-4">
							<div class="col-lg-12 col-12 position-relative">
								<div class="card mb-4 overflow-x-hidden" id="memberCardId">

									<div class="row" id="memberlistid"></div>
								</div>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn bg-gradient-info" onclick="savenewmembers();">Add</button>
						<button type="button" class="btn btn-link  ml-auto" data-bs-dismiss="modal">Close</button>
					</div>
				</div>
			</div>
		</div>


<!-- Modal For Add New task Start -->
		
		<div class="modal fade" id="newTask" tabindex="-1" role="dialog" aria-labelledby="newTaskLabel" aria-hidden="true">
			<div class="modal-dialog  modal-xl modal-dialog-centered" role="document">
				<div class="modal-content model-content-css">
					<div class="modal-header ">
						<h4 class="modal-title" id="newTaskLabel">New Task</h4>
						<button type="button" class="btn-close text-dark" data-bs-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<div class="container-fluid">
							<div class="card">
								<div class="card-body">
									<div class="row">
										<div class="col-lg-12 col-md-8">
											<form name="taskform" id="taskformId">
												<input type="hidden" name="actionType" id="action_type_id" value="createtask" /> <input type="hidden" name="taskid" id="taskid_id" value="" />
												<div class="row">
													<div class="col-md-6">
														<div class="input-group input-group-static mb-4">
															<label>Type <sup><i class="fa fa-asterisk"></i></sup></label> <select class="required form-control" id="taskType_id" name="taskType">
															</select> <span class="msgError" id="msgError_taskType_id"></span>
														</div>
													</div>
													<div class="col-md-6">
														<div class="input-group input-group-static mb-4">
															<label>Task Name <sup><i class="fa fa-asterisk"></i></sup></label> <input type="text" class="required form-control" name="task_name" id="task_name_id">
															<span class="msgError" id="msgError_task_name_id"></span>
														</div>
													</div>
													
													
												</div>
                                               <div class="row">
                                               <div class="col-md-12">
												<div class="input-group input-group-static mb-4">
												<label>Task Description </label>
												<textarea class=" form-control" rows="2" placeholder="This is how others will learn about the task, so make it good!" spellcheck="false"
													name="task_description" id="task_description_id"></textarea>
												<span class="msgError" id="msgError_task_description_id"></span>

											</div>
											</div>
                                               </div>
												
												
												
												
												<div class="row">
													<div class="col-md-4">
														<div class="input-group input-group-static mb-4">
															<label>Priority <sup><i class="fa fa-asterisk"></i></sup></label> <select class="required form-control" id="taskPriority_id" name="taskPriority">
															</select> <span class="msgError" id="msgError_taskPriority_id"></span>
														</div>
													</div>
													<div class="col-md-4">
														<div class="input-group input-group-static mb-4">
															<label>Status <sup><i class="fa fa-asterisk"></i></sup></label> <select class="required form-control" id="taskStatus_id" name="taskStatus">
															</select> <span class="msgError" id="msgError_taskStatus_id"></span>
														</div>
													</div>
													<div class="col-md-4">
														<div class="input-group input-group-static mb-4">
															<label>Assignee <sup><i class="fa fa-asterisk"></i></sup></label> <select class="required form-control" id="assignee_id" name="assignee">
																<option value="">Select Assignee</option>
															</select> <span class="msgError" id="msgError_assignee_id"></span>
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
															<label>Estimated time (Hours)</label> <input type="number" class="form-control" id="estimeted_time_id" name="estimeted_time">
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
																	<input class="form-check-input" type="checkbox" name="chkaddAllfollowers" value="1" id="addAllcheckboxId"> <label
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
													<div class="col-md-auto text-end px-1 d-none d-lg-block">
														<button type="button" class="btn bg-gradient-info" onclick="cearenewtask();" id="save&createid" onblur="showNewTaskModalAgain();">Save &amp Create</button>
													</div>
													&nbsp
													<div class="col-md-auto text-end px-1">
														<button type="button" class="btn bg-gradient-info" id="taskactionid" onclick="cearenewtask();">Create</button>
														&nbsp
														<button type="button" class="btn btn-link  ml-auto" data-bs-dismiss="modal">Close</button>
													</div>
												</div>
												<div class="d-flex justify-content-end">
													<div id="sandcdivid" class="col-md-auto text-end d-block d-lg-none">
														<button type="button" class="btn bg-gradient-info" id="secondsave&createid" onclick="cearenewtask();" onblur="showNewTaskModalAgain();">Save &amp
															Create</button>
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


		<!-- Modal For Add New task End -->



		<!-- Modal For Edit Time Log -->
		<div class="modal fade" id="taskTimeLogforEdit" tabindex="-1" role="dialog" aria-labelledby="taskTimeLogLabel" aria-hidden="true">
			<div class="modal-dialog  modal-lg modal-dialog-centered" role="document">
				<div class="modal-content model-content-css">
					<!--Header-->
					<div class="modal-header ">
						<h6 class="modal-title" id="newTaskLabel">Update Time</h6>
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
										<div class="col-lg-12 col-md-8">
											<form name="taskformforEdit" method="post" id="tasklogformforEditId">
												<input type="hidden" name="taskLogid" id="taskLogid_id" value="" /> <input type="hidden" name="taskid" id="taskid_id" value="" />
												<div class="row">
													<div class="col-md-6">
														<div class="input-group input-group-static mb-4">
															<label>Date <sup><i class="fa fa-asterisk"></i></sup></label> <input type="date" class="required form-control" name="task_log_date" id="task_log_date_id"
																required="required"> <span class="msgError" id="msgError_task_log_date_id"></span>
														</div>
													</div>

													<div class="col-md-6">
														<div class="input-group input-group-static mb-4">
															<label>Hours <sup><i class="fa fa-asterisk"></i></sup></label> <input type="number" class="required form-control" id="task_log_hours_id"
																name="task_log_hours" required="required"> <span class="msgError" id="msgError_task_log_hours_id"></span>
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
															<label>Activity <sup><i class="fa fa-asterisk"></i></sup></label> <select class="required form-control" id="taskActivity_id" name="taskActivity">
																<option value="">Select Activity</option>
															</select> <span class="msgError" id="msgError_taskActivity_id"></span>
														</div>
													</div>

												</div>

											</form>
											<form enctype="multipart/form-data" method="post" id="attachForm_Id" onsubmit="return validateServiceDetails('attachForm_Id');">
												<input type="hidden" name="task_id" id="taskidforfile_id" value="" />
												<div class="row" id="attachFormId">
													<div class="col-12 position-relative">
														<div class="card">
															<div class="card-body">
																<div class="row">
																	<div class="row" id="upFile">
																		<div class="col-md-2">
																			<label>Upload File</label>
																		</div>
																		<div class="col-md-2" id="btnFile">
																			<input type="button" id="uploadFilebtnId" class="btn bg-gradient-info mt-2" value="Upload File" onclick="togglefunction();">
																		</div>
																	</div>
																	<div class="row my-2" id="choosefileid" hidden>

																		<div class="col-md-6">
																			<input type="file" class="form-control form-control-sm" id="choosefile" name="updateAttachment"
																				accept=".csv, application/vnd.ms-excel,text/plain, application/pdf, image/*"> <span id="file_msgErrorId" class="msgError">File too Big,
																				please select a file less than 10 Mb</span>
																		</div>
																		<div class="col-md-2">
																			<input type="button" id="cancel_btn" class="btn btn-link ml-auto" value="Cancel" onclick="cancelbtn();">
																		</div>
																		<div class="p-3 pt-2" id="tableData" hidden>
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
																							<td class="col-md-6 "><input type="text" id="discrip" class="form-control"></td>
																							<td class="col-md-6 "><textarea type="textarea" id="description" class="required form-control" rows="2" cols="50" name="descriptionforfile"
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
											<div class="d-flex justify-content-end mt-4">
												<button type="button" class="btn bg-gradient-info" id="tasklogid" onclick="updatetasklog();">Update</button>
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
		<!-- Modal for Edit TimeLog End -->
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
	var projectid = 0;
	var hoursTotal= 0;
	
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

	$(function() {
		checkSession();
		projectid = sessionStorage.getItem("projectid");
		var projectname = sessionStorage.getItem("projectname");
		$("#projectnameid").text(projectname);
		var company_id = '<%= session.getAttribute("companyID") %>';
		console.log("company id is ",company_id);
		loadAssigneeList();
		loadActivity();
		loadTaskTypeList();
		loadTaskPriorityList();
		loadTaskStatusList();
		loadProjectList();
		loadDepartmentList();

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
	
	 // When Add All checkbox for add all employees to project
    $("#addAllEmployeesId").click(function(){
        $(".employees").prop("checked", this.checked);
    });
 	// When any followers checkbox is clicked
	function checkemployees(){
        if($('.employees:checked').length == $('.employees').length){
            $('#addAllEmployeesId').prop('checked',true);
        }else{
            $('#addAllEmployeesId').prop('checked',false);
        }
	}
	// function for manage file input and buttons 
	function togglefunction() {
		$("#upFile").prop("hidden", true);
		$("#choosefileid").prop("hidden", false);
		$("#cancel_btn").prop("hidden", false);
		$("#choosefile").prop("hidden", false);
	}

	$("#choosefile").change(function(e) {
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
		$("#savebtn").click(function() {
		if (validateServiceDetails('attachForm_Id')) {
			$("#upFile").prop("hidden", false);
			$("#tableData").prop("hidden", true);
			$("#btnFile1").prop("hidden", false);
			$("#choosefile").prop("hidden", true);
			$("#cancel_btn").prop("hidden", true);
			$("#choosefileid").prop("hidden", true);
			uploadFile();
		}
		});
	function cancelbtn() {
		$("#choosefile").prop("hidden", true);
		$("#choosefile").val("");
		$("#upFile").prop("hidden", false);
		$("#cancel_btn").prop("hidden", true);
		$("#tableData").prop("hidden", true);
		$("#description").val("");
		$("#msgError_description").css("display", "none");
		$("#file_msgErrorId").css("display", "none");
	}
	//--------------------End -----------------------------
 

	function showSelectedViewforTaskList() {
		if ($('#tasklisttableviwid').is(":checked")) {
			$('#taskList-view').hide();
			$('#taskList_grid-view').show();

		} else {
			$('#taskList-view').show();
			$('#taskList_grid-view').hide();

		}
	}
	function showSelectedViewforMemberList() {
		if ($('#membertableviwid').is(":checked")) {
			$('#memberList-view').hide();
			$('#memberList_grid-view').show();

		} else {
			$('#memberList-view').show();
			$('#memberList_grid-view').hide();

		}
	}
	
	function loadMembers() {
		debugger;
		$('#cPageNumber').val(1);
		$('#memberstbodyforListId').empty();
		$('#membersbodyforGridId').empty();
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
						if (data.length % 2 == 0) {
							$('#loadmorememberlistid').prop('hidden', true);
							$('#loadmoremembersgridid').prop('hidden', true);
						}
						if (data.length < 10) {
							$('#loadmorememberlistid').prop('hidden', true);
							$('#loadmoremembersgridid').prop('hidden', true);
							
						}else {
							$('#loadmorememberlistid').prop('hidden', false);
							$('#loadmoremembersgridid').prop('hidden', false);
						}
						var jsonData = eval(data);
						if (jsonData.length > 0) {
							for (var i = 0; i < jsonData.length; i++) {
								var rowdata = jsonData[i];
								newRowContentforListView = getEmployeeRowforListView(rowdata);
								$("#memberstbodyforListId").append(
										newRowContentforListView);
								
								newRowContentForGridView = createMemberRowForGrid(rowdata);
								$('#membersbodyforGridId').append(newRowContentForGridView);
								
							}
						} else {
							$("#memberstbodyforListId")
									.append(
											"<tr><td colspan='8'><center><b style='color:red'>No Members Found....<b></center></td></tr>");
							$('#membersbodyforGridId').append("<div><center><b style='color:red'>No Members Found....<b></center></div>");

						}
					},
					error : function(data) {
						alert("Error in process. Please try again.");
					}
				});
	}

	function loadMoreMembers() {
// 		$('#memberstbodyforListId').empty();
		if ($('#cPageNumber').val() != '') {
			var cPageNumber = parseInt($('#cPageNumber').val()) + 1;
			$('#cPageNumber').val(cPageNumber)
		jQuery
				.ajax({
					type : "POST",
					url : "projectsemployee",
					data : {
						actionType : 'getprojectmembers',
						projectid : projectid,
						startIndex : 0,
						endIndex : 10,
						pageNo: cPageNumber
					},
					async : true,
					success : function(data) {
						console.log(data);
						if (data.length % 2 == 0) {
							$('#loadmorememberlistid').prop('hidden', true);
							$('#loadmoremembersgridid').prop('hidden', true);
						}
						if (data.length < 10) {
							$('#loadmorememberlistid').prop('hidden', true);
							$('#loadmoremembersgridid').prop('hidden', true);
							
						}else {
							$('#loadmorememberlistid').prop('hidden', false);
							$('#loadmoremembersgridid').prop('hidden', false);
						}
						var jsonData = eval(data);
						if (jsonData.length > 0) {
							for (var i = 0; i < jsonData.length; i++) {
								var rowdata = jsonData[i];
								newRowContentforListView = getEmployeeRowforListView(rowdata);
								$("#memberstbodyforListId").append(
										newRowContentforListView);

								newRowContentForGridView = createMemberRowForGrid(rowdata);
								$('#membersbodyforGridId').append(newRowContentForGridView);
							}
						} else {
// 							$("#memberstbodyforListId")
// 									.append(
// 											"<tr><td colspan='8'><center><b style='color:red'>No Members Found....<b></center></td></tr>");

						}
					},
					error : function(data) {
						alert("Error in process. Please try again.");
					}
				});
	}
}
	function createMemberRowForGrid(data) {
		var rowData = '<div class="col-xl-3 col-md-6 mb-xl-0 mb-4" id="EmployeeRow-row-'+ data.project_employee_id +'" >';
		rowData += "<div class='card'>";
		rowData += "<div class='card-header p-0'>";
		rowData += "</div>";
		rowData += "<div class='card-body p-3'><a href='javascript:;'><h5>"
				+ data.employee_name + "</h5></a>";
		rowData += "<p class='mb-4 text-sm'>" + data.employee_email + "</p>";
		rowData += "<div class='d-flex align-items-center justify-content-between'>";
		rowData += "<p class='text-sm'>" + data.employee_dempartment + "</p>";
		rowData += "<p class='text-sm'>Role = " + data.employee_role + "</p>";
		rowData += "<div><a class='btn btn-link text-danger text-gradient px-1 mb-0' data-bs-toggle='modal' data-bs-target='#exampleModal' onclick='deleteProjectEmployeeById("
				+ data.project_employee_id
				+ ");'><i class='material-icons text-sm me-2'>delete</i></a></div>";
		rowData += "</div>";
		rowData += "</div>";
		rowData += "</div>";
		rowData += "</div>";
		rowData += "</div>";
        return rowData;
	}
	
	
	function getEmployeeRowforListView(data) {
		
		
		
		var rowData = '<tr id ="member-row-'+ data.project_employee_id +'">';
		rowData += "<td><a class='text-danger cursor-pointer'  onclick='deleteProjectEmployeeById("
				+ data.project_employee_id
				+ ");'><i class='material-icons text-sm me-2'>delete</i></a></td>";
		rowData += "<td><img  class=\"avatar border-radius-profile me-2\" src='uploads/avatar/"+ data.employee_profile_avatar +"'> "
				+ data.employee_name + "</td>";
		rowData += "<td>" + data.employee_email + "</td>";
		rowData += "<td>" + data.employee_dempartment + "</td>";
		rowData += "<td>" + data.employee_role + "</td>";
		rowData += "<tr/>";
		return rowData;
	}
	function searchForNewMember(searchKeyword) {
		console.log(searchKeyword + " " + searchKeyword.length);
		$('#memberlistid').empty();
		jQuery.ajax({
			type : "POST",
			url : "projectsemployee",
			data : {
				actionType : 'getnewmembers',
				projectid : projectid,
				searchkeyword : searchKeyword,
				departmentid : $('#searchMemberDept_id').val()
			},
			async : true,
			success : function(data) {
				console.log(data);
				var jsonData = eval(data);
				if (jsonData.length > 0) {
					for (var i = 0; i < jsonData.length; i++) {
						var rowdata = jsonData[i];
						newRowContent = getRowData(rowdata);
						$("#memberlistid").append(newRowContent);
					}
				}
			},
			error : function(data) {
				alert("Error in process. Please try again.");
			}
		});
	}
	
	
	function showNewMemberModel(){
		$('#searchMemberDept_id').val('0');
		$('#addAllEmployeesId').prop('checked',false);
		$('#newmemberModal').modal("show");
		 getNewMembers();
	}
	
	
	function getNewMembers(){
		$('#memberlistid').empty();
		jQuery.ajax({
			type : "POST",
			url : "projectsemployee",
			data : {
				actionType : 'getnewmembers',
				projectid : projectid,
				searchkeyword : '',
				departmentid : $('#searchMemberDept_id').val()
			},
			async : true,
			success : function(data) {
				console.log('member data',data);
				$('#addAllEmployeesId').prop('checked',false);
				var jsonData = eval(data);
				if (jsonData.length > 0) {
					for (var i = 0; i < jsonData.length; i++) {
						var rowdata = jsonData[i];
						newRowContent = getRowData(rowdata);
						$("#memberlistid").append(newRowContent);
					}
				}
			},
			error : function(data) {
				alert("Error in process. Please try again.");
			}
		});
	}
	
	function savenewmembers() {
		$("#memberlistid input[type=checkbox]:checked").each(function() {
			jQuery.ajax({
				type : "POST",
				url : "projectsemployee",
				data : {
					actionType : 'addnewmembers',
					projectid : projectid,
					employeeid : this.value
				},
				async : false,
				success : function(data) {
					console.log(data);

				},
				error : function(data) {
					alert("Error in process. Please try again.");

				}
			});
		});
		loadAssigneeList();
		$('#memberlistid').empty();
		$('#newmemberModal').modal("hide");
		loadMembers();

	}

	function getRowData(data) {
		var rowData = "<div class=\"col-lg-4 col-md-6 col-sm-12\">";
		rowData += "<div class=\"d-flex px-2 py-1\">";
		rowData += "<div class=\"form-check px-2 py-1\">";
		rowData += "<input class=\"form-check-input employees\" type=\"checkbox\" onchange=\"checkemployees();\" name='chknewmember' value='"+data.employee_id+"' id='nmemberid_"+data.employee_id+"'></div>";
		rowData += "<div><img src='uploads/avatar/"+ data.employee_profile_avatar +"' class=\"avatar avatar-sm me-3\" alt=\"avatar image\">";
		rowData += "</div>";
		rowData += "<div class=\"d-flex flex-column justify-content-center\">";
		rowData += "<h6 class=\"mb-0 font-weight-normal text-sm\">"
				+ data.employee_name + "</h6>";
		rowData += "</div>";
		rowData += "</div>";
		rowData += "</div>";
		return rowData;
	}

	function getFollowerRowData(data) {
		var rowData = "<div class=\"col-lg-3 col-md-6 col-sm-12\">";
		rowData += "<div class=\"d-flex px-2 py-1\">";
		rowData += "<div class=\"form-check px-2 py-1\">";
		rowData += "<input class=\"form-check-input followers\" type=\"checkbox\" onchange=\"checkfollowers();\" name='chkfollowmember' value='"+data.employee_id+"' id='fmemberid_"+data.employee_id+"'></div>";
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
	function deleteProjectEmployeeById(projectemployeeid) {
		$("#deleteID").val(projectemployeeid);
		$('#deleteModal').modal("show");
		$("#deleteBtnID").attr("onclick", "deleteProjectEmployee()");
	}

	function deleteProjectEmployee() {
		var memberId = $("#deleteID").val();
		jQuery.ajax({
			type : "POST",
			url : "projectsemployee",
			data : {
				actionType : 'deleteprojectemplpyee',
				projectEmployeeID : memberId
			},
			async : true,
			success : function(data) {
				console.log(data);
				$('#deleteModal').modal("hide");
				//loadMembers();
				//loadAssigneeList()
				$('#member-row-'+ memberId).remove();
			},
			error : function(data) {
				alert("Error in process. Please try again.");
				loadMembers();
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

	function showNewTaskModel() {
		
		loadFollowers($('#searchdepartment_id').val()); 
		document.getElementById('save&createid').style.visibility = 'visible';
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
		$('#done_value_id').val('0');
		$('#searchdepartment_id').val('0');
		$('#followerlistid').empty();
		$('#msgError_project_id').hide();
		$('#msgError_assignee_id').hide();
		$('#msgError_task_name_id').hide();
		$('#msgError_task_description_id').hide();
	}

	function showNewTaskModalAgain() {
		loadFollowers($('#searchdepartment_id').val()); 
		$("#newTaskLabel").text("Create Task");
		$('#action_type_id').val('createtask');
		$("#taskactionid").html("Save");
		$("#taskactionid").attr("onclick", "cearenewtask()");
		$('#task_name_id').val('');
		$('#task_description_id').val('');
		$('#taskStatus_id').val('1');
		$('#taskType_id').val('');
		$('#taskPriority_id').val('');
		$('#assignee_id').val('');
		$('#searchdepartment_id').val('0');
		$('#start_date_id').val(today());
		$('#due_date_id').val(currdateTime());
		$('#estimeted_time_id').val('');
		$('#done_value_id').val('0');
		$("#newTask").modal('show');
	}

	function loadAssigneeList() {
		$('#filterassigneeid').empty();
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
						console.log("assignee list", data);
						var jsonData = eval(data);
						if (jsonData.length > 0) {
							var htmlData = '<option value="0">Select Assignee</option>';
							// $('#assignee_id').append(htmlData);
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

	function cearenewtask() {
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
					projectId : projectid,
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
				success : function(data) {
					console.log(data);
					$('#newTask').modal("hide");
					loadTaskList();
				},
				error : function(data) {
					alert("Error in process. Please try again.");
				}
			});
		}

	}

	function loadTaskList() {
		$('#cPageNo').val(1);
		$('#taskbodyforListId').empty();
		$('#taskbodyforGridId').empty();
		jQuery
				.ajax({
					type : "POST",
					url : "tasks",
					data : {
						actionType : 'tasklist',
						projectId : projectid,
						filterTask : $('#filtertasknameid').val(),
						filterStatus : $('#filtertaskstatusid').val(),
						filterAssignee : $('#filterassigneeid').val(),
						startIndex : 0,
						endIndex : 10,
					},
					async : true,
					success : function(data) {
						if (data.length % 2 == 0) {
							$('#loadmoreid').prop('hidden', true);
							$('#loadmoregridid').prop('hidden', true);
						}
						if (data.length < 10) {
							$('#loadmoreid').prop('hidden', true);
							$('#loadmoregridid').prop('hidden', true);
						}else {
							$('#loadmoreid').prop('hidden', false);
							$('#loadmoregridid').prop('hidden', false);
						}
						console.log(data);
						var jsonData = eval(data);
						if (jsonData == 0) {
							var htmlMsg = "<tr><td colspan='8'><center><b style='color:red'>No Task Found....<b></center></td></tr>";
							$("#taskbodyforListId").append(htmlMsg);
							$("#taskbodyforGridId")
									.append(
											"<div><center><b style='color:red'>No records found....<b></center></div>");

						} else {
							for (var i = 0; i < jsonData.length; i++) {
								var rowdata = jsonData[i];
								var newtaskrowforList = createtaskrowforList(rowdata);
								$('#taskbodyforListId').append(
										newtaskrowforList);
								
								var newtaskrowforGrid = createtaskrowforGrid(rowdata)
								$("#taskbodyforGridId").append(newtaskrowforGrid);
							}
						}
					},
					error : function(data) {
						alert("Error in process. Please try again.");
					}
				});
	}

	function loadMoreTasks() {
		//$('#taskbodyforListId').empty();
		if ($('#cPageNo').val() != '') {
			var cpage = parseInt($('#cPageNo').val()) + 1;
			$('#cPageNo').val(cpage)
			jQuery
					.ajax({
						type : "POST",
						url : "tasks",
						data : {
							actionType : 'tasklist',
							projectId : projectid,
							filterTask : $('#filtertasknameid').val(),
							filterStatus : $('#filtertaskstatusid').val(),
							filterAssignee : $('#filterassigneeid').val(),
							startIndex : 0,
							endIndex : 10,
							pageNo : cpage
						},
						async : true,
						success : function(data) {
							console.log(data);
							if (data.length % 2 == 0) {
								$('#loadmoreid').prop('hidden', true);
								$('#loadmoregridid').prop('hidden', true);
							}
							if (data.length < 10) {
								$('#loadmoreid').prop('hidden', true);
								$('#loadmoregridid').prop('hidden', true);
							}else {
								$('#loadmoreid').prop('hidden', false);
								$('#loadmoregridid').prop('hidden', false);
							}
							var jsonData = eval(data);
							if (jsonData == 0) {
								var htmlMsg = "<tr><td colspan='8'><center><b style='color:red'>No Task Found....<b></center></td></tr>";
								// 							$("#taskbodyforListId").append(htmlMsg);
								// 							$("#taskbodyforGridId")
								// 									.append(
								// 											"<div><center><b style='color:red'>No records found....<b></center></div>");

							} else {
								for (var i = 0; i < jsonData.length; i++) {
									var rowdata = jsonData[i];
									var newtaskrowforList = createtaskrowforList(rowdata);
									$('#taskbodyforListId').append(
											newtaskrowforList);
									
									var newtaskrowforGrid = createtaskrowforGrid(rowdata)
									$("#taskbodyforGridId").append(newtaskrowforGrid);
								}
							}
						},
						error : function(data) {
							alert("Error in process. Please try again.");
						}
					});
		}
	}

	function createtaskrowforGrid(data) {
		var rowData = "<div class='col-xl-3 col-md-6 mb-xl-0 mb-4'>";
		rowData += "<div class='card'>";
		rowData += "<div class='card-header p-0'> #" + data.taskId;
		rowData += "</div>";
		rowData += "<div class='card-body p-3'><p class='mb-0 text-sm'>"
				+ data.taskType
				+ " "
				+ createStatusElement(data.taskStatusId, data.taskStatus)
			+ " "
				+ createPriorityElement(data.taskPriorityId, data.taskPriority,
						data.taskStatusType)
				+ "</p><a href='javascript:;'><h5>" + data.taskName
				+ "</h5></a>";
		rowData += "<p class='mb-4 text-sm'>" + data.assigneeName + "</p>";

		rowData += "<div class='d-flex align-items-center justify-content-between'>";
		rowData += "<p class='text-sm'>" + data.lastUpdatedDate + "</p>";
		rowData += "<div><a href='updatetask.jsp' class='btn btn-link text-dark px-1 mb-0' onclick='redirectEditTask("
				+ data.taskId
				+ ")'><i class='material-icons text-sm me-2'>edit</i></a><a class='btn btn-link text-danger text-gradient px-1 mb-0'  onclick='deleteTaskById("
				+ data.taskId
				+ ");'><i class='material-icons text-sm me-2'>delete</i></a></div>";
		rowData += "</div>";
		rowData += "</div>";
		rowData += "</div>";
		rowData += "</div>";
		rowData += "</div>";
		return rowData;

	}
	
	function createtaskrowforList(data) {
// 		console.log(data.taskId, "taskid");
		var rowData = "<tr id ='task-row-"+ data.taskId + "'>";
		rowData += "<td><a href='updatetask.jsp' class='text-dark cursor-pointer' onclick='redirectEditTask("
				+ data.taskId
				+ ")'><i class='material-icons text-sm me-2'>edit</i></a><a class='text-danger cursor-pointer'  onclick='deleteTaskById("
				+ data.taskId
				+ ");'><i class='material-icons text-sm me-2'>delete</i></a></td>";
		rowData += "<td>#" + data.taskId + "</td>";
		rowData += "<td>" + data.taskType + "</td>";
		rowData += "<td>"
				+ createStatusElement(data.taskStatusId, data.taskStatus,
						data.taskStatusType) + "</td>";
		rowData += "<td>"
				+ createPriorityElement(data.taskPriorityId, data.taskPriority,
						data.taskPriorityType) + "</td>";
		rowData += "<td>" + data.taskName + "</td>";
		rowData += "<td>" + data.assigneeName + "</td>";
		rowData += "<td>" + data.lastUpdatedDate + "</td>";
		rowData += "<tr/>";
		return rowData;
	}

	function redirectEditTask(taskId) {
		sessionStorage.setItem("taskId", taskId);
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
				/* async : true, */
				success : function(data) {
					console.log(data);
					$('#newTask').modal("hide");
					loadTaskList();
				},
				error : function(data) {
					alert("Error in process. Please try again.");
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
		var taskId= $('#deleteID').val();
		jQuery.ajax({
			type : "POST",
			url : "tasks",
			data : {
				actionType : 'deletetask',
				taskId : taskId
			},
			async : true,
			success : function(data) {
				console.log(data);
				$('#deleteModal').modal("hide");
			//	loadTaskList();
				$('#task-row-'+taskId).remove();
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
		 $('#addAllcheckboxId').prop('checked',false);
		$('#followerlistid').empty();
		jQuery.ajax({
			type : "POST",
			url : "projectsemployee",
			data : {
				actionType : 'getprojectmembers',
				projectid : projectid,
				departmentid : departmentid,
				listType : "getFollowers",
			},
			async : true,
			success : function(data) {
				console.log(data, "follower list");
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
	function loadActivity() {
		
		$('#errormessageforfromdateId').hide();			
		$('#errormessagefortodateId').hide();
		$('#errMsgDateCompare').hide();
		$('#errormessagefordiffDaysId').hide();
		
		var activityFilter = $('#activityselect_filter_id').val();
		
		if( activityFilter == 'custom_dates'){
			var from_date = $("#activityFilterStartDateid").val();
			var to_date = $("#activityFilterEndDateid").val();
			
			var date1 = new Date(from_date);
			var date2 = new Date(to_date);
			var diffTime = Math.abs(date2 - date1);
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
		
		console.log('loading taskLog Activity.....');
		loadTaskActivityList();
		$('#currentPageNumber').val(1);
		jQuery
				.ajax({
					type : "POST",
					url : "workspace",
					data : {
						actionType : 'getActivityLogList',
						projectid : projectid,
						searchBy : $("#activityselect_filter_id").val(),
						filterStartDateid : $("#activityFilterStartDateid")
								.val(),
						filterEndDate : $("#activityFilterEndDateid").val(),
						startIndex: 0,
						endIndex: 10,
					},
					async : true,
					success : function(data) {
						
						console.log("activity data ",data);
						var jsonData = eval(data);
						$("#activityLogbodyId").empty();
						if(data.length < 10){
							$('#loadmoreactivityid').prop('hidden', true);
						}else{
							$('#loadmoreactivityid').prop('hidden', false);
						}
						if (jsonData.length == 0) {
							var htmlMsg = "<center><b style='color:red'>No Activity Found....<b></center>";
							$("#activityLogbodyId").append(htmlMsg);
						} else {
							var dateGroup = jsonData[0].groupDate.split(' ')[0];
							for (var i = 0; i < jsonData.length; i++) {
								if (i == 0
										|| dateGroup != jsonData[i].groupDate
												.split(' ')[0]) {
									var headingDate = jsonData[i].groupDate
											.split(' ')[0];
									var dateRow = "<h6 class=\"groupDate \">"
											+ moment(headingDate).format(
													'DD MMM YYYY');
									+"</h6>";
									$("#activityLogbodyId").append(dateRow);
									dateGroup = jsonData[i].task_log_created_on
											.split(' ')[0];
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
	
function loadMoreActivity() {
		
		$('#errormessageforfromdateId').hide();			
		$('#errormessagefortodateId').hide();
		$('#errMsgDateCompare').hide();
		$('#errormessagefordiffDaysId').hide();
		
		var activityFilter = $('#activityselect_filter_id').val();
		
		if( activityFilter == 'custom_dates'){
			var from_date = $("#activityFilterStartDateid").val();
			var to_date = $("#activityFilterEndDateid").val();
			
			var date1 = new Date(from_date);
			var date2 = new Date(to_date);
			var diffTime = Math.abs(date2 - date1);
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
		
		console.log('loading taskLog Activity.....');
		loadTaskActivityList();
		if ($('#currentPageNumber').val() != '') {
			var currentPageNumber = parseInt($('#currentPageNumber').val()) + 1;
			$('#currentPageNumber').val(currentPageNumber)
		jQuery
				.ajax({
					type : "POST",
					url : "workspace",
					data : {
						actionType : 'getActivityLogList',
						projectid : projectid,
						searchBy : $("#activityselect_filter_id").val(),
						filterStartDateid : $("#activityFilterStartDateid")
								.val(),
						filterEndDate : $("#activityFilterEndDateid").val(),
						startIndex: 0,
						endIndex: 10,
						pageNo: currentPageNumber
					},
					async : true,
					success : function(data) {
						console.log("activity data ",data);
						if (data.length % 2 == 0) {
							$('#loadmoreactivityid').prop('hidden', true)
						}
						if(data.length < 10){
							$('#loadmoreactivityid').prop('hidden', true)
						}else {
							$('#loadmoreactivityid').prop('hidden', false)
						}
						var jsonData = eval(data);
// 						$("#activityLogbodyId").empty();
						
						if (jsonData.length == 0) {
// 							var htmlMsg = "<center><b style='color:red'>No Activity Found....<b></center>";
							$("#activityLogbodyId").append(htmlMsg);
						} else {
							var dateGroup = jsonData[0].groupDate.split(' ')[0];
							for (var i = 0; i < jsonData.length; i++) {
								if (i == 0
										|| dateGroup != jsonData[i].groupDate
												.split(' ')[0]) {
									var headingDate = jsonData[i].groupDate
											.split(' ')[0];
									var dateRow = "<h6 class=\"groupDate \">"
											+ moment(headingDate).format(
													'DD MMM YYYY');
									+"</h6>";
									$("#activityLogbodyId").append(dateRow);
									dateGroup = jsonData[i].task_log_created_on
											.split(' ')[0];
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
}
	
	
	
	
	function createActivityLogrow(data) {
		var rowData = "<div class=\"d-flex mb-2\">";
		rowData += "<div class=\"flex-shrink-0\">";
		rowData += "<img  class=\"avatar rounded-circle\" src='uploads/avatar/"+ data.employee_profile_avatar +"'>";
		rowData += "</div>";
		rowData += "<div class=\"flex-grow-1 ms-3\">";
		rowData += "<h6 class=\"h6 mt-0 mb-0\">" + data.createdBy_employee_name
				+ " </h6> <span class=\"text-sm text-color-gray\"> On: "
				+ data.task_log_created_on + "<span>";
		rowData += "<p class=\"text-sm text-info linebreak mb-0\">"
				+ data.task_name + "</p>";
		rowData += "<p class=\"text-sm text-color-black linebreak\">"
				+ "Time Log: " + data.log_hours + " hours On " + data.log_date
				+ ". " + data.taskComments + "</p>";
		if(data.document_name != null){
			rowData += "<span class='docIcons text-info'><a href='#' class='text-info cursor-pointer' id='viewAttachment' onclick='viewAttachment("+data.task_id +","+ data.document_id+ ");'><i class='material-icons text-sm me-2'>preview</i></a><a href='tasks?actionType=downloadAttachment&taskid="
			+ data.task_id
			+ "&document_name="
			+ data.document_name
			+ "&isadditional=1' target='_top' class='text-info cursor-pointer' id='downloadAttachmentId' ><i class='material-icons text-sm me-2'>download</i></a>"+ data.document_name+"</span>";
		}
		rowData += "</div>";
		rowData += "</div>";
		return rowData;
	}
	
	function loadTimeLogList() {
		hoursTotal = 0;
		$('#errormessageforfromdateIdTime').hide();	
		$('#errormessagefortodateIdTime').hide()				
		$('#errMsgDateCompareTime').hide();
		$('#errormessageforloaddiffDaysId').hide();
		
       var timeLogFilter = $('#timeLogselect_filter_id').val();
		
		if( timeLogFilter == 'custom_dates'){
			var from_date = $("#timeLogFilterStartDateid").val();
			var to_date = $("#timeLogFilterEndDateid").val();
			
			var date1 = new Date(from_date);
			var date2 = new Date(to_date);
			var diffTime = Math.abs(date2 - date1);
			var diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24)); 
			
			if (from_date == ""){
				$('#errormessageforfromdateIdTime').show();					
			}
			else if(to_date == "") {
				$('#errormessageforfromdateIdTime').hide();	
				$('#errormessagefortodateIdTime').show();	
			}
			else if (from_date > to_date ){
				$('#errormessageforfromdateIdTime').hide();	
				$('#errormessagefortodateIdTime').hide();				
				$('#errMsgDateCompareTime').show();		
			}
			else if (diffDays > 90){
				$('#errormessageforfromdateId').hide();			
				$('#errormessagefortodateId').hide();
				$('#errMsgDateCompare').hide();	
				
				$('#errormessageforloaddiffDaysId').show();	
				return;
			}
		
			else {
				$('#errormessageforfromdateIdTime').hide();	
				$('#errormessagefortodateIdTime').hide()				
				$('#errMsgDateCompareTime').hide();	
				$('#errormessageforloaddiffDaysId').hide();	
			}
		}
		$('#currentPageNo').val(1);
		jQuery
				.ajax({
					type : "POST",
					url : "workspace",
					data : {
						actionType : 'getTaskLogList',
						projectid : projectid,
						searchBy : $("#timeLogselect_filter_id").val(),
						filterStartDateid : $("#timeLogFilterStartDateid")
								.val(),
						filterEndDate : $("#timeLogFilterEndDateid").val(),
						startIndex : 0,
						endIndex : 10,
					},
					async : true,
					success : function(data) {
						$(".value").empty();
						if (data.length % 2 == 0) {
							$('#loadmorelogid').prop('hidden', true);
							$('#loadmoreloggridid').prop('hidden', true);
						}
						if (data.length < 10) {
							$('#loadmorelogid').prop('hidden', true);
							$('#loadmoreloggridid').prop('hidden', true);
							
						}else {
							$('#loadmorelogid').prop('hidden', false);
							$('#loadmoreloggridid').prop('hidden', false);
						}
						
						var jsonData = eval(data);
						$("#taskLogbodyforListId").empty();
						$("#taskLogbodyforGridId").empty();
						if (jsonData.length == 0) {
							var htmlMsg = "<tr><td colspan='8'><center><b style='color:red'>No Time Log Found....<b></center></td></tr>";
							$("#taskLogbodyforListId").append(htmlMsg);
							$("#taskLogbodyforGridId").append("<div><center><b style='color:red'>No records found....<b></center></div>");
						} else {
							for (var i = 0; i < jsonData.length; i++) {
								var rowdata = jsonData[i];

								newRowContentforListView = createtaskLogrowListView(rowdata);
								$("#taskLogbodyforListId").append(
										newRowContentforListView);
								
								newRowContentForGridView = createtaskLogrowGridView(rowdata);
								$('#taskLogbodyforGridId').append(newRowContentForGridView);
								hoursTotal = hoursTotal + jsonData[i].log_hours;
							}
						}
						$(".value").append(hoursTotal);
					},
					error : function(data) {
						alert("Error in process. Please try again.");
					}
				});
	}
	
	function loadMoreTimeLogList() {
		$('#errormessageforfromdateIdTime').hide();	
		$('#errormessagefortodateIdTime').hide()				
		$('#errMsgDateCompareTime').hide();
		$('#errormessageforloaddiffDaysId').hide();
		
       var timeLogFilter = $('#timeLogselect_filter_id').val();
		
		if( timeLogFilter == 'custom_dates'){
			var from_date = $("#timeLogFilterStartDateid").val();
			var to_date = $("#timeLogFilterEndDateid").val();
			
			var date1 = new Date(from_date);
			var date2 = new Date(to_date);
			var diffTime = Math.abs(date2 - date1);
			var diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24)); 
			
			if (from_date == ""){
				$('#errormessageforfromdateIdTime').show();					
			}
			else if(to_date == "") {
				$('#errormessageforfromdateIdTime').hide();	
				$('#errormessagefortodateIdTime').show();	
			}
			else if (from_date > to_date ){
				$('#errormessageforfromdateIdTime').hide();	
				$('#errormessagefortodateIdTime').hide();				
				$('#errMsgDateCompareTime').show();		
			}
			else if (diffDays > 90){
				$('#errormessageforfromdateId').hide();			
				$('#errormessagefortodateId').hide();
				$('#errMsgDateCompare').hide();	
				
				$('#errormessageforloaddiffDaysId').show();	
				return;
			}
		
			else {
				$('#errormessageforfromdateIdTime').hide();	
				$('#errormessagefortodateIdTime').hide()				
				$('#errMsgDateCompareTime').hide();	
				$('#errormessageforloaddiffDaysId').hide();	
			}
		}
		if ($('#currentPageNo').val() != '') {
			var currentPageNo = parseInt($('#currentPageNo').val()) + 1;
			$('#currentPageNo').val(currentPageNo)
		jQuery
				.ajax({
					type : "POST",
					url : "workspace",
					data : {
						actionType : 'getTaskLogList',
						projectid : projectid,
						searchBy : $("#timeLogselect_filter_id").val(),
						filterStartDateid : $("#timeLogFilterStartDateid")
								.val(),
						filterEndDate : $("#timeLogFilterEndDateid").val(),
						startIndex : 0,
						endIndex : 10,
						pageNo: currentPageNo,
					},
					async : true,
					success : function(data) {
						$(".value").empty();
						if (data.length % 2 == 0) {
							$('#loadmorelogid').prop('hidden', true);
							$('#loadmoreloggridid').prop('hidden', true);
						}
						if (data.length < 10) {
							$('#loadmorelogid').prop('hidden', true);
							$('#loadmoreloggridid').prop('hidden', true);
							
						}else {
							$('#loadmorelogid').prop('hidden', false);
							$('#loadmoreloggridid').prop('hidden', false);
						}
						
// 						var hoursTotal = 0;
						var jsonData = eval(data);
// 						$("#taskLogbodyforListId").empty();
						if (jsonData.length == 0) {
							var htmlMsg = "<tr><td colspan='8'><center><b style='color:red'>No Time Log Found....<b></center></td></tr>";
// 							$("#taskLogbodyforListId").append(htmlMsg);
						} else {
							for (var i = 0; i < jsonData.length; i++) {
								var rowdata = jsonData[i];

								newRowContentforListView = createtaskLogrowListView(rowdata);
								$("#taskLogbodyforListId").append(
										newRowContentforListView);
								newRowContentForGridView = createtaskLogrowGridView(rowdata);
								$('#taskLogbodyforGridId').append(newRowContentForGridView);
								hoursTotal = hoursTotal + jsonData[i].log_hours;
							}
						}
						$(".value").append(hoursTotal);
					},
					error : function(data) {
						alert("Error in process. Please try again.");
					}
				});
		}
	}
	
	

	function createtaskLogrowListView(data) {
		var rowData = '<tr id ="tasklogId-row-'+ data.task_log_id +'">';
		rowData += "<td><a class='text-dark cursor-pointer'  onclick='editTaskLog("
				+ data.task_log_id
				+ ");'><i class='material-icons text-sm me-2'>edit</i></a><a class='text-danger cursor-pointer'  onclick='showdeleteFortaskLog("
				+ data.task_log_id
				+ ");'><i class='material-icons text-sm me-2'>delete</i></a></td>";
		rowData += "<td>" + data.log_date + "</td>";
		rowData += "<td><img  class=\"avatar border-radius-profile me-2\" src='uploads/avatar/"+ data.employee_profile_avatar +"'> "
				+ data.createdBy_employee_name + "</td>";

		rowData += "<td>" + data.task_name + "</td>";
		rowData += "<td>" + data.estimated_hours + "</td>";
		rowData += "<td>" + data.log_hours + "</td>";
		rowData += "<td class='linebreak' style='white-space:break-spaces'>"
				+ data.taskComments + "</td>";
		rowData += "<td>" + data.task_log_created_on + "</td>";
		rowData += "<td>" + data.task_activity_name + "</td>";
		rowData += "<tr/>";
		return rowData;
	}
	function createtaskLogrowGridView(data) {
		var rowData = "<div class='col-xl-3 col-md-6 mb-xl-0 mb-4'>";
		rowData += "<div class='card'>";
		rowData += "<div class='card-header p-0'>";
		rowData += "</div>";
		rowData += "<div class='card-body p-3'><p class='mb-0 text-sm'>"
				+ data.log_date + "</p><a href='javascript:;'><h5>"
				+ data.createdBy_employee_name + "</h5></a>";
		rowData += "<p class='mb-4 text-sm'>" + data.taskComments + "</p>";
		rowData += "<div class='d-flex align-items-center justify-content-between'>";
		rowData += "<p class='text-sm'>" + data.task_activity_name + "</p>";
		rowData += "<p class='text-sm'>Hours = " + data.log_hours + "</p>";
		rowData += "<div><a class='btn btn-link text-dark px-1 mb-0' data-bs-toggle='modal' data-bs-target='#updateModal' onclick='editTaskLog("
				+ data.task_log_id
				+ ");'><i class='material-icons text-sm me-2'>edit</i></a><a class='btn btn-link text-danger text-gradient px-1 mb-0' data-bs-toggle='modal' data-bs-target='#exampleModal' onclick='showdeleteFortaskLog("
				+ data.task_log_id
				+ ");'><i class='material-icons text-sm me-2'>delete</i></a></div>";
		rowData += "</div>";
		rowData += "</div>";
		rowData += "</div>";
		rowData += "</div>";
		rowData += "</div>";
        return rowData;
	}
	function showdeleteFortaskLog(task_logId) {
		$("#deleteID").val(task_logId);
		$('#deleteModal').modal("show");
		$("#deleteBtnID").attr("onclick", "deleteTaskLogById()");
	}

	function deleteTaskLogById() {
		jQuery.ajax({
			type : "POST",
			url : "workspace",
			data : {
				actionType : 'deleteTaskLog',
				task_log_id : $("#deleteID").val()
			},
			async : true,
			success : function(data) {
				console.log("TaskLog Deleted " + data);
				//loadTimeLogList()
				$('#tasklogId-row-'+task_log_id).remove();
			},
			error : function(data) {
				alert("Error in process. Please try again.");
			}
		});
	}

	function editTaskLog(task_log_id) {
		$("#choosefileid").prop("hidden", true);
		$("#choosefile").prop("hidden", true);
		$("#choosefile").val("");
		$("#upFile").prop("hidden", false);
		$("#cancel_btn").prop("hidden", true);
		$("#tableData").prop("hidden", true);
		$("#description").val("");
		$("#file_msgErrorId").css("display", "none");
		$("#msgError_description").css("display", "none");
		$("#uploadFilebtnId").prop("disabled", false);
		$("#docsListId").prop("hidden", true);
		$("#documentBody").empty();
		jQuery.ajax({
			type : "POST",
			url : "workspace",
			data : {
				actionType : 'infoforEdit_task_log',
				task_log_id : task_log_id
			},
			async : true,
			success : function(data) {
				console.log("TaskLog editInfo_ " + data);
				
				$('#taskLogid_id').val(data.task_log_id);
				$('#taskid_id').val(data.task_id);
				$('#taskidforfile_id').val(data.task_id);
				$('#task_log_date_id').val(data.log_date);
				$('#task_log_hours_id').val(data.log_hours);
				$('#task_comments_id').val(data.taskComments);
				$('#taskActivity_id').val(data.task_activity_id);
				$("#msgError_task_log_date_id").css("display", "none");
				$("#msgError_log_hours_id").css("display", "none");
				$("#msgError_taskActivity_id").css("display", "none");
				$("#msgError_task_comments_id").css("display", "none");
				
				if(data.document_id != 0){
					$("#choosefile").prop("hidden", true);
					$("#choosefile").val("");
					$("#uploadFilebtnId").prop("disabled", true);
					$("#cancel_btn").prop("hidden", true);
					$("#docsListId").prop("hidden", false);
					var row = "";
					row += '<tr><td><a href="#" onclick="deleteAttachmentById('
							+ data.document_id
							+ ');"class="text-danger cursor-pointer"><i class="material-icons text-sm me-2">cancel</i></a><a href="#" class="text-info cursor-pointer" id="viewAttachment" onclick="viewAttachment('
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
							+ data.doc_discription
							+ '</td><td>'
							+ data.doc_created_on + '</td></tr>';
					$("#documentBody").append(row);
					sessionStorage.setItem("fileName",data.document_name);
				}
				$('#taskTimeLogforEdit').modal("show");
				
			},
			error : function(data) {
				alert("Error in process. Please try again.");
			}
		});
	}
	function updatetasklog() {
		console.log('update calling....');
		if (validateServiceDetails('tasklogformforEditId')) {
			jQuery.ajax({
				type : "POST",
				url : "workspace",
				data : {
					actionType : 'updatetasklog',
					task_log_id : $('#taskLogid_id').val(),
					taskId : $('#taskid_id').val(),
					logDate : $('#task_log_date_id').val(),
					logHours : $('#task_log_hours_id').val(),
					taskActivityId : $('#taskActivity_id').val(),
					taskComment : $('#task_comments_id').val()
				},
				async : true,
				success : function(data) {
					console.log(data);
					$('#taskTimeLogforEdit').modal("hide");
					loadTimeLogList();
				},
				error : function(data) {
					alert("Error in process. Please try again.");
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
	function viewProject(projectid) {
		sessionStorage.removeItem("projectid");
		sessionStorage.removeItem("projectname");
		sessionStorage.setItem("projectid", projectid);
		sessionStorage.setItem("projectname", $("#projectfilter_id :selected")
				.text());
		window.location = 'projectview.jsp';
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
	function uploadFile(){
		
		let formData = new FormData(); 
	   formData.append("updateAttachment", choosefile.files[0]);
	   formData.append("task_id", $('#taskidforfile_id').val());
	   formData.append("discription", $('#description').val());
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
								var DName = document.getElementById("documentBody");
								$("#documentBody").empty();
								if (data != null) {
									$("#choosefile").prop("hidden", true);
									$("#choosefile").val("");
									$("#uploadFilebtnId").prop("disabled", true);
									$("#cancel_btn").prop("hidden", true);
									$("#docsListId").prop("hidden", false);
									var row = "";
									row += '<tr><td><a href="#" onclick="deleteAttachmentById('
											+ data.document_id
											+ ');"class="text-danger cursor-pointer"><i class="material-icons text-sm me-2">cancel</i></a><a href="#" class="text-info cursor-pointer" id="viewAttachment" onclick="viewAttachment('
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
									$("#choosefile").prop("hidden", false);
									$("#choosefile").val("");
									$("#uploadFilebtnId").prop("disabled", false);
									$("#docsListId").prop("hidden", true);
								}
							},
							error : function(error) {
								alert(data);
							},
							processData : false,
							contentType : false,
						});  
					  
		}
	function viewAttachment(taskId, documentId) {
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
					// for server
					var attachmentFile = resp;
					window.open(attachmentFile, "Preview","width=800,height=500");
				}
			}
		});
	}
	function deleteAttachmentById(documentId) {
		$('#deleteModal').modal("show");
		$("#deleteBtnID").attr("onclick",
				"deleteAttachment(" + documentId + ")");
	}
	function deleteAttachment(documentId) {
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
				$("#uploadFilebtnId").prop("disabled", false);
				$("#description").val("");
				$("#docsListId").prop("hidden", true);
				$("#documentBody").empty();
				
			}
		})
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
								$('#searchMemberDept_id').append(htmlData);
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