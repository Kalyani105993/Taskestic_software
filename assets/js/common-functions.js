
// globalQueryObject.js
var globalQuery = {
  operation: "select",
  columns: [],
  table: "",
  conditions: [],
  joins: []
};

function resetGlobalQuery() {
  globalQuery = {
    operation: "select",
    columns: [],
    table: "",
    conditions: [],
    joins: []
  };
}

function globalQueryFunc(gbJsonQuery, contextPath) {
	return new Promise((resolve, reject) => {	
		
		  var xhr = new XMLHttpRequest();
		  xhr.open("POST", contextPath+"/commonfilterAPI?actionType=globalJsonQueryExecution", true);
		  xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
		
		  xhr.onreadystatechange = function () {
		    if (xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200) {
		      resolve(xhr.responseText);
		      return xhr.response;
		    }
		  };
		
		  xhr.send(JSON.stringify(gbJsonQuery));
	});	  
	  
}


/* Method: Ajax call to fecth field_id & field_name for fill add filter combos in report
 * Input: master(database Table or view name), contextPath
 * Output: primary key & primary name from view
 */
async function fetchMasterData(master, contextPath){
	return jQuery.ajax({
			type : "POST",
			url : contextPath + "/commonfilterAPI",
			data : {
				actionType : "fetchMasterData",
				master : master
			},
			async : true,
			success : await function(responce) {
				return responce;
			},
			error : function(error) {
				console.log("error ", error);
			}
		});
	
	
}

async function fetchFilteredData(executeQuery, startIndex, endIndex, pageNo){
      return jQuery.ajax({
			type : "POST",
			url : contextPath + "/commonfilterAPI?actionType=fetchFilteredData",
			data: {
				jsonQuery:executeQuery,
				startIndex : startIndex,
				endIndex : endIndex,
				pageNo: pageNo
			},
			async : true,
			success : await function(responce) {
				return responce;
			},
			error : function(error) {
				console.log("error ", error);
			}
		});
	
}



//Sample JSON
//{
//  "operation": "select",
//  "columns": ["column1", "column2"],
//  "table": "tablename",
//  "conditions": [
//    {
//      "field": "column1",
//      "operator": "=",
//      "value": "some_value"
//    },
//    {
//      "field": "column2",
//      "operator": ">",
//      "value": 100
//    }
//  ],
//  "joins": [
//    {
//      "table": "another_table",
//      "type": "inner",
//      "on": {
//        "left": "tablename.column_id",
//        "right": "another_table.id"
//      }
//    }
//  ]
//}

//How to Append values to the global JSON

//  globalQuery.columns.push("column1");
//  globalQuery.columns.push("column2");
//  
//  globalQuery.conditions.push({
//    field: "column1",
//    operator: "=",
//    value: "some_value"
//  });
//  globalQuery.conditions.push({
//    field: "column1",
//    operator: "=",
//    value: "some_value"
//  });
//
//  globalQuery.joins.push({
//    table: "another_table",
//    type: "inner",
//    on: {
//      left: "tablename.column_id",
//      right: "another_table.id"
//    }
//  });



