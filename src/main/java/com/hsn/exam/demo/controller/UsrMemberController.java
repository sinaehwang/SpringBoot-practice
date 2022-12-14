package com.hsn.exam.demo.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hsn.exam.demo.Util.Ut;
import com.hsn.exam.demo.service.MemberService;
import com.hsn.exam.demo.vo.Member;
import com.hsn.exam.demo.vo.ResultData;

@Controller
public class UsrMemberController {
	@Autowired
	private MemberService memberService;
	@Autowired
	private Rq rq;
	
	public UsrMemberController(MemberService memberService) {
		this.memberService=memberService;
	}

	@RequestMapping("/usr/member/doJoin")
	@ResponseBody
	public ResultData<Member> doJoin(String loginId,String loginPw,String name,String nickname,String cellphoneNum,String email) {
		
		if(Ut.empty(loginId)) { //아이디값을 매개변수로 주고 아이디에 Null여부를 판단하는 함수로 만듬
			return ResultData.from("F-4", "아이디를 입력해주세요");
		}
		
		if(Ut.empty(loginPw)) {
			return ResultData.from("F-4", "패스워드를 입력해주세요");
		}
		
		if(Ut.empty(name)) {
			return ResultData.from("F-4", "이름을 입력해주세요");
		}
		
		if(Ut.empty(nickname)) {
			return ResultData.from("F-4", "닉네임을 입력해주세요");
		}
		
		if(Ut.empty(cellphoneNum)) {
			return ResultData.from("F-4", "전화번호를 입력해주세요");
		}
		
		if(Ut.empty(email)) {
			return ResultData.from("F-4", "이메일을 입력해주세요");
		}
		
		 ResultData<Integer> JoinData = memberService.join(loginId,loginPw,name,nickname,cellphoneNum,email); //join으로 insert를 한후에
		 //현재 JoinData데이터에 들어있는 값은 코드,메세지,id정보
		 
		 if(JoinData.isFail()) {//아이디중복,이름+메일중복이 발생했을떄 둘다 실패한 경우니까 isFail()하나로 보여줄수 있음
			 return (ResultData)JoinData;
		 }
		 
		  Member member =memberService.getMemberById((int) JoinData.getData1()); //id를 기반으로 회원을 찾는 로직실행
		  //member에 들어있는 정보는 id기반으로 찾아온 회원정보가 들어있다.
		  
		  return ResultData.newData(JoinData,member);//코드,메세지,id정보와 member기초정보를 넘겨주는 새 메소드를 생성

	}
	
	
	@RequestMapping("/usr/member/doLogin")
	@ResponseBody
	public String doLogin(String loginId,String loginPw) {
		//1. 로그인 아이디/비번 일치여부부터 체크
		//2. 로그인 완료 구현
		
		//Rq rq = (Rq) req.getAttribute("rq");
		
		
		if(rq.isLogined()) {
			//return ResultData.from("F-3", "이미 로그인 상태입니다.");
			return Ut.jsHistoryBack("이미 로그인 상태입니다.");
		}
		
		if(Ut.empty(loginId)) { //아이디값을 매개변수로 주고 아이디에 Null여부를 판단하는 함수로 만듬
			//return ResultData.from("F-3", "아이디를 입력해주세요");
			return Ut.jsHistoryBack("아이디를 입력해주세요");
		}
		
		if(Ut.empty(loginPw)) {
			//return ResultData.from("F-3", "패스워드를 입력해주세요");
			return Ut.jsHistoryBack("패스워드를 입력해주세요");
		}
		
		Member member = memberService.getMemberByLogId(loginId);//로그인파라미터값으로 멤버찾아오기
		
		if(member == null) {
			
			//return ResultData.from("F-1", "존재하지 않는 아이디입니다.");
			return Ut.jsHistoryBack("존재하지 않는 아이디입니다.");
		}

		if(member.getLoginPw().equals(loginPw)==false) {//찾은멤버에서 비번을 가져오고,파라미터로 받은 비번과 일치여부 체크
			
			//return ResultData.from("F-2", "비밀번호가 일치하지않습니다.");
			return Ut.jsHistoryBack("비밀번호가 일치하지않습니다.");
		}
		
		rq.login(member);
		//세션말고 rq이 대신 받는다.
		
		return Ut.jsLocationReplace(Ut.f("%s님 로그인 완료",member.getName()),"/");
	}
	
	@RequestMapping("/usr/member/login") //로그인 창만 보여주는 역활을 한다.
	public String showLogin(HttpSession httpsession) {
		
		return "usr/member/login"; //로그인폼양식을 jsp파일로 리턴해준다.
		
	}
	
	
	
	@RequestMapping("/usr/member/doLogout")
	@ResponseBody
	public String doLogout(HttpSession httpsession) {
		
		//Rq rq = (Rq) req.getAttribute("rq");
		
		if(rq.isLogined()==false) { 
			return Ut.jsHistoryBack("이미 로그아웃 상태입니다.");
			//return ResultData.from("F-4", "이미 로그아웃 상태입니다.");
		}
		
		rq.logout();
		
		return Ut.jsLocationReplace("로그아웃되었습니다.","../home/main");
		
	}
	

	
	@RequestMapping("/usr/member/getMembers")
	@ResponseBody
	public List<Member> getMembers() { //가입된 회원정보 모두를 가져올려면 리스트형태가 필요하다.
		
		return memberService.getMembers();
	}

}



