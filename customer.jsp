<%@page import="java.util.Iterator"%>
<%@page import="com.dakshabhi.pms.customers.dtos.CCustomerDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ include file="/include/header.jsp"%>

<style>
.msgError {
	font-size: 0.875rem;
	display: none;
	color: red;
}

#loadnextgridid {
  padding: 10px 20px;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  position: absolute;
  bottom: -40;
  width: 100%; /* Button width set to 100% */
  text-align: center;
}

#loadmoreid{
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
	<main
		class="main-content position-relative max-height-vh-100 h-100 border-radius-lg ">
		<!-- Navbar -->
		<nav
			class="navbar navbar-main navbar-expand-lg position-sticky  top-1 px-0 shadow-none border-radius-xl z-index-sticky"
			id="navbarBlur" data-scroll="true">
			<div class="container-fluid py-1 px-3"
				style="display: block !important">
				<nav aria-label="breadcrumb">
					<div class="row">
						<div class="col-6">
						 <ol class="breadcrumb" >
						    <li class="breadcrumb-item"><a i class="material-icons fixed-plugin-button-nav cursor-pointer " href='workspace.jsp'> home </i></a></li>
						     <h6 class="font-weight-bolder mb-0 breadcrumb-item active" >Customer</h6>
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
								data-bs-target="#newCustomerModal"
								class="btn bg-gradient-dark mb-0 mt-0 ">
								<i
									class="material-icons text-white position-relative text-md pe-2"
									id=" plusSignimgId">add</i>Create New

							</button>
								
						
					</div>
				</nav>
				
				</div>
		</nav>
		<!--End Navbar -->

		<div class="container-fluid">
			<div class="card mb-0">
				<div class="card-header p-2">
					<div class="row">
						<div class="col-lg-12 col-md-12 ">
							<form class="multisteps-form__form mb-0">
								<div class="content">
									<div class="row">
										<div class="col-md-3">
											<div class="input-group input-group-dynamic">
												<label class="form-label">Name</label> <input
													class="multisteps-form__input form-control" type="text"
													name="name" id="searchname_id" />
											</div>
										</div>
										<div class="col-md-3">
											<div class="input-group input-group-dynamic">
												<label class="form-label">Email</label> <input
													class="multisteps-form__input form-control" type="text"
													name="email" id="searchemail_id" />
											</div>
										</div>
										<div class="col-md-3">
											<div class="input-group input-group-dynamic">
												<label class="form-label">Phone</label> <input
													class="multisteps-form__input form-control" type="text"
													name="phone" id="searchphone_id" />
											</div>
										</div>
										<div class="col-md-3 rightalign">
											<button class="btn btn-icon btn-2 btn-dark" type="button"
												id="search_id">
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
								data-on="<i class='fas fa-th'></i> Grid"
								data-off="<i class='fas fa-th-list'></i> List"
								data-onstyle="success" data-offstyle="info">
						</div>
					</div>
				</div>
				<input type="hidden" id="currentPageNo" value="1"/> 
				<div class="card-body p-2 height-auto" id="gridview">
					<div class="row" id="customerlistid"></div>
					<a id="loadnextgridid" href="#"
							onclick="loadMoreCustomers()"> <strong>Load More...</strong></a>
				</div>
				
				<input type="hidden" id="cPageNo" value="1"/> 
				<div class="card-body p-2 pt-2" id="tableview">
					<div class="table-responsive">
						<table class="table table-flush text-sm" id="employeelistidbylist">
							<thead class="thead-light">
								<tr>
									<th></th>
									<th>Customer Name</th>
									<th>Customer Address</th>
									<th>Customer Email</th>
									<th>Customer Phone</th>
								</tr>
							</thead>
							<tbody id="tbodyId"></tbody>
						</table>
						<a id="loadmoreid" href="#"
							onclick="loadMoreCustomersGrid()"> <strong>Load More...</strong></a>
					</div>
				</div>
			</div>

		</div>

		<!-- Modal -->
		<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered" role="document">
				<div class="modal-content modeldelete" id="modaldelete">
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
							data-bs-dismiss="modal" onclick="deleteCustomer();">Delete</button>
					</div>
				</div>
			</div>
		</div>

		<!-- Modal For New Customer-->

		<div class="modal fade " id="newCustomerModal" tabindex="-1"
			role="dialog" aria-labelledby="newCustomerModalLabel"
			aria-hidden="true">
			<div class="modal-dialog modal-xl modal-dialog-centered"
				role="document">
				<div class="modal-content ">
					<div class="modal-header ">
						<h5 class="modal-title font-weight-normal"
							id="newCustomerModalLabel">New Customer</h5>

						<button type="button" class="btn-close text-dark"
							data-bs-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>

					<div class="container-fluid">
						<div class="row">
							<div class="col-lg-12 col-12 mx-auto position-relative">
								<div class="card">
									<div class="card-body pt-2 ">
										<form id="customer_form"
											>
											<div class="row">
												<div class="col-md-6 col-sm-12">
													<div class="input-group input-group-static mb-1">
														<label>Type</label> <select class="required form-control"
															id="customer_type" name="customer_type">
														</select>
														<span class="msgError" id="msgError_customer_type"></span>
													</div>
												</div>
											</div>

											<div class="row">
												<div class="col-md-6 col-sm-12">
													<div class="input-group input-group-static mb-1">
														<label>Customer Name</label> <input type="text"
															class="required form-control" id="customer_name"
															name="customer_name">
														<span class="msgError" id="msgError_customer_name"></span>
													</div>
												</div>

												<div class="col-md-6 col-sm-12">
													<div class="input-group input-group-static mb-1">
														<label>Customer Address</label> <input type="text"
															class="required form-control" id="customer_address"
															name="customer_address">
														<span class="msgError" id="msgError_customer_address"></span>
													</div>
												</div>
											</div>
											<div class="row">
												<div class="col-md-6 col-sm-12">
													<div class="input-group input-group-static mb-1">
														<label>Customer Email</label> <input type="email"
															class="required form-control" id="customer_email"
															name="customer_email">
														<span class="msgError" id="msgError_customer_email"></span>
													</div>
												</div>

												<div class="col-md-6 col-sm-12">
													<div class="input-group input-group-static mb-1">
														<label>Customer Phone</label> <input type="text"
															class="required form-control" id="customer_phone"
															name="customer_phone">
														<span class="msgError" id="msgError_customer_phone"></span>
													</div>
												</div>
											</div>

											<div class="row">
												<div class="col-md-6 col-sm-12">
													<div class="input-group input-group-static mb-1">
														<label>Customer Alternate Email</label> <input
															type="email" class="form-control" id="altcustomer_email"
															name="customer_email">
													</div>
												</div>

												<div class="col-md-6 col-sm-12">
													<div class="input-group input-group-static mb-1">
														<label>Customer Alternate Phone</label> <input type="text"
															class="form-control" id="altcustomer_phone"
															name="customer_phone">
													</div>
												</div>
											</div>

											<div class="row justify-content-md-end mt-4">

												<div class="col-md-auto px-1 text-end">
													<button type="button" onclick="saveCustomer()" name="button"
														class="btn bg-gradient-info">Add Customer</button>
													<button type="button" name="button" data-bs-dismiss="modal"
														class="btn btn-link  ml-auto">Close</button>
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
		<!-- Modal End For New Customer-->


		<!-- Modal For update Customer-->

		<div class="modal fade" id="updateCustomerModal" tabindex="-1"
			role="dialog" aria-labelledby="newCustomerModalLabel"
			aria-hidden="true">
			<div class="modal-dialog modal-xl modal-dialog-centered"
				role="document">
				<div class="modal-content">
					<div class="modal-header ">
						<h5 class="modal-title font-weight-normal"
							id="newCustomerModalLabel">Update Customer</h5>

						<button type="button" class="btn-close text-dark"
							data-bs-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>

					<div class="container-fluid">
						<div class="row">
							<div class="col-lg-12 col-12 mx-auto position-relative">
								<div class="card">
									<div class="card-body pt-2">
										<form id="edit_customer_form">
											

											<input type="hidden" name="actionType"> <input
												type="hidden" name="customerId" id="customerId" />
											<div class="row">
												<div class="row">
													<div class="col-md-6 col-sm-12">
														<div class="input-group input-group-static mb-1">
															<label>Type</label> <select class="form-control"
																id="editcustomer_type" name="customer_type"
																required="required">
																<option value="">Select Customer Type</option>
															</select>
														</div>
													</div>

												</div>

												<div class="col-md-6 col-sm-12">
													<div class="input-group input-group-static mb-1">
														<label>Customer Name</label> <input type="text"
															id="customer_Name" name="customer_name"
															class="required form-control" readonly>
														<span class="msgError" id="msgError_customer_Name" ></span>
														</div>
												</div>

												<div class="col-md-6 col-sm-12">
													<div class="input-group input-group-static mb-1">
														<label>Customer Address</label> <input type="text"
															id="customer_Address" name="customer_address"
															class="required form-control">
														<span class="msgError" id="msgError_customer_Address"></span>
													</div>
												</div>
											</div>
											<div class="row">
												<div class="col-md-6 col-sm-12">
													<div class="input-group input-group-static mb-1">
														<label>Customer Email</label> <input type="email"
															class="required form-control" id="customer_Email"
															name="customer_email">
														<span class="msgError" id="msgError_customer_Email"></span>
													</div>
												</div>


												<div class="col-md-6 col-sm-12">
													<div class="input-group input-group-static mb-1">
														<label>Customer Phone</label> <input type="text"
															id="customer_Phone" name="customer_phone"
															class="required form-control">
														<span class="msgError" id="msgError_customer_Phone"></span>
													</div>
												</div>
											</div>

											<div class="row">
												<div class="col-md-6 col-sm-12">
													<div class="input-group input-group-static mb-1">
														<label>Customer Alternate Email</label> <input
															type="email" class="form-control" id="altcustomer_Email"
															name="customer_email">
													</div>
												</div>

												<div class="col-md-6 col-sm-12">
													<div class="input-group input-group-static mb-1">
														<label>Customer Alternate Phone</label> <input type="text"
															class="form-control" id="altcustomer_Phone"
															name="customer_phone">
													</div>
												</div>
											</div>

											<div class="row justify-content-md-end mt-4">

												<div class="col-md-auto px-1 text-end">
													<button type="button" onclick="updateCustomer('edit_customer_form');" name="button" 
														class="btn bg-gradient-info">Update Customer</button>
													<button type="button" name="button" data-bs-dismiss="modal"
														class="btn btn-link  ml-auto">Close</button>
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
		<!-- Modal End For update Customer-->




	</main>
	<!-- End Main -->
	<form name="customerform" action="customer" method="post">
		<input type="hidden" name="actionType" /> <input type="hidden"
			name="customer_id" />
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
<script src="assets/js/material-dashboard.js?v=3.0.6"></script>
<link
	href="https://gitcdn.github.io/bootstrap-toggle/2.2.2/css/bootstrap-toggle.min.css"
	rel="stylesheet">
