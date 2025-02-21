package com.dakshabhi.pms.api.dtos;

import java.util.ArrayList;

public class APIResponseDTO {
	int response;
	String reposneText;
	Object responseData;
	ArrayList<?> responseList;
	String responseType;

	public String getResponseType() {
		return responseType;
	}

	public void setResponseType(String responseType) {
		this.responseType = responseType;
	}

	public int getResponse() {
		return response;
	}

	public void setResponse(int response) {
		this.response = response;
	}

	public String getReposneText() {
		return reposneText;
	}

	public void setReposneText(String reposneText) {
		this.reposneText = reposneText;
	}

	public Object getResponseData() {
		return responseData;
	}

	public void setResponseData(Object responseData) {
		this.responseData = responseData;
	}

	public ArrayList<?> getResponseList() {
		return responseList;
	}

	public void setResponseList(ArrayList<?> responseList) {
		this.responseList = responseList;
	}

}
