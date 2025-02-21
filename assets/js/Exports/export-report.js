var jsPdfScript = document.createElement('script');  
jsPdfScript.setAttribute('src','https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.5.3/jspdf.min.js');
document.head.appendChild(jsPdfScript);

var jsPdfAutoTableScript = document.createElement('script');  
jsPdfAutoTableScript.setAttribute('src','https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.6/jspdf.plugin.autotable.min.js');
document.head.appendChild(jsPdfAutoTableScript);


/* Method: Export report in csv
 * Input: Responce data & report name(File name)
 * Output: Dowloaded file in csv format
 */
function csv(dataExport, reportName) {
    var columnExport = [];
    for (let keys in dataExport[0]) { columnExport.push(keys) };

    let csvHeader = columnExport.join(',') + '\n'; // header row
    let csvBody = dataExport.map(row => Object.values(row).join(',')).join('\n');

    var hiddenElement = document.createElement('a');
    hiddenElement.href = 'data:text/csv;charset=utf-8,' + encodeURI(csvHeader + csvBody);
    hiddenElement.target = '_blank';
    hiddenElement.download = reportName + '.csv';
    hiddenElement.click();


}

/* Method: Export report in excel
 * Input:  data, column keys in json format & report name(File name)
 * Output: Dowloaded file in excel format
 */
async function excel(jsonToExportExcel,reportName) {

        var xhr = new XMLHttpRequest();
        xhr.open("POST", contextPath + "/excel?actionType=FnExportToExcel", true);
        xhr.responseType = "blob"; 
        xhr.onload = function() {
            if (xhr.status === 200) {
                var blob = new Blob([xhr.response], { type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" });
                var url = URL.createObjectURL(blob);
                var a = document.createElement("a");
                a.href = url;
                a.download = reportName +".xlsx";
                a.click();
                URL.revokeObjectURL(url);
            }
        };
        xhr.send(JSON.stringify(jsonToExportExcel));
            


}

/* Method: Export report in pdf
 * Input:  data, column keys, report name(File name), pdfExpFilters(means the filters you added for data display)
 * Output: Dowloaded file in pdf format
 */
function pdf(dataToExport, columnsToExport, reportName, pdfExpFilters) {
            var dataValues = [];
            var appliedFilters = [];
            var title = reportName;
            var companyName = "Dakshabhi It Solutions"
//            var companyAddress = sessionStorage.getItem('companyAddress')

            const unit = "pt";
            const size = "A4";
            const orientation = "landscape";
            var	doc = new jsPDF(orientation, unit, size);
            const header = [columnsToExport];

            for (let i = 0; i < dataToExport.length; i++) {
                var crArray = new Array();
                for (let j = 0; j < columnsToExport.length; j++) {
                    var col = columnsToExport[j];
                    crArray.push(dataToExport[i][col]);
                }
                dataValues.push(crArray)
            }

            console.log("checking dataValues: ", dataValues)
            console.log("checking header: ", header)

            let content = {
                head: header,
                body: dataValues,
                columnWidth: 'wrap',
                tableLineColor: [189, 195, 199],
                tableLineWidth: 1,
                bodyStyles: { lineColor: [189, 195, 199] },
                styles: { fontSize: 8, font: 'helvetica' },
                headStyles: {
                    fillColor: [255, 255, 255],
                    textColor: [0, 0, 0],
                    fontSize: 8,
                    padding: 0,
                },

            };

            var filtrObjKeys = Object.keys(pdfExpFilters);
            if (filtrObjKeys.length !== 0) {
                for (let objKey = 0; objKey < filtrObjKeys.length; objKey++) {
                    var key = filtrObjKeys[objKey];
                    var value = pdfExpFilters[filtrObjKeys[objKey]];
                    appliedFilters.push(key + " : " + value)
                }
                content['startY'] = 130 + filtrObjKeys.length * 20;
                console.log("startY", content)
            } else {
                content['startY'] = 130
            }

            var text = companyName,
                xOffset = (doc.internal.pageSize.width / 2) - (doc.getStringUnitWidth(text) * doc.internal.getFontSize() / 2);
            doc.text(text, xOffset, 50);
            doc.setFontSize(16);

            doc.text(reportName, xOffset + 40 , 90)

            doc.text(appliedFilters, 50, 100);
            doc.autoTable(content);
            doc.save(reportName + '.pdf')

        }
    
