<%@page import="java.util.Iterator"%>
<%@page import="com.dakshabhi.pms.customers.dtos.CCustomerDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ include file="/include/header.jsp"%>
<%@ page isELIgnored="false"%>
<link rel="stylesheet" href="https://cdn.datatables.net/1.12.1/css/jquery.dataTables.min.css">
<style>
.voicebtn {
	border: none;
	padding: 0;
	border-radius: 100%;
	font-size: 3em;
	color: #fff;
	padding: 0;
	margin: 0;
	background: red;
	position: relative;
	z-index: 999;
	display: inline-block;
	text-align: center;
	white-space: nowrap;
	vertical-align: middle;
	-ms-touch-action: manipulation;
	touch-action: manipulation;
	cursor: pointer;
}

.card.zoomed {
	padding-left: 5%;
	  width: 100%;
	  height: 88vh;
	  position: fixed;
	  top: 92px;
	  left: 0;
	  z-index: 9998;
	  transition: all 0.3s;
	}



.pulse-ring {
	position: relative;
	border-radius: 50%;
}

@-webkit-keyframes pulsate { 
	0% {
		-webkit-transform: scale(1, 1);
		opacity: 1;
	}
	100%
	{-webkit-transform : scale(1.3,1.3);
	opacity:0;
	}
}
::-webkit-scrollbar {
            width: 5px; /* Width of the scrollbar */
        }
::-webkit-scrollbar-thumb {
            background-color: #888; /* Color of the scrollbar thumb */
            border-radius: 1px; /* Rounded corners for the thumb */
        }
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
}

.button.btn.bg-gradient-dark.m-0.ms-2 {
	width: fit-content;
	width: min-content;
}

i.fa.fa-asterisk {
	color: #ff0000;
	font-size: xx-small;
}

.msgoptions {
	padding-left: 44px;
}

.taskMsgEdit {
	border-bottom-style: ridge;
	font-weight: bold;
	background-color: #e0dfdf6b;
}

