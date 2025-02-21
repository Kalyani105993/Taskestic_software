package com.dakshabhi.common.utility;

public class PagingBean {

	private boolean hasPreviousPage;

	private boolean hasNextPage;

	private int previousPage;

	private int nextPage;

	private int totalPages;

	private String nextPageURL;

	private String previousPageURL;

	private String firstPageURL;

	private String lastPageURL;

	private int firstPage;

	private int lastPage;

	private boolean hasFirstPage;

	private boolean hasLastPage;

	public boolean isHasNextPage() {
		return hasNextPage;
	}

	public void setHasNextPage(boolean hasNextPage) {
		this.hasNextPage = hasNextPage;
	}

	public boolean isHasPreviousPage() {
		return hasPreviousPage;
	}

	public void setHasPreviousPage(boolean hasPreviousPage) {
		this.hasPreviousPage = hasPreviousPage;
	}

	public int getNextPage() {
		return nextPage;
	}

	public void setNextPage(int nextPage) {
		this.nextPage = nextPage;
	}

	public int getPreviousPage() {
		return previousPage;
	}

	public void setPreviousPage(int previousPage) {
		this.previousPage = previousPage;
	}

	public int getTotalPages() {
		return totalPages;
	}

	public void setTotalPages(int totalPages) {
		this.totalPages = totalPages;
	}

	public String getNextPageURL() {
		return nextPageURL;
	}

	public void setNextPageURL(String nextPageURL) {
		this.nextPageURL = nextPageURL;
	}

	public String getPreviousPageURL() {
		return previousPageURL;
	}

	public void setPreviousPageURL(String previousPageURL) {
		this.previousPageURL = previousPageURL;
	}

	public String getFirstPageURL() {
		return firstPageURL;
	}

	public void setFirstPageURL(String firstPageURL) {
		this.firstPageURL = firstPageURL;
	}

	public String getLastPageURL() {
		return lastPageURL;
	}

	public void setLastPageURL(String lastPageURL) {
		this.lastPageURL = lastPageURL;
	}

	public int getFirstPage() {
		return firstPage;
	}

	public void setFirstPage(int firstPage) {
		this.firstPage = firstPage;
	}

	public int getLastPage() {
		return lastPage;
	}

	public void setLastPage(int lastPage) {
		this.lastPage = lastPage;
	}

	public boolean isHasFirstPage() {
		return hasFirstPage;
	}

	public void setHasFirstPage(boolean hasFirstPage) {
		this.hasFirstPage = hasFirstPage;
	}

	public boolean isHasLastPage() {
		return hasLastPage;
	}

	public void setHasLastPage(boolean hasLastPage) {
		this.hasLastPage = hasLastPage;
	}

}
