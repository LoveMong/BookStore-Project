package org.zerock.controller;


import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.zerock.domain.Bs_OrderDTO;
import org.zerock.domain.Bs_OrderList;
import org.zerock.domain.Bs_PayInfoVo;
import org.zerock.domain.Bs_PointVO;
import org.zerock.domain.Bs_UserVO;
import org.zerock.domain.PointSerchPD;
import org.zerock.service.BookStoreService;
import org.zerock.service.PointService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/pay/*")
@Log4j
public class PayController {
	
	@Autowired
	private BookStoreService service;
	
	@Autowired
	private PointService pointService;
	
	
	@GetMapping("/payment")
	public String pay(Model model, HttpSession session) throws Exception {
		
		Bs_UserVO login = (Bs_UserVO) session.getAttribute("login");
	    String userID = login.getUser_id();
	    
	    log.info("userID = " + userID);
	    model.addAttribute("addList", service.addrList(userID));
		
		return "pay/payment";
	}
	

	@RequestMapping(value = "/payment", method = RequestMethod.POST)
	public String payment(@ModelAttribute(value="Bs_OrderDTO") Bs_OrderDTO dto, HttpSession session, Model model) throws Exception {
		
		Bs_UserVO login = (Bs_UserVO) session.getAttribute("login");
	    String userID = login.getUser_id();
	    
	    log.info("userID = " + userID);
	    model.addAttribute("addList", service.addrList(userID));
	    
	    log.info(dto);
	    log.info(dto.getOrderlist().size());
	
	    List<Bs_OrderList> list = new ArrayList<Bs_OrderList>();
	    
	    
	   
	    for(int i = 0 ; i < dto.getOrderlist().size(); i++ ) {
	    	
	     	String chkBox = dto.getOrderlist().get(i).getChkBox();
	    	
	     	log.info(chkBox);
		    	
		    if(chkBox != null) {
		    	
		    	int bk_num = dto.getOrderlist().get(i).getBk_num();	    	
		    	
		    	Bs_OrderList orderList = service.payList(bk_num);	    	
		    	orderList.setBk_ordercnt(dto.getOrderlist().get(i).getBk_ordercnt());
		    	orderList.setCart_num(dto.getOrderlist().get(i).getCart_num());
		    	
		    	log.info(orderList.getBk_name());
		    	
		    	list.add(orderList);
		    	
		    }
	   
	    }
	    
	   
	    model.addAttribute("list", list);
		
	    	
		return "pay/payment";
	
	}
	
	@RequestMapping(value = "/regiaddr", method = RequestMethod.POST) 
	@ResponseBody
	public void stockAdd(@RequestParam("userID") String userID,
					     @RequestParam("name") String name,
					     @RequestParam("phone") int phone,
					     @RequestParam("addr") String addr) throws	Exception  {
		
		
	    
		log.info(userID);
		log.info(name);
		log.info(phone);
		log.info(addr);
		
		service.addAddress(userID, name, phone, addr);   
	 
		
	}
	
	@RequestMapping(value ="/LastPayment", method = RequestMethod.POST)
	@ResponseBody
	public void lastPayment(Bs_PayInfoVo vo, HttpSession session) throws Exception {
		
		log.info(vo);		
		
		
		service.payContent(vo);
		service.addBookSel(vo);
		service.minuStock(vo);
		service.delCart(vo);
		service.minuPoint(vo);
		
//		PointSerchPD pPd = new PointSerchPD();
//		SimpleDateFormat format1 = new SimpleDateFormat ("yyyy-MM-dd");
//		Date time = new Date();
//		String time1 = format1.format(time);
//		
//		pPd.setEndDate(time1);
//		pPd.setStartDate(time1);
//		pPd.setUser_id(vo.getUserId());
//		
//		List<Bs_PointVO> pVo = pointService.dateRead(pPd);
//		
//		
//		int pVoPoint = pVo.get(0).getPoint();
//		int voPoint = vo.getUserPoint();
//		
//		log.info("pVoPoint 값 : " + pVoPoint);
//		log.info("voPoint 값 : " + voPoint);
//		
//		if(pVoPoint != voPoint) {
//			log.info("if문 : " + pVo.get(0).getPoint());
//			log.info("if문 : " + vo.getUserPoint());
//			service.infoPayment(vo);
//		}
//	
		
		
		
		Bs_UserVO login = (Bs_UserVO) session.getAttribute("login");
	    String userID = login.getUser_id();    
	    
	    Integer user_amount = service.user_amount(userID);
		int user_rank = login.getUser_rank();
		
		if(user_amount == null) {
			
			user_amount = 0;
		}
		
		log.info("user_amount =" +user_amount);
	    
		if(user_amount >= 200000 && user_rank == 0) {
			
			service.upgrade_VIP(userID);
			
		} else if(user_amount >= 500000 && user_rank == 1) {
			
			service.upgrade_VVIP(userID);
		
		}
	
	}
	

	@RequestMapping(value ="/LastPayment", method = RequestMethod.GET)
	@ResponseBody
	public void lastPayment(@RequestParam("shipPrice") int shipPrice, @RequestParam("user_point") int user_point, HttpSession session) throws Exception {
	
		Bs_UserVO login = (Bs_UserVO) session.getAttribute("login");
	    String userID = login.getUser_id();
	    log.info(" 값 : " + shipPrice + user_point);
		
		service.shipPrice(userID, shipPrice);
		/* service.payInfoShipPC(userID, shipPrice, user_point); */
		
	}
}

