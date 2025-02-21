<%@ include file="/include/header.jsp"%>
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
							<ol class="breadcrumb">
								<li class="breadcrumb-item"><a i
									class="material-icons fixed-plugin-button-nav cursor-pointer "
									href='workspace.jsp'> home </i></a></li>
								<h6 class="font-weight-bolder mb-0 breadcrumb-item active">Tickets</h6>
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
												<input class="multisteps-form__input form-control"
													type="text" placeholder="From Name "
													name="search_from_name" id="search_from_name_id" />
											</div>
										</div>
										<div class="col-md-3">
											<div class="input-group input-group-dynamic">
												<input class="multisteps-form__input form-control"
													type="email" placeholder="From mail"
													name="search_From_email" id="search_From_email_id" />
											</div>
										</div>
										<div class="col-md-3">
											<div class="input-group input-group-static mb-2">
												<select class="required form-control p-2" name="search"
													id="searchbyId">
													<option value="today"
														<%=(equals("today") ? "selected='selected'" : "")%>>Today</option>
													<option value="yesterday"
														<%=(equals("yesterday") ? "selected='selected'" : "")%>>Yesterday</option>
													<option value="this_week"
														<%=(equals("this_week") ? "selected='selected'" : "")%>>This
														Week</option>
													<option value="this_month"
														<%=(equals("this_month") ? "selected='selected'" : "")%>>This
														Month</option>
													<option value="last_3_months"
														<%=(equals("last_3_months") ? "selected='selected'" : "")%>>Last
														3 Months</option>
												</select>
											</div>

										</div>
										<div class="col-md-3 rightalign text-end">
											<button class="btn btn-icon btn-2 btn-dark" id="search"
												onclick="searchEmaildetails();" type="button">
												<span class="btn-inner--icon"><i
													class="material-icons">search</i></span>
											</button>
										</div>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
				<div class="card-body p-2 pt-2" id="tableview">
					<div class="table-responsive">
						<table class="table table-flush text-sm" id="employeelistidbylist">
							<!-- 						<input type="hidden" id="cpageno" value="1"/>  -->
							<thead class="thead-light">
								<tr>
									<th>Action</th>
									<th>From Name</th>
									<th>From email</th>
									<th>To email</th>
									<th>Subject</th>
									<th>Date</th>
								</tr>
							</thead>
							<tbody id="tbodyId"></tbody>
						</table>
					</div>
				</div>
			</div>
			<div class="card-body p-2 height-auto text-center">
				<input type="hidden" id="currentPageNo" value="1" /> <a
					id="loadnextemaillistId" href="#" onclick="loadNextEmailList()">
					<strong>Load More...</strong>
				</a>
			</div>
		</div>

		<div class="modal fade " id="editEmailModel" tabindex="-1"
			role="dialog" aria-labelledby="editEmailModelLable"
			aria-hidden="true">
			<div class="modal-dialog modal-xl modal-dialog-centered"
				role="document">
				<div class="modal-content w-55 ">
					<div class="modal-header ">
						<h5 class="modal-title font-weight-normal"
							id="editEmailModelLable">Update Email</h5>

						<button type="button" class="btn-close text-dark"
							data-bs-dismiss="modal" aria-label="Close"
							onclick="closeEditModel()">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>

					<div class="container-fluid">
						<div class="row">
							<div class="col-lg-12 col-12 mx-auto position-relative">
								<div class="card-plain p-2">
									<div class="card-body pt-2 ">
										<form id="account_form">
											<div class="row">

												<div class="col-md-6 col-sm-12">
													<div class="input-group input-group-static mb-1">
														<label>Subject</label> <input type="text"
															class="required form-control" id="email_SubjectID"
															name="email_Subject"> <span class="msgError"
															id="msgError_name_id"></span>
													</div>
													<div id="validationMessageSTG"></div>

												</div>

											</div>

											<div class="row justify-content-md-end mt-4">
												<div class="col-md-auto px-1 text-end">
													<button type="button" onclick="updateEmailDetails()"
														name="button" class="btn bg-gradient-info" id="emailBtnId">Update
													</button>
													<button type="button" name="button" data-bs-dismiss="modal"
														class="btn btn-link  ml-auto" onclick="closeEditModel()">Close</button>
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
		<div class="modal fade" id="viewEmailModel" tabindex="-1"
			role="dialog" aria-labelledby="viewEmailModelLabel"
			aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title font-weight-normal"
							id="viewEmailModelLabel">View Email</h5>
						<button type="button" class="btn-close text-dark"
							data-bs-dismiss="modal" aria-label="Close"
							onclick="closeEmailModel()">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<div class="row">
							<div class="col-12">
								
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" name="button"
							class="btn btn-link ml-auto text-end" data-bs-dismiss="modal"
							onclick="closeEmailModel()">Close</button>
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
<!-- Kanban scripts -->
<script src="assets/js/plugins/dragula/dragula.min.js"></script>
<script src="assets/js/plugins/jkanban/jkanban.js"></script>
<link
	href="https://gitcdn.github.io/bootstrap-toggle/2.2.2/css/bootstrap-toggle.min.css"
	rel="stylesheet">