#loadmoreid {
  padding: 10px 20px;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  position: absolute;
  bottom: -15;
  width: 100%; /* Button width set to 100% */
  text-align: center;
}
td:nth-child(3) {
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
						<div class="col-6">
							<ol class="breadcrumb">
								<li class="breadcrumb-item"><a i class="material-icons fixed-plugin-button-nav cursor-pointer " href='workspace.jsp'> home </i></a></li>
								<h6 class="font-weight-bolder mb-0 breadcrumb-item active">Tasks View</h6>
							</ol>
							<div class="sidenav-toggler sidenav-toggler-inner">
								<a href="javascript:;" class="nav-link text-body p-0">
									<div class="sidenav-toggler-inner">
										<i class="sidenav-toggler-line"></i> <i class="sidenav-toggler-line"></i> <i class="sidenav-toggler-line"></i>
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
			<div class="card card-plain">
				<div class="row">
					<div class="col-lg-6 col-sm-12">
						<div class="card ">
							<div class="card-header p-2">
								<div class="row">
									<div class="col-9">
										<h6 class="mb-0">Tasks Details</h6>
									</div>
									<div class="col-3 text-end">
										<div class="dropstart">
											<a href="javascript:;" class="text-secondary" id="dropdownMarketingCard" data-bs-toggle="dropdown" aria-expanded="false"> <i class="material-icons text-xl">more_vert</i>
											</a>
											<ul class="dropdown-menu dropdown-menu-lg-start px-2 py-3" aria-labelledby="dropdownMarketingCard" style="" id="statuslistid">
											</ul>
										</div>
									</div>
								</div>
							</div>
							<div class="card-body p-0 height-auto">
								<div class="card-body pb-0">
									<div class="row align-items-center mb-0">
										<div class="col-6">
											<h6 class="mb-1">
												<span id="tasknameid"></span>
											</h6>
										</div>
										<div class="col-6 text-end">
											<h6 class="mb-1 text-sm ms-auto">
												Assign To: <span id="assigneeid" class="ms-auto  text-color-black"></span>
											</h6>
										</div>
									</div>
									<p class="text-sm break-white-spaces text-color-black" id="task_description_id"></p>
									<div class="row d-flex">
										<div class="col-md-6 col-sm-12">
											<ul class="list-unstyled mx-auto">
												<li class="d-flex">
													<p class="mb-0 text-sm">Status:</p> <span id="statusid" class="ms-auto"></span>
												</li>
												<li>
													<hr class="horizontal dark">
												</li>
												<li class="d-flex">
													<p class="mb-0 text-sm">Priority:</p> <span id="priorityid" class="ms-auto"></span>
												</li>
												<li>
													<hr class="horizontal dark">
												</li>
												<li class="d-flex">
													<p class="mb-0 text-sm">Estimated time:</p> <span id="taskestimatedtimeid" class="ms-auto"></span>
												</li>
												<li>
													<hr class="horizontal dark">
												</li>
												<li class="d-flex">
													<p class="mb-0 text-sm">Total Hours:</p> <span id="totalHours_id" class="ms-auto"></span>
												</li>
												<li>
													<hr class="horizontal dark">
												</li>
											</ul>
										</div>
										<div class="col-md-6 col-sm-12">
											<ul class="list-unstyled mx-auto">
												<li class="d-flex">
													<p class="mb-0 text-sm">Start Date:</p> <span id="startdateid" class="ms-auto"></span>
												</li>
												<li>
													<hr class="horizontal dark">
												</li>

												<li class="d-flex">
													<p class="mb-0 text-sm">Due Date:</p> <span id="duedateid" class="ms-auto"></span>
												</li>
												<li>
													<hr class="horizontal dark">
												</li>
												<li class="d-flex">
													<p class="mb-0 text-sm">% Done:</p> <span id="taskcompletionvalueid" class="ms-auto"></span> <a href="javascript:;" class="text-secondary"
													data-bs-toggle="dropdown" aria-expanded="false"><i class="material-icons text-xl">more_vert</i> </a>
													<ul class="dropdown-menu dropdown-menu-lg-start px-2 py-3" aria-labelledby="dropdownMarketingCard" style="" id="statuslistid">

														<li><a class="dropdown-item border-radius-md" href="javascript:;" onclick="updateCompletionValue('0')">0%</a></li>
														<li><a class="dropdown-item border-radius-md" href="javascript:;" onclick="updateCompletionValue('10')">10%</a></li>
														<li><a class="dropdown-item border-radius-md" href="javascript:;" onclick="updateCompletionValue('20')">20%</a></li>
														<li><a class="dropdown-item border-radius-md" href="javascript:;" onclick="updateCompletionValue('30')">30%</a></li>
														<li><a class="dropdown-item border-radius-md" href="javascript:;" onclick="updateCompletionValue('40')">40%</a></li>
														<li><a class="dropdown-item border-radius-md" href="javascript:;" onclick="updateCompletionValue('50')">50%</a></li>
														<li><a class="dropdown-item border-radius-md" href="javascript:;" onclick="updateCompletionValue('60')">60%</a></li>
														<li><a class="dropdown-item border-radius-md" href="javascript:;" onclick="updateCompletionValue('70')">70%</a></li>
														<li><a class="dropdown-item border-radius-md" href="javascript:;" onclick="updateCompletionValue('80')">80%</a></li>
														<li><a class="dropdown-item border-radius-md" href="javascript:;" onclick="updateCompletionValue('90')">90%</a></li>
														<li><a class="dropdown-item border-radius-md" href="javascript:;" onclick="updateCompletionValue('100')">100%</a></li>
													</ul>
												</li>
												<li>
													<hr class="horizontal dark">
												</li>
											</ul>
										</div>
									</div>
								</div>
							</div>
						</div>
					<!-- File upload against task -->
						<form enctype="multipart/form-data" method="post" id="attachForm_Id" onsubmit="return validateServiceDetails('attachForm_Id');">
							<input type="hidden" name="task_id" id="taskidforfile_id" value="" />
							<div class="row" id="attachFormId">
								<div class="col-12 position-relative">
									<div class="card mt-2">
										<div class="card-header p-2">
											<div class="row">
												<div class="col-9">
													<h6 class="mb-0">Document Files</h6>
												</div>
												<div class="col-3 text-end">
													<a id="uploadFilebtnId" onclick="if (!this.classList.contains('disabled'))togglefunction();" class="cursor-pointer btn-link text-color-primary"> <i
														class="material-icons text-lg">upload</i> Upload
													</a>
												</div>
											</div>
										</div>
										<div class="card-body p-2 height-200 overflow-x-hidden">
											<div class="">
												<div class="card-body p-0 ">
												<div class="row text-end"> <span id="" class="">(Max 5 files)</span></div>
													<div class="row my-2" id="choosefileid" hidden>
														<div class="col-md-5 col-sm-12">
															<input type="file" class="form-control form-control-sm" id="choosefile" name="updateAttachment"
																accept=".csv, application/vnd.ms-excel,text/plain, application/pdf, image/*">
																 <span id="file_msgErrorId" class="msgError">File too Big, please select a file less than 10 Mb</span>
														</div>
														<div class="col-md-3 col-sm-12"id="descriptionDiv_id" hidden>
															<textarea type="textarea" id="description" class="required form-control" rows="2" cols="50" name="descriptionforfile" onfocus="focused(this)"
																placeholder="Description" onfocusout="defocused(this)"></textarea>
															<span class="msgError" id="msgError_description"></span>
														</div>
														<div class="col-md-2 col-sm-12" >
															<input type="button" id="cancel_btn" class="btn btn-link rounded-1 mb-0" value="Cancel" onclick="cancelbtn();">
														</div>
														<div class="col-md-2 col-sm-12" id="savebtndiv_id" hidden>
															<input type="button" id="savebtn" class="btn bg-gradient-dark btn-sm rounded-1 mb-0" value="save"> 
														</div>
													</div>
													<div class="row" id="docsListId">
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
							</div>
						</form>

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
																								accept=".csv, application/vnd.ms-excel,text/plain, application/pdf, image/*"> <span id="logfile_msgErrorId" class="msgError">File too
																								Big, please select a file less than 10 Mb</span>
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
																											<td class="col-md-6 "><textarea type="textarea" id="logFileDescriptionid" class="required form-control" rows="2" cols="50"
																													name="descriptionforfile" onfocus="focused(this)" placeholder="Description" onfocusout="defocused(this)"></textarea><span class="msgError"
																												id="msgError_logFileDescriptionid"></span></td>
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
						<!--Start Delete Modal -->
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
					</div>
					
					
					
					<div class="col-lg-6 col-sm-12">
					  <div class="card" id="ActivityId">
					    <div class="card-header p-2">
					      <div class="row">
					        <div class="col-9">
					          <h6 class="mb-0">Activity</h6>
					        </div>
					        <div class="col-3 text-end">
					          <div class="dropstart">
					          <a href="#" id="modelzoomInOutButton"> <i class="material-icons" id="modelzoomInOut">zoom_in</i></a>
					          
					        
					            </div>
					        </div>
					      </div>
					    </div>
					    <div class="card-body p-2 height-500 overflow-scroll" id="taskmsgmainid">
					      <div class="">
					        <div class="card-body p-0 ">
					          <input type="hidden" id="userLogin_Id" value="${userLogin.user_login_id}">
					          <!-- Comments -->
					          <div class="mb-1 " id="taskmessagelistid"></div>
					          <div class="mb-1">
					            <div class="d-flex mt-2">
					              <div class="flex-shrink-0">
					                <img alt="Image placeholder" class="avatar border-radius-profile me-2" src="assets/img/team-2.jpg">
					              </div>
					              <div class="flex-grow-1 my-auto">
					                <div class="input-group input-group-static">
					                  <textarea class="form-control" id="taskmessageid" placeholder="Write your comment" rows="1" spellcheck="false" required></textarea>
					                  <span class="msgError" id="taskmsgError_id">Please Enter Message</span>
					                </div>
					              </div>
					              <div class="pulse-ring mb-0 mx-2" id="voice-ringId" onclick="voice();">
					                <a href="#" type="button" id="voicebtnid" class="mt-3"><i class="material-icons">mic</i></a>
					              </div>
					              <button class="btn bg-gradient-primary btn-sm mt-auto mb-0 ms-2" type="button" name="button" onclick="sendmessage();">
					                <i class="material-icons text-sm">send</i>
					              </button>
					            </div>
					          </div>
					        </div>
					      </div>
					    </div>
					  </div>
					</div>
					
					
					
					
					
				<div class="row">
					<div class="col-12">
						<div class="card ">
							<div class="card-header p-2">
								<div class="row">
									<div class="col-9">
										<h6 class="mb-0">Time Log</h6>
									</div>
									<div class="col-3 text-end">
										<div class="dropstart">
											<a href="#" class="cursor-pointer btn-link text-color-primary" onclick="addTimeLog();"><i class="material-icons text-xl me-2" data-bs-toggle="tooltip"
												data-bs-placement="bottom" data-bs-original-title="Add TimeLog">more_time</i></a>

										</div>
									</div>
								</div>
							</div>
							<input type="hidden" id="currentPageNo" value="1" />
							<div class="card-body p-2 height-auto" id="taskLog_list-view">
								<div class="table-responsive">
									<table class="table table-flush text-sm" id="tasktableId">
										<thead class="thead-light">
											<tr>
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
									<a id="loadmoreid" href="#" onclick="nexttasklogviewlist()"> <strong>Load More...</strong></a>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	 </main>
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
<script src="assets/js/material-dashboard.min.js?v=3.0.6"></script>

<script type="text/javascript">
	var taskid = 0;
	var hoursTotal= 0;
	$(function() {
		checkSession();
		taskid = sessionStorage.getItem("taskid");
		loadTaskDetails();
		loadTaskMessages();
		loadDocumentList();
		tasklogviewlist();
		loadTaskActivityList();
// 		loadDonePercentage();
	});
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
	var recognizing;
	var recognition = new webkitSpeechRecognition();
	recognition.continuous = true;
	reset();
	recognition.onend = reset();

	recognition.onresult = function(event) {
		for (var i = event.resultIndex; i < event.results.length; ++i) {
			if (event.results[i].isFinal) {
				taskmessageid.value += event.results[i][0].transcript;
			}
		}
	}
	recognition.onerror = function(event) {
		// Handle errors, e.g., user denied microphone access
		console.error(event.error);
	}

	recognition.onspeechend = function() {
		// Speech input has ended, stop recognition
		recognition.stop();
		reset();
	}
	function reset() {
		recognizing = false;
		$('#voice-ringId').css('animation', 'none');
		$('#voicebtnid').removeClass('voicebtn');
	}

	function voice() {
		if (recognizing) {
			recognition.stop();
			reset();
		} else {
			recognition.start();
			recognizing = true;
			$('#voice-ringId').css('animation', 'pulsate infinite 1.5s');
			$('#voicebtnid').addClass('voicebtn');
		}
	}
	function loadTaskDetails() {
		jQuery.ajax({
			type : "POST",
			url : "tasks",
			data : {
				actionType : 'taskdetails',
				taskId : taskid
			},
			async : true,
			success : function(data) {
				console.log("taskview", data);
				var jsonData = eval(data);
				$('#tasknameid').text("#" + taskid + " " + jsonData.taskName);
				$('#task_description_id').text(jsonData.taskDescription);
				$('#statusid').html(
						createStatusElement(jsonData.taskStatusId,
								jsonData.taskStatus, jsonData.taskStatusType));
				$('#priorityid').html(
						createPriorityElement(jsonData.taskPriorityId,
								jsonData.taskPriority,
								jsonData.taskPriorityType));
				$('#startdateid').text(convertDate(jsonData.startDate));
				$('#duedateid').text(convertDate(jsonData.dueDate));
				$('#taskestimatedtimeid').text(
						jsonData.taskEstimatedTime + " hrs");
				$('#taskcompletionvalueid').text(
						jsonData.taskCompletionValue + " %");
				$('#assigneeid').html(
						"<a href=\"javascript:;\" >" + jsonData.assigneeName
								+ "</a>");
				loadTaskStatusList(jsonData.taskStatusId);
			},
			error : function(data) {
				alert("Error in process. Please try again.");
			}
		});
	}

	function convertDate(inputFormat) {
		function pad(s) {
			return (s < 10) ? '0' + s : s;
		}
		var d = new Date(inputFormat)
		return [ pad(d.getDate()), pad(d.getMonth() + 1), d.getFullYear() ]
				.join('-')
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

	function sendmessage() {
		if($('#taskmessageid').val() === ""){
			$('#taskmsgError_id').show();
			return false;
		}
		jQuery.ajax({
			type : "POST",
			url : "tasks",
			data : {
				actionType : 'sendtaskmessage',
				taskId : taskid,
				taskMessage : $('#taskmessageid').val()
			},
			async : true,
			success : function(data) {
				console.log(data);
				$('#taskmessageid').val('');
				$('#taskmsgError_id').hide();
				loadTaskMessages();

			},
			error : function(data) {
				alert("Error in process. Please try again.");
			}
		});
	}

	function loadTaskMessages() {
		$("#taskmessagelistid").empty();
		jQuery.ajax({
			type : "POST",
			url : "tasks",
			data : {
				actionType : 'taskmessagelist',
				taskId : taskid
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
						$("#taskmessagelistid").append(newRowContent);
					}
				}
				$("#taskmsgmainid").animate({
					scrollTop : $('#taskmsgmainid').prop("scrollHeight")
				}, 1000);
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
		rowData += "<h6 class=\"h6 mt-0 mb-0\">" + data.employeeName + " </h6>";
		if (userLoginid == data.employeeId) {
			rowData += "<span class='msgoptions text-end ms-auto'><a class='text-dark cursor-pointer' id='editMsgId_"
					+ data.taskMessageId
					+ "'  onclick='editTaskMsg("
					+ data.taskMessageId
					+ ");'><i class='material-icons text-sm me-2'>edit</i></a><a class='text-danger cursor-pointer' id='deleteMsgId_"
					+ data.taskMessageId
					+ "'  onclick='deleteTaskMsg("
					+ data.taskMessageId
					+ ");'><i class='material-icons text-sm me-2'>delete</i></a><a class='text-success cursor-pointer' id='updateMsgId_"
					+ data.taskMessageId
					+ "' style='display:none;' onclick='updateTaskMsg("
					+ data.taskMessageId
					+ ");'><i class='material-icons text-lg me-2'>checkmark</i></a> </span> ";
		}
		rowData += "</div>";

		rowData += "<span class=\"text-sm text-color-gray\"> On: "
				+ data.messageDateTime + "<span>";
		rowData += "<p contentEditable ='false' class=\"text-sm text-color-black\" id=\"msgId_"+data.taskMessageId+"\">"
				+ data.taskMessage + "</p>";
		rowData += "</div>";
		rowData += "</div>";
		return rowData;
	}
	function editTaskMsg(taskMsgId) {

		$("#msgId_" + taskMsgId).attr("contentEditable", "true");
		$("#msgId_" + taskMsgId).addClass("taskMsgEdit");
		$("#msgId_" + taskMsgId).css('outline', 'none');
		$("#msgId_" + taskMsgId).focus();
		$("#editMsgId_" + taskMsgId).hide();
		$("#deleteMsgId_" + taskMsgId).hide();
		$("#updateMsgId_" + taskMsgId).show();
	}
	function updateTaskMsg(taskMsgId) {
		var editMsg = $('#msgId_' + taskMsgId).text();
		jQuery.ajax({
			type : "POST",
			url : "tasks",
			data : {
				actionType : 'updatetaskmessage',
				taskMsgId : taskMsgId,
				taskMessage : editMsg
			},
			async : true,
			success : function(data) {
				console.log(data);
				$('#taskmessageid').val('');
				loadTaskMessages();
			},
			error : function(data) {
				alert("Error in process. Please try again.");
			}
		});
	}
	function deleteTaskMsg(taskMsgId) {
		var userLoginid = $('#userLogin_Id').val();
		jQuery.ajax({
			type : "POST",
			url : "tasks",
			data : {
				actionType : 'deletetaskmessage',
				taskMsgId : taskMsgId,
				deletedBy : userLoginid,
			},
			async : true,
			success : function(data) {
				console.log(data);
				$('#taskmessageid').val('');
				loadTaskMessages();
			},
			error : function(data) {
				alert("Error in process. Please try again.");
			}
		});
	}
	function loadTaskStatusList(cstatusid) {
		debugger;
		$('#statuslistid').empty();
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
								if (data[i].taskStatusID != cstatusid) {
									var htmlData = '<li><a class="dropdown-item border-radius-md" href="javascript:;" onclick="updateStatus('
											+ data[i].taskStatusID
											+ ')">'
											+ data[i].taskStatus + '</a></li>';
									$('#statuslistid').append(htmlData);
								}
							}
						}
					},
					error : function(error) {
						alert(error);
					}
				});
	}

	function updateStatus(statusId) {
		jQuery.ajax({
			type : "POST",
			url : "tasks",
			data : {
				actionType : 'updatestatus',
				taskId : taskid,
				statusid : statusId
			},
			async : true,
			success : function(data) {
				console.log(data);
				loadTaskDetails();
			},
			error : function(data) {
				alert("Error in process. Please try again.");
			}
		});
	}

	function updateCompletionValue(doneValue) {
		jQuery.ajax({
			type : "POST",
			url : "tasks",
			data : {
				actionType : 'updatepercentage',
				taskId : taskid,
				// 				statusid: statusId
				taskcompletionvalue : doneValue
			},
			async : true,
			success : function(data) {
				console.log(data);
				loadTaskDetails();
			},
			error : function(data) {
				alert("Error in process. Please try again.");
			}
		});

	}
	function togglefunction(){
		$("#upFile").prop("hidden", true);
		$("#choosefileid").prop("hidden", false);
		 $("#cancel_btn").prop("hidden", false);
		 $("#choosefile").prop("hidden", false);
	} 

	$("#choosefile").change(function(e){
		$("#file_msgErrorId").css("display", "none");
		if( fileSizeValidation('choosefile')){
			$("#description").prop("hidden", false);
			$("#descriptionDiv_id").prop("hidden", false);
			$("#savebtndiv_id").prop("hidden", false);
// 			$("#tableData").prop("hidden", false);
// 			let val1 = e.target.files[0].name;
// 			$("#discrip").val(val1);
// 			$("#file1").val(val1);
// 			$("#filediv1").prop("hidden", false);
// 			$("#filename").prop("hidden", false);
		}
	})

	$("#savebtn").click(function(){
		if(validateServiceDetails('attachForm_Id')){
// 		$("#upFile").prop("hidden", false);
// 		$("#btnFile").prop("hidden", true);
// 		$("#tableData").prop("hidden", true);
		$("#description").prop("hidden", false);
		$("#descriptionDiv_id").prop("hidden", false);
		$("#choosefile").prop("hidden", true);
		$("#choosefileid").prop("hidden", true);
		$("#cancel_btn").prop("hidden", true);
		$("#savebtndiv_id").prop("hidden", false);
		uploadFile();
		}
	})
	function cancelbtn(){
		 	
	 		$("#choosefile").val("");
	 		$("#description").val("");
	 		$("#descriptionDiv_id").prop("hidden", true);
	 		$("#choosefile").prop("hidden", true);
	 		$("#cancel_btn").prop("hidden", true);
			$("#savebtndiv_id").prop("hidden", true);
	 		$("#msgError_description").css("display", "none");
	 		$("#file_msgErrorId").css("display", "none");
// 	 		$("#upFile").prop("hidden", false);
// 	 		$("#tableData").prop("hidden", true);
		}
	function loadDocumentList(){
		$.ajax({
			url:"tasks",
			type:"post",
			data:{
				actionType : "documentList",
				taskid : taskid,
			},success : function(data){ 
				console.log(data, "DocumentsList");
				$("#documentBody").empty();
				var row = "";
				if(data != ""){
					 $("#docsListId").prop("hidden", false);
					 $("#uploadFilebtnId").removeClass("disabled");
					 var DName = document.getElementById("documentBody");
						var row = "";
							for(var i = 0; i<data.length; i++){ 
								row += '<tr><td><a href="#" onclick="deleteAttachmentById('+data[i].document_id+');"class="text-danger cursor-pointer"><i class="material-icons text-sm me-2">cancel</i></a><a href="#" class="text-info cursor-pointer" id="viewAttachment" onclick="viewAttachment('+ taskid +', '+data[i].document_id+');"><i class="material-icons text-sm me-2">preview</i></a><a href="tasks?actionType=downloadAttachment&taskid='+taskid+'&document_name='+data[i].document_name+'" target="_top" class="text-info cursor-pointer" id="downloadAttachmentId" ><i class="material-icons text-sm me-2">download</i></a></td><td id="docNameFordwnId">'+data[i].document_name+'</td><td id="descriptionId">'+data[i].documentDiscription+'</td><td>'+data[i].created_on+'</td></tr>';  
							DName.innerHTML = row;
				}
				}else{
					 row += '<tr><td colspan="4"><center><b style="color:red">No Files Found....<b></center></td></tr>';
				     $("#documentBody").append(row);
				}
				if(data.length == "5"){
					$("#choosefile").prop("hidden", true);
			 		$("#choosefile").val("");
			 		$("#uploadFilebtnId").addClass("disabled");
			 		$("#cancel_btn").prop("hidden", true);
				}
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
	function tasklogviewlist(){
		$('#currentPageNo').val(1);
		jQuery
				.ajax({
					type : "POST",
					url : "workspace",
					data : {
						actionType : 'getTaskLog',
						taskid : taskid,
						startIndex : 0,
						endIndex : 5
						
					},
					async : true,
					success : function(data) {
						$("#totalHours_id").empty(); 
						
						if (data.length % 2 == 0) {
							$('#loadmoreid').prop('hidden', true);
							$('#loadmoreid').prop('hidden', true);
						}
						if (data.length < 5) {
							$('#loadmoreid').prop('hidden', true);
							$('#loadmoreid').prop('hidden', true);
							
						}else {
							$('#loadmoreid').prop('hidden', false);
							$('#loadmoreid').prop('hidden', false);
						}
						
						var jsonData = eval(data);
						$("#taskLogbodyforListId").empty();
						if (jsonData.length == 0) {
							var htmlMsg = "<tr><td colspan='8'><center><b style='color:red'>No Time Log Found....<b></center></td></tr>";
							$("#taskLogbodyforListId").append(htmlMsg);
						} else {
							for (var i = 0; i < jsonData.length; i++) {
								var rowdata = jsonData[i];
								newRowContentforListView = createtaskLogrowListView(rowdata);
								$("#taskLogbodyforListId").append(
										newRowContentforListView);

								hoursTotal = hoursTotal + jsonData[i].log_hours;
							}
						}
						$("#totalHours_id").text(hoursTotal);
					},
					error : function(data) {
						alert("Error in process. Please try again.");
					}
				});
			}
	
	//Load more Time Log
	function nexttasklogviewlist(){
		if ($('#currentPageNo').val() != '') {
			var currentPageNo = parseInt($('#currentPageNo').val()) + 1;
			$('#currentPageNo').val(currentPageNo)
		jQuery
				.ajax({
					type : "POST",
					url : "workspace",
					data : {
						actionType : 'getTaskLog',
						taskid : taskid,
						startIndex : 0,
						endIndex : 5,
						pageNo: currentPageNo,
						
					},
					async : true,
					success : function(data) {
					
						$("#totalHours_id").empty();
						
						if (data.length % 2 == 0) {
							$('#loadmoreid').prop('hidden', true);
							$('#loadmoreid').prop('hidden', true);
						}
						if (data.length < 5) {
							$('#loadmoreid').prop('hidden', true);
							$('#loadmoreid').prop('hidden', true);
							
						}else {
							$('#loadmoreid').prop('hidden', false);
							$('#loadmoreid').prop('hidden', false);
						}
// 						var hoursTotal = 0;
						var jsonData = eval(data);
// 						$("#taskLogbodyforListId").empty();
						if (jsonData.length == 0) {
// 							var htmlMsg = "<tr><td colspan='8'><center><b style='color:red'>No Time Log Found....<b></center></td></tr>";
// 							$("#taskLogbodyforListId").append(htmlMsg);
						} else {
							for (var i = 0; i < jsonData.length; i++) {
								var rowdata = jsonData[i];
								newRowContentforListView = createtaskLogrowListView(rowdata);
								$("#taskLogbodyforListId").append(
										newRowContentforListView);

								hoursTotal = hoursTotal + jsonData[i].log_hours;
							}
						}
						$("#totalHours_id").text(hoursTotal);
					},
					error : function(data) {
						alert("Error in process. Please try again.");
					}
				});
			}
	}
	
	function createtaskLogrowListView(data) {
		var rowData = "<tr>";
		rowData += "<td>" + data.log_date + "</td>";
		rowData += "<td>"
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
					taskId : taskid,
					logDate : $('#task_log_date_id').val(),
					logHours : $('#task_log_hours_id').val(),
					taskActivityId : $('#taskActivity_id').val(),
					taskComment : $('#task_comments_id').val()
				},
				async : true,
				success : function(data) {
					 $('#taskTimeLog').modal("hide");
					 tasklogviewlist();

				},
				error : function(data) {

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
	function today() {
		var d = new Date();
		var currDate = d.getDate();
		var currMonth = d.getMonth() + 1;
		var currYear = d.getFullYear();
		return currYear + "-"
				+ ((currMonth < 10) ? '0' + currMonth : currMonth) + "-"
				+ ((currDate < 10) ? '0' + currDate : currDate);
	}
	//function for upload task files
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
	//functions for timelog upload files start
function showFileInput() {
		$("#uploadbtn_div").prop("hidden", true);
		$("#logfilerow_id").prop("hidden", false);
		$("#cancelbtn_id").prop("hidden", false);
		$("#updateAttachment_id").prop("hidden", false);
	}

	$("#updateAttachment_id").change(function(e) {
		$("#logfile_msgErrorId").css("display", "none");
		if( fileSizeValidation('updateAttachment_id')){
			$("#logfileTableData").prop("hidden", false);
			let val1 = e.target.files[0].name;
			$("#logFilechossedid").val(val1);
			$("#file1").val(val1);
			$("#filediv1").prop("hidden", false);
			$("#filename").prop("hidden", false);
		}

	})
		$("#logFileSavebtn_id").click(function() {
		if (validateServiceDetails('updateAttachForm_Id')) {
			$("#uploadbtn_div").prop("hidden", false);
			$("#logfileTableData").prop("hidden", true);
			$("#updateAttachment_id").prop("hidden", true);
			$("#cancelbtn_id").prop("hidden", true);
			$("#logfilerow_id").prop("hidden", true);
			uploadLogFile();
		}
		});
 
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
	function uploadLogFile(){
		
	   let formData = new FormData(); 
	   formData.append("updateAttachment", updateAttachment_id.files[0]);
	   formData.append("task_id", taskid);
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
										+ taskid
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
										$("#logFiletBody").append(row);
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
	function viewLogAttachment(taskId, documentId) {
		var fileName = sessionStorage.getItem("fileName");
		$.ajax({
			url : "tasks",
			type : "POST",
			data : {
				actionType : "viewAttachment",
				taskid : taskid,
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
				taskid : taskid,
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
	function fileSizeValidation(fileInputId) {
		var filesId = document.getElementById(fileInputId);
// 		var filesId = $('#'+fileInputId);
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
</script>

<script>
$(document).ready(function () {
	  $("#modelzoomInOutButton").click(function (e) {
	    e.preventDefault();
	    const $card = $("#ActivityId");
	    if ($card.hasClass("zoomed")) {
	      // Zoom out
	      $card.removeClass("zoomed");
	      $("#modelzoomInOutButton").html('<i class="material-icons">zoom_in</i>');
	    } else {
	      // Zoom in
	      $card.addClass("zoomed");
	      $("#modelzoomInOutButton").html('<i class="material-icons">zoom_out</i>');
	    }
	  });
	});


</script>

<%@ include file="/include/footer.jsp"%>

