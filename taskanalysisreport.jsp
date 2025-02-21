<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="/include/header.jsp"%>


<style>
.filter-select-backgr {
	background-color: #ffff !important;
}

.filtr-col-selection-btn {
	margin: auto;
	display: block;
}

.filtr-single-coln-selection {
	margin-top: 50px;
}

.filtr-single-coln-top-botm {
	margin-top: 32px;
}

.field {
	width: 27%;
}

.add-filters-table-scroll {
	display: block;
	overflow-y: auto;
	overflow-x: auto;
	height: 125px;
	margin-top: 5px !important;
	margin-left: 10px !important;
}

.arrow-icons-fonts {
	font-size: 16px;
}

.rotate-down-arrow {
	transform: rotate(180deg);
}


@media ( min-width :320px) and (max-width: 425px) {
	.rotate-90 {
		-webkit-transform: rotate(-90deg);
	}
}


#loadnextitemsid {
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
						     <h6 class="font-weight-bolder mb-0 breadcrumb-item active">Task Analysis</h6>
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

						<div class="col-6">
							<div class="row">
								<div class="col-sm-6"></div>
								<div class="col-sm-5 rightalign">
									<div class="input-group input-group-static mb-2">
										<select class="required form-control p-2" name=""
											id="recordsbyDate" onchange="createJsonFilter();">
											<option value="last_3_months">Last 3 Months</option>
											<option value="this_month">This Month</option>
											<option value="this_week">This Week</option>
											<option value="yesterday">Yesterday</option>
											<option value="today">Today</option>
	                                    	</select>
									</div>
								</div>
								<div class="col-sm-1" >	
							</div>
							</div>
						</div>
					</div>
				</nav>
			</div>
		</nav>
		<!--End Navbar -->

		<div class="container-fluid">
			<p>
				<a class="author"  data-bs-toggle="collapse" href="#filter"
					role="button" aria-expanded="false" aria-controls="collapseExample">
					<span>Filters</span> <span class="material-icons-round">
						expand_more </span>
				</a>

			</p>
			<div class="collapse" id="filter">
				<div class="card card-body">
					<div class="row">
						<div class="col-12 col-lg-6 mb-5 mb-lg-0">
							<form class="multisteps-form__form mb-0">
								<div class="content">
									<div class="row align-items-center">
										<div class="col-md-5">
											<div class="input-group input-group-static">
												<label for="exampleFormControlSelect2" class="ms-0">Available
													Columns</label> <select multiple=""
													class="form-control pb-6 filter-select-backgr"
													id="availableColumns">

												</select>
											</div>
											<div class="mt-1">
												<button
													class="btn btn-icon btn-2 btn-dark filtr-col-selection-btn"
													onclick="moveAllToSelectedColumns();" type="button">Select
													All</button>

											</div>
										</div>
										<div class="col-md-1">
											<div class="row align-items-center">
												<div class="col text-end text-md-center">
													<a href="#" onclick="addSelectedColumns();"><i
														class="material-icons-round rotate-90 filtr-single-coln-selection arrow-icons-fonts my-3">east</i></a>
												</div>
												<div class="col text-start text-md-center">
													<a href="#" onclick="addAvailableColumns();"><i
														class="material-icons-round rotate-90 arrow-icons-fonts my-3">west</i></a>
												</div>
											</div>

										</div>
										<div class="col-md-6 col-sm-6">
											<div class="row">
												<div class="col-10 col-sm-10">
													<div class="input-group input-group-static">
														<label for="exampleFormControlSelect2" class="ms-0">Selected
															Columns</label> <select multiple="" id="selectedColumns"
															class="form-control pb-6 filter-select-backgr">
															<option value="employee_name" disabled>employee_name</option>
															<option value="task_name" disabled>task_name</option>
															<option value="task_status" disabled>task_status</option>
															<option value="task_priority" disabled>task_priority</option>
															<option value="task_priority_id" disabled
																style="display: none">task_priority_id</option>
															<option value="task_status_id" disabled
																style="display: none">task_status_id</option>
															<option value="task_status_type" disabled
																style="display: none">task_status_type</option>
															<option value="task_priority_type" disabled
																style="display: none">task_priority_type</option>
														</select>
													</div>
													<div class="mt-1">
														<button
															class="btn btn-icon btn-2 btn-dark filtr-col-selection-btn"
															onclick="moveAllToAvailableColumns();" type="button">Remove
															All</button>
													</div>
												</div>
												<div class="col-1 pe-1">
													<a href="#" onclick="moveOptionTop();"> <img
														width="17px" height="16px"
														src="assets/img/icons8-double-up-arrows-48.png"
														class="filtr-single-coln-top-botm mb-3" /></a> <a href="#"
														onclick="moveOptionup();"><i
														class="material-icons-round arrow-icons-fonts mb-3">north</i></a>
													<a href="#" onclick="moveOptiondown();"><i
														class="material-icons-round arrow-icons-fonts mb-3">south</i></a>
													<a href="#" onclick="moveOptionBottom();"> <img
														width="17px" height="16px"
														src="assets/img/icons8-double-up-arrows-48.png"
														class="rotate-down-arrow" /></a>

												</div>
											</div>
										</div>
									</div>
								</div>
							</form>



						</div>
						<div class="col-12 col-lg-6 ">
							<div class="content">
								<div class="row" style="display: flex;">
									<div class="col-sm-3">
										<label for="exampleFormControlSelect2" class="ms-0">Add
											Filter </label>
									</div>
									<div class="col-sm-9">
										<div class="input-group input-group-dynamic">
											<select class="form-control p-2" id="add_filter_select"
												onchange="addFilterSelect();">
												<option value="0">Select</option>

											</select>
										</div>
									</div>
								</div>

								<div class="row">
									<table id="filters-table" class='add-filters-table-scroll'></table>

								</div>


							</div>
						</div>
					</div>
					
				</div>
			</div>

		</div>



		<div class="container-fluid mt-2">
			<div class="row">
				<div class="col-sm-6">
					<div style="display: flex;">
						<button class="btn btn-icon btn-2 btn-dark"
							onclick="createJsonFilter();" type="button">Apply Filter</button>
						<button class="btn btn-icon btn-2 btn-dark ms-2"
							onclick="window.location.reload();" type="button">Clear
							Filter</button>
					</div>
				</div>
				<div class="col-sm-6">
					<div class="rightalign">
						<button class="btn btn-icon btn-2 btn-dark"
							onclick="ExportToPdf();" type="button">PDF</button>
						<button class="btn btn-icon btn-2 btn-dark ms-2"
							onclick="ExportToExcel();" type="button">EXCEL</button>
						<button class="btn btn-icon btn-2 btn-dark ms-2"
							onclick="ExportToCSV();" type="button">CSV</button>
					</div>
				</div>
			</div>
		</div>
		
	<input type="hidden" id="currentPageNumber" value="1" />
		<div class="card card-body p-2 pt-2" id="list-view">
			<div class="table-responsive">
				<table class="table table-flush text-sm" id="reporttasktableId">
					<thead class="thead-light">
						<tr id="reportTasksColumns">

						</tr>
					</thead>
					<tbody id="reportTasklistid">
					</tbody>
				</table>
				<a id="loadnextitemsid" href="#" onclick="loadnextitems()"> <strong>Load More...</strong></a>
			</div>
		</div>
	</main>





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
    var reportName = "Task Analysis";
    var dataExport = [];
    var columnExport = [];
    var pdfExpFilters = [];
    
	$(document).ready(function() {
		jQuery.ajax({
			type : "POST",
			url : "taskanalysisReport",
			data : {
				actionType : "fetchTaskAnalysisRptRecrds"
			},
			async : true,
			success :async function(responce) {
				taskanalysisRptData = responce;
				var availableColSelectTag = document.getElementById("availableColumns");
				var filterSelectTag = document.getElementById("add_filter_select")
				
				console.log("response list: ", responce)
				
				var rptColumnHeads = Object.keys(responce[0]);
				
				for (let colKey = 0; colKey < rptColumnHeads.length; colKey++) {
					const content = responce[0];
					const columnName = rptColumnHeads[colKey];
					const value = content[columnName];
					if (value !== null) {
						const myArray = value.split(":");
						console.log(myArray[1]);
						switch (myArray[1]) {
							case 'Y':
									var opt = document.createElement("option");
		                        	opt.value = rptColumnHeads[colKey];
		                        	opt.innerHTML = rptColumnHeads[colKey];
		                        	availableColSelectTag.append(opt);
		                        	filterSelectTag.append(opt);
							case 'O':
								if (rptColumnHeads[colKey] != 'followers' && rptColumnHeads[colKey] != 'task_priority_type' && rptColumnHeads[colKey]!= 'task_status_type' && rptColumnHeads[colKey] !== 'employee_name' && rptColumnHeads[colKey] !== 'task_name' && rptColumnHeads[colKey] !== 'task_status' && rptColumnHeads[colKey] !== 'task_status_id' && rptColumnHeads[colKey] !== 'task_priority' && rptColumnHeads[colKey] !== 'task_priority_id' ) {
									var opt = document.createElement("option");
		                        	opt.value = rptColumnHeads[colKey];
		                        	opt.innerHTML = rptColumnHeads[colKey];
		                        	availableColSelectTag.append(opt);
								}	
								break;
							default:
								break;
						}

					}

				}
				
				checkPageIsRenderFromEmpPerf();
				

			},
			error : function(error) {
				console.log("error ", error);
			}
		});
		
		createJsonFilter();
		
		
	})
	
	const checkPageIsRenderFromEmpPerf = async() =>{
		/* Filter data coming from employee performance page  */
		var filtrData = localStorage.getItem('filtrDataFromEmpPerfRpt');
		var filtrDataParse = JSON.parse(filtrData);
				
		for(let filtrInd = 0; filtrInd < filtrDataParse.filterName.length; filtrInd++){
			let filterName = filtrDataParse.filterName[filtrInd];
			let filterVal = filtrDataParse.filterVal[filtrInd];
			
			if(filterVal != '' && filterVal !='totTasks'){
				var selectFilterElement = document.getElementById('add_filter_select');
				var optionToSelectFilter = selectFilterElement.querySelector('option[value="' + filterName + '"]');
				
				var selectFilterElement = document.getElementById('add_filter_select');
				var optionToSelectFilter = selectFilterElement.querySelector('option[value="' + filterName + '"]');
				
				// Set the selected attribute of the option
				if (optionToSelectFilter) {
					optionToSelectFilter.selected = true;
					
				    await addFilterSelect();
				    
				    var selectEleAddedByFiltr = document.getElementById('values_'+filterName+'_id');
				    var optionEleAddedByFiltrValue = selectEleAddedByFiltr.querySelector('option[value="' + filterVal + '"]');
				    if(optionEleAddedByFiltrValue){
				    	optionEleAddedByFiltrValue.selected = true;
				    }
				    
				    
				}
			}
		}
		createJsonFilter();
		$('#filter').collapse('show');
		localStorage.removeItem('filtrDataFromEmpPerfRpt');
	}
	
	const addFilterSelect = async () => {
        var filterText = document.getElementById('add_filter_select');

        document.querySelectorAll("#add_filter_select option").forEach(opt => {
            if (opt.value === filterText.value) {
                opt.disabled = true;
            }
        });
        const filterTextValue = filterText.value;
        const value = taskanalysisRptData[0][filterTextValue];
        const myArray = value.split(":");

        switch (myArray[2]) {
            case 'C':
                var masterList = await fetchMasterData(myArray[3], contextPath);
                var trow = $("#filters-table").append($('<tr id="tr_' + filterText.value + '_id"></tr>').addClass("filter"));
                var label = $('<input type="checkbox"  id="cb_' + filterText.value + '_id" value=' + filterText.value + '  checked/> <label>&nbsp;' + filterText.value + '</label>').addClass("removeTr");
                var input1 = $('<div class="input-group input-group-dynamic"><select class="form-control ms-2 p-2"  id="operators_' + filterText.value + '_id"></select><div>')
                var input2 = $('<div class="input-group input-group-dynamic"><select class="form-control ms-2 p-2"  id="values_' + filterText.value + '_id"></select><div>')
                $('#filters-table tr:last').append($("<td>").addClass("field").append(label));
                $('#filters-table tr:last').append($("<td>").addClass("operator").append(input1));
                $('#filters-table tr:last').append($("<td>").addClass("values").append(input2));
                for (let operatorIndex = 0; operatorIndex < operatorByType.list.length; operatorIndex++) {
                    $('#operators_' + filterText.value + '_id').append("<option value='" + operatorByType.list[operatorIndex] + "'> " + operatorLabels[operatorByType.list[operatorIndex]] + "</option>");
                }
                $.each(masterList, function (key, value) {
                    $('#values_' + filterText.value + '_id').append("<option value='" + value.field_name + "'> " + value.field_name + "</option>");
                });
                break;

            case 'T':
                var trow = $("#filters-table").append($('<tr id="tr_' + filterText.value + '_id"></tr>').addClass("filter"));
                var label = $('<input type="checkbox" id="cb_' + filterText.value + '_id" value=' + filterText.value + ' checked/> <label>&nbsp;' + filterText.value + '</label>').addClass("erp-form-label removeTr");
                var input1 = $('<select class="ms-2 p-2"  id="operators_' + filterText.value + '_id"></select>')
                var input2 = $('<input type="text" class="ms-2"  id="values_' + filterText.value + '_id"></input>')
                $('#filters-table tr:last').append($("<td>").addClass("field").append(label));
                $('#filters-table tr:last').append($("<td>").addClass("operator").append(input1));
                $('#filters-table tr:last').append($("<td>").addClass("values").append(input2));

                for (let opByTpIndex = 0; opByTpIndex < operatorByType.string.length; opByTpIndex++) {
                    $('#operators_' + filterText.value + '_id').append("<option value='" + operatorByType.string[opByTpIndex] + "'> " + operatorLabels[operatorByType.string[opByTpIndex]] + "</option>");
                }
                break;

            case 'H':
                var trow = $("#filters-table").append($('<tr id="tr_' + filterText.value + '_id"></tr>').addClass("filter"));
                var label = $('<input type="checkbox" id="cb_' + filterText.value + '_id" value=' + filterText.value + ' checked/> <label class="erp-form-label">&nbsp;' + filterText.value + '</label>').addClass("removeTr");
                var input1 = $('<div class="input-group input-group-dynamic"><select class="form-control ms-2 p-2" id="operators_' + filterText.value + '_id"></select></div>')
                var input2 = $('<div class="input-group input-group-dynamic"><select class="form-control ms-2 p-2" id="values_' + filterText.value + '_id"></select></div>')
                $('#filters-table tr:last').append($("<td>").addClass("field").append(label));
                $('#filters-table tr:last').append($("<td>").addClass("operator").append(input1));
                $('#filters-table tr:last').append($("<td>").addClass("values").append(input2));

                for (let operatorIndex = 0; operatorIndex < operatorByType.list.length; operatorIndex++) {
                    $('#operators_' + filterText.value + '_id').append("<option value='" + operatorByType.list[operatorIndex] + "'> " + operatorLabels[operatorByType.list[operatorIndex]] + "</option>");
                }
                for (let opByTpIndex = 0; opByTpIndex < operatorByType.status.length; opByTpIndex++) {
                    $('#values_' + filterText.value + '_id').append("<option value='" + operatorByType.status[opByTpIndex] + "'> " + operatorLabels[operatorByType.status[opByTpIndex]] + "</option>");
                }
                break;
            case 'D':
                var trow = $("#filters-table").append($('<tr id="tr_' + filterText.value + '_id"></tr>').addClass("filter"));
                var label = $('<input type="checkbox" id="cb_' + filterText.value + '_id" value=' + filterText.value + ' checked/> <label class="erp-form-label">&nbsp;' + filterText.value + '</label>').addClass("removeTr");
                var input1 = $('<div class="input-group input-group-dynamic"><select class="form-control ms-2 p-2" id="operators_' + filterText.value + '_id"></select></div>')
                var input2 = $('<div class="input-group input-group-dynamic"><input type="date" class="form-control ms-2" id="values_' + filterText.value + '_id"/></div>')
                $('#filters-table tr:last').append($("<td>").addClass("field").append(label));
                $('#filters-table tr:last').append($("<td>").addClass("operator").append(input1));
                $('#filters-table tr:last').append($("<td>").addClass("values").append(input2));

                for (let operatorIndex = 0; operatorIndex < operatorByType.list.length; operatorIndex++) {
                    $('#operators_' + filterText.value + '_id').append("<option value='" + operatorByType.list[operatorIndex] + "'> " + operatorLabels[operatorByType.list[operatorIndex]] + "</option>");
                }
                for (let opByTpIndex = 0; opByTpIndex < operatorByType.status.length; opByTpIndex++) {
                    $('#values_' + filterText.value + '_id').append("<option value='" + operatorByType.status[opByTpIndex] + "'> " + operatorLabels[operatorByType.status[opByTpIndex]] + "</option>");
                }
                break; 
                

        }

        $('.removeTr').click(function () {
            var trIdVal = $(this).val();
            document.querySelectorAll("#add_filter_select option").forEach(opt => {
                if (opt.value === trIdVal) {
                    opt.disabled = false;
                }
            });
            $('table#filters-table tr#tr_' + trIdVal + '_id').remove();
            var filtrSelectedVal = $("#add_filter_select option:selected").val();
            if (filtrSelectedVal === trIdVal) {
                $("#add_filter_select").val('0');
            }
        })

    }
	
    var pageNo = $('#currentPageNumber').val();

    function loadnextitems(){
    	if ($('#currentPageNumber').val() != '') {
			var currentPageNumber = parseInt($('#currentPageNumber').val()) + 1;
			pageNo = currentPageNumber;
			$('#currentPageNumber').val(pageNo);

    	createJsonFilter();
    	}
    }
    
    const createJsonFilter = async () => {
        var selectBox = document.getElementById("selectedColumns");
//         var group_by = document.getElementById("group_by").value;
        var jsonQuery = { 'params':{} , 'selectQuery': {}, 'whereQuery': {}};
        storeSelectedValues = []
        if (selectBox.length > 8) {
            for (let selBoxInd = 0; selBoxInd < selectBox.length; selBoxInd++) {
                let optionValue = selectBox.options[selBoxInd].value;
                jsonQuery['selectQuery'][optionValue] = optionValue;
                storeSelectedValues.push(optionValue)
            }
        }
//         jsonQuery['group_by']["GROUP BY"] = group_by;
        jsonQuery['params']['viewName'] = 'pms_project_task_info_view';
        jsonQuery['params']['ORDER BY'] = " employee_name ASC, task_id DESC";
        jsonQuery['params']['is_deleted'] = 0;
      
        var table = document.getElementById("filters-table");
        var tr = table.getElementsByTagName("tr");

        for (let j = 0; j < tr.length; j++) {
            var tdLabel = tr[j].getElementsByTagName("td")[0];
            var tdOperator = tr[j].getElementsByTagName("td")[1];
            var tdValues = tr[j].getElementsByTagName("td")[2];
            var field = tdLabel.getElementsByTagName("label")[0];
            var operator = tdOperator.getElementsByTagName("select")[0];
            var values;
            var valueSelectValue;
            if(tdValues.getElementsByTagName("select").length !=0){
            	values = tdValues.getElementsByTagName("select")[0];
            	valueSelectValue = values.options[values.selectedIndex].value;
            }else{
            	values = tdValues.getElementsByTagName("input")[0];
            	valueSelectValue = values.value;
            	
            }

            var fieldvalue = field.textContent.trim()
            var operatorSelectValue = operator.options[operator.selectedIndex].value;
            if(valueSelectValue != ""){
                jsonQuery['whereQuery'][fieldvalue + " "+ operatorSelectValue] = valueSelectValue;
			}
            
            pdfExpFilters[fieldvalue] = valueSelectValue;
		}
        if(jsonQuery.whereQuery['task_due_date ='] == undefined && jsonQuery.whereQuery['task_start_date ='] == undefined){
	        const reportsByDateResp = reportsByDate(); 
	        
	        var from_date = reportsByDateResp[0].task_start_date;
	        var to_date = reportsByDateResp[0].task_due_date;
	        
	        if(to_date != ""){
	        	jsonQuery['whereQuery']['task_start_date BETWEEN "'+from_date+'" AND "'+to_date+'"'] = "";
	        }else{
	        	jsonQuery['whereQuery']["task_start_date = "] = from_date;
	        }
        }
        var executeQuery = JSON.stringify(jsonQuery)
        var startIndex = 0;
        var endIndex = 10;
        debugger;
        const responce = await fetchFilteredData(executeQuery, startIndex, endIndex, pageNo);
        if(responce.data.length != 0){
        	dataExport = [];
        	dataExport = responce.data;
        	const columns = createColumnHeads(responce.columns);
        	createTHeadsListView(columns);
        	createTRowContent(responce.data, columns);
        }else{
        	dataExport = [];
        	columnExport = [];
        	$("#reportTasksColumns").empty();
        	$('#reportTasklistid').empty();
        }
        console.log("responce: ", responce);
    }
    
   
    
    
    function createColumnHeads(newColumnHeads){
   	 	  const columns = [];
	   	  for (let colKey = 0; colKey < newColumnHeads.length; colKey++) {
	    	 if (newColumnHeads[colKey] != 'task_due_date' && !newColumnHeads[colKey].includes('followers') && !newColumnHeads[colKey].includes('_type') && !newColumnHeads[colKey].includes('_id') && !newColumnHeads[colKey].includes('is_') && !newColumnHeads[colKey].includes('_on') && !newColumnHeads[colKey].includes('_by') && !newColumnHeads[colKey].includes('field_name')) {
	    		 columns.push(newColumnHeads[colKey]);
	         }
	   	  }
	   	  return columns;
    }
    
    function createTHeadsListView(columns){
    	$("#reportTasksColumns").empty();
    	columnExport = [];
    	var thContent;
    	if(storeSelectedValues.length != 0){
	   		for (let selValCount = 0; selValCount < storeSelectedValues.length; selValCount++) {
	   	           for (let colKey = 0; colKey < columns.length; colKey++) {
	   	                if (storeSelectedValues[selValCount] === columns[colKey] ) {
	   	                	  columnExport.push(columns[colKey]);
	   	                	  thContent += '<th>'+columns[colKey]+'</th>';
	   	                }
	   	            }
	   	        }
    	}else{
    		 for (let colKey = 0; colKey < columns.length; colKey++) {
    			 columnExport.push(columns[colKey]);
    			 thContent += '<th>'+columns[colKey]+'</th>';
    		 }
    	}
    	
		$("#reportTasksColumns").append(thContent);
    }
    
    function createTRowContent(data, columns){
//     	$('#reportTasklistid').empty();
						if (data.length % 2 == 0) {
							$('#loadnextitemsid').prop('hidden', true);
							$('#loadnextitemsid').prop('hidden', true);
						}
						if (data.length < 10) {
							$('#loadnextitemsid').prop('hidden', true);
							$('#loadnextitemsid').prop('hidden', true);
							
						}else {
							$('#loadnextitemsid').prop('hidden', false);
							$('#loadnextitemsid').prop('hidden', false);
						}
    	for (let dataIndex = 0; dataIndex < data.length; dataIndex++) {
    		var rowData = "<tr>";
    		var obj = data[dataIndex];
    		if(storeSelectedValues.length != 0){
    			for (let selValCount = 0; selValCount < storeSelectedValues.length; selValCount++) {
    				const column = storeSelectedValues[selValCount];
    			    if(!column.includes('_type') && !column.includes('_id') && !column.includes('followers')){
	    				switch(column){
		    				case 'task_status':
		    							rowData += '<td>'+createStatusElement(obj['task_status_id'], obj['task_status'],
		       							obj['task_status_type'])+'</td>';
		       							break;
		    				case 'task_priority':
										rowData += '<td>'+createPriorityElement(obj['task_priority_id'], obj['task_priority'],
												obj['task_priority_type'])+'</td>';
		   								break;
		    				case 'task_completion_value':
		        						rowData += '<td>'+createProgressBarElement(obj['task_completion_value'])+'</td>';
										break;			
		    				default:	
		    					rowData += '<td class='+column+'>'+obj[column]+'</td>';
		    					break;
						}
    				
    			    }	
    			}
    		}else{
        		for (let colKey = 0; colKey < columns.length; colKey++) {
        			const column = columns[colKey];
        			switch(column){
        				case 'task_status':
        							rowData += '<td>'+createStatusElement(obj['task_status_id'], obj['task_status'],
	       							obj['task_status_type'])+'</td>';
	       							break;
        				case 'task_priority':
    								rowData += '<td>'+createPriorityElement(obj['task_priority_id'], obj['task_priority'],
    										obj['task_priority_type'])+'</td>';
       								break;
        				case 'task_completion_value':
		        					rowData += '<td>'+createProgressBarElement(obj['task_completion_value'])+'</td>';
									break;
        				default:	
        					rowData += '<td class='+column+'>'+obj[column]+'</td>';
        					break;
					}
        			
        		}
    		}
    		
    		rowData += '</tr>'
    		$('#reportTasklistid').append(rowData);
    		
    	}
    	$('.task_name').css('white-space', 'unset');
    	$('.task_description').css('white-space', 'unset');
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
    	 if (dataExport.length !== 0) {
             var jsonToExportExcel = { 'allData': {}, 'columns': {}, 'filtrKeyValue': {}, 'headings': {}, 'key': 'reportExport' }

              var filtrObjKeys = Object.keys(pdfExpFilters);
              for (let objKey = 0; objKey < filtrObjKeys.length; objKey++) {
                  var key = filtrObjKeys[objKey];
                  var value = pdfExpFilters[filtrObjKeys[objKey]];
                  jsonToExportExcel['filtrKeyValue'][objKey] = key + ' : ' + value
              }
             for (let col = 0; col < columnExport.length; col++) {
                 jsonToExportExcel['columns'][col] = columnExport[col]
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
	
	
	 function addSelectedColumns() {
        var availColn = document.getElementById("availableColumns");
        if (availColn.value !== '') {
            var selecColn = document.getElementById("selectedColumns");
            var option = document.createElement("option");
            option.text = availColn.value;
            option.value = availColn.value;
            selecColn.add(option);
            availColn.remove(availColn.selectedIndex);
        }
    }
	
	function addAvailableColumns() {
        var selecColn = document.getElementById("selectedColumns");
        if (selecColn.value !== '') {
            var availColn = document.getElementById("availableColumns");
            var option = document.createElement("option");
            option.text = selecColn.value;
            option.value = selecColn.value;
            availColn.add(option);
            selecColn.remove(selecColn.selectedIndex);
        }
    }

    function moveAllToSelectedColumns() {
        var availColn = document.getElementById("availableColumns");
        var selecColn = document.getElementById("selectedColumns");
        $("#availableColumns option").each(function () {
            var option = document.createElement("option");
            option.text = $(this).val();
            option.value = $(this).val();
            selecColn.add(option)
            availColn.remove(option)

        });

    }

    function moveAllToAvailableColumns() {
        var availColn = document.getElementById("availableColumns");
        var selecColn = document.getElementById("selectedColumns");
        $("#selectedColumns option").each(function () {
            const value = $(this).val();
            if (value!= 'task_status_type' && value !== 'employee_name' && value !== 'task_name' && value !== 'task_status' && value !== 'task_status_id' && value !== 'task_priority' && value !== 'task_priority_id' && value != 'task_priority_type' ) {
                var option = document.createElement("option");
                option.text = value;
                option.value = value;
                availColn.add(option)
                $('#selectedColumns option[value=' + value + ']').remove();
            }

        });

    }

    function moveOptionup() {
        var opt = $('#selectedColumns option:selected');
        if (opt.is(':first-child')) {
            opt.insertAfter($('#selectedColumns option:last-child'));
        }
        else {
            opt.insertBefore(opt.prev());
        }
    };

    function moveOptiondown() {
        var opt = $('#selectedColumns option:selected');
        if (opt.is(':last-child')) {
            opt.insertBefore($('#selectedColumns option:first-child'));
        }
        else {
            opt.insertAfter(opt.next());
        }
    };

    function moveOptionTop() {
        var opt = $('#selectedColumns option:selected');
        opt.insertBefore($('#selectedColumns option:first-child'));
    }
    function moveOptionBottom() {
        var opt = $('#selectedColumns option:selected');
        opt.insertAfter($('#selectedColumns option:last-child'));
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