<script
	src="https://gitcdn.github.io/bootstrap-toggle/2.2.2/js/bootstrap-toggle.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		checkSession();
	})
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
	var start_Index;
	var end_Index
	var index = 1;
	var curPage = 0;
	var activePage = 0;

	var id;
	function deleteCustomerById(customerId) {
		this.id = customerId;
	}

	function deleteCustomer() {
		$.ajax({
			url : "customer?actionType=deleteCustomerById",
			type : 'post',
			data : {
				id : id,
			},
			success : function(data) {
				location.reload();
			},
			error : function(error) {
				alert(error);
			}
		})
	}

	function saveCustomer() {
		
		if(validateServiceDetails("customer_form")) {
		
		$.ajax({
			url : "customer?actionType=save",
			type : "POST",
			data : {
				customer_name : $('#customer_name').val(),
				customer_address : $('#customer_address').val(),
				customer_email : $('#customer_email').val(),
				customer_phone : $('#customer_phone').val(),
				altcustomer_email : $('#altcustomer_email').val(),
				altcustomer_phone : $('#altcustomer_phone').val(),
				customer_type : $('#customer_type').val()

			},
			success : function(resp) {
				$('#newCustomerModal').modal('toggle');
				$('#customer_form')[0].reset();
				console.log(resp);
				loadCustomerList();
				loadCustomerList1();
			}

		})
		}
	}

	$(document).ready(function() {
		action_type = "list";
		activePage = 0;
		start_Index = 0;
		end_Index = 100;
		index = 1;
		loadCustomerList();
		loadCustomerList1();
		getCustomerTypeList();
		showSelectedView();
	})

	function loadCustomerList1() {
		$('#currentPageNo').val(1);
		$
				.ajax({
					url : "customer",
					type : "POST",
					data : {
						actionType : action_type,
						name : $('#searchname_id').val(),
						email : $('#searchemail_id').val(),
						phone : $('#searchphone_id').val(),
						startIndex : 0,
						endIndex : 10,
					},
					success : function(resp) {
// 						$('#loadnextgridid').prop('hidden', false)
						console.log(resp[0]);
						$("#tbodyId").empty();
						
						if (resp[0].length % 2 == 0) {
							$('#loadmoreid').prop('hidden', true);
							$('#loadmoreid').prop('hidden', true);
						}
						if (resp[0].length < 10) {
							$('#loadmoreid').prop('hidden', true);
							$('#loadmoreid').prop('hidden', true);
							
						}else {
							$('#loadmoreid').prop('hidden', false);
							$('#loadmoreid').prop('hidden', false);
						}
						
						var tbo = document.getElementById("tbodyId");
						for (var i = 0; i < resp[0].length; i++) {
							var row = '<tr><td><a class="btn btn-link text-dark px-1 mb-0" data-bs-toggle="modal" data-bs-target="#updateCustomerModal" onclick="showCustomerDetails('
									+ resp[0][i].customer_id
									+ ');"><i class="material-icons text-sm me-2">edit</i></a>'
									+ '<a class="btn btn-link text-danger px-1 mb-0" data-bs-toggle="modal" data-bs-target="#exampleModal" onclick="deleteCustomerById('
									+ resp[0][i].customer_id
									+ ');"><i class="material-icons text-sm me-2">delete</i></a><a href="javascript:;" class="btn btn-link text-dark px-1 mb-0" onclick="viewprojects('
									+ resp[0][i].customer_id
									+ ')"><i class="material-icons text-xl me-2">preview</i></a></td><td>'
									+ resp[0][i].customer_name
									+ '</td><td>'
									+ resp[0][i].customer_address
									+ '</td><td>'
									+ resp[0][i].customer_email
									+ '</td><td>'
									+ resp[0][i].customer_phone + '</td></tr>';
							tbo.innerHTML += row;
						}
					},
					error : function(error) {
						alert(error);
					}
				})
	}
	
	
	function loadMoreCustomersGrid() {
		if($('#currentPageNo').val() != ''){
			var currentPageNo = parseInt($('#currentPageNo').val()) +1; 
			$('#currentPageNo').val(currentPageNo)
		$
				.ajax({
					url : "customer",
					type : "POST",
					data : {
						actionType : action_type,
						name : $('#searchname_id').val(),
						email : $('#searchemail_id').val(),
						phone : $('#searchphone_id').val(),
						startIndex : 0,
						endIndex : 10,
						pageNo: currentPageNo 
					},
					success : function(resp) {
						console.log(resp[0]);
						//$("#tbodyId").empty();
						if(resp[0] == null){
							$('#loadmoreid').prop('hidden', true);
						}
						if (resp[0].length % 2 == 0) {
							$('#loadmoreid').prop('hidden', true);
							$('#loadmoreid').prop('hidden', true);
						}
						if (resp[0].length < 10) {
							$('#loadmoreid').prop('hidden', true);
							$('#loadmoreid').prop('hidden', true);
							
						}else {
							$('#loadmoreid').prop('hidden', false);
							$('#loadmoreid').prop('hidden', false);
						}
// 						else{
						var tbo = document.getElementById("tbodyId");
						for (var i = 0; i < resp[0].length; i++) {
							var row = '<tr><td><a class="btn btn-link text-dark px-1 mb-0" data-bs-toggle="modal" data-bs-target="#updateCustomerModal" onclick="showCustomerDetails('
									+ resp[0][i].customer_id
									+ ');"><i class="material-icons text-sm me-2">edit</i></a>'
									+ '<a class="btn btn-link text-danger px-1 mb-0" data-bs-toggle="modal" data-bs-target="#exampleModal" onclick="deleteCustomerById('
									+ resp[0][i].customer_id
									+ ');"><i class="material-icons text-sm me-2">delete</i></a><a href="javascript:;" class="btn btn-link text-dark px-1 mb-0" onclick="viewprojects('
									+ resp[0][i].customer_id
									+ ')"><i class="material-icons text-xl me-2">preview</i></a></td><td>'
									+ resp[0][i].customer_name
									+ '</td><td>'
									+ resp[0][i].customer_address
									+ '</td><td>'
									+ resp[0][i].customer_email
									+ '</td><td>'
									+ resp[0][i].customer_phone + '</td></tr>';
							tbo.innerHTML += row;
						}
// 						}
					},
					error : function(error) {
						alert(error);
					}
				})
	}
}
	
	
	function showSelectedView() {
		if ($('#tableviwid').is(":checked")) {
			$('#tableview').show();
			$('#gridview').hide();

		} else {
			$('#tableview').hide();
			$('#gridview').show();
		}
	}

	$('#search_id').click(function() {
		action_type = "searchByData";
		activePage = 0;
		start_Index = 0;
		end_Index = 100;
		index = 1;
		loadCustomerList();
		loadCustomerList1();
	})

	function loadCustomerList() {
		$('#cPageNo').val(1);
		$.ajax({
			url : "customer",
			type : "POST",
			data : {
				actionType : action_type,
				name : $('#searchname_id').val(),
				email : $('#searchemail_id').val(),
				phone : $('#searchphone_id').val(),
				startIndex : 0,
				endIndex : 10,
			},
			success : function(resp) {
// 				$('#loadmoreid').prop('hidden', false)
				console.log("list1",resp[0]);
				$("#customerlistid").empty();
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
							var newcustomerrow = createcustomerrow(rowdata);
							$('#customerlistid').append(newcustomerrow);
						}
					}

				}

			}
		})
	}

	function loadMoreCustomers() {
		if($('#cPageNo').val() != ''){
			var cPageNo = parseInt($('#cPageNo').val()) +1; 
			$('#cPageNo').val(cPageNo)
		$.ajax({
			url : "customer",
			type : "POST",
			data : {
				actionType : action_type,
				name : $('#searchname_id').val(),
				email : $('#searchemail_id').val(),
				phone : $('#searchphone_id').val(),
				startIndex : 0,
				endIndex : 10,
				pageNo: cPageNo 
			},
			success : function(resp) {
				console.log("loadMore",resp);
// 				$("#customerlistid").empty();
				if(resp[0] == null){
					$('#loadnextgridid').prop('hidden', true);
				}
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
// 				if (resp[1] > 0) {
					var jsonData = eval(resp[0]);
					if (jsonData.length > 0) {
						for (var i = 0; i < jsonData.length; i++) {
							var rowdata = jsonData[i];
							var newcustomerrow = createcustomerrow(rowdata);
							$('#customerlistid').append(newcustomerrow);
						}
					}

// 				}
// 				}

			}
		})
	}
}
	
	
	function createcustomerrow(data) {
		var rowData = '<div class="col-lg-4 col-sm-12 col-md-6 mb-2">';
		rowData += '<div class="card">';
		rowData += '<div class="card-body p-3 position-relative">';
		rowData += '<div class="row">';
		rowData += '<div class="col-10 text-start">';
		rowData += '<h6 class="font-weight-bolder mb-0">';
		rowData += '' + data.customer_name + '';
		rowData += '</h6>';
		rowData += '<p class="text-sm mb-1 text-capitalize font-weight-bold">Address: '
				+ data.customer_address + '</p>';
		rowData += '<p class="p-0 mb-0"><i class="fas fa-envelope text-info text-sm" aria-hidden="true"></i> '
				+ data.customer_email + '</p>';
		rowData += '<p class="p-0 mb-0"><i class="fa fa-phone-square-alt text-info text-sm" aria-hidden="true"></i> '
				+ data.customer_phone + '</p>';
		rowData += '</div>';
		rowData += '<div class="col-2">';
		rowData += '<div class="text-end">';
		rowData += '<a href="javascript:;" class="text-info" onclick="viewprojects('
				+ data.customer_id + ')">';
		rowData += '<i class="material-icons text-xl">preview</i>';
		rowData += '</a>';

		rowData += '</div>';
		rowData += '</div>';
		rowData += '</div>';
		rowData += '<div class="row">';
		rowData += '<div class="col-12 text-end">';
		rowData += '<a class="btn btn-link text-dark px-1 mb-0" data-bs-toggle="modal" data-bs-target="#updateCustomerModal" onclick="showCustomerDetails('
				+ data.customer_id + ');">';
		rowData += '<i class="material-icons text-sm me-2">edit</i></a>';
		rowData += '<a class="btn btn-link text-danger px-1 mb-0" data-bs-toggle="modal" data-bs-target="#exampleModal" onclick="deleteCustomerById('
				+ data.customer_id + ');">';
		rowData += '<i class="material-icons text-sm me-2">delete</i></a>';
		rowData += '</div>';
		rowData += '</div>';
		rowData += '</div>';
		rowData += '</div>';
		rowData += '</div>';
		return rowData;
	}

	function showCustomerDetails(customerId) {
		console.log(customerId)
		$.ajax({
			url : "customer",
			type : "POST",
			data : {
				customer_id : customerId,
				actionType : "infoforedit"
			},
			success : function(resp) {
				console.log(resp);
				$('#customerId').val(resp.customer_id);
				$('#customer_Name').val(resp.customer_name);
				$('#customer_Address').val(resp.customer_address);
				$('#customer_Email').val(resp.customer_email);
				$('#customer_Phone').val(resp.customer_phone);
				$('#altcustomer_Email').val(resp.customer_alternate_emailId);
				$('#altcustomer_Phone').val(resp.customer_alternate_contact);
				$('#editcustomer_type').val(resp.customer_type_id);
				console.log(customer_type);
			}
		})
	}

	function updateCustomer(formid) {
		
		if (validateServiceDetails(formid)) {
	
		
		var customerId = $('#customerId').val();
		console.log(customerId);
		$.ajax({
			url : "customer?actionType=update",
			type : "POST",
			data : {
				customer_id : $('#customerId').val(),
				customer_name : $('#customer_Name').val(),
				customer_address : $('#customer_Address').val(),
				customer_email : $('#customer_Email').val(),
				customer_phone : $('#customer_Phone').val(),
				altcustomer_email : $('#altcustomer_Email').val(),
				altcustomer_phone : $('#altcustomer_Phone').val(),
				editcustomer_type : $('#editcustomer_type').val()

			},
			success : function(resp) {
				$('#updateCustomerModal').modal('toggle');
				loadCustomerList();
				loadCustomerList1();
				
			}
		})
		}
	}

	function getCustomerTypeList() {
		$
				.ajax({
					url : "masterDetails",
					type : 'post',
					data : {
						actionType : "customertypelist"
					},
					success : function(data) {
						if (data != null) {
							for (let i = 0; i < data.length; i++) {
								var htmlData = '<option value="' + data[i].customer_type_id + '">'
										+ data[i].customer_type + '</option>'
								$('#editcustomer_type').append(htmlData);
								$('#customer_type').append(htmlData);
							}
						}
					},
					error : function(error) {
						alert(error);

					}
				});
	}
	function viewprojects(customerid) {
		sessionStorage.removeItem("customerid");
		sessionStorage.setItem("customerid", customerid);
		window.location = 'projects.jsp';
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
			}else if (inputObj.type === 'email'
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

<%@ include file="/include/footer.jsp"%>

