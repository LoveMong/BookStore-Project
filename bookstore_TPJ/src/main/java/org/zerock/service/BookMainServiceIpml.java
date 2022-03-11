package org.zerock.service;


import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;
import org.zerock.domain.Bs_BookVO;
import org.zerock.domain.Bs_CartVO;
import org.zerock.domain.Bs_CodeVO;
import org.zerock.domain.Bs_ReviewVO;
import org.zerock.domain.Bs_UserVO;
import org.zerock.domain.PaginationPD;
import org.zerock.domain.SearchPD;
import org.zerock.mapper.BookMainMapper;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BookMainServiceIpml implements BookMainService{
	
	private final BookMainMapper mapper;


	@Override
	public List<Bs_BookVO> dateselect() {
		return mapper.dateselect();
	}

	@Override
	public List<Bs_BookVO> cateselect(int code) {
		return mapper.cateselect(code);
	}

	@Override
	public Bs_UserVO login(Bs_UserVO vo) {
		return mapper.login(vo);
	}

	@Override
	public int idCheck(String vo) {
		return mapper.idCheck(vo);
	}

	@Override
	public void register(Bs_UserVO vo) {
		mapper.register(vo);
		
	}

	@Override
	public void addcart(Bs_CartVO vo) {
		mapper.addcart(vo);
		
	}

	@Override
	public int count() throws Exception {
		return mapper.count();
	}

	@Override
	public Bs_BookVO detail(int bk_num) {
		return mapper.detail(bk_num);
	}

	@Override
	public void comment(Bs_ReviewVO vo) {
		mapper.comment(vo);
		
	}

	@Override
	public List<Bs_ReviewVO> selectcomment(int vo) {
		return mapper.selectcomment(vo);
	}

	@Override
	public int ordCheck(Bs_ReviewVO vo) {
		return mapper.ordCheck(vo);
	}

	@Override
	public double selectsum(int bk_num) {
		return mapper.selectsum(bk_num);
	}

	@Override
	public int rankcount(int bk_num) {
		return mapper.rankcount(bk_num);
	}

	@Override
	public void commentdelete(Bs_ReviewVO vo) {
		mapper.commentdelete(vo);
		
	}

	@Override
	public void commentupdate(Bs_ReviewVO vo) {
		mapper.commentupdate(vo);
		
	}

	@Override
	public int getBookListCnt(SearchPD code) throws Exception {
		return mapper.getBookListCnt(code);
	}

	@Override
	public List<Bs_BookVO> getBookList(SearchPD code) throws Exception {
		return mapper.getBookList(code);
	}

	@Override
	public List<Bs_BookVO> searchlist(SearchPD search) throws Exception {
		return mapper.searchlist(search);
	}

	@Override
	public int searchlistcnt(SearchPD search) throws Exception {
		return mapper.searchlistcnt(search);
	}
	
	@Override
	public void userupdate(Bs_UserVO vo) {
		mapper.userupdate(vo);
		
	}

	@Override
	public void userpointupdate(Bs_UserVO vo) {
		mapper.userpointupdate(vo);
		
	}



	@Override
	public void revupdate(@Param("rank")double rank, @Param("bk_num")int bk_num) throws Exception {
		mapper.revupdate(rank, bk_num);
		
	}

	@Override
	public List<Bs_BookVO> rankselect() {
		return mapper.rankselect();
	}

	@Override
	public int revranklistcnt() throws Exception {
		return mapper.revranklistcnt();
	}

	@Override
	public List<Bs_BookVO> revranklist(SearchPD best) throws Exception {
		return mapper.revranklist(best);
	}

	@Override
	public int newbooklistcnt() throws Exception {
		return mapper.newbooklistcnt();
	}

	@Override
	public List<Bs_BookVO> newbooklist(SearchPD best) throws Exception {
		return mapper.newbooklist(best);
	}

	@Override
	public int decommentcnt(SearchPD bk_num) throws Exception {
		return mapper.decommentcnt(bk_num);
	}

	@Override
	public List<Bs_ReviewVO> decomment(SearchPD bk_num) throws Exception {
		return mapper.decomment(bk_num);
	}

	@Override
	public List<Bs_BookVO> bestselect() {
		return mapper.bestselect();
	}
	
	@Override
	public int check(String userId) throws Exception {
			
		return mapper.idCheck(userId);
	}
	
	@Override
	public void regiUser(String userId, String userNickName) throws Exception {
		
		mapper.regiUser(userId, userNickName);
		
	}
	
	@Override
	public Bs_UserVO infoUser(String userId) throws Exception {
		
		return mapper.infoUser(userId);
	}

	@Override
	public Bs_UserVO selectPoint(String vo) {
		return mapper.selectPoint(vo);
	}

	
		
	
	@Override
	public Bs_UserVO mailCheck(Bs_UserVO vo) {		//유저 아이디 찾기를 위한 추가 
	
		return mapper.mailCheck(vo);
	}

	@Override
	public int mailCheckCnt(Bs_UserVO vo) {			//유저 아이디 찾기를 위한 추가 

		return mapper.mailCheckCnt(vo);
	}

	@Override
	public Bs_UserVO pasmailCheck(Bs_UserVO vo) {	// 유저 비밀번호 찾기를 위한 추가
	
		return mapper.pasmailCheck(vo);
	}

	@Override
	public int pasmailCheckCnt(Bs_UserVO vo) {		// 유저 비밀번호 찾기를 위한 추가
		
		return mapper.pasmailCheckCnt(vo);
	}





}
