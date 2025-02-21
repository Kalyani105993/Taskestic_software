package com.dakshabhi.common.utility;

import java.util.ArrayList;
import java.util.Collection;

public class PagingBean1 {
	
	public PagingBean1(){
		
	}
	
	public PagingBean1(int startPage){
		this.startPage = startPage;	
	}
	
	public PagingBean1(int startPage, int pageSize){
		this.startPage = startPage;
		this.pageSize = pageSize;
	}
	
	private Collection<String> collPages = new ArrayList<String>(0);

	private String strStartOfSet = null;
	
	private String strStopOfSet = null;
	
	private String currentRecordRange;

	private int viewperpage = 20;

	private int count;

	private int startPage;
	
	private int pageSize = 20;
	
	private int startRec;

	private int pages=0;

	public Collection<String> getCollPages() {
		return collPages;
	}

	public void setCollPages(Collection<String> collPages) {
		this.collPages = collPages;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
		
		//calculate pages		
		if (this.pageSize > 0) {
			this.pages = this.count / this.pageSize ;
			if ((this.pages * this.pageSize ) < this.count)
				this.pages = this.pages + 1;
				
			if (this.startPage > 0)
				this.startRec = (this.startPage - 1) * this.pageSize ;					
			else
				this.startRec = this.startPage * this.pageSize ;
		}
		this.calcPage(this);
	}
	
	private void calcPage(PagingBean1 pagingBean) {
		int nPages = pagingBean.getPages();
		int nStartPage = 0;
		int nStartOfSet = 0, nStopOfSet = 0;
		
		int nLinksPerPage = pagingBean.getViewperpage();
		
		nStartPage = pagingBean.getStartPage();

		if (nStartPage > nLinksPerPage) {
			nStartOfSet = nStartPage / nLinksPerPage;
			if (nStartPage % nLinksPerPage == 0)
				nStartOfSet--;

			nStartOfSet = (nStartOfSet * nLinksPerPage) + 1;
			pagingBean.setStrStartOfSet(String.valueOf(nStartOfSet - 1));
		} else
			nStartOfSet = 1;

		if ((nPages - nStartPage) > nLinksPerPage) {
			if (nStartPage >= 0) {
				nStopOfSet = nStartOfSet + nLinksPerPage;
				if (nStopOfSet > nPages)
					nStopOfSet = nPages;

				pagingBean.setStrStopOfSet(String.valueOf(nStopOfSet));
			} else {
				nStopOfSet = nLinksPerPage + 1;
				pagingBean.setStrStopOfSet(String.valueOf(nStopOfSet));
			}
		} else if ((nPages - nStartPage) == nLinksPerPage) {
			if (nStartPage >= 0) {
				nStopOfSet = nStartOfSet + nLinksPerPage;
				if (nStopOfSet > nPages)
					nStopOfSet = nPages;

				pagingBean.setStrStopOfSet(String.valueOf(nStopOfSet));
			} else {
				nStopOfSet = nLinksPerPage + 1;
				pagingBean.setStrStopOfSet(String.valueOf(nStopOfSet));
			}

		} else {
			if((nPages - nStartOfSet)>nLinksPerPage){
				nStopOfSet = nPages - ((nPages-nStartOfSet)-nLinksPerPage);
				pagingBean.setStrStopOfSet(String.valueOf(nStopOfSet));
			}else{
				nStopOfSet = nPages + 1;
				pagingBean.setStrStopOfSet(null);
			}
		}
		Collection<String> collPages = new ArrayList<String>(nPages);		
		for (int i = nStartOfSet; i < nStopOfSet; i++) {
			collPages.add(String.valueOf(i));
		}
		
		pagingBean.setCurrentRecordRange(""+(this.startRec+1)+" - " + (this.startRec + this.viewperpage));
		if(this.startPage == nPages){
			pagingBean.setCurrentRecordRange(""+(this.startRec+1)+" - " + (this.startRec + this.viewperpage + (this.count- (this.startPage * this.viewperpage))));
		}
		pagingBean.setCollPages(collPages);
	}
	
	public int getPages() {
		return pages;
	}

	public void setPages(int pages) {
		this.pages = pages;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getStartRec() {
		return startRec;
	}

	public void setStartRec(int startRec) {
		this.startRec = startRec;
	}

	public String getStrStartOfSet() {
		return strStartOfSet;
	}

	public void setStrStartOfSet(String strStartOfSet) {
		this.strStartOfSet = strStartOfSet;
	}

	public String getStrStopOfSet() {
		return strStopOfSet;
	}

	public void setStrStopOfSet(String strStopOfSet) {
		this.strStopOfSet = strStopOfSet;
	}

	public int getViewperpage() {
		return viewperpage;
	}

	public void setViewperpage(int viewperpage) {
		this.viewperpage = viewperpage;
	}

	public String getCurrentRecordRange() {
		return currentRecordRange;
	}

	public void setCurrentRecordRange(String currentRecordRange) {
		this.currentRecordRange = currentRecordRange;
	}		
}
