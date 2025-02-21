package com.dakshabhi.common.security;

import java.io.IOException;
import java.util.Date;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

public class LogFilter implements Filter {

	@Override
	public void destroy() {
		// TODO Auto-generated method stub
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		 
		// Downcasting to HttpServletRequest
		HttpServletRequest req = (HttpServletRequest) request;
		
		String  url = req.getRequestURI();
		// Log the IP address and current timestamp.
		//System.out.println(" url " + url);

		// Pass request back down the filter chain
		chain.doFilter(request, response);

	}

	@Override
	public void init(FilterConfig config) throws ServletException {
		// Get init parameter
		String testParam = config.getInitParameter("test-param");

		// Print the init parameter
		System.out.println("Test Param: " + testParam);
	}

}
