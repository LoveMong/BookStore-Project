package org.zerock.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.domain.KakaoPayVO;
import org.zerock.mapper.KakaoPayMapper;


@Service
public class KakaoPayServiceImpl implements KakaoPayService{

	@Autowired
	private KakaoPayMapper paymapper;
	
	@Override
	public void pointupdate(KakaoPayVO vo) {
		paymapper.pointupdate(vo);
		
	}

	@Override
	public void insert(KakaoPayVO vo) {
		paymapper.insert(vo);
		
	}

}
