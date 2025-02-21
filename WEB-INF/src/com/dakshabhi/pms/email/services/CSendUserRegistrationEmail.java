package com.dakshabhi.pms.email.services;

import java.util.Properties;

import com.dakshabhi.common.mail.SMTPAuthenticator;
import com.dakshabhi.pms.email.dtos.CEmailDetailsDTO;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class CSendUserRegistrationEmail {

	public static boolean sendEmail(CEmailDetailsDTO emailDetailsDTO) {

		try {
			Properties props = new Properties();
			props.setProperty("mail.transport.protocol", "smtp");
			props.setProperty("mail.smtp.host", "in-v3.mailjet.com");
			props.setProperty("mail.smtp.port", "587");
			props.setProperty("mail.smtp.ssl.protocols", "TLSv1.2");
			props.setProperty("mail.smtp.auth", "true");
			//props.setProperty("mail.smtp.ssl.enable", "true");
			props.setProperty("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
			props.setProperty("mail.smtp.starttls.enable", "true");
			props.setProperty("mail.smtp.ssl.trust", "*");
			Authenticator auth = new SMTPAuthenticator("066cedb9543568fbc3c43b88878e3a05",
					"87666c274f47d7d008f96a4bd0792bb7");

			Session mailSession = Session.getInstance(props, auth);
			mailSession.setDebug(false);
			MimeMessage mimemsg = new MimeMessage(mailSession);
			mimemsg.setRecipients(Message.RecipientType.TO, emailDetailsDTO.getToEmail());
			
			if(!"".equals(emailDetailsDTO.getBccEmail()))
				mimemsg.setRecipients(Message.RecipientType.BCC, emailDetailsDTO.getBccEmail());
			
			mimemsg.setFrom(new InternetAddress(emailDetailsDTO.getFromEmail()));
			mimemsg.setSubject(emailDetailsDTO.getEmailSubject());
			mimemsg.setText(emailDetailsDTO.getEmailBody());
			mimemsg.setContent(emailDetailsDTO.getEmailBody(), emailDetailsDTO.getContentType());
			javax.mail.Transport.send(mimemsg);

			return true;
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		return false;
	}

}
