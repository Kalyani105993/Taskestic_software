package com.dakshabhi.pms.email.services;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Properties;

import javax.mail.Address;
import javax.mail.Flags;
import javax.mail.Folder;
import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.Part;
import javax.mail.Session;
import javax.mail.Store;
import javax.mail.internet.MimeBodyPart;
import javax.mail.search.FlagTerm;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dakshabhi.pms.companies.dtos.CCompanyDTO;
import com.dakshabhi.pms.email.daos.EmailDetailDAO;
import com.dakshabhi.pms.email.dtos.ReadMailDetailDTO;
import com.google.gson.Gson;

@WebServlet("/readEmailServlet")
public class ReadMailService extends HttpServlet{
	/**
	 * Class for manage services related to read email 
	 * 
	 */
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
		String host = "imap.gmail.com";
	    final String username = "pmsdakshabhi@gmail.com";
	    final String password = "tlgdlnseaxborlos"; // Use the 16-character App Password here

	    EmailDetailDAO emaildao = new EmailDetailDAO();
	    // Set up the Gmail properties
	    Properties props = new Properties();
		props.put("mail.imap.host", "imap.gmail.com");
		props.put("mail.imap.user", username);
		props.put("mail.imap.ssl.enable", "true");
		props.put("mail.imap.port", "993");        
		props.put("mail.store.protocol", "imaps");
		props.put("mail.imap.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		props.put("mail.imap.socketFactory.fallback", "false");
	    
		System.setProperty("https.protocols", "TLSv1.2");

	    Session session = Session.getInstance(props, null);
	    String from ="";
		String to = "";
		String subject= "";
		String formattedDate = "";
		String contentType = "";
		String fromName = "";
		String toName ="";
		String messageBody = "";//Initialize with empty string
	    
	    try {
	    	
	        // Connect to Gmail
	        Store store = session.getStore("imaps");
	        store.connect(host, username, password);

	        // Open the INBOX folder
	        Folder inbox = store.getFolder("INBOX");
	        inbox.open(Folder.READ_WRITE);
	        
	        // Retrieve recent messages
	        Message[] messages = inbox.search(new FlagTerm(new Flags(Flags.Flag.RECENT), false));

	        System.out.println("Total Msgs: " + messages.length);

	        // Create the destination folder "pmsdakshabhi" if it doesn't exist
			  Folder destinationFolder = store.getFolder("pmsdakshabhi"); 
			  if (!destinationFolder.exists()) {
				  System.out.println("Destination folder does not exist.");
				  return; 
			  }
		
	        // Loop through recent messages and save details to the database
	        for (Message message : messages) {
	        	
	        	//delete flag before move other folder 
	        	message.setFlag(Flags.Flag.DELETED, true);
	        	 // Extract message details
		   
				 Address[] fromAddresses = message.getFrom();
				 Address[] toAddresses = message.getRecipients(Message.RecipientType.TO);
				 
				 Address[] fromNameArr = message.getFrom();
				 Address[] toNameArr = message.getRecipients(Message.RecipientType.TO);
				 
				fromName =emaildao.extractName(fromNameArr[0].toString()); 
				toName =emaildao.extractName(toNameArr[0].toString());
					 
				 from = emaildao.extractEmailAddress(fromAddresses[0].toString());
			     to = emaildao.extractEmailAddress(toAddresses[0].toString());
			
		        subject = message.getSubject();
		    	String sentDate = message.getSentDate().toString();
		    	SimpleDateFormat inputDateFormat = new SimpleDateFormat("E MMM dd HH:mm:ss z yyyy");
		        SimpleDateFormat outputDateFormat = new SimpleDateFormat("yyyy-MM-dd");
		         
		         try {

		             Date date = inputDateFormat.parse(sentDate);
		             formattedDate = outputDateFormat.format(date);
		             System.out.println("Formatted Date: " + formattedDate);
		             
		         } catch (ParseException e) {
		             e.printStackTrace();
		         }
		    	
		    	contentType = message.getContentType();
		    	
				// store attachment file name, separated by comma
				String attachFiles = "";

				if (contentType.contains("multipart")) {
					// content may contain attachments
					Multipart multiPart = (Multipart) message.getContent();
					int numberOfParts = multiPart.getCount();
					for (int partCount = 0; partCount < numberOfParts; partCount++) {
						MimeBodyPart part = (MimeBodyPart) multiPart.getBodyPart(partCount);
						if (Part.ATTACHMENT.equalsIgnoreCase(part.getDisposition())) {
							// this part is attachment
							String fileName = part.getFileName();
							attachFiles += fileName + ",";
//							part.saveFile(saveDirectory + File.separator + fileName);
						}else {
//							// this part may be the message content or message body
							messageBody = part.getContent().toString();
							}
					}
					if (attachFiles.length() > 1) {
						attachFiles = attachFiles.substring(0, attachFiles.length() - 2);
					}
				} else if (contentType.contains("text/plain")) {
					Object content = message.getContent();
					if (content != null) {
						messageBody = content.toString();
					}
				}
		     
		        // Get the message content (text/plain part)
		        if (message.isMimeType("text/plain")) {
		            messageBody = message.getContent().toString();
		        }

		        System.out.println("\t from: " + from);
		        System.out.println("\t to : " + to);
		        System.out.println("\t from  name: " +fromName );
		        System.out.println("\t to name: " + toName);
		        System.out.println("\t subject : " + subject);
		        System.out.println("\t messageBody : " + messageBody);
		        System.out.println("\t sentDate" + sentDate);

	            message.setFlag(Flags.Flag.RECENT, true);
			    destinationFolder.appendMessages(new Message[]{message}); 
	        }
	   
	        if(messages.length != 0) {
	        	ReadMailDetailDTO mailDetailDTO = new ReadMailDetailDTO();
	        	mailDetailDTO.setFromEmail(from);
	 	        mailDetailDTO.setToEmail(to);
	 	        mailDetailDTO.setEmailSubject(subject);
	 	        mailDetailDTO.setEmailBody(messageBody);
	 	        mailDetailDTO.setFromName(fromName);
	 	        mailDetailDTO.setToName(toName);
	 	        mailDetailDTO.setSend_date(formattedDate);
	 			emaildao.saveEmailDetails(mailDetailDTO);
	 			
	        }
	        // Close folders and the store
	        inbox.close(false);
	        store.close();

	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    
	    }
	    
	}
	

