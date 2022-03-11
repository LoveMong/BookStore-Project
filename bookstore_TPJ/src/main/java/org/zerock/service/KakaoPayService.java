package org.zerock.service;

import org.springframework.stereotype.Service;
import org.zerock.domain.KakaoPayVO;


public interface KakaoPayService {
	public void pointupdate(KakaoPayVO vo);
	public void insert(KakaoPayVO vo);
}
