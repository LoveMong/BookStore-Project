package org.zerock.controller;


import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.Bs_BookVO;
import org.zerock.domain.Bs_CartVO;
import org.zerock.domain.Bs_CodeVO;
import org.zerock.domain.Bs_ReviewVO;
import org.zerock.domain.Bs_UserVO;
import org.zerock.domain.PaginationPD;
import org.zerock.domain.SearchPD;
import org.zerock.service.BookMainService;
import org.zerock.service.KakaoAPI;

import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequiredArgsConstructor
public class HomeController {
   @Autowired
   private final BookMainService service;
   private final KakaoAPI kakao;
   
   
   @GetMapping("/remain")
   public String remain() {
      return "mainRe";
   }
   
   
   @RequestMapping(value="/kakaoLogin" ,method = RequestMethod.GET )
   public String login(@RequestParam("code") String code, HttpSession session) throws Exception{
	   
	   System.out.println("code : " + code);
	   String access_Token = kakao.getAccessToken(code);
	   HashMap<String, Object> userInfo = kakao.getUserInfo(access_Token);
	   System.out.println("login Controller : " + userInfo);
	   
	   String userId = (String)userInfo.get("email");
	   String userNickName = (String)userInfo.get("nickname");
	   
	   System.out.println("userId : " + userId);
	   
	   int check = service.check(userId);
	   
	   if(check == 0) {
		   
		   service.regiUser(userId, userNickName);
		   

		   
	   }
	   
	   Bs_UserVO user = service.infoUser(userId);
	   
	   session.setAttribute("login", user);
	   
	   return "redirect:/main";
	   
   }
  
   
   @RequestMapping(value="/googleLogin" ,method = RequestMethod.POST )
   @ResponseBody
   public String login(@RequestParam("email") String email,@RequestParam("userName") String userName, HttpSession session) throws Exception{
   
	  
	   
	   System.out.println("email : " + email);
	   System.out.println("userName : " + userName);
	   
	   int check = service.check(email);
	   
	   	   if(check == 0) {
		   
		   service.regiUser(email, userName);

		   
	   }
	   	   
	   Bs_UserVO user = service.infoUser(email);
		   
		   session.setAttribute("login", user);
		   
		   
		   return "suc";
		
		 
		
		   
   }
   
   
//   @RequestMapping(value="/kakaoLogout")
//   public String kakaoLogout(HttpSession session) {
//       kakao.kakaoLogout((String)session.getAttribute("access_Token"));
//       session.removeAttribute("access_Token");
//       session.removeAttribute("userId");
//       session.invalidate();
//       return "redirect:/main";
//   }
   
   
   @GetMapping("/login")
   public String login() {
      return "loginMain";
   }
   
   @GetMapping("/join")
   public String join() {
      return "joinForm";
   }
   
   @RequestMapping(value = "/idCheck",method = RequestMethod.GET, produces = "application/text; charset=utf8")
   @ResponseBody
   public String idCheck(HttpServletRequest request) {
      
      String user_id = request.getParameter("user_id");
      int result=service.idCheck(user_id);
      return Integer.toString(result);	
   }
   
   @PostMapping("/join") // 회원가입(암호화 기능 추가)
   public String joinForm(Bs_UserVO vo, RedirectAttributes redirectAttributes) {
      String hashedPw = BCrypt.hashpw(vo.getUser_pw(), BCrypt.gensalt()); 
      vo.setUser_pw(hashedPw); 
      service.register(vo); 
      
      return "redirect:/login";
   }
   
   @RequestMapping(value = "/loginCheck", method = RequestMethod.POST)
   @ResponseBody
   public String login(@RequestBody Bs_UserVO vo, HttpSession session) throws Exception {
      
      String result = null;
      
      //로그인 시도한 회원의 아이디와 일치하는 정보를 user에 할
      Bs_UserVO user = service.login(vo);
      //아이디 존재 -> 가입된 회원이 존재 -> 비밀번호 확인 필요
      if(user != null&&BCrypt.checkpw(vo.getUser_pw(), user.getUser_pw())) {
         
         session.setAttribute("login", user);
         result = "loginSuccess";
         
      } else {  //이메일이 존재하지 않음
         result = "idFail";
      }
      
      return result;
   }
   @PostMapping("/login")
   public String login2() {
      return "redirect:/main";
   }
   
    @GetMapping("/main")
    public String main(Model model, HttpSession session) throws Exception {
    	Bs_UserVO login = (Bs_UserVO) session.getAttribute("login");
    	if(login!=null) {
        	String user_id = login.getUser_id();
        	log.info("userid"+user_id);
        		Bs_UserVO selectPoint = service.selectPoint(user_id);
        		List<Bs_BookVO> ranklist=service.rankselect();
        		List<Bs_BookVO> list=service.dateselect();
        		List<Bs_BookVO> bestlist=service.bestselect();
        		model.addAttribute("userinfo", selectPoint);
        		model.addAttribute("ranklist",ranklist);
        		model.addAttribute("list", list);
        		model.addAttribute("bestlist", bestlist);
        		return "main";
    	}
    	else {
    		List<Bs_BookVO> ranklist=service.rankselect();
    		List<Bs_BookVO> list=service.dateselect();
    		List<Bs_BookVO> bestlist=service.bestselect();
    		model.addAttribute("ranklist",ranklist);
    		model.addAttribute("list", list);
    		model.addAttribute("bestlist", bestlist);
    		return "main";
    	}
    	
    }
    

