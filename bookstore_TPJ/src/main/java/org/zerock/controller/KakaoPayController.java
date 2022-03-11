package org.zerock.controller;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.zerock.domain.KakaoPayVO;
import org.zerock.service.KakaoPayService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class KakaoPayController {
	
	@Autowired
	private KakaoPayService payservice;
	
	@RequestMapping("/kakaopay")
	@ResponseBody
	public String kakaopay(Model model, KakaoPayVO vo) {
		try {
			String userid = vo.getUserid();
			int pointCharge = vo.getPointCharge();
			int point = vo.getPoint();
			log.info("userid : "+userid);
			log.info("point : "+pointCharge);
			log.info("point : " + point);
			
			URL pay = new URL("https://kapi.kakao.com/v1/payment/ready");
			HttpURLConnection connect = (HttpURLConnection) pay.openConnection();
			connect.setRequestMethod("POST");
			connect.setRequestProperty("Authorization", "KakaoAK 0a6319489b0b97c1f5ba06e04f9687d1");
			connect.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
			connect.setDoOutput(true);
			String parameter = "cid=TC0ONETIME&"
					+ "partner_order_id=partner_order_id&"
					+ "partner_user_id="+userid+"&"
					+ "item_name=point&"
					+ "quantity=1&"
					+ "total_amount="+pointCharge+"&"
					+ "vat_amount=0&"
					+ "tax_free_amount=0&"
					+ "approval_url=http://localhost:8080/mypage/paylist&"
					+ "fail_url=http://localhost:8080/point&"
					+ "cancel_url=http://localhost:8080/point";
			OutputStream output = connect.getOutputStream();
			DataOutputStream putData = new DataOutputStream(output);
			putData.writeBytes(parameter);
			putData.flush();
			putData.close();
			
			int result = connect.getResponseCode();
			
			InputStream input;
			
			if(result == 200) {
				input = connect.getInputStream();
				log.info("input : "+input);
				payservice.insert(vo);
				payservice.pointupdate(vo);
			}
			else {
				input = connect.getErrorStream();
				log.info("input : "+input);
			}
			InputStreamReader reader = new InputStreamReader(input);
			BufferedReader changer = new BufferedReader(reader);
			return changer.readLine();
		} catch (MalformedURLException e) {
			e.printStackTrace();
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
}
