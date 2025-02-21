package com.dakshabhi.common.utility;

import org.apache.commons.lang.StringUtils;



public class QueryPager {

	private int limit;

	private int offset;

	private int foundRows;
	
	private String baseURL;

	public int getLimit() {
		return limit;
	}

	public void setLimit(int limit) {
		this.limit = limit;
	}

	public int getOffset() {
		return offset;
	}

	public void setOffset(int offset) {
		this.offset = offset;
	}

	public void setPageingBean( PagingBean pageBean ) {
		
		if (foundRows > 0) {
			
			/*boolean isFirst = foundRows > offset;			
			if(isFirst){*/
			pageBean.setFirstPage(0);
			int mod = foundRows % offset;
			if( mod == 0){
				mod = offset;
			}
			pageBean.setLastPage(foundRows - mod);
			//}
				
			boolean isPrevious = limit >= offset;
			pageBean.setHasPreviousPage(isPrevious);
			pageBean.setHasFirstPage(isPrevious);
			if (pageBean.isHasPreviousPage()) {
				int previous = limit - offset;
				if (previous >= 0) {
					pageBean.setPreviousPage(previous);
				}
			}
			int next = limit + offset;
			boolean isNext = next < foundRows;
			pageBean.setHasNextPage(isNext);
			pageBean.setHasLastPage(isNext);
			if (pageBean.isHasNextPage()) {				
				if (isNext) {
					pageBean.setNextPage(next);
				}
			}
			pageBean.setTotalPages( foundRows );
			
			if( !StringUtils.isEmpty( baseURL ) ){
				pageBean.setPreviousPageURL( baseURL + "?limit=" + pageBean.getPreviousPage() + "&offset=" + offset );
				pageBean.setNextPageURL( baseURL + "?limit=" + pageBean.getNextPage() + "&offset=" + offset );
				pageBean.setFirstPageURL( baseURL + "?limit=" + pageBean.getFirstPage() + "&offset=" + offset );
				pageBean.setLastPageURL( baseURL + "?limit=" + pageBean.getLastPage() + "&offset=" + offset );
			}			
		}
	}
	
	
	public String createQueryForPager( String baseQuery, String baseURL ){		
		if( limit >= 0 && offset > 0 ){			
			this.baseURL = baseURL;
			
			String query = 	baseQuery +
					"  limit " + (limit ) + " , " + (limit + offset);
			
			return query;
		}
		return null;
	}

	public int getFoundRows() {
		return foundRows;
	}

	public void setFoundRows(int foundRows) {
		this.foundRows = foundRows;
	}
	
	

}
