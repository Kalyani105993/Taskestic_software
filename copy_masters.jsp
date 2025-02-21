<%@page import="java.util.Iterator"%>
<%@page import="com.dakshabhi.pms.customers.dtos.CCustomerDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page isELIgnored="false"%>
<%@ include file="/include/header.jsp"%>
<link rel="stylesheet"
	href="https://cdn.datatables.net/1.12.1/css/jquery.dataTables.min.css">

<body class="g-sidenav-show  bg-gray-100 g-sidenav-hidden"> 
	<!-- Main -->
	<main
		class="main-content position-relative max-height-vh-100 h-100 border-radius-lg ">
		<!-- Navbar -->
		<nav
			class="navbar navbar-main navbar-expand-lg position-sticky mt-4 top-1 px-0 shadow-none border-radius-xl z-index-sticky"
			id="navbarBlur" data-scroll="true">
			<div class="container-fluid py-1 px-3"
				style="display: block !important">
				 
			</div>
		</nav>
		<!--End Navbar -->
		<div class="container-fluid py-1">
			<div class="row">
				 
				<div class="col-lg-9 col-sm-12">
					<div class="card">
						<div class="card-header p-0">
							<div class="row">
								 
								<div class="col-md-3 col-sm-3 col-xs-3">
									<select class="form-control mb-0 p-2" id="sroucecompanyid"
										name="sroucecompany">
										<option value="1">Dakshabhi IT Solutions Pvt. Ltd.</option>
									</select>
								</div>
								<div class="col-md-3 col-sm-3 col-xs-3">
									<select class="form-control mb-0 p-2" id="destinationcompanyid"
										name="destinationcompany" >
										<option value="">Select other company</option>
									</select>
								</div>
								
								<div class="col-md-3 col-sm-3 col-xs-3 mt-2">
									 <button type="button" class="btn bg-gradient-info" id="btncopyid"
															id="taskactionid" onclick="copymasters();">Copy</button>
								</div>
							</div>
						</div>
						 
					</div>
				</div>

			</div>
		</div>
		 

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
 
<%@ include file="/include/footer.jsp"%>
<script type="text/javascript">
	$(function() {
		loadOtherCompany(); 
	});
	
	function loadOtherCompany(){
		$("#destinationcompanyid").empty();
		$.ajax({
			url : "company",
			type : "post",
			async : false,
			data : {
				action_type : "getothercompanylist" 
			},
			success : function(data) {
				console.log("data: " + data);
				var htmlData = '<option value="">Select other company</option>';
				$("#destinationcompanyid").append(htmlData); 
				for (var i = 0; i < data.length; i++) {
					var htmlData = '<option value="' + data[i].company_id + '">'
					+ data[i].company_name + '</option>';
					$("#destinationcompanyid").append(htmlData); 
				}
			}
		})
	}
	
	function copymasters(){
		$.ajax({
			url : "company",
			type : "post",
			async : false,
			data : {
				action_type : "copymasters",
				sourceid : $('#sroucecompanyid').val(),
				destid : $('#destinationcompanyid').val()
			},
			success : function(data) {
				console.log("data: " + data);
				
			}
		})
		
	}
</script>
