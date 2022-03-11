package org.zerock.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.zerock.domain.Bs_BookVO;
import org.zerock.domain.Bs_CartVO;
import org.zerock.domain.Bs_CodeVO;
import org.zerock.domain.Bs_ReviewVO;
import org.zerock.domain.Bs_UserVO;
import org.zerock.domain.PaginationPD;
import org.zerock.domain.SearchPD;



// 2가지 방법
// 방법 1 : 자바 인터페이스에서 SQL을 작성하는 방법
// 방법 2 : 자바 인터페이스 + XML mapper(SQL)을 사용하는 방법

// insert만 처리되고 생성된 PK 값을 알 필요가 없는 경우 : ①
// insert문이 실행되고, 생성된 PK 값을 알아야 하는 경우 : ②
public interface BookMainMapper {
//	@Select("select * from tbl_board where bno > 0 order by bno desc")

	
	public List<Bs_BookVO> dateselect();
	public List<Bs_BookVO> cateselect(int code);
	public Bs_UserVO login(Bs_UserVO vo);
	public int idCheck(String vo);
	public void register(Bs_UserVO vo);
	public void addcart(Bs_CartVO vo);
	public int count() throws Exception;
	public Bs_BookVO detail(int bk_num);
	public void comment(Bs_ReviewVO vo);
	public List<Bs_ReviewVO> selectcomment(int vo);
	public int ordCheck(Bs_ReviewVO vo);
	public double selectsum(int bk_num);
	public int rankcount(int bk_num);
	public void commentdelete(Bs_ReviewVO vo);
	public void commentupdate(Bs_ReviewVO vo);
	public int getBookListCnt(SearchPD code) throws Exception;
	public List<Bs_BookVO> getBookList(SearchPD code) throws Exception;
	public List<Bs_BookVO> searchlist(SearchPD search) throws	Exception;
	public int searchlistcnt(SearchPD search) throws Exception;
	public void revupdate(@Param("rank")double rank , @Param("bk_num")int bk_num)throws Exception;
	public void userupdate(Bs_UserVO vo);
	public void userpointupdate(Bs_UserVO vo);
	public List<Bs_BookVO> rankselect();
	public int revranklistcnt() throws Exception;
	public List<Bs_BookVO> revranklist(SearchPD best) throws Exception;
	public int newbooklistcnt() throws Exception;
	public List<Bs_BookVO> newbooklist(SearchPD best) throws Exception;
	public int decommentcnt(SearchPD bk_num) throws Exception;
	public List<Bs_ReviewVO> decomment(SearchPD bk_num) throws Exception;
	public List<Bs_BookVO> bestselect();
	
	public int check(String userId) throws Exception;
	public void regiUser(@Param("userId") String userId, @Param("userNickName") String userNickName) throws	Exception;
	public Bs_UserVO infoUser(String userId) throws Exception;
	
	public Bs_UserVO selectPoint(String vo);
	
	public Bs_UserVO mailCheck (Bs_UserVO vo);		//유저 아이디 찾기를 위한 추가 
	public int mailCheckCnt (Bs_UserVO vo);			//유저 아이디 찾기를 위한 추가 
	public Bs_UserVO pasmailCheck (Bs_UserVO vo);		//유저 비밀번호 찾기를 위한 추가 
	public int pasmailCheckCnt (Bs_UserVO vo);			//유저 비밀번호 찾기를 위한 추가 
	
}

