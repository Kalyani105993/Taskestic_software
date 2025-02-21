package com.dakshabhi.common.mail;

import com.dakshabhi.common.log.Loger;
 

import java.io.File;
import java.util.Date;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.Authenticator;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.Message.RecipientType;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.internet.MimeUtility;
import javax.naming.InitialContext;

public class MailSend {
	protected static Session mailSession = null;
	protected static Transport transport = null;
	protected static String smtpAddress = "144.217.234.150";
	protected static String mailProtocol = "smtp";
	protected static String mailUsername = "noreply@fastaddresschange.com";
	protected static String mailPassword = "LoginCr@t";

	static {
		Authenticator auth = new SMTPAuthenticator(mailUsername, mailPassword);
		Properties props = new Properties();
		props.setProperty("mail.transport.protocol", mailProtocol);
		props.setProperty("mail.smtp.host", smtpAddress);
		props.setProperty("mail.smtp.auth", "false");
		props.setProperty("mail.debug", "true");
		mailSession = Session.getDefaultInstance(props, auth);
	}

	public boolean sendMail(String mailTo, String mailSubject, String mailMessageContents, File[] files, String type) {
		boolean flag = true;
		try {
			InitialContext ic = new InitialContext();

			String smtpAddress = (String) ic.lookup("java:comp/env/MAILHOST");
			String mailProtocol = (String) ic.lookup("java:comp/env/mailProtocol");
			String mailFrom = (String) ic.lookup("java:comp/env/MailFrom");
			String mailUsername = (String) ic.lookup("java:comp/env/MailUsername");
			String mailPassword = (String) ic.lookup("java:comp/env/MailPassword");

			Properties props = new Properties();
			props.setProperty("mail.transport.protocol", mailProtocol);
			props.setProperty("mail.smtp.host", smtpAddress);
			props.setProperty("mail.smtp.auth", "false");
			props.setProperty("mail.debug", "true");
			Authenticator auth = new SMTPAuthenticator(mailUsername, mailPassword);
			Session mailSession = Session.getDefaultInstance(props, auth);
			mailSession.setDebug(true);
			Transport transport = mailSession.getTransport();

			MimeMessage message = new MimeMessage(mailSession);
			message.setSubject(mailSubject, "UTF-8");
			message.setFrom(new InternetAddress(mailFrom));
			message.setSentDate(new Date());

			message.setContent(mailMessageContents, "text/html");
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(mailTo));

			MimeMultipart multipart = new MimeMultipart();
			if ((files != null) && (files.length > 0)) {
				for (File file : files) {
					if (file != null) {
						MimeBodyPart bodyPart = new MimeBodyPart();
						bodyPart.setContent(file, type);
						FileDataSource fds = new FileDataSource(file);
						bodyPart.setDataHandler(new DataHandler(fds));
						bodyPart.setFileName(fds.getName());
						multipart.addBodyPart(bodyPart);
					}
				}
			}
			message.setContent(multipart);
			transport.connect();
			Transport.send(message, message.getRecipients(Message.RecipientType.TO));
			transport.close();
		} catch (Exception e) {
			flag = false;
			Loger.log(2, e);
		}
		return flag;
	}

	public boolean sendMail(String mailTo, String mailSubject, String mailMessageContents, File file, String type) {
		boolean flag = true;
		try {
			InitialContext ic = new InitialContext();

			String smtpAddress = (String) ic.lookup("java:comp/env/MAILHOST");
			String mailProtocol = (String) ic.lookup("java:comp/env/mailProtocol");
			String mailFrom = (String) ic.lookup("java:comp/env/MailFrom");
			String mailUsername = (String) ic.lookup("java:comp/env/MailUsername");
			String mailPassword = (String) ic.lookup("java:comp/env/MailPassword");

			Properties props = new Properties();
			props.setProperty("mail.transport.protocol", mailProtocol);
			props.setProperty("mail.smtp.host", smtpAddress);
			props.setProperty("mail.smtp.auth", "false");
			props.setProperty("mail.debug", "true");
			Authenticator auth = new SMTPAuthenticator(mailUsername, mailPassword);
			Session mailSession = Session.getDefaultInstance(props, auth);
			mailSession.setDebug(true);
			Transport transport = mailSession.getTransport();

			MimeMessage message = new MimeMessage(mailSession);
			message.setSubject(mailSubject, "UTF-8");
			message.setFrom(new InternetAddress(mailFrom));
			message.setSentDate(new Date());

			message.setContent(mailMessageContents, "text/html");
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(mailTo));
			if (file != null) {
				MimeBodyPart bodyPart = new MimeBodyPart();
				MimeMultipart multipart = new MimeMultipart();

				bodyPart.setContent(file, type);
				FileDataSource fds = new FileDataSource(file);
				bodyPart.setDataHandler(new DataHandler(fds));
				bodyPart.setFileName(fds.getName());
				multipart.addBodyPart(bodyPart);
				message.setContent(multipart);
			}
			transport.connect();
			Transport.send(message, message.getRecipients(Message.RecipientType.TO));
			transport.close();
		} catch (Exception e) {
			flag = false;
			Loger.log(2, e);
		}
		return flag;
	}

	public boolean sendMail(String mailTo, String mailSubject, String mailMessageContents) {
		boolean flag = true;
		try {
			InitialContext ic = new InitialContext();

			String smtpAddress = (String) ic.lookup("java:comp/env/MAILHOST");
			String mailProtocol = (String) ic.lookup("java:comp/env/mailProtocol");
			String mailFrom = (String) ic.lookup("java:comp/env/MailFrom");
			String mailUsername = (String) ic.lookup("java:comp/env/MailUsername");
			String mailPassword = (String) ic.lookup("java:comp/env/MailPassword");

			Properties props = new Properties();
			props.setProperty("mail.transport.protocol", mailProtocol);
			props.setProperty("mail.smtp.host", smtpAddress);
			props.setProperty("mail.smtp.auth", "false");
			props.setProperty("mail.debug", "true");
			Authenticator auth = new SMTPAuthenticator(mailUsername, mailPassword);
			Session mailSession = Session.getDefaultInstance(props, auth);
			mailSession.setDebug(true);
			Transport transport = mailSession.getTransport();

			MimeMessage message = new MimeMessage(mailSession);
			message.setSubject("62" + mailSubject, "UTF-8");
			message.setSentDate(new Date());
			message.setFrom(new InternetAddress(mailFrom));
			message.setContent(mailMessageContents, "text/html");
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(mailTo));

			transport.connect();
			transport.sendMessage(message, message.getRecipients(Message.RecipientType.TO));
			transport.close();
		} catch (Exception e) {
			flag = false;
			Loger.log(2, e);
		}
		return flag;
	}

	public boolean sendMail(String mailFrom, String mailTo, String mailSubject, String mailMessageContents,
			String contentType) {
		Loger.log("<Dakshabhi>From-" + mailFrom);
		Loger.log("<Dakshabhi>To-" + mailTo);
		Loger.log("<Dakshabhi>Subject-" + mailSubject);

		boolean flag = true;
		try {
			MimeMessage mimemsg = new MimeMessage(mailSession);

			mimemsg.setRecipients(Message.RecipientType.TO, mailTo);

			mimemsg.setFrom(new InternetAddress(mailFrom));

			// mimemsg.setSubject(MimeUtility.encodeText(mailSubject));
			mimemsg.setSubject(mailSubject, "UTF-8");

			mimemsg.setText(mailMessageContents);
			mimemsg.setSentDate(new Date());

			mimemsg.setContent(mailMessageContents, contentType);
			if ((transport != null) && (transport.isConnected())) {
				transport.sendMessage(mimemsg, mimemsg.getAllRecipients());
			} else {
				transport = mailSession.getTransport("smtp");
				transport.connect(mailUsername, mailPassword);
				transport.sendMessage(mimemsg, mimemsg.getAllRecipients());
			}
		} catch (Exception e) {
			flag = false;
			Loger.log(2, e);
			e.printStackTrace();
		}
		return flag;
	}

	public boolean sendMailForFollowup(String mailFrom, String mailTo, String mailSubject, String mailMessageContents,
			String contentType, String bcc) {
		Loger.log("<Dakshabhi>From-" + mailFrom);
		Loger.log("<Dakshabhi>To-" + mailTo);
		Loger.log("<Dakshabhi>Subject-" + mailSubject);
		Loger.log("<Dakshabhi>Bcc-" + bcc);

		boolean flag = true;
		try {
			MimeMessage mimemsg = new MimeMessage(mailSession);

			mimemsg.setRecipients(Message.RecipientType.TO, mailTo);
			mimemsg.setRecipients(Message.RecipientType.BCC, bcc);
			mimemsg.setFrom(new InternetAddress(mailFrom));
			// mimemsg.setSubject(MimeUtility.encodeText(mailSubject));
			mimemsg.setSubject(mailSubject, "UTF-8");
			mimemsg.setText(mailMessageContents);
			mimemsg.setSentDate(new Date());
			mimemsg.setContent(mailMessageContents, contentType);
			if ((transport != null) && (transport.isConnected())) {
				transport.sendMessage(mimemsg, mimemsg.getAllRecipients());
			} else {
				transport = mailSession.getTransport("smtp");
				transport.connect(mailUsername, mailPassword);
				transport.sendMessage(mimemsg, mimemsg.getAllRecipients());
			}
		} catch (Exception e) {
			flag = false;
			Loger.log(2, e);
			e.printStackTrace();
		}
		return flag;
	}

	public boolean sendUSPSConfirmationMail(String mailFrom, String mailTo, String mailSubject,
			String mailMessageContents, String contentType) {
		Loger.log("<Dakshabhi>From-" + mailFrom);
		Loger.log("<Dakshabhi>To-" + mailTo);
		Loger.log("<Dakshabhi>Subject-" + mailSubject);

		boolean flag = true;
		try {
			MimeMessage mimemsg = new MimeMessage(mailSession);

			mimemsg.setRecipients(Message.RecipientType.TO, mailTo);
			mimemsg.setRecipients(Message.RecipientType.BCC, "orders@movingconcepts.biz,1stopmove@s5infotech.com");

			mimemsg.setFrom(new InternetAddress(mailFrom));

			mimemsg.setSubject(mailSubject, "UTF-8");
			mimemsg.setSentDate(new Date());

			mimemsg.setText(mailMessageContents);

			mimemsg.setContent(mailMessageContents, contentType);
			if ((transport != null) && (transport.isConnected())) {
				transport.sendMessage(mimemsg, mimemsg.getAllRecipients());
			} else {
				transport = mailSession.getTransport("smtp");
				transport.connect(mailUsername, mailPassword);
				transport.sendMessage(mimemsg, mimemsg.getAllRecipients());
			}
		} catch (Exception e) {
			flag = false;
			Loger.log(2, e);
			e.printStackTrace();
		}
		return flag;
	}

	public boolean sendUnsubcribeHeaderMail(String header, String mailFrom, String mailTo, String mailSubject,
			String mailMessageContents, String contentType) {
		Loger.log("<Dakshabhi>From-" + mailFrom);
		Loger.log("<Dakshabhi>To-" + mailTo);
		Loger.log("<Dakshabhi>Subject-" + mailSubject);
		Loger.log("<Dakshabhi>Header-" + header);

		boolean flag = true;
		try {
			InitialContext ic = new InitialContext();

			String smtpAddress = (String) ic.lookup("java:comp/env/MAILHOST");
			String mailProtocol = (String) ic.lookup("java:comp/env/mailProtocol");
			String mailUsername = (String) ic.lookup("java:comp/env/MailUsername");
			String mailPassword = (String) ic.lookup("java:comp/env/MailPassword");

			Properties props = new Properties();
			props.setProperty("mail.transport.protocol", mailProtocol);
			props.setProperty("mail.smtp.host", smtpAddress);
			props.setProperty("mail.smtp.auth", "false");

			Authenticator auth = new SMTPAuthenticator(mailUsername, mailPassword);
			Session mailSession = Session.getDefaultInstance(props, auth);
			mailSession.setDebug(true);
			Transport transport = mailSession.getTransport();
			MimeMessage mimemsg = new MimeMessage(mailSession);
			mimemsg.addHeader("List-Unsubscribe", "<" + header + ">");
			mimemsg.setHeader("Return-Path", "<noreply@postmailadmin-usp.com>");
			mimemsg.setHeader("Precedence", "list");
			mimemsg.setHeader("List-Owner", "<mailto:noreply@postmailadmin-usp.com>");
			mimemsg.setHeader("Reply-To", "noreply@postmailadmin-usp.com");
			mimemsg.setHeader("List-Help", header);
			mimemsg.setRecipients(Message.RecipientType.TO, mailTo);
			// mimemsg.setHeader("List-Unsubscribe",
			// "<http://www.host.com/list.cgi?cmd=unsub&lst=list>,
			// <mailto:list-request@host.com?subject=unsubscribe>");
			mimemsg.setRecipients(Message.RecipientType.BCC, "1stopmove@s5infotech.com");
			mimemsg.setFrom(new InternetAddress(mailFrom));
			mimemsg.setSubject(mailSubject, "UTF-8");
			mimemsg.setSentDate(new Date());

			// mimemsg.setText(mailMessageContents);

			// mimemsg.setContent(mailMessageContents, contentType);

			// Now the message body.
			Multipart mp = new MimeMultipart();

			BodyPart textPart = new MimeBodyPart();
			textPart.setText(""); // sets type to "text/plain"

			BodyPart pixPart = new MimeBodyPart();
			pixPart.setContent(mailMessageContents, contentType);

			// Collect the Parts into the MultiPart
			mp.addBodyPart(textPart);
			mp.addBodyPart(pixPart);
			// Put the MultiPart into the Message
			// mesg.setContent(mp);
			// mimemsg.setText(mailMessageContents);
			// mimemsg.setContent(mailMessageContents, contentType);

			mimemsg.setContent(mp);

			if ((transport != null) && (transport.isConnected())) {
				transport.sendMessage(mimemsg, mimemsg.getAllRecipients());
			} else {
				transport = mailSession.getTransport("smtp");
				transport.connect(mailUsername, mailPassword);
				transport.sendMessage(mimemsg, mimemsg.getAllRecipients());
			}
		} catch (Exception e) {
			flag = false;
			Loger.log(2, e);
			e.printStackTrace();
		}
		return flag;
	}

	public boolean sendMail(String mailFrom, String mailTo, String mailSubject, String mailMessageContents,
			String contentType, String filepath, String fileName) {
		Loger.log("<Dakshabhi>From-" + mailFrom);
		Loger.log("<Dakshabhi>To-" + mailTo);
		Loger.log("<Dakshabhi>Subject-" + mailSubject);
		Loger.log("<Dakshabhi>mailMessageContents-" + mailMessageContents + "<finish>");

		boolean flag = true;
		try {
			InitialContext ic = new InitialContext();

			String smtpAddress = (String) ic.lookup("java:comp/env/MAILHOST");
			String mailProtocol = (String) ic.lookup("java:comp/env/mailProtocol");
			String mailUsername = (String) ic.lookup("java:comp/env/MailUsername");
			String mailPassword = (String) ic.lookup("java:comp/env/MailPassword");

			Properties props = new Properties();
			props.setProperty("mail.transport.protocol", mailProtocol);
			props.setProperty("mail.smtp.host", smtpAddress);
			props.setProperty("mail.smtp.auth", "false");
			props.setProperty("mail.debug", "true");
			Authenticator auth = new SMTPAuthenticator(mailUsername, mailPassword);
			Session mailSession = Session.getDefaultInstance(props, auth);
			mailSession.setDebug(true);

			MimeMessage message = new MimeMessage(mailSession);
			message.setSentDate(new Date());
			message.setFrom(new InternetAddress(mailFrom));
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(mailTo));
			message.setSubject(mailSubject, "UTF-8");

			BodyPart messageBodyPart = new MimeBodyPart();

			messageBodyPart.setContent(mailMessageContents, contentType);

			Multipart multipart = new MimeMultipart();

			multipart.addBodyPart(messageBodyPart);

			messageBodyPart = new MimeBodyPart();

			DataSource source = new FileDataSource(filepath);

			messageBodyPart.setDataHandler(new DataHandler(source));

			messageBodyPart.setFileName(fileName);

			multipart.addBodyPart(messageBodyPart);

			message.setContent(multipart);

			Transport.send(message);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return flag;
	}

	public boolean sendMail(String mailFrom, String mailTo, String mailSubject, String mailMessageContents,
			String smtpAdd, String mailServerType) {
		boolean flag = true;
		try {
			InitialContext ic = new InitialContext();
			String smtpAddress = (String) ic.lookup("java:comp/env/MAILHOST");
			String mailProtocol = (String) ic.lookup("java:comp/env/mailProtocol");
			String mailUsername = (String) ic.lookup("java:comp/env/MailUsername");
			String mailPassword = (String) ic.lookup("java:comp/env/MailPassword");

			Properties props = new Properties();
			props.setProperty("mail.transport.protocol", mailProtocol);
			props.setProperty("mail.smtp.host", smtpAddress);
			props.setProperty("mail.smtp.auth", "false");
			props.setProperty("mail.debug", "true");
			Authenticator auth = new SMTPAuthenticator(mailUsername, mailPassword);
			Session mailSession = Session.getDefaultInstance(props, auth);

			MimeMessage mimemsg = new MimeMessage(mailSession);

			mimemsg.setRecipients(Message.RecipientType.TO, mailTo);
			mimemsg.setSentDate(new Date());

			mimemsg.setFrom(new InternetAddress(mailFrom));

			mimemsg.setSubject("193" + mailSubject, "UTF-8");

			mimemsg.setText(mailMessageContents);

			Transport.send(mimemsg);
		} catch (Exception e) {
			flag = false;
			Loger.log(2, e);
		}
		return flag;
	}

	public boolean sendMail(String mailTo, String mailSubject, String mailMessageContents, String fromPageName) {
		boolean flag = true;
		try {
			InitialContext ic = new InitialContext();
			String smtpAddress = (String) ic.lookup("java:comp/env/MAILHOST");
			String mailProtocol = (String) ic.lookup("java:comp/env/mailProtocol");
			String mailUsername = (String) ic.lookup("java:comp/env/MailUsername");
			String mailPassword = (String) ic.lookup("java:comp/env/MailPassword");

			Properties props = new Properties();
			props.setProperty("mail.transport.protocol", mailProtocol);
			props.setProperty("mail.smtp.host", smtpAddress);
			props.setProperty("mail.smtp.auth", "false");
			props.setProperty("mail.debug", "true");
			Authenticator auth = new SMTPAuthenticator(mailUsername, mailPassword);
			Session mailSession = Session.getDefaultInstance(props, auth);
			mailSession.setDebug(true);
			Transport transport = mailSession.getTransport();

			MimeMessage message = new MimeMessage(mailSession);
			message.setSubject("244" + mailSubject, "UTF-8");
			message.setFrom(new InternetAddress(fromPageName));
			message.setContent(mailMessageContents, "text/html");
			message.setHeader("X-Mailer", "1StopMove mailer");
			message.setSentDate(new Date());
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(mailTo));

			transport.connect();
			transport.sendMessage(message, message.getRecipients(Message.RecipientType.TO));
			transport.close();
		} catch (Exception e) {
			flag = false;
			Loger.log(2, e);
		}
		return flag;
	}

	public boolean sendForgotMail(String mailFrom, String replyTo, String mailTo, String mailSubject,
			String mailMessageContents, String contentType) {
		Loger.log("<Dakshabhi>From-" + mailFrom);
		Loger.log("<Dakshabhi>ReplyTo-" + replyTo);
		Loger.log("<Dakshabhi>To-" + mailTo);
		Loger.log("<Dakshabhi>Subject-" + mailSubject);

		boolean flag = true;
		try {
			InitialContext ic = new InitialContext();

			String smtpAddress = (String) ic.lookup("java:comp/env/MAILHOST");
			String mailProtocol = (String) ic.lookup("java:comp/env/mailProtocol");
			String mailUsername = (String) ic.lookup("java:comp/env/MailUsername");
			String mailPassword = (String) ic.lookup("java:comp/env/MailPassword");

			Properties props = new Properties();
			props.setProperty("mail.transport.protocol", mailProtocol);
			props.setProperty("mail.smtp.host", smtpAddress);
			props.setProperty("mail.smtp.auth", "false");
			props.setProperty("mail.debug", "true");
			Authenticator auth = new SMTPAuthenticator(mailUsername, mailPassword);
			Session mailSession = Session.getDefaultInstance(props, auth);
			MimeMessage mimemsg = new MimeMessage(mailSession);

			mimemsg.setRecipients(Message.RecipientType.TO, mailTo);
			mimemsg.setSentDate(new Date());

			mimemsg.setFrom(new InternetAddress(mailFrom));

			mimemsg.setSubject(mailSubject, "UTF-8");

			mimemsg.setText(mailMessageContents);

			mimemsg.setContent(mailMessageContents, contentType);
			Transport.send(mimemsg);
		} catch (Exception e) {
			flag = false;
			Loger.log(2, e);
			e.printStackTrace();
		}
		return flag;
	}

	public static boolean sendMailWithAttachment(String mailFrom, String mailTo, String mailSubject,
			String mailMessageContents, String contentType, String filepath, String fileName) {
		boolean flag = false;
		try {
			InitialContext ic = new InitialContext();

			String smtpAddress = (String) ic.lookup("java:comp/env/MAILHOST");
			String mailProtocol = (String) ic.lookup("java:comp/env/mailProtocol");
			String mailUsername = (String) ic.lookup("java:comp/env/MailUsername");
			String mailPassword = (String) ic.lookup("java:comp/env/MailPassword");

			Properties props = new Properties();
			props.setProperty("mail.transport.protocol", mailProtocol);
			props.setProperty("mail.smtp.host", smtpAddress);
			props.setProperty("mail.smtp.auth", "false");
			props.setProperty("mail.debug", "true");
			Authenticator auth = new SMTPAuthenticator(mailUsername, mailPassword);
			Session mailSession = Session.getDefaultInstance(props, auth);
			mailSession.setDebug(true);

			MimeMessage message = new MimeMessage(mailSession);

			message.setFrom(new InternetAddress(mailFrom));
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(mailTo));
			message.setSubject(mailSubject, "UTF-8");
			message.setSentDate(new Date());

			BodyPart messageBodyPart = new MimeBodyPart();

			messageBodyPart.setContent(mailMessageContents, contentType);

			Multipart multipart = new MimeMultipart();

			multipart.addBodyPart(messageBodyPart);

			messageBodyPart = new MimeBodyPart();

			DataSource source = new FileDataSource(filepath);

			messageBodyPart.setDataHandler(new DataHandler(source));

			messageBodyPart.setFileName(fileName);

			multipart.addBodyPart(messageBodyPart);

			message.setContent(multipart);

			Transport.send(message);

			flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return flag;
	}

	 
}