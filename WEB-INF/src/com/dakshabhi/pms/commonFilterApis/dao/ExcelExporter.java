package com.dakshabhi.pms.commonFilterApis.dao;

import java.io.IOException;
import java.io.OutputStream;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.json.JSONObject;

public class ExcelExporter {
	private XSSFWorkbook workbook;
	private XSSFSheet sheet;
	private JSONObject jsonData;
	int rowCount = 4;

	public ExcelExporter(JSONObject exportJson) {
		this.jsonData = exportJson;
		workbook = new XSSFWorkbook();
	}

	private void writeHeaderLine() {
		int columnCount = 0;
		sheet = workbook.createSheet("users");
		Row row = null;

		CellStyle styleForFilterElements = workbook.createCellStyle();
		XSSFFont fontForFilterElements = workbook.createFont();
		fontForFilterElements.setBold(true);
		fontForFilterElements.setFontHeight(12);
		styleForFilterElements.setFont(fontForFilterElements);

		JSONObject filtrKeyVals = (JSONObject) jsonData.get("filtrKeyValue");
		rowCount++;

//		Excel Filter values
		if (!filtrKeyVals.keySet().isEmpty()) {
			int count = 0;
			for (int filterKeyIndex = 0; filterKeyIndex < filtrKeyVals.length(); filterKeyIndex++) {
				if (count == 0) {
					row = sheet.createRow(rowCount);
					sheet.addMergedRegion(new CellRangeAddress(rowCount, // first row (0-based)
							rowCount, // last row (0-based)
							count, // first column (0-based)
							2 // last column (0-based)
					));
				} else {
					row = sheet.getRow(rowCount);
					sheet.addMergedRegion(new CellRangeAddress(rowCount, // first row (0-based)
							rowCount, // last row (0-based)
							count, // first column (0-based)
							count + 2 // last column (0-based)
					));
				}
				Object excelDataValue = filtrKeyVals.getString(Integer.toString(filterKeyIndex));
				createCell(row, count, excelDataValue, styleForFilterElements);
				if (rowCount == 8) {
					rowCount = 5;
					count += 2;
				} else {
					rowCount++;
				}

			}
			rowCount = 9;
			rowCount++;
		}

//		Excel Column Heads

		CellStyle style = workbook.createCellStyle();
		XSSFFont font = workbook.createFont();
		font.setBold(true);
		font.setFontHeight(12);

		style.setFont(font);
		style.setBorderTop(BorderStyle.THIN);
		style.setBorderBottom(BorderStyle.THIN);
		style.setBorderLeft(BorderStyle.THIN);
		style.setBorderRight(BorderStyle.THIN);

		JSONObject columnNames = (JSONObject) jsonData.get("columns");

		row = sheet.createRow(rowCount++);
		for (int colKeyIndex = 0; colKeyIndex < columnNames.length(); colKeyIndex++) {
			createCell(row, columnCount, columnNames.getString(Integer.toString(colKeyIndex)), style);
			columnCount++;
		}

	}

	private void writeDataLines() {
		int columnCount = 0;
		Row row = null;
		CellStyle style = workbook.createCellStyle();
		XSSFFont font = workbook.createFont();

		font.setFontHeight(11);
		style.setFont(font);

		style.setBorderTop(BorderStyle.THIN);
		style.setBorderBottom(BorderStyle.THIN);
		style.setBorderLeft(BorderStyle.THIN);
		style.setBorderRight(BorderStyle.THIN);

		JSONObject columnNames = (JSONObject) jsonData.get("columns");
		JSONObject columnValues = (JSONObject) jsonData.get("allData");

		for (int jsonAllDataKeys = 0; jsonAllDataKeys < columnValues.length(); jsonAllDataKeys++) {
			row = sheet.createRow(rowCount++);
			columnCount = 0;
			JSONObject data = (JSONObject) columnValues.get(Integer.toString(jsonAllDataKeys));
			for (int colKeyIndex = 0; colKeyIndex < columnNames.length(); colKeyIndex++) {
				Object excelDataValue = data.get(columnNames.getString(Integer.toString(colKeyIndex)));
				if (excelDataValue.equals(null)) {
					excelDataValue = "";
				}
				createCell(row, columnCount++, excelDataValue, style);
			}

		}
//		Create Excel Header 
		CellStyle styleHeading = workbook.createCellStyle();
		XSSFFont fontHeading = workbook.createFont();

		fontHeading.setFontHeight(16);
		styleHeading.setFont(fontHeading);
		fontHeading.setBold(true);
		styleHeading.setAlignment(HorizontalAlignment.CENTER);
		row = sheet.createRow(0);

		JSONObject headingJson = (JSONObject) jsonData.get("headings");

		Object company = headingJson.get("CompanyName");
		sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, columnCount));
		createCell(row, 0, company, styleHeading);

		//Style for address

		CellStyle styleAddr = workbook.createCellStyle();
		XSSFFont fontAddr = workbook.createFont();

		fontAddr.setFontHeight(13);
		styleAddr.setFont(fontAddr);
		styleAddr.setAlignment(HorizontalAlignment.CENTER);

		row = sheet.createRow(1);
		Object address = headingJson.get("CompanyAddress");
		sheet.addMergedRegion(new CellRangeAddress(1, 1, 0, columnCount));
		createCell(row, 0, address, styleAddr);
		
		row = sheet.createRow(2);
		sheet.addMergedRegion(new CellRangeAddress(2, 2, 0, columnCount));
		
		//Style for Report Name
		CellStyle styleReport = workbook.createCellStyle();
		XSSFFont fontReport = workbook.createFont();

		fontReport.setFontHeight(13);
		styleReport.setFont(fontReport);
		fontReport.setBold(true);
		styleReport.setAlignment(HorizontalAlignment.CENTER);

		row = sheet.createRow(3);
		Object reportName = headingJson.get("ReportName");
		sheet.addMergedRegion(new CellRangeAddress(3, 3, 0, columnCount));
		createCell(row, 0, reportName, styleReport);
		
	}

	private void createCell(Row row, int columnCount, Object value, CellStyle style) {
		sheet.autoSizeColumn(columnCount);
		Cell cell = row.createCell(columnCount);
		if (value instanceof Integer) {
			cell.setCellValue((Integer) value);
		} else if (value instanceof Boolean) {
			cell.setCellValue((Boolean) value);
		} else if (value instanceof Number) {
			cell.setCellValue(((Number) value).doubleValue());
		} else {
			cell.setCellValue((String) value);
		}
		cell.setCellStyle(style);
	}

	public void export(HttpServletResponse resp) throws IOException {
		writeHeaderLine();
		writeDataLines();

		String checkExportKey = jsonData.getString("key");

		if (checkExportKey.equals("bomExport")) {
			for (int rowIndex = 11; rowIndex < rowCount; rowIndex++) {
				Row row = sheet.getRow(rowIndex); // Replace rowNumber with the row number (0-based index)
				Cell cell = row.getCell(4); // Replace columnNumber with the column number (0-based index)

				CellStyle cellStyle = workbook.createCellStyle();
				cellStyle.cloneStyleFrom(cell.getCellStyle());

				cellStyle.setLocked(false);
				cellStyle.setFillForegroundColor(IndexedColors.LIGHT_GREEN.getIndex());
				cellStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND); // Set the fill pattern

				cell.setCellStyle(cellStyle);
			}

		}
//		Sheet Locked 
		sheet.protectSheet("");
		// Freeze the header row
        sheet.createFreezePane(0, 6);
	

        OutputStream outputStream = resp.getOutputStream();
		workbook.write(outputStream);
		workbook.close();

		outputStream.close();

	}
}