<script
	src="https://gitcdn.github.io/bootstrap-toggle/2.2.2/js/bootstrap-toggle.min.js"></script>

<script>
	$(document).ready(function() {
		loadAllEmailDetail();
	});

	function editEmail() {
		$('#email_Subject').val('');
		$('#editEmailModelLable').html('Edit Email');
		$("#editEmailModel").modal('show');
	}
	var start_Index;
	var end_Index;
	var selectElement;
	var selectedOption;
	var pageNo;
	// load all email data
	function loadAllEmailDetail() {
		$('#search').click(function() {
			actiontype = "searchmaildetails";
		});
		actiontype = "showAllMaildetails";
		$('#currentPageNo').val(1);
		$
				.ajax({
					url : "ticketsService",
					type : "POST",
					data : {
						actionType : actiontype,
						startIndex : 0,
						endIndex : 5,
					},
					success : function(data) {
						var searchAllJsonData = eval(data);
						if (searchAllJsonData.length > 0) {
							$("#tbodyId").html('');
							for (var i = 0; i < searchAllJsonData.length; i++) {
								var rowdata = searchAllJsonData[i];
								var searchrowData = createDataROW(rowdata);
								$('#tbodyId').append(searchrowData);
							}
						} else {
							$('#tbodyId').empty();
							$('#tbodyId')
									.append(
											"<tr class='text-sm'><td colspan='7'><center>No record found..</center></td><tr/>");
						}
					}
				});
	}
	function createDataROW(data) {
		var rowData = "<tr class='text-sm'>";
		// Edit icon
		rowData += '<td><a class="cursor-pointer text-color-primary" onclick="editEmail(\''
				+ data.pkid
				+ '\');"><i class="material-icons text-sm me-2">edit</i></a>';
		rowData += '<a class="cursor-pointer text-danger" data-bs-toggle="modal" data-bs-target="#deleteModal" onclick="deleteEmail(\''
				+ data.pkid
				+ '\');"><i class="material-icons text-sm me-2">delete</i></a>';
		rowData += ' <a href="javascript:;" class="text-info cursor-pointer" onclick="viewEmailDetails(\''
				+ data.pkid
				+ '\');"><i class="material-icons text-sm me-2">preview</i></a></td>';
		rowData += "<td>" + data.fromName + "</td>";
		rowData += "<td>" + data.fromEmail + "</td>";
		rowData += "<td>" + data.toEmail + "</td>";
		rowData += "<td>" + data.emailSubject + "</td>";
		rowData += "<td>" + data.send_date + "</td>";
		rowData += "</tr>";

		var tempElement = document.createElement('div');
		tempElement.innerHTML = data.emailBody;
		var textContent = tempElement.textContent;
		console.log(textContent);
		return rowData;
	}
	//-------------------- view specific user email record------------------
	function viewEmailDetails(pkid) {
		actiontype = "viewEmailDetails";
		$
				.ajax({
					url : "ticketsService",
					type : "POST",
					data : {
						actionType : actiontype,
						pkid : pkid
					},
					success : function(data) {
						$("#viewEmailModel").modal('show');

						if (data != null) {
							var rowData = viewDataROW(data);
							$("#viewEmailModel").modal('show');

							getModalWithData(data);
						} else {
							$('#viewEmailTblID').empty();
							$('#viewEmailTblID')
									.append(
											"<tr class='text-sm'><td colspan='7'><center>No record found..</center></td><tr/>");
						}

					}

				});
	}
	function viewDataROW(data) {
		var rowData = "<tr class='text-sm'>";
		rowData += "<td>" + data.fromName + "</td>";
		rowData += "<td>" + data.fromEmail + "</td>";

		var tempElement = document.createElement('div');
		tempElement.innerHTML = data.emailBody;
		var textContent = tempElement.textContent;
		rowData += "<td>" + textContent + "</td>";
		rowData += "<td>" + data.emailSubject + "</td>";
		rowData += "<td>" + data.send_date + "</td>";
		rowData += "</tr>";
		console.log(textContent);
		return rowData;
	}

	function getModalWithData(data) {
		$("#viewEmailModel .modal-title").text("View Email"); // Update modal title
		var appendviewData = $("#viewEmailModel .modal-body .col-12");
		appendviewData.empty(); // Clear existing content

		appendviewData.append("<p><strong>From Name :</strong> "
				+ data.fromName + "</p>");
		appendviewData.append("<p><strong>From Email :</strong> "
				+ data.fromEmail + "</p>");
		appendviewData.append("<p><strong>Message :</strong> " + data.emailBody
				+ "</p>");
		appendviewData.append("<p><strong>Subject :</strong> "
				+ data.emailSubject + "</p>");
		appendviewData.append("<p><strong>Date :</strong> " + data.send_date
				+ "</p>");
	}
	

	//search email list
	function searchEmaildetails() {
		$('#currentPageNo').val(1);
		selectElement = document.getElementById("searchbyId");
		selectedOption = selectElement.value;
		$
				.ajax({
					url : "ticketsService",
					type : "post",
					data : {
						actionType : "searchmaildetails",
						from_name : $("#search_from_name_id").val(),
						from_email : $("#search_From_email_id").val(),
						search_by : selectedOption,
						startIndex : 0,
						endIndex : 5,
					},
					success : function(data) {
						var searchAllJsonData = eval(data);
						if (searchAllJsonData.length > 0) {
							$("#tbodyId").html('');
							for (var i = 0; i < searchAllJsonData.length; i++) {
								var rowdata = searchAllJsonData[i];
								var searchrowData = createDataROW(rowdata);
								$('#tbodyId').append(searchrowData);
							}
						} else {
							$('#tbodyId').empty();
							$('#tbodyId')
									.append(
											"<tr class='text-sm'><td colspan='7'><center>No record found..</center></td><tr/>");
						}
					},
					error : function(error) {
						alert(error);
					}
				});
	}
	//-------------------- delete email record------------------
	function deleteEmail(pkid) {
		var confirmed = confirm("Are you sure you want to delete this Email Record?");
		if (confirmed) {
			$.ajax({
				url : "ticketsService",
				type : "POST",
				data : {
					actionType : 'deleteEmailRecord',
					pkid : pkid
				},
				success : function(resp) {
					loadAllEmailDetail();
				},
				error : function(xhr, status, error) {
					alert("Error: " + error);
				}
			});
		}
	}
	//load more Email details
	function loadNextEmailList() {
		if (actiontype == "viewEmailDetails") {
			actiontype = "searchmaildetails";
		}
		if (actiontype == "searchmaildetails") {
			if ($('#currentPageNo').val() != '') {
				var spage = parseInt($('#currentPageNo').val()) + 1;
				$('#currentPageNo').val(spage)
				$.ajax({
					url : "ticketsService",
					type : "POST",
					data : {
						actionType : "searchmaildetails",
						from_name : $("#search_from_name_id").val(),
						from_email : $("#search_From_email_id").val(),
						search_by : selectedOption,
						startIndex : 0,
						endIndex : 5,
						pageNo : spage,
					},
					success : function(data) {
						var searchAllJsonData = eval(data);
						for (var i = 0; i < searchAllJsonData.length; i++) {
							var rowdata = searchAllJsonData[i];
							var searchrowData = createDataROW(rowdata);
							$('#tbodyId').append(searchrowData);
						}

					},
					error : function(error) {
						alert(error);
					}
				});
			}
		} else {

			if ($('#currentPageNo').val() != '') {
				var cpage = parseInt($('#currentPageNo').val()) + 1;
				$('#currentPageNo').val(cpage)
				$.ajax({
					url : "ticketsService",
					type : "POST",
					data : {
						actionType : actiontype,
						startIndex : 0,
						endIndex : 5,
						pageNo : cpage,
					},
					success : function(data) {
						var searchAllJsonData = eval(data);
						for (var i = 0; i < searchAllJsonData.length; i++) {
							var rowdata = searchAllJsonData[i];
							var searchrowData = createDataROW(rowdata);
							$('#tbodyId').append(searchrowData);
						}
					},
					error : function(error) {
						alert(error);
					}
				});
			}

		}
	}
</script>
<script src="assets/js/material-dashboard.min.js?v=3.0.6"></script>
<%@ include file="/include/footer.jsp"%>
