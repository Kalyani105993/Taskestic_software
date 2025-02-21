<%@page import="java.util.ArrayList"%>
<%@ include file="/include/header.jsp"%>
<%@ page isELIgnored="false"%>


<style>
</style>
<body class="g-sidenav-show  bg-gray-100 g-sidenav-hidden">
	<%@ include file="/include/leftnav.jsp"%>
	<main
		class="main-content position-relative max-height-vh-100 h-100 border-radius-lg ">
		<!-- Navbar -->
		<nav
			class="navbar navbar-main navbar-expand-lg position-sticky  px-0 shadow-none border-radius-xl z-index-sticky"
			id="navbarBlur" data-scroll="true">
			<div class="container-fluid py-1 px-3"
				style="display: block !important">
				<nav aria-label="breadcrumb">
					<div class="row">
						<div class="col-6">
						 <ol class="breadcrumb" >
						    <li class="breadcrumb-item"><a i class="material-icons fixed-plugin-button-nav cursor-pointer " href='workspace.jsp'> home </i></a></li>
						     <h6 class="font-weight-bolder mb-0 breadcrumb-item active">Help</h6>
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
						<div class="col-6" id="addbtbn"></div>
					</div>
				</nav>
			</div>
		</nav>



		<div class="card card-body p-2 pt-2">
			<div class="table-responsive">
				<table class="table table-flush text-sm">
					<thead>
						<tr>
							<th>user manual</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><a href="#" onclick="redirect();">How Can I login?</a></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</main>


</body>
<script src="assets/js/core/popper.min.js"></script>
<script src="assets/js/core/bootstrap.min.js"></script>
<script src="assets/js/plugins/perfect-scrollbar.min.js"></script>
<script src="assets/js/plugins/smooth-scrollbar.min.js"></script>
<script src="assets/js/plugins/dragula/dragula.min.js"></script>
<script src="assets/js/plugins/jkanban/jkanban.js"></script>
<script src="assets/js/material-dashboard.min.js?v=3.0.6"></script>

<script>
	function redirect() {
		window.open("helperVideo.jsp", "");
	}
</script>
<%@ include file="/include/footer.jsp"%>
