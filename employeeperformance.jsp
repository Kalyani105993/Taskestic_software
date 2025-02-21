<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="/include/header.jsp"%>



<style>
.sticky-column {
	position: sticky;
	left: 0;
	background-color: white !important;
}
.sticky-column-1{
	position: sticky;
	left: 30px;
	background-color: white !important;
}
</style>


<body class="g-sidenav-show  bg-gray-100 g-sidenav-hidden">
	<%@ include file="/include/leftnav.jsp"%>

	<!-- Main -->
	<main
		class="main-content position-relative max-height-vh-100 h-100 border-radius-lg ">
		<nav
			class="navbar navbar-main navbar-expand-lg position-sticky  px-0 shadow-none border-radius-xl z-index-sticky"
			id="navbarBlur" data-scroll="true">
			<div class="container-fluid py-1 px-3"
				style="display: block !important">
				<nav aria-label="breadcrumb">
					<div class="row">
						<div class="col-3">
							<h6 class="font-weight-bolder mb-0">Employee Performance</h6>
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
			<div class="content card-header p-2">
				<div class="row">
					<div class="col-md-3">
						<div class="input-group input-group-static mb-2">
							<select class="required form-control p-2" id="project-select"
								onchange="projectOnChng(this);">
								<option value="">Select Project</option>
							</select>
						</div>
					</div>
					<div class="col-md-3">
						<div class="input-group input-group-static mb-2">
							<select class="required form-control p-2" id="emp-select"
								onchange="createJsonFilter();">
								<option value="">Select Employee</option>
							</select>
						</div>
					</div>
					<div class="col-md-3">
						<div class="input-group input-group-static mb-2">
							<select class="required form-control p-2" name=""
								id="recordsbyDate" onchange="createJsonFilter();">
								<option value="last_3_months">Last 3 Months</option>
								<option value="this_month">This Month</option>
								<option value="this_week">This Week</option>
								<option value="yesterday">Yesterday</option>
								<option value="today">Today</option>
								<option value="custom_dates">Custom Dates</option>

							</select>
						</div>
					</div>
					<div class="col-md-3 rightalign">
						<button class="btn btn-icon btn-2 btn-dark" id="search"
							type="button" onclick="createEmpPerformRowContent();">
							<span class="btn-inner--icon"><i class="material-icons">search</i></span>
						</button>
					</div>

				</div>
				<div class="row">
					<div class="col-md-3" id="start-date-col" style="display: none;">
						<div class="input-group input-group-dynamic">
							<input class="multisteps-form__input form-control" type="date"
								name="startdate" id="startdate" />
						</div>
						<span id="error-msg-stDate" class="err-msg"
							style="display: none; color: red;">Please select a date !</span>
						<span id="err-msg-DateCompare" class="err-msg"
							style="display: none; color: red">From date is greater
							than to date..! </span>

					</div>

					<div class="col-md-3" id="end-date-col" style="display: none;">
						<div class="input-group input-group-dynamic">
							<input class="multisteps-form__input form-control" type="date"
								name="enddate" id="enddate" />
						</div>
						<span id="error-msg-toDate" class="err-msg"
							style="display: none; color: red">Please select a date!...</span>
					</div>
				</div>

			</div>

		</div>



		<div class="container-fluid mt-2">
			<div class="row">
				<div class="col-sm-6"></div>
				<div class="col-sm-6">
					<div class="rightalign">
						<!-- 						<button class="btn btn-icon btn-2 btn-dark" -->
						<!-- 							onclick="ExportToPdf();" type="button">PDF</button> -->
						<button class="btn btn-icon btn-2 btn-dark ms-2"
							onclick="ExportToExcel();" type="button">EXCEL</button>
						<button class="btn btn-icon btn-2 btn-dark ms-2"
							onclick="ExportToCSV();" type="button">CSV</button>
					</div>
				</div>
			</div>
		</div>

		<div class="card card-body p-2 pt-2" id="list-view">
			<div class="table-responsive" style="overflow: auto; height: 450px;">
				<table class="table table-flush text-sm" id="empPerformancetable">
					<thead class="thead-light" id="empPerformanceth"
						style="background-color: #ffff; position: sticky; top: 0; z-index: 1;">
						<tr id="mainTr">
							<th rowspan="2" class="sticky-column"></th>
							<th rowspan="2" class="sticky-column-1">Employee Name</th>
							<th id="totTsk">Total Tasks</th>
						</tr>
						<tr id="totTskStatusheads">

						</tr>
					</thead>
					<tbody id="empPerformancetbody">

					</tbody>
				</table>
			</div>
		</div>
	</main>

	<!-- Modal -->
	<div class="modal fade" id="exampleModalLong" tabindex="-1"
		role="dialog" aria-labelledby="exampleModalLongTitle"
		aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title font-weight-normal"
						id="pieChartModalTitle"></h5>
					<button type="button" class="btn-close text-dark"
						data-bs-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body font-weight-light">
				    <div class="row">
				        <div class="col-sm-4">
				        	<p class="h6"><small>Department: </small></p>
				        </div>
				        <div class="col-sm-4">
				        	<span id="department" ></span>
				        </div>
				    
				    </div>
				    
				     <div class="row">
				        <div class="col-sm-4">
				        	<p class="h6"><small>Reporting To: </small></p>
				        </div>
				        <div class="col-sm-4">
				        	<span id="reportingTo" ></span>
				        </div>
				    
				    </div>
				
					<canvas id="employeePerformanceChart"></canvas>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn bg-gradient-secondary"
						data-bs-dismiss="modal">Close</button>
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
<!-- <script src="assets/js/plugins/datatables.js"></script> -->
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script
	src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
