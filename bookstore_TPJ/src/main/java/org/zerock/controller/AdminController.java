package org.zerock.controller;

import java.io.File;


import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.zerock.domain.Bs_BookVO;
import org.zerock.domain.PaginationPD;
import org.zerock.domain.SearchPD;
import org.zerock.service.BookStoreService;
import org.zerock.utils.UploadFileUtils;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/admin/*")
@Log4j
public class AdminController {
   


   @Autowired
   private BookStoreService service;
   
   @Resource(name="uploadPath")
   private String uploadPath;
   
   
   @GetMapping("/product")
   public String register() {
      return "admin/product";
   }
   
   @GetMapping("/memberList")
   public String memberList(Model model
         ,@RequestParam(required = false, defaultValue = "1") int page
         ,@RequestParam(required = false, defaultValue = "1") int range
         ,@RequestParam(required = false, defaultValue = "userID") String searchType
         ,@RequestParam(required = false) String keyword
         )throws Exception {
      
      SearchPD search = new SearchPD();
      search.setSearchType(searchType);
      search.setKeyword(keyword);
      
      int listCnt = service.memberListCnt(search);
      
      search.pageInfo(page, range, listCnt);
      
      model.addAttribute("pagination", search);   
      model.addAttribute("list", service.memberList(search));
      
      
      return "admin/memberList";
   }
   
   @GetMapping("/orderList")
   public String orderList(Model model
         ,@RequestParam(required = false, defaultValue = "1") int page
         ,@RequestParam(required = false, defaultValue = "1") int range
         ,@RequestParam(required = false, defaultValue = "orderNum") String searchType
         ,@RequestParam(required = false) String keyword
         )throws Exception {
      
      SearchPD search = new SearchPD();
      search.setSearchType(searchType);
      search.setKeyword(keyword);
      
      int listCnt = service.orderListCnt(search);
      
      search.pageInfo(page, range, listCnt);
      
      model.addAttribute("pagination", search);   
      model.addAttribute("list", service.orderList(search));
      
      return "admin/orderList";
   }
   
   // 도서 리스트
   @GetMapping("/productList")
   public String list(Model model
         ,@RequestParam(required = false, defaultValue = "1") int page
         ,@RequestParam(required = false, defaultValue = "1") int range
         ,@RequestParam(required = false, defaultValue = "title") String searchType
         ,@RequestParam(required = false) String keyword
         )throws Exception {
      
      SearchPD search = new SearchPD();
      search.setSearchType(searchType);
      search.setKeyword(keyword);
      
      //전체 게시글 개수
      int listCnt = service.productListCnt(search);
      
      //Pagination 객체생성
      
      search.pageInfo(page, range, listCnt);
      
      model.addAttribute("pagination", search);
      model.addAttribute("list", service.productList(search));
      
      log.info(search);
      return "admin/productList";
   }
   
   
   // 도서 등록
   @PostMapping("/bregister")
   public String register(Bs_BookVO vo, MultipartFile file) throws   Exception {
      
      
      log.info(file.getOriginalFilename());
      
      String imgUploadPath = uploadPath + File.separator + "imgUpload";
      String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
      String fileName = null;
      
      if(file.getOriginalFilename() != null && file.getOriginalFilename() != "") {
         fileName = UploadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(), ymdPath);
      } else {
         fileName = uploadPath + File.separator + "images" + File.separator + "none.png";
      }
      
      vo.setBk_pictureUrl(File.separator + "imgUpload" + ymdPath + File.separator + fileName);
      vo.setBk_thumbUrl(File.separator + "imgUpload" + ymdPath + File.separator + "s" + File.separator + "s_" + fileName);
      
      service.register(vo);
      
      return "redirect:productList";
   }
   
   // 도서 재고 추가 ajax
   @RequestMapping(value = "/stockAdd", method = RequestMethod.GET) 
   @ResponseBody
   public void stockAdd(@RequestParam("stockAdd") int stockAdd,
                  @RequestParam("bk_num") int bkNum) throws   Exception  {
      
      
       
      log.info(stockAdd);
      log.info(bkNum);
      
       service.stockAdd(stockAdd, bkNum);
       
    
      
   }
   
   // 배송 확인 ajax
   @RequestMapping(value = "/delivery", method = RequestMethod.GET) 
   @ResponseBody
   public void delivery(@RequestParam("cNum") int cNum,
                  @RequestParam("oNum") int oNum) throws Exception  {
      
      
       
      log.info(cNum);
      log.info(oNum);
      
      if(cNum == 0) {
         cNum++;
         service.delivery(cNum, oNum);
      }else if(cNum == 1) {
         cNum++;
         service.delivery(cNum, oNum);
      } 
      
   }
   
   // 도서리스트 도서 삭제
   @RequestMapping(value = "/delBook", method = RequestMethod.GET) 
   @ResponseBody
   public void delivery(@RequestParam("bk_num") int bkNum) throws Exception  {
      
      
       
      log.info(bkNum);
      
      service.delBook(bkNum);
   
      
   }
   

   
   
}
   
 
