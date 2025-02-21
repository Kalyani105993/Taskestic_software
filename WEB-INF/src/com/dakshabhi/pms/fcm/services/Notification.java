package com.dakshabhi.pms.fcm.services;

import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

import java.io.IOException;

import com.dakshabhi.pms.fcm.dtos.PushNotificationRequest;

public class Notification {

	public PushNotificationRequest notification(PushNotificationRequest pushNotificationRequest) {

		OkHttpClient client = new OkHttpClient().newBuilder().build();
		MediaType mediaType = MediaType.parse("application/json");

		
		RequestBody body = RequestBody.create(mediaType, "{\"registration_ids\": [ \""+pushNotificationRequest.getToken()+"\"   ],    \"notification\": {     \"body\": \""+pushNotificationRequest.getMessage()+"\",        \"title\": \""+pushNotificationRequest.getTitle()+"\",       \"android_channel_id\": \"pushnotificationapp\",        \"sound\": false\n    }}");
		
		
		Request request = new Request.Builder().url("https://fcm.googleapis.com/fcm/send").method("POST", body)
				.addHeader("Authorization","key=AAAAE6nTbj4:APA91bGD5gbR8zIgS51VB1brh0n-lBtgRDOH1vyAFOGWO98L6EFTGFDcKdTqxTcgMWGirlwzQ6OuNgu582uuh4I7V-m3KUnqOd2sML1B6u3xgNBpLl0Jgu15mPdAvO3bj1QXoTZY7NmQ")
				.addHeader("Content-Type", "application/json").build();
	
	
		try {
			Response response = client.newCall(request).execute();
			System.out.println(response);
		} catch (IOException e) {
			e.printStackTrace();
		}

		return pushNotificationRequest;

	}

}