<link rel="stylesheet"
	href="https://cdn.datatables.net/1.12.1/css/jquery.dataTables.min.css">
<!-- Kanban scripts -->
<script src="assets/js/plugins/dragula/dragula.min.js"></script>
<script src="assets/js/plugins/jkanban/jkanban.js"></script>
<script src="assets/js/material-dashboard.js?v=3.0.6"></script>
<link
	href="https://gitcdn.github.io/bootstrap-toggle/2.2.2/css/bootstrap-toggle.min.css"
	rel="stylesheet">
<script
	src="https://gitcdn.github.io/bootstrap-toggle/2.2.2/js/bootstrap-toggle.min.js"></script>

<!-- common functions  -->
<script src="assets/js/common-functions.js"></script>
<script src="assets/js/Exports/export-report.js"></script>

<!-- Pie chart cdn  -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script>
	var operatorLabels = { "=": "is", "!=": "is not", "1": "active", "0": "closed", "o": "open", "!*": "none", "*": "any", "~": "contains", "!~": "doesn't contain", "^": "starts with", "$": "ends with" };
	var operatorByType = {
	    "list": ["=", "!="], "status": ["1", "0"], "list_status": ["o", "=", "!", "c", "*"], "list_optional": ["=", "!", "!*", "*"],
	    "list_subprojects": ["*", "!*", "=", "!"], "string": ["~", "=", "!~", "!", "^", "$"], "text": ["~", "!~", "^", "$", "!*", "*"],
	    "integer": ["=", "\u003e=", "\u003c=", "\u003e\u003c", "!*", "*"], "float": ["=", "\u003e=", "\u003c=", "\u003e\u003c", "!*", "*"],
	    "relation": ["=", "!", "=p", "=!p", "!p", "*o", "!o", "!*", "*"], "tree": ["=", "~", "!*", "*"]
	};
	var taskanalysisRptData = [];
    var contextPath = '<%=request.getContextPath()%>';
    var storeSelectedValues = [];
    var reportName = "Employee Perfomance";
    var dataExport = [];
    var columnExport = [];
    var pdfExpFilters = [];
    var tskStatusList;
	var tskPriorityList;
	var empList;
	
    
	$(document).ready(async function() {
		empList = await fetchMasterData("pms_employees_view", contextPath);
		var projList = await fetchMasterData("pms_projects_view", contextPath);
		var empListElement = document.getElementById("emp-select");
		var projListElement = document.getElementById("project-select");

		empList.forEach((employee) => {
			var option = document.createElement("option");
            option.text = employee.field_name;
            option.value = employee.field_id;
            empListElement.add(option)
		});
		
		projList.forEach((project) => {
			var option = document.createElement("option");
            option.text = project.field_name;
            option.value = project.field_id;
            projListElement.add(option)
		});
		
		tskStatusList = await fetchMasterData("pms_mst_task_status_view", contextPath);
		tskStatusList.forEach((item, index) => {
			var status = item.field_name
			tskStatusList[index].field_name = status.replace(" ", "-");
			
		});
		tskPriorityList = await fetchMasterData("pms_mst_task_priority_view", contextPath);
		
		await createTableHeads();
		await createEmpPerformRowContent();
	});
	
	
	$("#recordsbyDate").change(function() {
		var custom_date = $("#recordsbyDate").val();
		if (custom_date == "custom_dates") {
			$("#end-date-col").show();
			$("#start-date-col").show();

		} else {
			$("#end-date-col").hide();
			$("#start-date-col").hide();
		}
	});
	
	async function projectOnChng(event){
		const project_id = event.value;
		resetGlobalQuery();
	  	globalQuery.columns.push("employee_id");
	 	globalQuery.columns.push("employee_name");
	 	
	 	globalQuery.table = "project_employee_info_view"; 	  
	 	
	 	globalQuery.conditions.push({
	 	    field: "project_id",
	 	    operator: "=",
	 	    value: project_id
	 	  });
	   console.log("globalQuery: ", globalQuery);
	   
	   var resp = await globalQueryFunc(globalQuery, contextPath);
	   let parseResp = JSON.parse(resp);
	   
	   var empListElement = document.getElementById("emp-select");
	   
	   empListElement.innerHTML = '';
	   
	   parseResp.forEach((employee, index) => {
		   if(index == 0){
			   let option = document.createElement("option");
	           option.text = "Select Employee";
	           option.value = "";
	           empListElement.add(option)
		   }
		   var option = document.createElement("option");
           option.text = employee.employee_name;
           option.value = employee.employee_id;
           empListElement.add(option)
		});
	   
	}
	
	const createEmpPerformRowContent = async () => {
		var project = $('#project-select').val();
    	var employee = $('#emp-select').val();
    	
    	const reportsByDateResp = reportsByDate(); 
        var from_date = reportsByDateResp[0].task_start_date;
        var to_date = reportsByDateResp[0].task_due_date;
        
        if(from_date == 'NaN-NaN-NaN' && $('#recordsbyDate').val() == 'custom_dates'){$('#error-msg-stDate').show(); return false;}else{$('#error-msg-stDate').hide()}
        if(to_date == 'NaN-NaN-NaN' && $('#recordsbyDate').val() == 'custom_dates'){$('#error-msg-toDate').show(); return false;}else{$('#error-msg-toDate').hide()}
        
        if (from_date != 'NaN-NaN-NaN' && to_date != 'NaN-NaN-NaN' && $('#recordsbyDate').val() == 'custom_dates') {
			var fromDate = new Date(from_date);
			var lastDate = new Date(to_date);
			var isGreater = lastDate > fromDate;

			if (isGreater) {
				$('#errMsgDateCompare').hide();
			} else {
				$('#errMsgDateCompare').show();
				return false;
			}
		}
		
        
		jQuery.ajax({
			type : "POST",
			url : "employeeperformance",
			data : {
				actionType : "fetchEmpPerformanceTasks",
				from_date : from_date,
				to_date : to_date,
				project : project,
				employee : employee
			},
			async : true,
			success : function(responce) {
				console.log("fetchEmpPerformanceTasks responce: ", responce)
				$('#empPerformancetbody').empty();
				createTableBody(responce);
				
			},
			error : function(error) {
				console.log("error: ", error);
			}
		});
		
	}
	
    
	
	const createTableHeads = async() =>{
		tskStatusList.push({'field_id': '', 'field_name':'Total-Tasks'});
		tskStatusList.push({'field_id': '', 'field_name':'Completion-Percent'});
		
		$('#totTsk').attr('colspan', tskStatusList.length);
		tskStatusList.forEach(item => {
			var status = '<th>'+createStatusElement(item.field_name, item.field_id)+'</th>';
			$('#totTskStatusheads').append(status);
			
		});
		
		tskPriorityList.forEach(item => {
			var priorityTh = '<th colspan= '+tskStatusList.length+'>'+createPriorityElement(item.field_name, item.field_id)+'</th>';
			$('#mainTr').append(priorityTh);
			
			tskStatusList.forEach(item => {
				var status = '<th>'+createStatusElement(item.field_name, item.field_id)+'</th>';
				$('#totTskStatusheads').append(status);
				
			});
			
		});

	}
	
	const createTableBody = async(responce) =>{
		dataExport = responce;
		columnExport = Object.keys(responce[0]);
		for(let empIdInds = 0; empIdInds < responce.length; empIdInds++){
			let emp_id = responce[empIdInds].employee_id;
			let emp_name = responce[empIdInds].employee_name;
			
			var employees = '<tr id=emp-'+emp_id+'-tr><td class="sticky-column text-center"><a href="#exampleModalLong" onclick="return piechartData('+emp_id+');" data-bs-toggle="modal" data-bs-target="#exampleModalLong"><i class="material-icons">pie_chart</i></a></td><td class="sticky-column-1 anchorClick"><input type="hidden" class="hidden_input" employee_name="'+emp_name+'"  task_status = ""  task_priority=""  /><a href="#" class="cursor-pointer">'+emp_name+'</a></td></tr>';
			$('#empPerformancetbody').append(employees);
			
			for(let priInd = 0; priInd < tskPriorityList.length; priInd++){
				if(priInd == 0){
					for(let statusInd = 0; statusInd < tskStatusList.length; statusInd++){
						var crEmpTd = '<td class="text-center" id="empId-'+emp_id+'-'+tskStatusList[statusInd].field_name+'-totTasks">0</td>';
						$('#emp-'+emp_id+'-tr').append(crEmpTd);
					}
				}
				for(let statusInd = 0; statusInd < tskStatusList.length; statusInd++){
					var crEmpTd = '<td class="text-center" id="empId-'+emp_id+'-'+tskStatusList[statusInd].field_name+'-'+tskPriorityList[priInd].field_name+'">0</td>';
					$('#emp-'+emp_id+'-tr').append(crEmpTd);
				}
			}
			
			var empJson = responce[empIdInds];
			var getKeysEmpJson = Object.keys(empJson);
			
			for (let empJsonInd = 0; empJsonInd < getKeysEmpJson.length; empJsonInd++) {
				let value = empJson[getKeysEmpJson[empJsonInd]];
				let key = getKeysEmpJson[empJsonInd].replaceAll('_', '-');
				let createId = 'empId-'+ emp_id + '-' +  key;
				let tskStatus = "";
				let tskPriority = "";
				
				if(empJsonInd > 2){
					let splitId = createId.split('-');
					tskStatus = splitId[2];
					tskPriority = splitId[3];
				}
				if(key.includes('Total-Tasks')  || key.includes('Completion-Percent') || value == null){
					$('#'+createId).empty();
					if(value == null){value = '-'}
					$('#'+createId).append(value);
				}else{
					$('#'+createId).empty();
					$('#'+createId).append('<input type="hidden" class="hidden_input"  employee_name="'+emp_name+'"  task_status = "'+tskStatus+'"  task_priority="'+tskPriority+'"  /><a href="#" class="cursor-pointer text-sm font-weight-bold">'+value+'</a>');
					$('#'+createId).addClass('anchorClick');
				}
				
				
				
			}
		}
	}
	
	
	
	var ctx = document.getElementById('employeePerformanceChart').getContext('2d');

	var data = {
	    labels: [],
	    datasets: [{
	        data: [], // Initial data values
	        backgroundColor: [],
	    }]
	};

	var options = {
			plugins: {
		        legend: {
		            display: true,
		            position: 'right', // Position of the legend
		            labels: {
		                generateLabels: function(chart) {
		                    var data = chart.data;
		                    if (data.labels.length && data.datasets.length) {
		                        var dataset = data.datasets[0];
		                        var labels = data.labels;
		                        var legendItems = [];

		                        for (var i = 0; i < labels.length; i++) {
		                            legendItems.push({
		                                text: labels[i] + ': ' + dataset.data[i] + '%',
		                                fillStyle: dataset.backgroundColor[i],
		                                hidden: false,
		                                index: i,
		                            });
		                        }
		                        return legendItems;
		                    }
		                    return [];
		                },
		            },
		        },
		    },
			cutoutPercentage: 60, // Adjust the size of the doughnut hole (0 to 100),  
			 
		};

	var employeePerformanceChart = new Chart(ctx, {
	    type: 'doughnut',
	    data: data,
	    options: options,
	});

	
	function piechartData(emp_id){
		var backgroundColors = [];
		var pieChartNumbers =  []; 
		var labels = [];
		
		var emp_json = dataExport.find(employee => employee.employee_id == emp_id);
		
		// Destroy the existing chart
		if (employeePerformanceChart) {
		    employeePerformanceChart.destroy();
		}
		
		
		tskStatusList.forEach((item, index) => {
			var status = item.field_name;
			if(!status.includes('Total-Tasks') && !status.includes('Completion-Percent')){
					labels.push(status);
			}
			backgroundColors.push(createStatusElementColors(item.field_name, item.field_id));
			let crStatus = status+'_totTasks';
			if(emp_json[crStatus] == null || emp_json[crStatus] == undefined){
				pieChartNumbers.push(0);
			}else {
				pieChartNumbers.push(emp_json[crStatus]);
			}
		});
		
	
		$('#pieChartModalTitle').empty();
		$('#department').empty();
		$('#reportingTo').empty();
		
		$('#reportingTo').append('<p class="text-sm"><strong>'+emp_json.reporting_to_name+'</strong></p>');
		$('#department').append('<p class="text-sm"><strong>'+emp_json.department_name+'</strong></p>');
		$('#pieChartModalTitle').append('<span class="anchorClick"><input type="hidden" class="hidden_input" employee_name="'+emp_json.employee_name+'"  task_status = ""  task_priority=""  /><a href="#" class="cursor-pointer">'+emp_json.employee_name+'</a></span>');
		
		// Create a new chart with updated data
	    employeePerformanceChart = new Chart(ctx, {
	        type: 'doughnut',
	        data: {
	            labels: labels,
	            datasets: [{
	                data: pieChartNumbers,
	                backgroundColor: backgroundColors,
	            }]
	        },
	        options: options,
	    });
		 
		
	}
	
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
	
	$(document).on('click', '.anchorClick', function() {
		var forwdataTotaskAnalyRept = {
									  filterName: [],
									  filterVal: [],
									};
		
		var employee_name = $(this).find("input").attr('employee_name');
		var task_status = $(this).find("input").attr('task_status');
		var task_priority = $(this).find("input").attr('task_priority');
		
		forwdataTotaskAnalyRept.filterName.push("employee_name");
		forwdataTotaskAnalyRept.filterName.push("task_status");
		forwdataTotaskAnalyRept.filterName.push("task_priority");
		
		forwdataTotaskAnalyRept.filterVal.push(employee_name);
		forwdataTotaskAnalyRept.filterVal.push(task_status);
		forwdataTotaskAnalyRept.filterVal.push(task_priority);
		
		// Store the data in local storage
        localStorage.setItem('filtrDataFromEmpPerfRpt', JSON.stringify(forwdataTotaskAnalyRept));
		 
		window.location.href= "taskanalysisreport.jsp"; 
	});

	
	
	function createStatusElement(status, type) {
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
	
	function createPriorityElement( prioirty, type) {
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
	
	function createProgressBarElement(task_completion_value){
    	var completion;
    	if(task_completion_value >= 80){
    		completion = 'bg-gradient-success';
    	}else if(task_completion_value >= 50 && task_completion_value <= 80){
    		completion = 'bg-gradient-warning';
    	}else if(task_completion_value <= 50){
    		completion = 'bg-gradient-danger';
    	}
    	
    	switch(completion){
    		case 'bg-gradient-success':
    	    	return '<div class="progress-wrapper"> <div class="progress-info"> <div class="progress-percentage"> <span class="text-sm font-weight-normal">'+task_completion_value+'%</span> </div> </div> <div class="progress"> <div class="progress-bar bg-gradient-success" role="progressbar" aria-valuenow='+task_completion_value+' aria-valuemin="0" aria-valuemax="100" style="width:'+task_completion_value+'%; height: 6px;"></div> </div> </div>'
    	    	break;
    		case 'bg-gradient-warning':
   	    		return '<div class="progress-wrapper"> <div class="progress-info"> <div class="progress-percentage"> <span class="text-sm font-weight-normal">'+task_completion_value+'%</span> </div> </div> <div class="progress"> <div class="progress-bar bg-gradient-warning" role="progressbar" aria-valuenow='+task_completion_value+' aria-valuemin="0" aria-valuemax="100" style="width:'+task_completion_value+'%; height: 6px;"></div> </div> </div>'
   	    		break;
    		case 'bg-gradient-danger':
   	    		return '<div class="progress-wrapper"> <div class="progress-info"> <div class="progress-percentage"> <span class="text-sm font-weight-normal">'+task_completion_value+'%</span> </div> </div> <div class="progress"> <div class="progress-bar bg-gradient-danger" role="progressbar" aria-valuenow='+task_completion_value+' aria-valuemin="0" aria-valuemax="100" style="width:'+task_completion_value+'%; height: 6px;"></div> </div> </div>'
   	    		break;
   	    		
    	}
    	
    	
    }
    
     function ExportToCSV(){
    	  if (dataExport.length !== 0) {
              var data = [];
              for (let index = 0; index < dataExport.length; index++) {
                  var dataJson = {};
                  const element = dataExport[index];
                  for (let colExIndex = 0; colExIndex < columnExport.length; colExIndex++) {
                      dataJson[columnExport[colExIndex]] = element[columnExport[colExIndex]]
                  }
                  data.push(dataJson)
              }
              csv(data, reportName);
          } 
     	
     }
     
     function ExportToExcel(){
    	 var project = $('#project-select').val();
       	 var employee = $('#emp-select').val();
       	 var date = $('#recordsbyDate').val();
     	
     	 if (dataExport.length !== 0) {
             var jsonToExportExcel = { 'allData': {}, 'columns': {}, 'filtrKeyValue': {}, 'headings': {}, 'key': 'reportExport' }
               
             if(project != ""){
            	 jsonToExportExcel['filtrKeyValue'][0] = "Project" + ' : ' + project
             }
             if(employee != ""){
            	 jsonToExportExcel['filtrKeyValue'][0] = "Employee" + ' : ' + employee
             }
             if(date == 'custom_dates'){
            	 const reportsByDateResp = reportsByDate(); 
                 var from_date = reportsByDateResp[0].task_start_date;
                 var to_date = reportsByDateResp[0].task_due_date;
            	 jsonToExportExcel['filtrKeyValue'][0] = "Date" + ' : ' + from_date + ' To ' + to_date
             }else{
                 jsonToExportExcel['filtrKeyValue'][0] = "Date" + ' : ' + date.replaceAll('_', '-')
             }
             
             for (let col = 0; col < columnExport.length; col++) {
            	 if(!columnExport[col].includes('_id')){
                     jsonToExportExcel['columns'][col] = columnExport[col]
            	 }
             }
             for (let arrKey = 0; arrKey < dataExport.length; arrKey++) {
                 jsonToExportExcel['allData'][arrKey] = dataExport[arrKey];
             }
             jsonToExportExcel['headings']['ReportName'] = reportName
             jsonToExportExcel['headings']['CompanyName'] = '<%=session.getAttribute("companyName")%>';
             jsonToExportExcel['headings']['CompanyAddress'] = "";

             console.log("jsonToExportExcel: ", jsonToExportExcel)
             excel(jsonToExportExcel, reportName)
         }
     }
     
     function ExportToPdf(){
         if (dataExport.length !== 0) {
             var filtrObjKeys = Object.keys(pdfExpFilters);
             for (let objKey = 0; objKey < filtrObjKeys.length; objKey++) {
                 var key = filtrObjKeys[objKey];
                 var value = pdfExpFilters[filtrObjKeys[objKey]];
             }
             pdf(dataExport, columnExport, reportName, pdfExpFilters)
 
         }
         
     }
	
	
	 function reportsByDate(){
		var selectedDate = $('#recordsbyDate').val();
    	var fromDate;
		var toDate;
		var formattedToDate;
		var formattedFromDate;
		var dates = [];
		
		const today = new Date();
		if (selectedDate == 'today') {
			fromDate = today;
		} else if (selectedDate == 'yesterday') {
			const yesterday = new Date(today);
			yesterday.setDate(today.getDate() - 1);
			fromDate = yesterday;
		} else if (selectedDate == 'this_week') {
			const startOfWeek = new Date(today);
			startOfWeek.setDate(today.getDate() - today.getDay());

			const endOfWeek = new Date(today);
			endOfWeek.setDate(today.getDate() + (6 - today.getDay()));

			fromDate = startOfWeek;
			toDate = endOfWeek;

		} else if (selectedDate == 'this_month') {
			const startOfMonth = new Date(today.getFullYear(), today
					.getMonth(), 1);
			const endOfMonth = new Date(today.getFullYear(), today
					.getMonth() + 1, 0);

			fromDate = startOfMonth;
			toDate = endOfMonth;

		}else if (selectedDate == 'last_3_months') {
			// Get the current date
			  const currentDate = new Date();

			  // Calculate the month of three months ago
			  const threeMonthsAgo = new Date(currentDate);
			  threeMonthsAgo.setMonth(currentDate.getMonth() - 3);

			  // Create an array to store the last 3 months
			  const lastThreeMonths = [];

			  // Loop from three months ago up to the current month
			  while (threeMonthsAgo <= currentDate) {
			    lastThreeMonths.push(new Date(threeMonthsAgo));
			    threeMonthsAgo.setMonth(threeMonthsAgo.getMonth() + 1);
			  }

			  fromDate = lastThreeMonths[0];
			  toDate = lastThreeMonths[lastThreeMonths.length-1];

		}else if (selectedDate == 'custom_dates') {
			fromDate = new Date($('#startdate').val());
			toDate = new Date($('#enddate').val());
		}
		
		const year = fromDate.getFullYear();
		const month = String(fromDate.getMonth() + 1).padStart(2, '0');
		const day = String(fromDate.getDate()).padStart(2, '0');
		formattedFromDate = year + "-" + month + "-" + day;

		if (selectedDate != 'today' && selectedDate != 'yesterday') {
			const toDateYear = toDate.getFullYear();
			const toDateMonth = String(toDate.getMonth() + 1).padStart(2,
					'0');
			const toDateday = String(toDate.getDate()).padStart(2, '0');

			formattedToDate = toDateYear + "-" + toDateMonth + "-"
					+ toDateday;
		}
		dates.push({'task_start_date':formattedFromDate, 'task_due_date': formattedToDate});
		return dates;
		
    }
    
    
	
	
</script>