    @RequestMapping(value = "/addcart", method = RequestMethod.POST)
    @ResponseBody
    public String addcart(Bs_CartVO vo) {
       String result=null;
       log.info("vo : " + vo);
       
       
          if(vo!=null) {
             service.addcart(vo);
             result="success";
          }
          else {
             result="fail";
          }
       return result;
    }
    
    
    @RequestMapping(value = "/comment", method=RequestMethod.POST)
    @ResponseBody
    public String comment(Bs_ReviewVO vo) throws Exception {
       log.info("vo : "+ vo);
       String result = null;
       int ordCheck = service.ordCheck(vo);
       if(ordCheck==0) {
          result="notorder";
       }
       else {
          service.comment(vo);
          int bk_num=vo.getBk_num();
          double sum=service.selectsum(bk_num);
           int count=service.rankcount(bk_num);
           double avg=sum/count;
           double revrank=(double)Math.round(avg*10)/10;
           service.revupdate(revrank, bk_num);
          result="order";
       }
       return result;
       
    }
    @RequestMapping(value = "/commentDelete", method = RequestMethod.GET)
   @ResponseBody
    public void commentDelete(Bs_ReviewVO vo) {
       log.info("vo : "+vo);
       service.commentdelete(vo);
   }
    @RequestMapping(value = "/commentUpdate", method = RequestMethod.POST)
   @ResponseBody
    public void commentUpdate(Bs_ReviewVO vo) {
       log.info("vo : "+vo);
       service.commentupdate(vo);
   }
    
    @RequestMapping(value = "/logout", method = RequestMethod.GET)
   public String logout(HttpSession session) {
     
      session.invalidate();
      return "redirect:/main";
   }
    
    @GetMapping("/detail")
    public String detail(Model model
          , @RequestParam(required = false)int num
          , @RequestParam(required = false, defaultValue = "1") int page
          , @RequestParam(required = false, defaultValue = "1") int range) throws Exception {
       model.addAttribute("bk_num", num);
       log.info("bk_num : "+num);
       int bk_num = num;
       double sum=service.selectsum(bk_num);
       int count=service.rankcount(bk_num);
       double avg=sum/count;
       double rank=(double)Math.round(avg*10)/10;
       log.info("rank : "+rank);
       log.info("count : "+count);
       log.info("sum :"+sum);
       model.addAttribute("rank", rank);
       model.addAttribute("book", service.detail(bk_num));
       
       SearchPD search = new SearchPD();
      search.setBk_num(bk_num);
       
      int listCnt = service.decommentcnt(search);
      log.info("listCnt 값 :" + listCnt);
      
      search.pageInfo(page, range, listCnt);
      model.addAttribute("pagination", search);   
       model.addAttribute("comment", service.decomment(search));
       return "detail";
    }

   
    @RequestMapping(value = "/search", method = RequestMethod.GET)
   public String getBookList(Model model
         , @RequestParam(required = false, defaultValue = "0") int cateCode
         , @RequestParam(required = false, defaultValue = "0") int best
         , @RequestParam(required = false, defaultValue = "0") int newbook
         , @RequestParam(required = false, defaultValue = "1") int page
         , @RequestParam(required = false, defaultValue = "1") int range
         , @RequestParam(required = false, defaultValue = "title") String searchType
         , @RequestParam(required = false) String keyword
         ) throws Exception {
       log.info("cateCode : "+cateCode);
       if(cateCode!=0 && best==0 && newbook==0) {
          model.addAttribute("code",cateCode);
          model.addAttribute("best",best);
          model.addAttribute("newbook",newbook);
         SearchPD search = new SearchPD();
          search.setCode(cateCode);
          
          int listCnt = service.getBookListCnt(search);
          log.info("listCnt 값 :" + listCnt);
          
          search.pageInfo(page, range, listCnt);
          
          model.addAttribute("listCnt",listCnt);
          model.addAttribute("pagination", search);   
          model.addAttribute("bookList", service.getBookList(search));
         return "search";
       }
       else if(best!=0 && cateCode==0 && newbook==0) {
          model.addAttribute("code",cateCode);
          model.addAttribute("best",best);
          model.addAttribute("newbook",newbook);
          
         SearchPD search = new SearchPD();
          search.setBest(best);
          
          int listCnt = service.revranklistcnt();
          log.info("listCnt 값 :" + listCnt);
          
          search.pageInfo(page, range, listCnt);
          
          model.addAttribute("listCnt",listCnt);
          model.addAttribute("pagination", search);   
          model.addAttribute("bookList", service.revranklist(search));
         return "search";
       }
       else if(newbook!=0 && cateCode==0 && best==0) {
          model.addAttribute("code",cateCode);
          model.addAttribute("best",best);
          model.addAttribute("newbook",newbook);
         
         SearchPD search = new SearchPD();
          search.setNewbook(newbook);
          
          int listCnt = service.newbooklistcnt();
          log.info("listCnt 값 :" + listCnt);
          
          search.pageInfo(page, range, listCnt);
          
          model.addAttribute("listCnt",listCnt);
          model.addAttribute("pagination", search);   
          model.addAttribute("bookList", service.newbooklist(search));
          return "search";
       }
       else {
          model.addAttribute("keyword",keyword);
          model.addAttribute("code",cateCode);
          model.addAttribute("best",best);
          model.addAttribute("newbook",newbook);
          log.info("searchType : "+searchType);
          log.info("keyword : "+keyword);
          SearchPD search = new SearchPD();
          search.setSearchType(searchType);
          search.setKeyword(keyword);
          
          int listCnt = service.searchlistcnt(search);
          log.info("listCnt 값 :" + listCnt);
          
          search.pageInfo(page, range, listCnt);
          
          model.addAttribute("listCnt",listCnt);
          model.addAttribute("pagination", search);   
          model.addAttribute("bookList", service.searchlist(search));
          return "search";
       }
   }
}